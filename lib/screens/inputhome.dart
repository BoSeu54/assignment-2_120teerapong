import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inputwidgets/models/drink.dart';
import 'package:inputwidgets/models/food.dart';

class Inputwidgets extends StatefulWidget {
  const Inputwidgets({Key? key}) : super(key: key);

  @override
  _InputwidgetsState createState() => _InputwidgetsState();
}

class _InputwidgetsState extends State<Inputwidgets> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _username = TextEditingController();
  TextEditingController _pasw = TextEditingController();

  String? groupfood;
  List<Food>? foods;

  List checkDrink = [];
  List<Drink>? drinks;
//DD
  List<ListItem>? types = ListItem.getItem();
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItem;
  late ListItem _selectedTypeItem;

//
  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    drinks = Drink.getDrink();
    _dropdownMenuItem = createDropdownMenuItem(types!);
    _selectedTypeItem = _dropdownMenuItem[0].value!;

    // print(foods![0].thname);
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenuItem(
      List<ListItem> types) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in types) {
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            child: Text(
          'Input Widgets',
          style: GoogleFonts.mali(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        )),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            textfield(),
            textfieldpass(),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 40),
              child: DropdownButton(
                items: _dropdownMenuItem,
                style: GoogleFonts.krub(fontSize: 17, color: Colors.black),
                value: _selectedTypeItem,
                onChanged: (ListItem? value) {
                  setState(() {
                    _selectedTypeItem = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 40, bottom: 10),
              child: Text(
                'Dropdown selected: ${_selectedTypeItem.name}',
                style: GoogleFonts.mali(
                    fontSize: 15, color: Colors.lightGreen[800]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Column(
                children: createRadioFood(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 40, bottom: 10),
              child: Text('Radio Selected: ${groupfood}',
                  style: GoogleFonts.mali(
                      fontSize: 15, color: Colors.lightGreen[800])),
            ),
            // Center(child: Text('Radio Selected: $groupfood')),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Column(
                children: createCheckboxDrink(),
              ),
            ),
            submitBT(),
          ],
        ),
      ),
    );
  }

  Widget submitBT() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 30, 50),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print(_username.text);
              }
            },
            child: Text('Submit',
                style: GoogleFonts.mali(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
      ],
    );
  }

  Widget textfield() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
      child: TextFormField(
        controller: _username,
        validator: (vaLue) {
          if (vaLue!.isEmpty) {
            return "please enter username";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Username',
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blue[900],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )),
      ),
    );
  }

  Widget textfieldpass() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*',
        controller: _pasw,
        validator: (vaLue) {
          if (vaLue!.isEmpty) {
            return "Please Enter Your Password";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.red[800],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )),
      ),
    );
  }

  List<Widget> createRadioFood() {
    List<Widget> listFood = [];
    for (var food in foods!) {
      listFood.add(
        RadioListTile<dynamic>(
          title: Text(food.thname!,
              style: GoogleFonts.mali(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
          subtitle: Text(food.engname!),
          secondary: Text('${food.price} บาท',
              style: GoogleFonts.mali(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
          value: food.foodValue!,
          groupValue: groupfood,
          onChanged: (value) {
            setState(() {
              groupfood = value;
            });
          },
        ),
      );
    }
    return listFood;
  }

  List<Widget> createCheckboxDrink() {
    List<Widget> listDrink = [];

    for (var drink in drinks!) {
      listDrink.add(
        CheckboxListTile(
          value: drink.checked,
          title: Text(drink.thname!,
              style: GoogleFonts.mali(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
          subtitle: Text('${drink.price} บาท',
              style: GoogleFonts.mali(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
          onChanged: (value) {
            setState(() {
              drink.checked = value;
            });
          },
        ),
      );
    }
    return listDrink;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);

  static getItem() {
    return [
      ListItem(1, 'เครื่องดื่ม'),
      ListItem(2, 'อาหารอีสาน'),
      ListItem(3, 'อาหารปักษ์ใต้'),
      ListItem(4, 'อาหารเหนือ'),
    ];
  }

  // void add(DropdownMenuItem dropdownMenuItem) {}
}
