import 'package:booktopia/common/color_extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../book_details.dart';
import '../../common_widget/best_sellers_cell.dart';
import '../../common_widget/top_picks_cell.dart';
import '../main_tab/menubar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List topPicksArr = [
    {
      "name": "HARRY POTTER and the SORCERER'S STONE",
      "author": "J.K. Rowling",
      "img": "assets/1.jpg",
      "rating": 4.47,
      "price": 8.99,
      "description":
          "'Turning the envelope over,his hand trembling,Harry saw a purple wax seal bearing a coat of arms;a lion,an eagle, a badger and a snake surrounding a large letter 'H'.'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harry's eleventh birthday,a great beetle-eyed giant of a man called Rubeus Hagrid bursts in with some astonishing news: Harry Potter is a wizard,and he has a place at Hogwarts School of Witchcraft and Wizardry. An incredible adventure is about to begin!"
    },
    {
      "name": "The Name of the Wind",
      "author": "Patrick Rothfuss",
      "img": "assets/2.jpg",
      "rating": 4.5,
      "price": 9.89,
      "description": "Told in Kvothe's own voice,this is the tale of the magically gifted young man who grows to be the most notorious wizard his world has ever seen.The intimate narrative of his childhood in a troupe of traveling players, his years spent as a near-feral orphan in a crime-ridden city, his daringly brazen yet successful bid to enter a legendary school of magic, and his life as a fugitive after the murder of a king form a gripping coming-of-age story unrivaled in recent literature.A high-action story written with a poet's hand,The Name of the Wind is a masterpiece that will transport readers into the body and mind of a wizard."
    },
    {
      "name": "The Way of Kings",
      "author": "Brandon Sanderson",
      "img": "assets/3.jpg",
      "rating": 4.66,
      "price": 7.99,
      "description": "Roshar is a world of stone and storms.Uncanny tempests of incredible power sweep across the rocky terrain so frequently that they have shaped ecology and civilization alike. Animals hide in shells,trees pull in branches,and grass retracts into the soilless ground. Cities are built only where the topography offers shelter.It has been centuries since the fall of the ten consecrated orders known as the Knights Radiant,but their Shardblades and Shardplate remain: mystical swords and suits of armor that transform ordinary men into near-invincible warriors. Men trade kingdoms for Shardblades. Wars were fought for them, and won by them.One such war rages on a ruined landscape called the Shattered Plains.There,Kaladin,who traded his medical apprenticeship for a spear to protect his little brother,has been reduced to slavery. In a war that makes no sense,where ten armies fight separately against a single foe,he struggles to save his men and to fathom the leaders who consider them expendable.Brightlord Dalinar Kholin commands one of those other armies. Like his brother,the late king,he is fascinated by an ancient text called The Way of Kings. Troubled by over-powering visions of ancient times and the Knights Radiant,he has begun to doubt his own sanity.Across the ocean,an untried young woman named Shallan seeks to train under an eminent scholar and notorious heretic,Dalinar's niece,Jasnah. Though she genuinely loves learning,Shallan's motives are less than pure. As she plans a daring theft,her research for Jasnah hints at secrets of the Knights Radiant and the true cause of the war.The result of over ten years of planning,writing,and world-building,The Way of Kings is but the opening movement of the Stormlight Archive,a bold masterpiece in the making.Speak again the ancient oaths:Life before death.Strength before weakness.Journey before Destination.and return to men the Shards they once bore.The Knights Radiant must stand again."
    },
    {
      "name": "The Wicked King",
      "author": "Holly Black",
      "img": "assets/7 .jpg",
      "rating": 4.31,
      "price": 12.8,
      "description": "You must be strong enough to strike and strike and strike again without tiring.The first lesson is to make yourself strong.After the jaw-dropping revelation that Oak is the heir to Faerie,Jude must keep her brother safe. To do so,she has bound the wicked king,Cardan,to her,and made herself the power behind the throne. Navigating the constantly shifting political alliances of Faerie would be difficult enough if Cardan were easy to control. But he does everything in his power to humiliate and undermine her even as his fascination with her remains undiminished.When it becomes all too clear that someone close to Jude means to betray her,threatening her own life and the lives of everyone she loves,Jude must uncover the traitor and fight her own complicated feelings for Cardan to maintain control as a mortal in a Faerie world."
    },
    {
      "name": "The Martian",
      "author": "Andy Weir",
      "img": "assets/8.jpg",
      "rating": 4.4,
      "price": 8.99,
      "description": "Six days ago,astronaut Mark Watney became one of the first people to walk on Mars. Now,he’s sure he’ll be the first person to die there.After a dust storm nearly kills him and forces his crew to evacuate while thinking him dead,Mark finds himself stranded and completely alone with no way to even signal Earth that he’s alive—and even if he could get word out,his supplies would be gone long before a rescue could arrive.Chances are,though,he won’t have time to starve to death. The damaged machinery,unforgiving environment,or plain-old “human error” are much more likely to kill him first.But Mark isn’t ready to give up yet. Drawing on his ingenuity,his engineering skills — and a relentless, dogged refusal to quit — he steadfastly confronts one seemingly insurmountable obstacle after the next. Will his resourcefulness be enough to overcome the impossible odds against him?"
    },
    {
      "name": "The Will of the Many",
      "author": "James Islington",
      "img": "assets/9.jpg",
      "rating": 4.7,
      "price": 14.99,
      "description": "The Catenan Republic – the Hierarchy – may rule the world now,but they do not know everything.I tell them my name is Vis Telimus. I tell them I was orphaned after a tragic accident three years ago,and that good fortune alone has led to my acceptance into their most prestigious school. I tell them that once I graduate,I will gladly join the rest of civilised society in allowing my strength,my drive and my focus – what they call Will – to be leeched away and added to the power of those above me,as millions already do. As all must eventually do.I tell them that I belong,and they believe me.But the truth is that I have been sent to the Academy to find answers. To solve a murder. To search for an ancient weapon. To uncover secrets that may tear the Republic apart.And that I will never,ever cede my Will to the empire that executed my family.To survive,though,I will still have to rise through the Academy’s ranks. I will have to smile,and make friends, and pretend to be one of them and win. Because if I cannot,then those who want to control me,who know my real name,will no longer have any use for me.And if the Hierarchy finds out who I truly am,they will kill me."
    },
    {
      "name": "Of Darkness and Light",
      "author": "Ryan Cahill",
      "img": "assets/10.jpg",
      "rating": 4.49,
      "price": 7.49,
      "description": "Heroes will rise. Nations will fall.Behind the towering walls of Belduar,Calen Bryer and his companions stand in defense of the city and its new king. In over a thousand years,Belduar has never fallen. It has stood as a bastion of hope. But the Lorian empire are at its walls once more,and the Dragonguard are coming.In the North,with Faenir by her side,Calen’s sister Ella arrives at the port of Antiquar,her only compass,a letter addressed to her fallen love. But she holds no fear of the unknown. She will see this through,no matter what – or who – gets in her way.Meanwhile,at the embassy of the Circle of Magii in Al’Nasla,Rist Havel hones his newfound powers in preparation for the trials of Faith and Will. Unbeknownst to Rist,he is being watched,measured,and judged. He was not taken into the Circle by chance. There is greatness in him. But great men can do terrible things.As Lorian forces land on southern shores and Aeson Virandr’s letters of rebellion find their way to the right hands,only the Knights of Achyron see the true danger. The danger that stirs in the darkness. The coming shadow will not stop. It will consume all in its path. It wants for nothing but blood and fire."
    }
  ];

  List bestSellerArr = [
    {
      "name": "The Invisible Life of Addie LaRue",
      "author": "V.E. Schwab",
      "img": "assets/4.jpg",
      "rating": 4.2,
      "price": 12.99,
      "description": "France,1714: in a moment of desperation,a young woman makes a Faustian bargain to live forever and is cursed to be forgotten by everyone she meets.Thus begins the extraordinary life of Addie LaRue,and a dazzling adventure that will play out across centuries and continents,across history and art,as a young woman learns how far she will go to leave her mark on the world.But everything changes when,after nearly 300 years,Addie stumbles across a young man in a hidden bookstore and he remembers her name."
    },
    {
      "name": "The Wager: A Tale of Shipwreck, Mutiny and Murder",
      "author": "David Grann",
      "img": "assets/5.jpg",
      "rating": 4.5,
      "price": 14.99,
      "description": "From the #1 New York Times bestselling author of Killers of the Flower Moon,a page-turning story of shipwreck,survival,and savagery,culminating in a court martial that reveals a shocking truth. The powerful narrative reveals the deeper meaning of the events on the Wager,showing that it was not only the captain and crew who ended up on trial,but the very idea of empire.On January 28,1742,a ramshackle vessel of patched-together wood and cloth washed up on the coast of Brazil. Inside were thirty emaciated men,barely alive, and they had an extraordinary tale to tell. They were survivors of His Majesty's Ship the Wager, a British vessel that had left England in 1740 on a secret mission during an imperial war with Spain. While the Wager had been chasing a Spanish treasure-filled galleon known as 'the prize of all the oceans,' it had wrecked on a desolate island off the coast of Patagonia. The men, after being marooned for months and facing starvation, built the flimsy craft and sailed for more than a hundred days, traversing nearly 3,000 miles of storm-wracked seas. They were greeted as heroes.But then . . . six months later, another, even more decrepit craft landed on the coast of Chile. This boat contained just three castaways, and they told a very different story. The thirty sailors who landed in Brazil were not heroes - they were mutineers. The first group responded with countercharges of their own, of a tyrannical and murderous senior officer and his henchmen. It became clear that while stranded on the island the crew had fallen into anarchy, with warring factions fighting for dominion over the barren wilderness. As accusations of treachery and murder flew, the Admiralty convened a court martial to determine who was telling the truth. The stakes were life-and-death--for whomever the court found guilty could hang.The Wager is a grand tale of human behavior at the extremes told by one of our greatest nonfiction writers. Grann's recreation of the hidden world on a British warship rivals the work of Patrick O'Brian, his portrayal of the castaways' desperate straits stands up to the classics of survival writing such as The Endurance, and his account of the court martial has the savvy of a Scott Turow thriller. As always with Grann's work, the incredible twists of the narrative hold the reader spellbound."
    },
    {
      "name": "The Covenant of Water",
      "author": "Abraham Verghese",
      "img": "assets/6.jpg",
      "rating": 4.49,
      "price": 9.24,
      "description": "A stunning and magisterial new epic of love,faith,and medicine,set in Kerala and following three generations of a family seeking the answers to a strange secret.Spanning the years 1900 to 1977, The Covenant of Water is set in Kerala,on South India’s Malabar Coast,and follows three generations of a family that suffers a peculiar affliction: in every generation,at least one person dies by drowning—and in Kerala,water is everywhere. The family is part of a Christian community that traces itself to the time of the apostles,but times are shifting,and the matriarch of this family,known as Big Ammachi—literally “Big Mother”—will witness unthinkable changes at home and at large over the span of her extraordinary life. All of Verghese’s great gifts are on display in this new work: there are astonishing scenes of medical ingenuity, fantastic moments of humor, a surprising and deeply moving story, and characters imbued with the essence of life.A shimmering evocation of a lost India and of the passage of time itself, The Covenant of Water is a hymn to progress in medicine and to human understanding,and a humbling testament to the hardships undergone by past generations for the sake of those alive today. It is one of the most masterful literary novels published in recent years."
    },
    {
      "name": "1932: FDR,Hoover,and the Dawn of a New America",
      "author": "Scott Martelle",
      "img": "assets/11.jpg",
      "rating": 4.1,
      "price": 13.99,
      "description": "An enthralling slice of history with contemporary resonance,this unique account examines the most transformative year in American history -- when a battered nation would emerge from the Great Depression and reinvent itself under the skilled leadership of President Franklin Delano Roosevelt.In one vitally significant year in American history,the country would experience turmoil,instability,natural disaster,bubbling political radicalism,and a rise of dangerous forces ushering in a new era of global conflict – and emerge both afresh and revitalized.At the start of 1932,the nation’s worst economic crisis has left one-in-four workers without a job,countless families facing eviction,banks shutting down as desperate depositors withdraw their savings,and growing social and political unrest from urban centers to the traditionally conservative rural heart of the country.Amid this turmoil,a political decision looms that will determine the course of the nation. It is a choice between two men with very diferent visions of Incumbent Republican Herbert Hoover with his dogmatic embrace of small government and a largely unfettered free market,and New York’s Democratic Governor Franklin Delano Roosevelt and his belief that the path out of the economic crisis requires government intervention in the economy and a national sense of shared purpose.Now veteran journalist Scott Martelle provides a gripping narrative retelling of that vitally significant year as social and political systems struggled under the weight of the devastating Dust Bowl,economic woes,rising political protests,and growing demand for the repeal of Prohibition. That November,voters overwhelmingly rejected decades of Republican rule and backed Roosevelt and his promise to redefine the role of the federal government while putting the needs of the people ahead of the wishes of the wealthy.'The story of the 1932 election is well-known,so I wanted to write a book that explores other lesser-known aspects of that tumultuous year,'Martelle says.'In the end,I hope the reader comes away with a feel for what life was like for average Americans as they lived in the shadow of highly dramatic events.'Deftly told,this illuminating work spotlights parallel events from that pivotal year and brings to life figures who made headlines in their time but have been largly forgotten today. Ultimately,it is the story of a nation that,with the help of a leader determined to unite and inspire,took giant steps toward a new America."
    },
    {
      "name": "The Redhead of Auschwitz: A True Story",
      "author": "Nechama Birnbaum",
      "img": "assets/12.jpg",
      "rating": 4.8,
      "price": 16.16,
      "description": "Rosie was always told her red hair was a curse, but she never believed it. She often dreamed what it would look like under a white veil with the man of her dreams by her side. However, her life takes a harrowing turn in 1944 when she is forced out of her home and sent to the most gruesome of places: Auschwitz.Upon arrival, Rosie's head is shaved and along with the loss of her beautiful hair, she loses the life she once cherished. Among the chaos and surrounded by hopelessness, Rosie realizes the only thing the Nazis cannot take away from her is the fierce redhead resilience in her spirit. When all of her friends conclude they are going to heaven from Auschwitz, she remains determined to get home. She summons all of her courage, through death camps and death marches to do just that.This victorious biography, written by Nechama Birnbaum in honor of her grandmother, is as full of life as it is of death. It is about the intricacies of Jewish culture that still exist today and the tender experiences that are universal to all humanity: family, coming of age, and first love. It is a story that celebrates believing in yourself no matter the odds. This is a story about the little redheaded girl who thought she could, and so she did."
    },
    {
      "name": "Ward D",
      "author": "Freida McFadden",
      "img": "assets/13.jpg",
      "rating": 4.3,
      "price": 7.49,
      "description": "Medical student Amy Brenner is spending the night on a locked psychiatric ward.Amy has been dreading her evening working on Ward D, the hospital’s inpatient mental health unit. There are very specific reasons why she never wanted to do this required overnight rotation. Reasons nobody can ever find out.And as the hours tick by, Amy grows increasingly convinced something terrible is happening within these tightly secured walls. When patients and staff start to vanish without a trace, it becomes clear that everyone on the unit is in grave danger.Amy’s worst nightmare was spending the night on Ward D.And now she might never escape."
    },
    {
      "name": "Burned Out",
      "author": "Dean Mafako",
      "img": "assets/14.jpg",
      "rating": 4.3,
      "price": 9.49,
      "description": "Eric Philson came to the Children's Hospital of Biloxi with a goal ― to build the cardiac intensive care unit from the ground up. The physician faces insurmountable the devastating aftereffects of a hurricane, deprivation of essential staff and resources, and a cardiac surgeon resistant to change. Dr. Philson will do whatever it takes to help improve the care for children, until the job begins to take a toll on his free time, marriage, and health. How much is he willing to sacrifice? Working hundred-hour weeks, overcoming the impossible, and facing personal ruin are only the start of what he will face. Does he have the grit and determination to do what's right, even if it costs him everything?"
    }
  ];

  void _navigateToBookDetails(BuildContext context, Map bookDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetails(bookDetails: bookDetails),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.7,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                          color: TColor.text,
                          borderRadius:
                              BorderRadius.circular(media.width * 0.5)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: media.width * 0.025,
                    ),
                    AppBar(
                      backgroundColor: TColor.text,
                      elevation: 0,
                      title: Row(children: const [
                        Text(
                          "Trending Books",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                      ]),
                      leading: Container(),
                      leadingWidth: 2,
                      actions: [
                        IconButton(
                            color: Colors.white70,
                            onPressed: () {
                              sideMenuScafflodKey.currentState?.openEndDrawer();
                            },
                            icon: const Icon(Icons.menu))
                      ],
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.9,
                      // color:Colors.red,
                      child: CarouselSlider.builder(
                        itemCount: topPicksArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var iObj = topPicksArr[itemIndex] as Map? ?? {};
                          return GestureDetector(
                            onTap: () {
                              _navigateToBookDetails(context, iObj);
                            },
                            child: TopPicksCell(
                              iObj: iObj,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 530,
                          aspectRatio: 1,
                          viewportFraction: 0.45,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          "Featured Books",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 6),
                          scrollDirection: Axis.horizontal,
                          itemCount: bestSellerArr.length,
                          itemBuilder: ((context, index) {
                            var bObj = bestSellerArr[index] as Map? ?? {};
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                      bookDetails: bObj,
                                    ),
                                  ),
                                );
                              },
                              child: BestSellersCell(
                                bObj: bObj,
                              ),
                            );
                          })),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
