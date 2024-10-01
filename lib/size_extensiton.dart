import 'package:flutter/material.dart';


extension PaddingExtension on num {
  SizedBox get pw => SizedBox(width: toDouble());
  SizedBox get ph => SizedBox(height: toDouble());
}


extension MediaQueryPaddingExtension on num {
  SizedBox mpw(BuildContext context) => SizedBox(width: MediaQuery.of(context).size.width * (toDouble() / 100));
  SizedBox mph(BuildContext context) => SizedBox(height: MediaQuery.of(context).size.height * (toDouble() / 100));
}


extension ContentMediaQueryPaddingExtension on num {
  double cmpw(BuildContext context) => MediaQuery.of(context).size.width * (toDouble() / 100);
  double cmph(BuildContext context) => MediaQuery.of(context).size.height * (toDouble() / 100);
}




/*

For sizebox 
================================================

20.pw, 
20.ph,

For sizebox MediaQuery
================================================

20.mpw, 
20.mph,

For Content MediaQuery
================================================

20.cmpw, 
20.cmph,

*/

