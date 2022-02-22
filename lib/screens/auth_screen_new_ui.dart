import 'package:flutter/material.dart';

class NewAuthScreen extends StatelessWidget {
  final googleImg = Image.asset("assets/Img/google.png");
  final facebookImg = Image.asset("assets/Img/facebook.png");
  Widget buildInputField(String displayText, bool pass) {
    return pass
        ? Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              child: TextFormField(
                style: TextStyle(color: Colors.black87),
                obscureText: true,
                // onFieldSubmitted: (value) => next,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: displayText,
                ),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              child: TextFormField(
                style: TextStyle(color: Colors.black87),
                // onFieldSubmitted: (value) => next,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: displayText,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.lerp(Color.fromRGBO(139, 199, 255, 0.4),
      //     Color.fromRGBO(139, 199, 255, 1), 0.7),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(139, 199, 255, 0.7),
              Color.fromRGBO(139, 199, 255, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  "BaatCheet",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              // const SizedBox(
              //   height: 7,
              // ),
              Text(
                "Text Messaging Application",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                alignment: Alignment.bottomLeft,
                child:
                    Text("Hi!", style: Theme.of(context).textTheme.headline1),
              ),
              const SizedBox(
                height: 7,
              ),
              buildInputField("Email", false),
              const SizedBox(
                height: 7,
              ),
              buildInputField("Password", true),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Continue",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "or",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        "https://ibb.co/kM0J0xH",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : CircularProgressIndicator(),
                        errorBuilder: (context, error, stackTrace) => googleImg,
                      ),
                    ),
                    title: Text(
                      "Continue with Google",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        "https://ibb.co/qrt6k2R",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : CircularProgressIndicator(
                                    color: Colors.black87,
                                  ),
                        errorBuilder: (context, error, stackTrace) =>
                            facebookImg,
                      ),
                    ),
                    title: Text(
                      "Continue with Facebook",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 7,
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    FlatButton(onPressed: () {}, child: Text("Sign Up"))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                // padding: const EdgeInsets.only(left: 15),
                child: FlatButton(
                    onPressed: () {}, child: Text("Forget your password")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
