import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  TextEditingController billController = TextEditingController();

  double totalBillAmount = 0.0;

  double tipAmount = 0.0;
  final List<bool> _selected = [true, false, false, false];

  final _formkey = GlobalKey<FormState>();

  void calculate(){

   final billAmount = double.parse(billController.text.trim());
   final tipIndex = _selected.indexWhere((element) => element);
   final tipPercent = [0.1, 0.15, 0.2, 0.25][tipIndex];


    setState(() {
      tipAmount = double.parse((billAmount * tipPercent).toStringAsFixed(2));
      totalBillAmount = double.parse((billAmount * tipAmount).toStringAsFixed(2));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,

        leading: IconButton(

          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {


          },

        ),
        title: Text("Tippy",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
          child: Column(

            children: [

              Text("Enter bill account", style: TextStyle(fontSize: 28),
              ),
              SizedBox(height: 15,),
              Container(
                width: 200,
                child: Form(
                  key: _formkey,
                  child: TextFormField(
                    controller: billController,

                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: '\$100.0',
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                        )


                    ),
                    validator: (value){

                      if(value == null || value.isEmpty){

                        return 'Please enter a valid amount';
                      }
                      return null;

                    },


                  ),
                ),

              ),
              SizedBox(height: 20,),

              Text(
                "Chhose Tip", style: TextStyle(fontSize: 25, color: Colors.black87),

              ),
              Container(child: ToggleButtons(isSelected: _selected,

                fillColor: Colors.red,
                selectedColor: Colors.white,
                children: const [

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("10%"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("15%"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("20%"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("25%"),
                  ),
                ],
                onPressed: (int selectIndex){

                  for(int index = 0; index < _selected.length; index++){

                    setState(() {
                      _selected[index] = selectIndex == index;
                    });


                  }



                },

              ),
              ),
              SizedBox(height: 40,),
              Container(

                height: 70,
                width: double.infinity,

                child: ElevatedButton(child: Text("Calculate",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),

                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange
                  ),

                  onPressed: (){

              if(_formkey.currentState!.validate()){

               calculate();

              }

                  },
                ),

              ),
              SizedBox(height: 20,),
              Text("Total Bill Account", style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20,),
              Text('\$$totalBillAmount',style: TextStyle(fontSize: 30, color: Color(0xFF08502D),
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              Text('Tip Amount',style: TextStyle(fontSize: 50, color: Color(0xFF08502D),
                  fontWeight: FontWeight.bold
              ),),
              Text('\$$tipAmount',style: TextStyle(fontSize: 20, color: Colors.green,
                  fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
