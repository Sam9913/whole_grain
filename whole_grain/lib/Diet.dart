import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DietCalculate{
	final String material_name;
	final double material_count;

  DietCalculate(this.material_name, this.material_count);
}

class Diet{
	final String date;
	final String time;
	final String dietName;
	final double dietNumber;

	Diet(
			{@required this.date,
				@required this.time,
				@required this.dietName,
				@required this.dietNumber,});
}