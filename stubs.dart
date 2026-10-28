import 'package:flutter/material.dart';

// =====================================================
// DATA MODELS FOR PERSISTENT STORAGE
// =====================================================

class FieldData {
  final String fieldName;
  final double width;
  final double length;
  double get area => width * length;
  String get soilType => _getSoilType();

  FieldData({
    required this.fieldName,
    required this.width,
    required this.length,
  });

  String _getSoilType() {
    // Simulated soil lookup based on area
    if (area < 100) return "Sandy Loam";
    if (area < 500) return "Clayey Loam";
    if (area < 1000) return "Rich Black Soil";
    return "Alluvial Soil";
  }
}

class HarvestRecord {
  final String cropName;
  final double quantity; // in kg
  final DateTime date;
  final String notes;

  double get yield => quantity;

  HarvestRecord({
    required this.cropName,
    required this.quantity,
    required this.date,
    required this.notes,
  });
}

class FarmTask {
  final String title;
  final String description;
  final DateTime dueDate; // Full date/time
  final String category; // farming, maintenance, harvest
  bool isCompleted;

  FarmTask({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    this.isCompleted = false,
  });

  String getTimeString() {
    return '${dueDate.hour.toString().padLeft(2, '0')}:${dueDate.minute.toString().padLeft(2, '0')}';
  }
}

// Global data storage
class FarmingAppData {
  static final FarmingAppData _instance = FarmingAppData._internal();

  factory FarmingAppData() {
    return _instance;
  }

  FarmingAppData._internal();

  List<FieldData> fields = [];
  List<HarvestRecord> harvests = [];
  List<FarmTask> tasks = [];
}

// =====================================================
// STUB PAGES
// =====================================================

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: const Center(
        child: Text(
          "Forgot Password Feature - Coming Soon",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AdvancedFeaturesPage extends StatelessWidget {
  final String currentLanguage;

  const AdvancedFeaturesPage({super.key, required this.currentLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Tools"),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: const Center(
        child: Text(
          "Advanced Tools Feature - Coming Soon",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// =====================================================
// TOOLS HUB PAGE - Navigation to all tools
// =====================================================

class ToolsPage extends StatefulWidget {
  final String currentLanguage;

  const ToolsPage({super.key, required this.currentLanguage});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  final List<Map<String, dynamic>> tools = [
    {
      "title": "Agricultural Map",
      "subtitle": "Manage your fields",
      "icon": Icons.map_outlined,
      "color": const Color(0xFF4CAF50),
      "description": "Calculate field areas, track soil data, manage locations",
    },
    {
      "title": "Production Statistics",
      "subtitle": "Track harvest data",
      "icon": Icons.bar_chart_rounded,
      "color": const Color(0xFF2196F3),
      "description": "Log harvests, calculate yield metrics, view analytics",
    },
    {
      "title": "Farming Chatbot",
      "subtitle": "Get farming advice",
      "icon": Icons.smart_toy_outlined,
      "color": const Color(0xFFFF9800),
      "description": "Ask real farming questions, get instant answers",
    },
    {
      "title": "Smart Calendar",
      "subtitle": "Manage farm tasks",
      "icon": Icons.calendar_today,
      "color": const Color(0xFF4CAF50),
      "description": "Schedule tasks, set times, track completion status",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text("Farming Tools"),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(
              tools.length,
              (index) {
                final tool = tools[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      _navigateToTool(context, tool['title']);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: tool['color'] as Color,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: (tool['color'] as Color).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              tool['icon'] as IconData,
                              color: tool['color'] as Color,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tool['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tool['description'] as String,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: tool['color'] as Color,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToTool(BuildContext context, String toolName) {
    Widget page;
    switch (toolName) {
      case "Agricultural Map":
        page = const AgricultureMapPage();
        break;
      case "Production Statistics":
        page = const ProductionStatisticsPage();
        break;
      case "Farming Chatbot":
        page = const FarmingChatbotPage();
        break;
      case "Smart Calendar":
        page = const SmartCalendarPage();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

// =====================================================
// TOOL 1: AGRICULTURAL MAP
// =====================================================

class AgricultureMapPage extends StatefulWidget {
  const AgricultureMapPage({super.key});

  @override
  State<AgricultureMapPage> createState() => _AgricultureMapPageState();
}

class _AgricultureMapPageState extends State<AgricultureMapPage> {
  final _fieldNameController = TextEditingController();
  final _widthController = TextEditingController();
  final _lengthController = TextEditingController();
  final data = FarmingAppData();

  void _addField() {
    if (_fieldNameController.text.isEmpty ||
        _widthController.text.isEmpty ||
        _lengthController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final field = FieldData(
      fieldName: _fieldNameController.text,
      width: double.parse(_widthController.text),
      length: double.parse(_lengthController.text),
    );

    setState(() {
      data.fields.add(field);
    });

    _fieldNameController.clear();
    _widthController.clear();
    _lengthController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${field.fieldName} added! Area: ${field.area.toStringAsFixed(2)} m²")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text("Agricultural Map"),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Field",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fieldNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Field Name",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _widthController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Width (m)",
                      labelStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _lengthController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Length (m)",
                      labelStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _addField,
                child: const Text(
                  "Add Field",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Your Fields",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (data.fields.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "No fields added yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              )
            else
              Column(
                children: List.generate(
                  data.fields.length,
                  (index) {
                    final field = data.fields[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              field.fieldName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Area: ${field.area.toStringAsFixed(2)} m²",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  "Soil: ${field.soilType}",
                                  style: const TextStyle(
                                    color: Color(0xFF4CAF50),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fieldNameController.dispose();
    _widthController.dispose();
    _lengthController.dispose();
    super.dispose();
  }
}

// =====================================================
// TOOL 2: PRODUCTION STATISTICS
// =====================================================

class ProductionStatisticsPage extends StatefulWidget {
  const ProductionStatisticsPage({super.key});

  @override
  State<ProductionStatisticsPage> createState() => _ProductionStatisticsPageState();
}

class _ProductionStatisticsPageState extends State<ProductionStatisticsPage> {
  final _cropController = TextEditingController();
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();
  final data = FarmingAppData();

  void _addHarvest() {
    if (_cropController.text.isEmpty || _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill required fields")),
      );
      return;
    }

    final record = HarvestRecord(
      cropName: _cropController.text,
      quantity: double.parse(_quantityController.text),
      date: DateTime.now(),
      notes: _notesController.text,
    );

    setState(() {
      data.harvests.add(record);
    });

    _cropController.clear();
    _quantityController.clear();
    _notesController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Harvest recorded: ${record.quantity}kg of ${record.cropName}")),
    );
  }

  double _getTotalYield() {
    return data.harvests.fold(0, (sum, record) => sum + record.quantity);
  }

  double _getAverageYield() {
    if (data.harvests.isEmpty) return 0;
    return _getTotalYield() / data.harvests.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text("Production Statistics"),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Harvest Record",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cropController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Crop Name",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Quantity (kg)",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Notes",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _addHarvest,
                child: const Text(
                  "Record Harvest",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF2196F3).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Yield",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${_getTotalYield().toStringAsFixed(2)} kg",
                          style: const TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF2196F3).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Avg. Yield",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${_getAverageYield().toStringAsFixed(2)} kg",
                          style: const TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Harvest History",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (data.harvests.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "No harvest records yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              )
            else
              Column(
                children: List.generate(
                  data.harvests.length,
                  (index) {
                    final record = data.harvests[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF2196F3).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  record.cropName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${record.quantity} kg",
                                  style: const TextStyle(
                                    color: Color(0xFF2196F3),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              record.date.toString().split('.')[0],
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            if (record.notes.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                record.notes,
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cropController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

// =====================================================
// TOOL 3: FARMING CHATBOT
// =====================================================

class FarmingChatbotPage extends StatefulWidget {
  const FarmingChatbotPage({super.key});

  @override
  State<FarmingChatbotPage> createState() => _FarmingChatbotPageState();
}

class _FarmingChatbotPageState extends State<FarmingChatbotPage> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  final List<ChatMessage> _messages = [];
  String? _selectedImageAsset;
  String? _selectedFileName;

  final Map<String, String> farmingKnowledgeBase = {
    'irrigation': 'For efficient irrigation, water crops early morning or late evening to reduce evaporation. Use drip irrigation for 30-40% water savings. Check soil moisture before watering.',
    'fertilizer': 'Apply fertilizer based on soil test results. Use NPK ratio 10-26-26 for vegetables, 20-20-0 for leafy greens. Apply during rainy season for best results.',
    'pest control': 'Use integrated pest management: remove affected plants, use neem oil spray, introduce beneficial insects. Rotate crops annually to reduce pest buildup.',
    'soil preparation': 'Prepare soil by adding compost/organic matter 2-3 weeks before planting. Test soil pH (6-7 is ideal for most crops). Ensure good drainage.',
    'crop rotation': 'Rotate crops to prevent soil depletion: legumes → cereals → vegetables. This improves soil fertility and reduces disease.',
    'watering': 'Most crops need 25-50mm water per week. Water at roots, not leaves. Adjust based on rainfall and soil type.',
    'disease': 'Prevent diseases: ensure good air circulation, avoid overhead watering, remove infected plants quickly, use crop rotation.',
    'image analysis': 'I can help analyze crop images! Upload a photo and I\'ll identify diseases, nutritional deficiencies, or pest issues. Great for diagnosing plant problems.',
  };

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _addInitialMessage();
  }

  void _addInitialMessage() {
    _messages.add(
      ChatMessage(
        text: 'Hi! 👋 I\'m your farming assistant. Ask me anything about irrigation, fertilizer, pests, soil, crop rotation, watering, or upload photos for disease analysis!',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _selectImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Image Source',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF4CAF50)),
              title: const Text('Gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _selectedImageAsset = 'assets/sample_crop.png';
                  _selectedFileName = 'crop_image.png';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF4CAF50)),
              title: const Text('Camera', style: TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _selectedImageAsset = 'assets/sample_field.png';
                  _selectedFileName = 'field_photo.png';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectFile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select File Type',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.description, color: Color(0xFF4CAF50)),
              title: const Text('PDF Document', style: TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _selectedFileName = 'farming_guide.pdf';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF file selected for upload')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart, color: Color(0xFF4CAF50)),
              title: const Text('Excel Sheet', style: TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _selectedFileName = 'harvest_data.xlsx';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Excel file selected for upload')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields, color: Color(0xFF4CAF50)),
              title: const Text('Text File', style: TextStyle(color: Colors.white)),
              onTap: () {
                setState(() {
                  _selectedFileName = 'farm_notes.txt';
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Text file selected for upload')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getResponse(String userMessage) {
    String lowerMessage = userMessage.toLowerCase();

    for (var key in farmingKnowledgeBase.keys) {
      if (lowerMessage.contains(key)) {
        return farmingKnowledgeBase[key]!;
      }
    }

    if (lowerMessage.contains('help') || lowerMessage.contains('how')) {
      return 'I can help with: irrigation, fertilizer, pest control, soil preparation, crop rotation, watering, disease diagnosis, and image analysis. Upload photos to analyze plant health!';
    }

    if (_selectedImageAsset != null) {
      return 'I\'ve analyzed your image. The plant shows good growth with healthy green coloring. Make sure to provide sufficient water and nutrients for optimal yield.';
    }

    if (_selectedFileName != null) {
      return 'I\'ve received your file: $_selectedFileName. I can help integrate this data into your farming strategy.';
    }

    return 'Please ask about specific farming topics or upload an image/file for analysis.';
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty && _selectedImageAsset == null && _selectedFileName == null) return;

    final userMessage = _messageController.text.trim();

    setState(() {
      _messages.add(ChatMessage(
        text: userMessage.isEmpty ? '📤 Uploaded: ${_selectedFileName ?? _selectedImageAsset}' : userMessage,
        isUser: true,
        timestamp: DateTime.now(),
        imageAsset: _selectedImageAsset,
        fileName: _selectedFileName,
        fileType: _selectedFileName != null
            ? (_selectedFileName!.endsWith('.pdf') ? 'pdf' : _selectedFileName!.endsWith('.xlsx') ? 'excel' : 'text')
            : null,
      ));
    });

    _messageController.clear();
    _selectedImageAsset = null;
    _selectedFileName = null;

    Future.delayed(const Duration(milliseconds: 500), () {
      final response = _getResponse(userMessage);
      setState(() {
        _messages.add(ChatMessage(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Row(
          children: [
            Text('🌿 Farming Assistant', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Plant Background Pattern
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0A0A0A),
                  const Color(0xFF1A3A1A).withValues(alpha: 0.3),
                  const Color(0xFF0A0A0A),
                ],
              ),
            ),
          ),
          // Decorative leaf elements
          Positioned(
            top: -30,
            right: -20,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Icons.eco,
                size: 200,
                color: const Color(0xFF4CAF50),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -40,
            child: Opacity(
              opacity: 0.04,
              child: Icon(
                Icons.grass,
                size: 250,
                color: const Color(0xFF4CAF50),
              ),
            ),
          ),
          // Chat content
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message.isUser;
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isUser) ...[
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4CAF50),
                                    Color(0xFF66BB6A),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text('🤖', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Flexible(
                            child: Column(
                              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                // Image display
                                if (message.imageAsset != null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          color: const Color(0xFF2A2A2A),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.image, color: Color(0xFF4CAF50), size: 40),
                                              const SizedBox(height: 8),
                                              Text(
                                                message.fileName ?? 'Image',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                // File indicator
                                if (message.fileName != null && message.imageAsset == null)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2A2A2A),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            message.fileType == 'pdf'
                                                ? Icons.description
                                                : message.fileType == 'excel'
                                                    ? Icons.table_chart
                                                    : Icons.text_fields,
                                            color: const Color(0xFF4CAF50),
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            message.fileName ?? 'File',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                // Text message
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isUser
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFF1A1A1A),
                                    borderRadius: BorderRadius.circular(18),
                                    border: !isUser
                                        ? Border.all(
                                            color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                                            width: 1,
                                          )
                                        : null,
                                    boxShadow: [
                                      BoxShadow(
                                        color: isUser
                                            ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
                                            : Colors.black.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.text,
                                        style: TextStyle(
                                          color: isUser ? Colors.white : Colors.white,
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: isUser ? FontWeight.w500 : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTime(message.timestamp),
                                        style: TextStyle(
                                          color: isUser
                                              ? Colors.white.withValues(alpha: 0.7)
                                              : Colors.white.withValues(alpha: 0.5),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isUser) ...[
                            const SizedBox(width: 10),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4CAF50),
                                    Color(0xFF66BB6A),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text('👤', style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Input area with modern style
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  border: Border(
                    top: BorderSide(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Show selected file preview
                      if (_selectedFileName != null || _selectedImageAsset != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        _selectedImageAsset != null ? Icons.image : Icons.attach_file,
                                        color: const Color(0xFF4CAF50),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _selectedFileName ?? _selectedImageAsset ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedFileName = null;
                                      _selectedImageAsset = null;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // Message input and action buttons
                      Row(
                        children: [
                          // Image button
                          GestureDetector(
                            onTap: _selectImage,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2A2A),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                                ),
                              ),
                              child: const Icon(
                                Icons.image_outlined,
                                color: Color(0xFF4CAF50),
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // File button
                          GestureDetector(
                            onTap: _selectFile,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2A2A),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                                ),
                              ),
                              child: const Icon(
                                Icons.attach_file_outlined,
                                color: Color(0xFF4CAF50),
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Text input
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2A2A),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: _messageController,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                                maxLines: null,
                                textInputAction: TextInputAction.send,
                                decoration: InputDecoration(
                                  hintText: '💬 Ask about farming...',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Send button
                          GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4CAF50),
                                    Color(0xFF66BB6A),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? imageAsset; // Path to image asset
  final String? fileName; // File name if attachment
  final String? fileType; // Type of file (image, pdf, doc, etc)

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.imageAsset,
    this.fileName,
    this.fileType,
  });
}

// =====================================================
// TOOL 4: SMART CALENDAR
// =====================================================

class SmartCalendarPage extends StatefulWidget {
  const SmartCalendarPage({super.key});

  @override
  State<SmartCalendarPage> createState() => _SmartCalendarPageState();
}

class _SmartCalendarPageState extends State<SmartCalendarPage> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;
  late TimeOfDay _selectedTime;
  final FarmingAppData _data = FarmingAppData();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescController = TextEditingController();
  String _selectedCategory = 'farming';

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _displayedMonth = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescController.dispose();
    super.dispose();
  }

  // Get tasks for a specific date
  List<FarmTask> _getTasksForDate(DateTime date) {
    final tasks = _data.tasks.where((task) {
      return task.dueDate.year == date.year &&
          task.dueDate.month == date.month &&
          task.dueDate.day == date.day;
    }).toList();
    // Sort by time
    tasks.sort((a, b) => a.dueDate.hour.compareTo(b.dueDate.hour));
    return tasks;
  }

  // Get remaining tasks (not completed)
  List<FarmTask> _getRemainingTasks(DateTime date) {
    return _getTasksForDate(date).where((task) => !task.isCompleted).toList();
  }

  // Get completed tasks
  List<FarmTask> _getCompletedTasks(DateTime date) {
    return _getTasksForDate(date).where((task) => task.isCompleted).toList();
  }

  // Add new task
  void _addTask() {
    if (_taskNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task name')),
      );
      return;
    }

    // Create DateTime with selected date and time
    final taskDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final newTask = FarmTask(
      title: _taskNameController.text,
      description: _taskDescController.text,
      dueDate: taskDateTime,
      category: _selectedCategory,
    );

    setState(() {
      _data.tasks.add(newTask);
      _taskNameController.clear();
      _taskDescController.clear();
      _selectedTime = TimeOfDay.now();
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task "${newTask.title}" added at ${newTask.getTimeString()}',
        ),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  // Delete task
  void _deleteTask(FarmTask task) {
    setState(() {
      _data.tasks.remove(task);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  // Toggle task completion
  void _toggleTaskCompletion(FarmTask task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  // Format date display
  String _formatDate(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[date.weekday - 1]} ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // Get days in month
  int _getDaysInMonth(DateTime date) {
    if (date.month == 12) {
      return 31;
    }
    return DateTime(date.year, date.month + 1, 0).day;
  }

  // Get first day of month (0=Monday, 6=Sunday)
  int _getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1).weekday - 1;
  }

  // Show add task dialog with time picker
  void _showAddTaskDialog() {
    _taskNameController.clear();
    _taskDescController.clear();
    _selectedCategory = 'farming';
    _selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => Dialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Task for ${_formatDate(_selectedDate)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Task name input
                  TextField(
                    controller: _taskNameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Task name (e.g., Water crops)',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                      prefixIcon: const Icon(Icons.edit, color: Color(0xFF4CAF50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF66BB6A), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Task description input
                  TextField(
                    controller: _taskDescController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Task details (optional)',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                      prefixIcon: const Icon(Icons.description, color: Color(0xFF4CAF50)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF66BB6A), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Time picker
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (pickedTime != null) {
                        setStateDialog(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF4CAF50), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, color: Color(0xFF4CAF50)),
                          const SizedBox(width: 12),
                          Text(
                            'Time: ${_selectedTime.format(context)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, color: Color(0xFF4CAF50), size: 14),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category selector
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF4CAF50), width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      dropdownColor: const Color(0xFF2A2A2A),
                      underline: const SizedBox(),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: 'farming',
                          child: Row(
                            children: [
                              const Icon(Icons.grass, color: Color(0xFF4CAF50)),
                              const SizedBox(width: 8),
                              const Text('Farming', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'maintenance',
                          child: Row(
                            children: [
                              const Icon(Icons.build, color: Color(0xFF4CAF50)),
                              const SizedBox(width: 8),
                              const Text('Maintenance', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'harvest',
                          child: Row(
                            children: [
                              const Icon(Icons.local_florist, color: Color(0xFF4CAF50)),
                              const SizedBox(width: 8),
                              const Text('Harvest', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setStateDialog(() {
                          _selectedCategory = value ?? 'farming';
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2A2A2A),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _addTask,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Add Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Show task details
  void _showTaskDetails(FarmTask task) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task.category.toUpperCase(),
                  style: const TextStyle(color: Color(0xFF4CAF50), fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // Date and Time
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF4CAF50), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(task.dueDate),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Color(0xFF4CAF50), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    task.getTimeString(),
                    style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Description
              if (task.description.isNotEmpty) ...[
                const Text(
                  'Details:',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
                ),
                const SizedBox(height: 16),
              ],
              // Status
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: task.isCompleted ? Colors.greenAccent.withValues(alpha: 0.1) : Colors.orangeAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      task.isCompleted ? Icons.check_circle : Icons.schedule,
                      color: task.isCompleted ? Colors.greenAccent : Colors.orangeAccent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      task.isCompleted ? 'Completed' : 'Pending',
                      style: TextStyle(
                        color: task.isCompleted ? Colors.greenAccent : Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _toggleTaskCompletion(task);
                        Navigator.pop(context);
                      },
                      icon: Icon(task.isCompleted ? Icons.undo : Icons.check),
                      label: Text(task.isCompleted ? 'Mark Incomplete' : 'Mark Complete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _deleteTask(task);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_displayedMonth);
    final firstDayOffset = _getFirstDayOfMonth(_displayedMonth);
    final monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final remainingTasks = _getRemainingTasks(_selectedDate);
    final completedTasks = _getCompletedTasks(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('📅 Smart Farm Calendar', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Month navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1);
                    });
                  },
                  icon: const Icon(Icons.chevron_left, color: Color(0xFF4CAF50), size: 28),
                ),
                Text(
                  '${monthNames[_displayedMonth.month - 1]} ${_displayedMonth.year}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1);
                    });
                  },
                  icon: const Icon(Icons.chevron_right, color: Color(0xFF4CAF50), size: 28),
                ),
              ],
            ),
          ),
          // Calendar grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Day headers
                Row(
                  children: dayNames.map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                // Calendar days
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: firstDayOffset + daysInMonth,
                  itemBuilder: (context, index) {
                    if (index < firstDayOffset) {
                      return const SizedBox();
                    }

                    final dayNumber = index - firstDayOffset + 1;
                    final date = DateTime(_displayedMonth.year, _displayedMonth.month, dayNumber);
                    final isSelected = date.year == _selectedDate.year &&
                        date.month == _selectedDate.month &&
                        date.day == _selectedDate.day;
                    final isToday = date.year == DateTime.now().year &&
                        date.month == DateTime.now().month &&
                        date.day == DateTime.now().day;

                    final tasksForDay = _getTasksForDate(date);
                    final hasCompletedTasks = tasksForDay.where((t) => t.isCompleted).isNotEmpty;
                    final hasIncompleteTasks = tasksForDay.where((t) => !t.isCompleted).isNotEmpty;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12),
                          border: isToday
                              ? Border.all(color: const Color(0xFF4CAF50), width: 2)
                              : Border.all(
                                  color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                                  width: 1,
                                ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    dayNumber.toString(),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                if (tasksForDay.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Wrap(
                                      spacing: 2,
                                      runSpacing: 2,
                                      children: [
                                        if (hasIncompleteTasks)
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: const BoxDecoration(
                                              color: Colors.orangeAccent,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        if (hasCompletedTasks)
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: const BoxDecoration(
                                              color: Colors.greenAccent,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Tasks section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Farm Tasks',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      _formatDate(_selectedDate),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _showAddTaskDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Task'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Tasks list
          Expanded(
            child: remainingTasks.isEmpty && completedTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.event_note, color: Color(0xFF4CAF50), size: 48),
                        const SizedBox(height: 12),
                        Text(
                          'No tasks for this date',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Remaining Tasks Section
                        if (remainingTasks.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.schedule, color: Colors.orangeAccent, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Remaining Tasks (${remainingTasks.length})',
                                  style: const TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...remainingTasks.map((task) {
                            final categoryIcons = {
                              'farming': Icons.grass,
                              'maintenance': Icons.build,
                              'harvest': Icons.local_florist,
                            };

                            return GestureDetector(
                              onTap: () => _showTaskDetails(task),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.orangeAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.orangeAccent.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        categoryIcons[task.category] ?? Icons.task,
                                        color: Colors.orangeAccent,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '⏰ ${task.getTimeString()}',
                                            style: const TextStyle(
                                              color: Colors.orangeAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (task.description.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(
                                                task.description,
                                                style: TextStyle(
                                                  color: Colors.white.withValues(alpha: 0.6),
                                                  fontSize: 11,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _toggleTaskCompletion(task),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.orangeAccent,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.orangeAccent,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                        // Completed Tasks Section
                        if (completedTasks.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'Completed Tasks (${completedTasks.length})',
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...completedTasks.map((task) {
                            final categoryIcons = {
                              'farming': Icons.grass,
                              'maintenance': Icons.build,
                              'harvest': Icons.local_florist,
                            };

                            return GestureDetector(
                              onTap: () => _showTaskDetails(task),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        categoryIcons[task.category] ?? Icons.task,
                                        color: Colors.greenAccent,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: Colors.greenAccent,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '⏰ ${task.getTimeString()}',
                                            style: const TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          if (task.description.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(
                                                task.description,
                                                style: TextStyle(
                                                  color: Colors.white.withValues(alpha: 0.4),
                                                  fontSize: 11,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
