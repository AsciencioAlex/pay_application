import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        primaryColor: Color(0xFF8B1D9E),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section with Purple Background
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF8B1D9E), // Purple background color
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        'PM',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.history, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionHistoryPage()),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Dash Wallet',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'S\$ XXXX.XX',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildTopActionItem('assets/top_up.png', 'Top up'),
                    buildTopActionItem(
                        'assets/send_money.png', 'Send money', context),
                    buildTopActionItem('assets/visa.png', 'Visa'),
                  ],
                ),
              ],
            ),
          ),
          // Grid Section with White Background
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  buildGridItem('assets/digital.png', 'Digital bank'),
                  buildGridItem('assets/invest.png', 'Invest'),
                  buildGridItem('assets/prepaid.png', 'Prepaid/Bills'),
                  buildGridItem('assets/grow.png', 'Grow money'),
                  buildGridItem('assets/insurance.png', 'Insurance'),
                  buildGridItem('assets/remit.png', 'Remit'),
                  buildGridItem('assets/fave.png', 'Fave'),
                  buildGridItem('assets/bill.png', 'Bill'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopActionItem(String imagePath, String label,
      [BuildContext? context]) {
    return GestureDetector(
      onTap: () {
        if (label == 'Send money' && context != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SendMoneyPage()),
          );
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildGridItem(String assetPath, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(12.0),
          child: Image.asset(
            assetPath,
            width: 40, // Adjust the width as needed
            height: 40, // Adjust the height as needed
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class SendMoneyPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Send Money',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            labelColor: Color(0xFF8B1D9E), // Tab active color
            unselectedLabelColor: Colors.black54,
            indicatorColor: Color(0xFF8B1D9E), // Indicator color
            tabs: [
              Tab(text: 'Transfer Locally'),
              Tab(text: 'Remit Overseas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Transfer Locally Tab
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Enter phone number or name here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Using Dash account',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_balance),
                      title: Text('Bank / Wallet Account'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to Bank / Wallet Account page (can be implemented similarly)
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Image.asset('assets/paynow.png', width: 24),
                      title: Text('PayNow'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentDetailsPage()),
                        );
                      },
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '\$1 will be charged for cash transfers from your Dash wallet to bank accounts.',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(child: Text('Remit Overseas content goes here')),
          ],
        ),
      ),
    );
  }
}

class PaymentDetailsPage extends StatefulWidget {
  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  String? _selectedAccountDetail = 'Mobile number';
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Send with PayNow',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter account details',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B1D9E)),
            ),
            SizedBox(height: 20),
            buildRadioButton('Mobile number'),
            if (_selectedAccountDetail == 'Mobile number')
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter phone number or name here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            SizedBox(height: 10),
            buildRadioButton('NRIC/FIN'),
            if (_selectedAccountDetail == 'NRIC/FIN')
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter NRIC/FIN here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            SizedBox(height: 10),
            buildRadioButton('Unique Entity Number (UEN)'),
            if (_selectedAccountDetail == 'Unique Entity Number (UEN)')
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter UEN here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            SizedBox(height: 10),
            buildRadioButton('Virtual Payment Address (VPA)'),
            if (_selectedAccountDetail == 'Virtual Payment Address (VPA)')
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter VPA here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8B1D9E),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                TransactionHistoryPage.addTransaction(
                  context,
                  'Sent to ${_controller.text}', // Example title
                  '-S\$ 80.00', // Example amount
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReceiptPage(
                            amount: "80.00", // Example amount
                            recipient:
                                _controller.text, // Pass recipient name/number
                          )),
                );
              },
              child: Text('Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioButton(String value) {
    return ListTile(
      title: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedAccountDetail,
        onChanged: (String? newValue) {
          setState(() {
            _selectedAccountDetail = newValue;
            _controller.clear(); // Clear the text field when switching
          });
        },
      ),
    );
  }
}

class ReceiptPage extends StatelessWidget {
  final String amount;
  final String recipient;

  ReceiptPage({required this.amount, required this.recipient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFF8B1D9E), // Background color similar to the image
      appBar: AppBar(
        backgroundColor: Color(0xFF8B1D9E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Your Receipt', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '-S\$ $amount',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              buildReceiptItem('PayNow Mobile', recipient),
              buildReceiptItem(
                  'PayNow Reference', '20240629100267023457P0176649'),
              buildReceiptItem('Description', 'Send to $recipient'),
              buildReceiptItem('Fee', 'S\$ 1.00'),
              buildReceiptItem('Transaction ID', '115985196'),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8B1D9E),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReceiptItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          Flexible(
            child: Text(value,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class TransactionHistoryPage extends StatelessWidget {
  static List<Map<String, String>> transactions = [
    {
      "date": "20 Aug 2024",
      "title": "Mcdonald's (bgv)",
      "time": "04:45 PM",
      "amount": "-S\$ 8.00"
    },
    {
      "date": "19 Aug 2024",
      "title": "Sent To 6598465466",
      "time": "07:26 PM",
      "amount": "-S\$ 10.80"
    },
    {
      "date": "19 Aug 2024",
      "title": "Shengsiong@yishun845",
      "time": "04:49 PM",
      "amount": "-S\$ 1.41"
    },
    {
      "date": "19 Aug 2024",
      "title": "Received Dash Top-Up",
      "time": "04:46 PM",
      "amount": "S\$ 20.00"
    },
    {
      "date": "16 Aug 2024",
      "title": "Shengsiong@yishun845",
      "time": "05:12 PM",
      "amount": "-S\$ 7.06"
    },
    {
      "date": "14 Aug 2024",
      "title": "Mcdonalds 930040",
      "time": "02:19 PM",
      "amount": "-S\$ 8.10"
    },
  ];

  static void addTransaction(
      BuildContext context, String title, String amount) {
    String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    String currentTime = DateFormat('hh:mm a').format(DateTime.now());

    transactions.insert(0, {
      "date": currentDate,
      "title": title,
      "time": currentTime,
      "amount": amount,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransactionHistoryPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 ||
                  transactions[index]['date'] !=
                      transactions[index - 1]['date'])
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    transactions[index]['date']!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ListTile(
                title: Text(transactions[index]['title']!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(transactions[index]['time']!),
                trailing: Text(transactions[index]['amount']!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
