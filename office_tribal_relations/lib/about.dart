import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:office_tribal_relations/widgets/categoryList.dart';
import 'package:office_tribal_relations/widgets/otrAppBar.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(AboutOTR());

class AboutOTR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: otrAppBar(
            "About", Colors.green[900], Colors.white, appLogo, context),
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0), child: AboutTxt()),
        ),
      ),
    );
  }
}

//fade in image
class AboutTxt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        child: Column(
      children: [
        Html(
          data:
              """<h1>About the Office of Tribal Relations</h1><p>The U.S. Forest Service established the first Tribal Government Program Manager position in the Washington Office in 1988, responding to identified needs and Executive direction. Subsequently, in 2004, the <strong>Office of Tribal Relations </strong>was formed as a permanent staff within the State and Private Forestry Deputy Area, to facilitate consistency and effectiveness in Forest Service program delivery to Tribes, and to institutionalize long-term consultative and collaborative relationships with tribal governments through new policy and direction. The current Office of Tribal Relations staff consists of six employees who serve as the Headquarters component of the Forest Service's Tribal Relations Program. Field staffs comprise the other part of the program, and include the Regional Program Managers, Tribal Liaisons at the Forest level, and individuals in each of the Agency's mission areas.</p><p><strong>The Office of Tribal Relations:</strong></p><ul> <li>Provides oversight of Forest Service programs and policy that may affect Tribes, encouraging and supporting respectful, supportive government-to-government relationships that strengthen external and internal coordination and communication about tribal concerns and the Forest Service mission.</li><li>Prepares and implements new and existing policy and direction outlining the legal requirements and opportunities within existing authorities relating to Tribes.</li><li>Clarifies the Agency's responsibilities regarding Tribal trust and reserved rights.</li><li>Develops and supports education and training for employees of the Forest Service and other agencies, helping them work more effectively with tribal governments and other partners.</li><li>Explores innovative ways to interact with Tribes, Tribal Members, and others to enhance the Forest Service's service to Native American communities.</li></ul><p>The Office of Tribal Relations supports meaningful and significant collaboration and consultation with Tribes across all program areas. The Office of Tribal Relations is committed to help increase opportunities for Tribes to benefit from the Forest Service programs and to help the Forest Service benefit from input from Tribes, in support of Tribal Sovereignty, self-governance, and self-determination, as well as Forest Service goals such as adaptation and mitigation of climate change. The Office of Tribal Relations is initializing and institutionalizing relationships with internal and external partners, working closely with other staffs to ensure Tribal concerns and opportunities are addressed in new policies, and developing implementation processes for new authorities.</p>""",
        ),
        FlatButton(
          color: Colors.green[900],
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.yellow,
          child: Text(
            'Explore Categories',
            style: GoogleFonts.workSans(
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: CategoryList()));
          },
        ),
      ],
    ));
  }
}
