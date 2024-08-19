import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MainWindow extends StatefulWidget {
  @override
  _MainWindowState createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  final List<String> _tabs = ['Feed', 'Chat', 'Account'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(),
                  _buildChatTab(),
                  _buildAccountTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TravelMate',
            style: GoogleFonts.pacifico(
              fontSize: 24,
              color: Colors.blue[700],
            ),
          ),
          Icon(Icons.notifications, color: Colors.blue[700]),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.blue[700],
        labelColor: Colors.blue[700],
        unselectedLabelColor: Colors.grey,
        tabs: _tabs.map((String name) => Tab(
          icon: Icon(
            name == 'Feed' ? Icons.home :
            name == 'Chat' ? Icons.chat :
            Icons.person,
          ),
          text: name,
        )).toList(),
      ),
    );
  }

  Widget _buildFeedTab() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildWelcomeMessage();
        }
        return _buildFeedItem();
      },
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to TravelMate!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Discover new friends and adventures around the world.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              'https://picsum.photos/400/300',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amazing trip to Paris!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Met some great people and visited the Eiffel Tower. Can\'t wait for the next adventure!',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showTravelPlanDialog();
        },
        child: Text('Start a new chat'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          textStyle: GoogleFonts.poppins(fontSize: 16),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  void _showTravelPlanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String destination = '';
        DateTime? startDate;
        DateTime? endDate;

        return AlertDialog(
          title: Text('Where are you traveling next?', style: GoogleFonts.poppins()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => destination = value,
                decoration: InputDecoration(labelText: 'Destination'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  DateTimeRange? dateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (dateRange != null) {
                    startDate = dateRange.start;
                    endDate = dateRange.end;
                  }
                },
                child: Text('Select travel dates'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement chat room logic based on destination and dates
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Joined chat for $destination')),
                );
              },
              child: Text('Join Chat'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAccountTab() {
    return Center(
      child: Text(
        'Account Settings',
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}