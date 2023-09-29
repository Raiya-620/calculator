import 'package:flutter/material.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt=20;

 Widget calcbutton(String btntxt,Color btncolor,Color txtcolor){
     return Container(
      child: ElevatedButton(
        onPressed:(){
          calculation(btntxt);
//TODO add function for button press
        },
        child:Text('$btntxt',
        style: TextStyle(
          fontSize: 35,
          color: txtcolor
        ),
        ),
        style:ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20)
        )
        ),
        
     );
 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Calculator'),
      backgroundColor: Colors.black),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal:0),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //calculator display
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:<Widget> [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('$text',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                      fontSize: 100
                      ),
                      ),
                      )
                  ],
                ), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //here buttons functions will be called where we will pass some aguments
                    calcbutton('AC', Colors.grey, Colors.black) ,
                    calcbutton('+/-', Colors.grey, Colors.black),
                    calcbutton('%', Colors.grey, Colors.black),
                    calcbutton('/', Colors.amber, Colors.black)
                  ],
                ),
                const SizedBox(height: 10),
                //now we will copy above row code and mane more rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget> [
                    //here buttons functions will be called where we will pass some aguments
                    calcbutton('7', Colors.grey[850]!, Color.fromARGB(255, 255, 255, 255)) ,
                    calcbutton('8', Colors.grey, Colors.white),
                    calcbutton('9', Colors.grey, Colors.white),
                    calcbutton('x', Colors.amber, Colors.black)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget> [
                    //here buttons functions will be called where we will pass some aguments
                    calcbutton('4', Colors.grey[850]!, Colors.white) ,
                    calcbutton('5', Colors.grey, Colors.white),
                    calcbutton('6', Colors.grey, Colors.white),
                    calcbutton('-', Colors.amber, Colors.black)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //here buttons functions will be called where we will pass some aguments
                    calcbutton('1', Colors.grey[850]!, Colors.white) ,
                    calcbutton('2', Colors.grey, Colors.white),
                    calcbutton('3', Colors.grey, Colors.white),
                    calcbutton('+', Colors.amber, Colors.black)
                  ],
                ),
                const SizedBox(height: 10,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //this is button 0
                    ElevatedButton(
                      child:
                       const Text("0",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white
                      ),
                      ),
                      style:ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(34, 20, 120, 10),
                        shape: const StadiumBorder()),
                      onPressed: (){
                        calculation('0');
                      },
                      ),
                      calcbutton('.', Colors.grey, Colors.white),
                    calcbutton('=', Colors.amber, Colors.black)
                  ],
                )
              ],
        ),
        ),
    );
  }
  //here we will write calculator logic for the app
    //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         finalResult = add();
      } else if( preOpr == '-') {
          finalResult = sub();
      } else if( preOpr == 'x') {
          finalResult = mul();
      } else if( preOpr == '/') {
          finalResult = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
          numOne = double.parse(result);
      } else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      } else if( opr == '-') {
          finalResult = sub();
      } else if( opr == 'x') {
          finalResult = mul();
      } else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    
    } 
    
    else {
        result = result + btnText;
        finalResult = result;        
    }


    setState(() {
          text = finalResult;
        });

  }


  String add() {
         result = (numOne + numTwo).toString();
         numOne = double.parse(result);           
         return doesContainDecimal(result);
  }

  String sub() {
         result = (numOne - numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String mul() {
         result = (numOne * numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String div() {
          result = (numOne / numTwo).toString();
          numOne = double.parse(result);
          return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }

}



