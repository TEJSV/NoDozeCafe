import 'package:flutter/material.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/CRUDModel.dart';
import 'package:intl/intl.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String productType = 'Latte';
  String cap='Regular';
  String title ;
  String price ;
  
  

  
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<CRUDModel>(context) ;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Hi Rakesh'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Product Title';
                  }
                },
                  onSaved: (value) => title = value
              ),
             
              DropdownButton<String>(
                value: productType,
                onChanged: (String newValue) {
                  setState(() {
                    productType = newValue;
                  });
                },
                items: <String>['Latte', 'Espresso', 'Cappuccino']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
				
				
              ),
			  DropdownButton<String>(
                value: cap,
                onChanged: (String newValue) {
                  setState(() {
                    cap = newValue;
                  });
                },
                items: <String>['Regular', 'Medium', 'Large']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              RaisedButton(
                splashColor: Colors.green,
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await productProvider.addProduct(Product(name: title,price: new DateFormat.yMMMd().format(new DateTime.now()),img: (productType+cap).toLowerCase()));
                    Navigator.pop(context) ;
                  }
                },
                child: Text('Place Order', style: TextStyle(color: Colors.white)),
                color: Colors.brown,
              )

            ],
          ),
        ),
      ),
    );
  }
}
