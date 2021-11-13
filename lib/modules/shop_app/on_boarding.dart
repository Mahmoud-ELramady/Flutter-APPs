import 'package:first_app/modules/shop_app/login/shop_login.dart';
import 'package:first_app/shared/componenets/Components.dart';
import 'package:first_app/shared/network/local/cash_helper.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
  @required this.image,
  @required this.title,
  @required this.body,
});


}


class OnBoarding extends StatefulWidget {

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController=PageController();

List<BoardingModel> boarding=[
  BoardingModel(image: "assets/images/onboard_1.jpg", title: "title 1", body: "body 1"),
  BoardingModel(image: "assets/images/onboard_1.jpg", title: "title 2", body: "body 2"),
  BoardingModel(image: "assets/images/onboard_1.jpg", title: "title 3", body: "body 3"),

];

bool isLast=  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: (){
                submit();
              },
              text: "Skip"

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast=true;
                    });
                    print("Last");
                  }else{
                    print("not Last");
                    setState(() {
                      isLast=false;
                    });

                  }
                },
              ),
            ),

            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                      spacing:5,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){

                    if(isLast){
                      submit();
                    }else{
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }


                  },
                child: Icon(Icons.arrow_forward_ios),

                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,

        ),
      ),
      SizedBox(
        height: 30.0,
      ),



    ],
  );


  void submit(){

    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen(),);

      }
    });

  }
}
