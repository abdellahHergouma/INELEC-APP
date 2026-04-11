import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Below is a dynamic version that allows users to add modules,
// grades, and coefficients, and calculates the weighted average accordingly.

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _moduleController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _coeffController = TextEditingController();
  final List<_GradeEntry> _entries = [];

  // Using shared preferences to persist data across app restarts.
  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('grade_entries') ?? [];
    setState(() {
      _entries.clear();
      for (var entry in savedData) {
        final parts = entry.split('|');
        if (parts.length == 3) {
          _entries.add(
            _GradeEntry(
              parts[0],
              double.tryParse(parts[1]) ?? 0,
              double.tryParse(parts[2]) ?? 0,
            ),
          );
        }
      }
    });
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final dataToSave = _entries
        .map((e) => '${e.module}|${e.grade}|${e.coeff}')
        .toList();
    await prefs.setStringList('grade_entries', dataToSave);
  }

  @override
  void initState() {
    super.initState();
    _loadEntries(); // Entries will be loaded when the screen initializes
  }

  double get _weightedAverage {
    final totalWeight = _entries.fold<double>(
      0,
      (sum, entry) => sum + entry.coeff,
    );
    if (totalWeight == 0) return 0;
    final totalPoints = _entries.fold<double>(
      0,
      (sum, entry) => sum + entry.grade * entry.coeff,
    );
    return totalPoints / totalWeight;
  }

  bool get _isPassed => _weightedAverage >= 10;

  void _addEntry() {
    if (!_formKey.currentState!.validate()) return;

    final moduleName = _moduleController.text.trim();
    final grade = double.parse(_gradeController.text.trim());
    final coeff = double.parse(_coeffController.text.trim());

    setState(() {
      _entries.add(_GradeEntry(moduleName, grade, coeff));
      _moduleController.clear();
      _gradeController.clear();
      _coeffController.clear();
    });
    _saveEntries(); // Save entries whenever a new one is added
  }

  void _removeEntry(int index) {
    setState(() {
      _entries.removeAt(index);
    });
    _saveEntries(); // Save entries whenever one is removed
  }

  @override
  void dispose() {
    _moduleController.dispose();
    _gradeController.dispose();
    _coeffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final headingBackgroundColor = isDarkMode
        ? Colors.grey[850]
        : const Color(0xFFEDE6F3);
    final headingTextColor = isDarkMode ? Colors.white70 : Colors.black;
    final cardBackgroundColor = isDarkMode
        ? Colors.grey[900]
        : const Color(0xFFF3F0FA);
    final cardBorderColor = isDarkMode
        ? Colors.grey[700]
        : const Color(0xFFDDD7EB);
    final bodyTextColor = isDarkMode ? Colors.grey[200] : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[700];
    final resultTextColor = _entries.isEmpty
        ? (isDarkMode ? Colors.grey[500] : Colors.grey)
        : (_isPassed ? Colors.green : Colors.red);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  const Icon(Icons.school, color: Color(0xFF701B99), size: 50),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Grade Calculator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _moduleController,
                      decoration: const InputDecoration(
                        labelText: 'Module Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter the module name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _gradeController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Grade',
                              hintText: 'e.g. 14.5',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter a grade';
                              }
                              final grade = double.tryParse(value);
                              if (grade == null || grade < 0 || grade > 20) {
                                return 'Grade must be 0-20';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _coeffController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'Coeff',
                              hintText: 'e.g. 2',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter a coefficient';
                              }
                              final coeff = double.tryParse(value);
                              if (coeff == null || coeff <= 0) {
                                return 'Coeff must be > 0';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Add Module',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF701B99),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _addEntry,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _entries.isEmpty
                    ? Center(
                        child: Text(
                          'Add modules to calculate your weighted average.',
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF701B99),
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: SingleChildScrollView(
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              headingBackgroundColor,
                            ),
                            columnSpacing: 16,
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Module',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: headingTextColor,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Grade',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: headingTextColor,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Coeff',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: headingTextColor,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '',
                                  style: TextStyle(color: headingTextColor),
                                ),
                              ),
                            ],
                            rows: List.generate(_entries.length, (index) {
                              final entry = _entries[index];
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      entry.module,
                                      style: TextStyle(color: bodyTextColor),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      entry.grade.toStringAsFixed(1),
                                      style: TextStyle(color: bodyTextColor),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      entry.coeff.toStringAsFixed(1),
                                      style: TextStyle(color: bodyTextColor),
                                    ),
                                  ),
                                  DataCell(
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => _removeEntry(index),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cardBorderColor!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weighted Average: ${_weightedAverage.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: bodyTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Result:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: bodyTextColor,
                          ),
                        ),
                        Text(
                          _entries.isEmpty
                              ? 'No modules added'
                              : (_isPassed ? 'Passed' : 'Failed'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: resultTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradeEntry {
  final String module;
  final double grade;
  final double coeff;

  _GradeEntry(this.module, this.grade, this.coeff);
}
