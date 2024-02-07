import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as https;

class paymentcontroller{
  Map<String,dynamic>? paymentIntentData;
  
  Future<void>makePayment(
  {required String amount,required String currency})async{
    try{
      paymentIntentData=await createPaymentIntent(amount,currency);
      if(paymentIntentData!=null){
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // applePay: true, // Enable Apple Pay
            // googlePay: true, // Enable Google Pay
            // testEnv: true, // Enable test environment
            // merchantCountryCode: 'US', // Set merchant country code
            merchantDisplayName: 'Prospects',
            customerId: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        displayPaymentSheet();
      }
    }catch(e,s){
      print('exception:$e$s');
    }
  }

  displayPaymentSheet()async{
    try{
      await Stripe.instance.presentPaymentSheet();
      print('Payment Successful');
    }on Exception catch(e){
      if(e is StripeException)
        {
          print("Error from Stripe: ${e.error.localizedMessage}");
        }else{
        print("Unforeseen error: ${e}");
      }
    }catch(e)
    {
      print("exception:$e");
    }
  }
  
  
  createPaymentIntent(String amount,String currency)async{
    try{
      Map<String,dynamic>body={
        'amount':calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]' : 'card'
      };
      var response = await https.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers:{
          'Authorization':
              'sk_test_51Oh58EE28ucdGj6qNhwZ5lpYhdnBCOXetJFhmNKGIUi8Sox7FErNv9ZyUDkoWFwmhE8QLilB7cC1nM7coIKVEaTO003zEWy9QK',
          'Content-Type': 'application/x-www-form-urlencoded'

        });
      return jsonDecode(response.body);
    }catch(err){
      print('err charging user:${err.toString()}');
    }
  }
  calculateAmount(String amount){
    final a=(int.parse(amount))*100;
    return a.toString();
  }
}

