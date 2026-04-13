import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ModulesScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFA67C52),  // Dark green theme
          elevation: 0,
          title: const Text(
            'MODULES',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'SEMESTRE 1'),
              Tab(text: 'SEMESTRE 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildModuleList1(),
            _buildModuleList2(),
            const Center(child: Text('No exams scheduled for Semester 2')),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleList1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
            
              SizedBox(width: 8),
              Text(
                'Semaster I',
                style: TextStyle(
                  color:Color(0xFF004D40), 
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView(
                // Add all your modules here
                children: const [
                  ModuleItemTile(title: "Algorithmic"),
                  ModuleItemTile(title: "Math I"),
                  ModuleItemTile(title: "Chemistry I"),
                  ModuleItemTile(title: "Physics I"),
                  ModuleItemTile(title: "Physics I Lab"),
                  ModuleItemTile(title: "English I"),
                  ModuleItemTile(title: "Writing Methods, Ethics and Deontology"),
                   ModuleItemTile(title: "Free and Open-Source Software"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 Widget _buildModuleList2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
            
              SizedBox(width: 8),
              Text(
                'Semaster II',
                style: TextStyle(
                  color: Color(0xFF004D40),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView(
                // Add all your modules here
                children: const [
                  ModuleItemTile(title: "Math II "),
                  ModuleItemTile(title: "Math III"),
                  ModuleItemTile(title: "Chemistry II"),
                  ModuleItemTile(title: "Physics II"),
                  ModuleItemTile(title: "Physics II Lab"),
                  ModuleItemTile(title: "English II"),
                  ModuleItemTile(title: "Electrical Engineering I"),
                  ModuleItemTile(title: "Electrical Engineering I Lab"),
                   ModuleItemTile(title: "Introduction to C programming"),
                   ModuleItemTile(title: "Oral Presentation and information techniques"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


class ModuleItemTile extends StatelessWidget {
  final String title;

  const ModuleItemTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              
               
                  
                
              
              
               
                ],
              ),
            ),
      ],   
      
  
  );
  }
  }
