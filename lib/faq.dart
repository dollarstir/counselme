import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "FAQ",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurrentExpanded(
              current: "What is Counsel-Me?",
              info:
                  "Counsel-Me simply believes that distance and time must not be a hindrance to accessing quality and professional counselling services. Counsel-Me is a cyber counselling modality designed to make counselling services available to anyone, anywhere and at anytime via your computer, tablet, mobile phone, telephone or smartphone. This counselling modalitiy brings your counsellor to you as soon as you place a call or send a message. Remember that your counsellor is just a click away.",
            ),
            CurrentExpanded(
              current: "Who can use Counsel-Me?",
              info:
                  "It is for anyone, at any age, at anywhere in the world and at any time of the day. There is no barrier to whom Counsel-Me can assist. We welcome you, regardless of your culture, religion, gender, sexual orientation, or employment group. No one is left behind in counselling with Counsel-Me ",
            ),
            CurrentExpanded(
              current: "Who does the counselling?",
              info:
                  "Our counsellors are certificated at least to first degree level, they are licensed by the Ghana Psychology Council and are trained to deliver cyber counselling services, our counsellors are  members of the Ghana National Association of Certificated Counsellors. Our counsellors are professionals and welcoming. Confidentiality is their hallmark.",
            ),
            CurrentExpanded(
              current: "Can I be sure of quality service?",
              info:
                  "TUCEE team ensures that every counsellor is fully licensed and in good standing with Ghana Psychology Council. Our counsellors undergo rigorous professional screening and training to ensure that they are well-equipped for the delivery of cyber counselling services. Counsellors are constantly assessed by their clients and any counsellor whose performance may fall below expected standard is dismissed immediately. In effect, any counsellor who is still on board is awesome so service quality is assured. ",
            ),
            CurrentExpanded(
              current: "Is my privacy secured?",
              info:
                  "Counsel-Me has been built in a well-structured technology systems, operation, and infrastructure with your privacy in mind. You can feel safe and comfortable because the following conditions have been embedded in the App to ensure your privacy.\n 1.Everything you tell your counsellor is protected because they have taken an oath to protect you. \n 2.Your counsellors are not in alliance with any agency that may require your records. \n 3.All the messages between you and your counsellor are secured and encrypted. \n4. Our browsing encryption system (SSL) follows modern best practices, providing world class online security and encryption.\n 5.Our databases are encrypted and scrambled so they essentially become useless in the very unlikely event that they are being stolen or inappropriately used.\n6.No one will record your counselling session.\n7.You have the freedom to ask any question that bothers your privacy as you use the system.",
            ),
            CurrentExpanded(
              current: "How do I access Counsel-Me?",
              info:
                  "Make a call to 0208496496\nSend e-mail to icounselgh.org@gmail.com\nClick here to start (insert a form)",
            ),
            CurrentExpanded(
              current: "How is the session held?",
              info:
                  "The modalities include:\n Phone calls via voice with your counsellor.\nChatting live via any chat App mutually agreed by you and your counsellor.\nVideo conferencing with your counsellor.\nText message\nE-mails. \n You can use different ways at different times as you wish, based on your needs, availability, and convenience. Where applicable, you may request a Face-to-Face session from your counsellor by placing a formal request.",
            ),
            CurrentExpanded(
              current: "What is the role of TUCEE Organisation in Counsel-Me?",
              info:
                  "TUCEE Organisation is the originator, administrator and supervisor of the Counsel-Me platform. TUCEE recruits, examines, trains and coordinates all activities that take place on the Counsel-Me platform. However, the counselling services are provided by independent professional counsellors who work directly with you as a client. These counsellors are not employees of TUCEE Organisation and Counsel-Me does not manage them professionally. However, we ensure that all their actions are within the code of ethics and conduct of the counselling profession.  TUCEE’s mission is to build, maintain, and support a platform that allows users and counsellors communicate effectively, and to facilitate this relationship so both counsellor and client can get the most out of their interaction.",
            ),
            CurrentExpanded(
              current: "Can I hide my identity?",
              info:
                  "When you sign up, we do not ask you for your full name or contact information. You may pick any \"common name\" which will identify you in the system. When you decide to start the counselling process, we will ask you for emergency contact information which is kept safe in the system, so it can be used if your counsellor believes that you or someone else might be in danger.",
            ),
            CurrentExpanded(
              current: "How much does it cost?",
              info:
                  "The cost of counseling through Counsel-Me varies depending on your presenting issues and sessions.  Once you sign-up and you provide us with your intake information, an invoice will be sent to you and the mode of payment will be mutually discussed. You are required to make 50% payment before the start of a session. Do note that any unpaid bills may be passed on to a debt collection agency to pursue you.",
            ),
            CurrentExpanded(
              current:
                  "Will I still have to pay if I cancel my appointment late?",
              info:
                  "For operational cost and preventing access to the counsellor, you will pay 20% of the charge per hour if it is immediate cancellation. If you keep your booking for a whole day and cancel it the following day, you will pay 20% of the charge per week.",
            ),
            CurrentExpanded(
              current: "Why should I choose Counsel-Me?",
              info:
                  "1.Counsellors are available 24/7, thus all day and night.\n 2.No barrier to accessing a counsellor.\n3.You can choose to hide your identity and freely talk about your issue. \n 4.It is less expensive.\n5.It saves time and trouble of travelling to counsellor’s office.",
            ),
            CurrentExpanded(
              current: "How does Counsel-Me work? ",
              info:
                  "After signing up, you will be connected to at least 3 counsellors who are experts in your area of needs. You have the freedom to choose any of them after reading their brief profile. Once you get connected to the counsellor, all other sessions will be between you and your counsellor. However, Counsel-Me will contact you for a periodic assessment of the process to ensure service quality.",
            ),
            CurrentExpanded(
              current: "What issues can Counsel-Me help?",
              info:
                  "Our counsellors are from wide range of  speciality. Together, they are prepared to help you prevent, cope, overcome and / or implement actions that will promote your mental health for positive social and physical life. Clients come to us with wide-ranging problems, including:\n 1.Anxiety (generalised anxiety problems, panic attacks, agoraphobia, social anxiety, claustrophobia). \n 2.Career path programme (Programme selection, Career matching). \n 3.Workplace issues (stress, work-life imbalances, bullying, sexual harassment, financial literacy) .\n 4.Post retirement adjustment (isolation, emptiness, rejection by family, coping with inactiveness).\n 5.Relationship issues (breakups, divorce, affairs, choosing appropriate partners, loneliness, life adjustments, marital problems, arguments, jealousy, wedding and premarital issues) .\n 6.Depression (including suicidal thoughts, low mood, social withdrawal). \n 7.Low self-esteem and lack of confidence.\n 8.Sexual problems (impotence, internet/pornography/sex addiction, loss of desire, infertility). \n 9.Trauma (including post-traumatic stress disorder from accidents, rape and other attacks/incidents). \n 10.Obsessive-compulsive disorder .\n 11.Eating problems (including bulimia, binge eating, negative body image). \n 11.Phobias and fears \n 12.Addiction (drugs, sex, behavioural) \n 13.Abuse (including physical, verbal, emotional and sexual abuse). \n 14.Bereavement/grief/loss. \n 15.Coping with Anger, Excessive jealousy, envy and more.",
            ),
            CurrentExpanded(
              current:
                  "Will I still have to pay if I cancel my appointment late?",
              info:
                  "For operational cost and preventing access to the counsellor, you will pay 20% of the charge per hour if it is immediate cancellation. If you keep your booking for a whole day and cancel it the following day, you will pay 20% of the charge per week. \n ",
            ),
            CurrentExpanded(
              current:
                  "What are my personal responsibilites towards Counsel-Me",
              info:
                  "1.You need to open up and share all your issues as truthful as it is, hiding facts will prevent effective support system.\n 2.Do not record any counselling session.\n 3.Make it a point to assess your counsellor when the need arises.\n 4.Pay your bills promptly.\n 5.Always secure a siren setting where you will be online whenever you have a session.\n 6.If you have any secret that you have shared with someone, it is no more a secret.\n 7.When you share your secret with the counsellor, do not share it with anyone so that the counsellor could be held responsible when the information is heard anywhere .",
            ),
            CurrentExpanded(
              current:
                  "Needing help or answers to any questions that are not addressed here?",
              info:
                  "Call  0208-496-496\nWhatsApp: \nE-mail: icounselgh.ord@gmail.com\nFill the enquiry form",
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentExpanded extends StatelessWidget {
  final Function tapped;
  final IconData icon;
  final String current;
  final String info;

  const CurrentExpanded(
      {Key key, this.current, this.tapped, this.icon, this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      leading: Icon(this.icon, color: Colors.grey[500]),
      title: Text(
        this.current ?? "TitleKi",
        style:
            GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          margin: EdgeInsets.only(left: 15, right: 15, top: 5,bottom: 5),
          child: Text(
            this.info ?? "Info",
            style: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify
          ),
        )
      ],
    );
  }
}
