import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FAQTile(
                question: "What is bail?",
                answer:
                    "Bail is a legal process that allows an accused person to be temporarily released from custody while awaiting trial. It involves the payment of a certain amount of money or collateral to ensure the accused person appears in court for their trial.",
              ),
              FAQTile(
                question: "How can I apply for bail for my loved one?",
                answer:
                    "To apply for bail, you should consult with a lawyer or legal expert who can guide you through the process. They will help you prepare the necessary documents and represent your loved one in court to request bail.",
              ),
              FAQTile(
                question: "How long does the legal process usually take?",
                answer:
                    "The duration of the legal process can vary significantly depending on the complexity of the case and the backlog of cases in the court. It's essential to consult with your lawyer to get a better estimate for your specific situation.",
              ),
              FAQTile(
                question: "What are the common reasons for bail being denied?",
                answer:
                    "Bail may be denied for various reasons, including the severity of the charges, a history of failing to appear in court, the risk of flight, and concerns about public safety. Your lawyer can help address these concerns and present a strong case for bail.",
              ),
              FAQTile(
                question: "How can I find a pro bono lawyer?",
                answer:
                    "You can reach out to legal aid organizations, bar associations, or public defenders' offices to inquire about pro bono legal services. They can help connect you with lawyers who are willing to provide free legal representation.",
              ),
              FAQTile(
                question: "What should I do if my loved one is denied bail?",
                answer:
                    "If your loved one is denied bail, you can work with their lawyer to explore other legal options, such as appealing the decision or requesting a bail reduction hearing. It's crucial to stay informed and involved in the legal process.",
              ),
              FAQTile(
                question: "Can I visit my loved one in prison?",
                answer:
                    "Yes, you can typically visit your loved one in prison, but you may need to follow specific visitation rules and schedules. Contact the prison authorities for more information on visitation procedures and requirements.",
              ),
              FAQTile(
                question:
                    "What support services are available for families of prisoners?",
                answer:
                    "There are various support services and organizations that offer assistance and guidance to families of prisoners. They can provide emotional support, legal advice, and information on resources available to you.",
              ),
              // Add more FAQs here
            ],
          ),
        ),
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  FAQTile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
