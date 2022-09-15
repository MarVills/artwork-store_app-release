import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:myapp/themes/style.dart';

Widget logo({size: 35.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.white,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset("assets/logo.png"),
        ),
      ),
    ),
  );
}

Widget userIcon({
  size: 40.0,
  bgColor: Colors.transparent,
  iconColor: Colors.black,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: bgColor,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          FontAwesomeIcons.user,
          color: iconColor,
        ),
      ),
    ),
  );
}

Widget cartIcon({size: 40.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.transparent,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          FontAwesomeIcons.shoppingCart,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget locationIcon({size: 40.0, iconSize: 30.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.transparent,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          Icons.location_on,
          color: Colors.black,
          size: iconSize,
        ),
      ),
    ),
  );
}

Widget cartPlusIcon({size: 40.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.transparent,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          FontAwesomeIcons.cartPlus,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget moreVertIcon({size: 40.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.transparent,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget search_icon({size: 30.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.green[200],
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget categoryIcon({
  size: 40.0,
  iconSize: 25.0,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.transparent,
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Icon(
          FontAwesomeIcons.list,
          color: Colors.black,
          size: iconSize,
        ),
      ),
    ),
  );
}

Widget elevatedButton({
  required onPressed,
  required buttonName,
  btnColor: Colors.blue,
  textColor: Colors.black,
  fontSize: 15.0,
  isUpperCase: false,
  width: 100.0,
  height: 40.0,
  borderRadius: 5.0,
  alignment: Alignment.center,
  isBold: false,
  xOffset: 0.0,
  yOffset: 3.0,
  shadowColor: Colors.black,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.9),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(xOffset, yOffset), // changes position of shadow
          ),
          BoxShadow(
            color: shadowColor.withOpacity(0.9),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(yOffset, xOffset), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        isUpperCase ? buttonName.toUpperCase() : buttonName,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    ),
  );
}

Widget expandedButton({
  required buttonName,
  required onPressed,
  btnColor: Colors.green,
  textColor: Colors.white,
  fontSize: 17.0,
  isUpperCase: false,
  width: 100.0,
  height: 40.0,
  borderRadius: 5.0,
  alignment: Alignment.center,
  isBold: true,
  xOffset: 0.0,
  yOffset: 3.0,
  shadowColor: Colors.black,
  hasShadow: true,
  xmargin: 0.0,
  ymargin: 10.0,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      // width: width,
      margin: EdgeInsets.symmetric(vertical: ymargin, horizontal: xmargin),
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: shadowColor.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(xOffset, yOffset), // changes position of shadow
                ),
                BoxShadow(
                  color: shadowColor.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(yOffset, xOffset), // changes position of shadow
                ),
              ]
            : null,
      ),
      child: Text(
        isUpperCase ? buttonName.toUpperCase() : buttonName,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    ),
  );
}

Widget ovalButton({
  required onPressed,
  required buttonName,
  btnColor: Colors.green,
  textColor: Colors.white,
  fontSize: 17.0,
  isUpperCase: false,
  width: 150.0,
  height: 40.0,
  borderRadius: 5.0,
  alignment: Alignment.center,
  isBold: true,
  xOffset: 0.0,
  yOffset: 3.0,
  shadowColor: Colors.black,
  hasShadow: true,
  xmargin: 0.0,
  ymargin: 10.0,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      // width: width,
      margin: EdgeInsets.symmetric(vertical: ymargin, horizontal: xmargin),
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.all(Radius.elliptical(200, 50)),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: shadowColor.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(xOffset, yOffset),
                ),
                BoxShadow(
                  color: shadowColor.withOpacity(0.9),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(yOffset, xOffset),
                ),
              ]
            : null,
      ),
      child: Text(
        isUpperCase ? buttonName.toUpperCase() : buttonName,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    ),
  );
}

Widget inputField({
  @required controller,
  @required validator,
  icon: null,
  hint: "",
  borderRadius: 0.0,
  borderColor: Colors.black,
  borderWidth: 1.0,
  onFocusBorderColor: Colors.black,
  type: TextInputType.text,
  onChange: "",
  textAlign: TextAlign.left,
  inputFormatters: const <TextInputFormatter>[],
  hasBorder: false,
  hintColor: Colors.grey,
  fieldColor: Colors.white,
  fontSize: 17.0,
  isObscure: false,
  enabled: true,
}) {
  return Container(
    // height: 50,
    margin: EdgeInsets.only(bottom: 10),
    alignment: Alignment.center,
    // color: Colors.red,
    child: TextFormField(
      enabled: enabled,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      onChanged: onChange == "" ? (text) {} : onChange,
      controller: controller,
      validator: validator,
      keyboardType: type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlignVertical: TextAlignVertical.center,
      obscureText: isObscure,
      style: TextStyle(fontSize: fontSize, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor,
        // prefixIcon: icon,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
        border: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: (onFocusBorderColor == Colors.black) ? borderColor : onFocusBorderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          // BorderSide(color: onFocusBorderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );
}

Widget passwordField({
  @required controller,
  @required validator,
  icon: null,
  hint: "",
  borderRadius: 0.0,
  borderColor: Colors.black,
  borderWidth: 1.0,
  onFocusBorderColor: Colors.black,
  type: TextInputType.text,
  onChange: "",
  textAlign: TextAlign.left,
  inputFormatters: const <TextInputFormatter>[],
  hasBorder: false,
  hintColor: Colors.grey,
  fieldColor: Colors.white,
  fontSize: 17.0,
  suffixIcon: null,
  suffixFunction: null,
  isObscure: false,
  hasSuffix: true,
  isPasswordVisible: false,
}) {
  return Container(
    // height: 50,
    margin: EdgeInsets.only(bottom: 10),
    alignment: Alignment.center,
    // color: Colors.red,
    child: TextFormField(
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      onChanged: onChange == "" ? (text) {} : onChange,
      controller: controller,
      validator: validator,
      keyboardType: type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlignVertical: TextAlignVertical.center,
      obscureText: isObscure,
      style: TextStyle(fontSize: fontSize, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor,
        // prefixIcon: icon,
        suffixIcon: hasSuffix
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: suffixFunction,
              )
            : null,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
        border: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: (onFocusBorderColor == Colors.black) ? borderColor : onFocusBorderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          // BorderSide(color: onFocusBorderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );
}

Widget searchField({
  @required controller,
  @required validator,
  icon: null,
  hint: "",
  borderRadius: 0.0,
  borderColor: Colors.black,
  borderWidth: 1.0,
  onFocusBorderColor: Colors.black,
  type: TextInputType.text,
  onChange: "",
  textAlign: TextAlign.left,
  inputFormatters: const <TextInputFormatter>[],
  hasBorder: false,
  hintColor: Colors.grey,
  fieldColor: Colors.white,
  fontSize: 17.0,
  suffixIcon: null,
  suffixFunction: null,
}) {
  return Container(
    // height: 40,
    margin: EdgeInsets.only(bottom: 10),
    alignment: Alignment.center,
    // color: Colors.red,
    child: TextFormField(
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      onChanged: onChange == "" ? (text) {} : onChange,
      controller: controller,
      validator: validator,
      keyboardType: type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: fontSize),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor,
        // prefixIcon: icon,
        suffixIcon: GestureDetector(
          onTap: suffixFunction,
          child: suffixIcon,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
        border: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: (onFocusBorderColor == Colors.black) ? borderColor : onFocusBorderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          // BorderSide(color: onFocusBorderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: hasBorder
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );
}

Widget labelText({
  required label,
  isRequired: false,
  textColor: Colors.white,
  color: Colors.black,
  fontSize: 17.0,
  isBold: false,
}) {
  return Container(
    // height: 25,
    margin: EdgeInsets.only(bottom: 8),
    child: Column(
      children: [
        Text.rich(
          TextSpan(
            text: label,
            children: <InlineSpan>[
              TextSpan(
                text: isRequired ? "*" : "",
                style: TextStyle(color: color),
              )
            ],
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget dropdown_widget({
  required onChanged,
  required sortBySelected,
  required sortBySelection,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    height: 40,
    decoration: BoxDecoration(
      // border: Border.all(color: hc.lightBrown),
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey,
    ),
    child: Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              value: sortBySelected,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 40,
              ),
              // iconSize: 45,
              elevation: 8,
              onChanged: onChanged,
              items: sortBySelection.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget detailLabel({
  required label,
  required value,
  textColor: Colors.black,
  color: Colors.black,
  fontSize: 15.0,
}) {
  return Container(
    // height: 23,
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        Text.rich(
          TextSpan(
            text: "${label}: ",
            children: <InlineSpan>[
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    ),
  );
}

Widget customCheckBox({required isChecked}) {
  return Stack(
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 23,
        height: 23,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/checkbox.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Visibility(
        visible: isChecked,
        child: Positioned(
          width: 30,
          height: 35,
          top: -10,
          child: Container(
            width: 20,
            height: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/check.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget radioButton({required groupValue, required value, required onChanged}) {
  return Container(
    // height: 60,
    // width: 60,
    child: RadioListTile(
      title: Text("Buy this Item/s"),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    ),
  );
}

showAlertDialog({
  required context,
  required title,
  required content,
  required onTapYes,
  required onTapNo,
}) {
  // set up the button
  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed: onTapYes,
  );
  Widget noButton = TextButton(
    child: Text("No"),
    onPressed: onTapNo,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      noButton,
      yesButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
