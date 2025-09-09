/// Mock API Service for Frontend-Only Development
/// Simulates backend API responses without requiring a real server
class MockApiService {
  static const Duration _simulatedDelay = Duration(milliseconds: 500);
  
  // Mock data storage
  static final List<Map<String, dynamic>> _mockInterns = [
    {
      "id": "intern_1",
      "internName": "Sarah Johnson",
      "batch": "2025-Summer",
      "roles": ["Frontend Developer", "UI/UX Designer"],
      "currentProjects": ["E-commerce Platform"],
      "tasksAssigned": [
        {
          "id": "task_1",
          "title": "Design Login Page",
          "description": "Create responsive login interface with Material Design 3",
          "status": "completed",
          "createdAt": "2025-01-15T10:30:00Z"
        },
        {
          "id": "task_2",
          "title": "Implement Navigation",
          "description": "Build responsive navigation bar",
          "status": "working",
          "createdAt": "2025-01-16T14:20:00Z"
        }
      ],
      "createdAt": "2025-01-10T09:00:00Z"
    },
    {
      "id": "intern_2",
      "internName": "Michael Chen",
      "batch": "2025-Summer",
      "roles": ["Backend Developer", "DevOps Engineer"],
      "currentProjects": ["API Gateway", "Microservices"],
      "tasksAssigned": [
        {
          "id": "task_3",
          "title": "Setup Database Schema",
          "description": "Design and implement user database schema",
          "status": "open",
          "createdAt": "2025-01-17T11:15:00Z"
        }
      ],
      "createdAt": "2025-01-12T10:30:00Z"
    },
    {
      "id": "intern_3",
      "internName": "Emily Rodriguez",
      "batch": "2025-Winter",
      "roles": ["Full Stack Developer"],
      "currentProjects": ["Mobile App", "Web Dashboard"],
      "tasksAssigned": [
        {
          "id": "task_4",
          "title": "Mobile UI Components",
          "description": "Create reusable Flutter widgets",
          "status": "todo",
          "createdAt": "2025-01-18T09:45:00Z"
        },
        {
          "id": "task_5",
          "title": "API Integration",
          "description": "Connect mobile app to backend services",
          "status": "pending",
          "createdAt": "2025-01-19T16:30:00Z"
        }
      ],
      "createdAt": "2025-01-08T14:20:00Z"
    },
    {
      "id": "intern_4",
      "internName": "David Kim",
      "batch": "2025-Spring",
      "roles": ["Data Scientist", "Backend Developer"],
      "currentProjects": ["Analytics Dashboard"],
      "tasksAssigned": [
        {
          "id": "task_6",
          "title": "Data Analysis Pipeline",
          "description": "Build automated data processing pipeline",
          "status": "working",
          "createdAt": "2025-01-20T13:10:00Z"
        }
      ],
      "createdAt": "2025-01-14T11:45:00Z"
    },
    {
      "id": "intern_5",
      "internName": "Lisa Wang",
      "batch": "2025-Summer",
      "roles": ["UI/UX Designer", "Frontend Developer"],
      "currentProjects": ["Design System"],
      "tasksAssigned": [
        {
          "id": "task_7",
          "title": "Component Library",
          "description": "Create comprehensive component library",
          "status": "deferred",
          "createdAt": "2025-01-21T08:30:00Z"
        }
      ],
      "createdAt": "2025-01-11T15:15:00Z"
    }
  ];

  /// Simulate network delay
  static Future<void> _simulateDelay() async {
    await Future.delayed(_simulatedDelay);
  }

  /// GET /interns - Get all interns with optional filtering
  static Future<Map<String, dynamic>> getAllInterns({
    String? batch,
    String? search,
    int? limit,
    int? offset,
  }) async {
    await _simulateDelay();
    
    try {
      List<Map<String, dynamic>> filteredInterns = List.from(_mockInterns);
      
      // Apply batch filter
      if (batch != null && batch.isNotEmpty) {
        filteredInterns = filteredInterns
            .where((intern) => intern['batch'] == batch)
            .toList();
      }
      
      // Apply search filter
      if (search != null && search.isNotEmpty) {
        filteredInterns = filteredInterns
            .where((intern) => intern['internName']
                .toString()
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }
      
      // Apply pagination
      int start = offset ?? 0;
      int end = limit != null ? start + limit : filteredInterns.length;
      end = end > filteredInterns.length ? filteredInterns.length : end;
      
      List<Map<String, dynamic>> paginatedInterns = 
          filteredInterns.sublist(start, end);
      
      return {
        'success': true,
        'data': paginatedInterns,
        'total': filteredInterns.length,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to fetch interns: ${e.toString()}',
      };
    }
  }

  /// POST /interns - Create a new intern
  static Future<Map<String, dynamic>> createIntern(Map<String, dynamic> internData) async {
    await _simulateDelay();
    
    try {
      // Validate required fields
      if (internData['internName'] == null || internData['internName'].isEmpty) {
        return {
          'success': false,
          'error': 'Intern name is required',
        };
      }
      
      // Generate new ID
      String newId = 'intern_${_mockInterns.length + 1}';
      
      // Create new intern object
      Map<String, dynamic> newIntern = {
        'id': newId,
        'internName': internData['internName'],
        'batch': internData['batch'] ?? '2025-Summer',
        'roles': internData['roles'] ?? [],
        'currentProjects': internData['currentProjects'] ?? [],
        'tasksAssigned': internData['tasksAssigned'] ?? [],
        'createdAt': DateTime.now().toIso8601String(),
      };
      
      // Add to mock storage
      _mockInterns.add(newIntern);
      
      return {
        'success': true,
        'data': newIntern,
        'message': 'Intern created successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to create intern: ${e.toString()}',
      };
    }
  }

  /// GET /interns/:id - Get specific intern
  static Future<Map<String, dynamic>> getIntern(String id) async {
    await _simulateDelay();
    
    try {
      Map<String, dynamic>? intern = _mockInterns
          .firstWhere((intern) => intern['id'] == id);
      
      return {
        'success': true,
        'data': intern,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Intern not found',
      };
    }
  }

  /// PATCH /interns/:id - Update intern
  static Future<Map<String, dynamic>> updateIntern(String id, Map<String, dynamic> updates) async {
    await _simulateDelay();
    
    try {
      int index = _mockInterns.indexWhere((intern) => intern['id'] == id);
      
      if (index == -1) {
        return {
          'success': false,
          'error': 'Intern not found',
        };
      }
      
      // Update intern data
      _mockInterns[index] = {..._mockInterns[index], ...updates};
      
      return {
        'success': true,
        'data': _mockInterns[index],
        'message': 'Intern updated successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to update intern: ${e.toString()}',
      };
    }
  }

  /// DELETE /interns/:id - Delete intern
  static Future<Map<String, dynamic>> deleteIntern(String id) async {
    await _simulateDelay();
    
    try {
      int index = _mockInterns.indexWhere((intern) => intern['id'] == id);
      
      if (index == -1) {
        return {
          'success': false,
          'error': 'Intern not found',
        };
      }
      
      _mockInterns.removeAt(index);
      
      return {
        'success': true,
        'message': 'Intern deleted successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to delete intern: ${e.toString()}',
      };
    }
  }

  /// GET /interns/count - Get total intern count
  static Future<Map<String, dynamic>> getInternCount() async {
    await _simulateDelay();
    
    return {
      'success': true,
      'count': _mockInterns.length,
    };
  }

  /// GET /interns/tasks/summary - Get task statistics
  static Future<Map<String, dynamic>> getTaskSummary() async {
    await _simulateDelay();
    
    try {
      Map<String, int> taskCounts = {
        'open': 0,
        'completed': 0,
        'todo': 0,
        'working': 0,
        'deferred': 0,
        'pending': 0,
      };
      
      int totalTasks = 0;
      
      for (var intern in _mockInterns) {
        List<dynamic> tasks = intern['tasksAssigned'] ?? [];
        totalTasks += tasks.length;
        
        for (var task in tasks) {
          String status = task['status'] ?? 'open';
          if (taskCounts.containsKey(status)) {
            taskCounts[status] = taskCounts[status]! + 1;
          }
        }
      }
      
      return {
        'success': true,
        'data': {
          'totalTasks': totalTasks,
          'statusBreakdown': taskCounts,
          'completionRate': totalTasks > 0 
              ? (taskCounts['completed']! / totalTasks * 100).round()
              : 0,
        },
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Failed to get task summary: ${e.toString()}',
      };
    }
  }

  /// Reset mock data to initial state
  static void resetMockData() {
    _mockInterns.clear();
    _mockInterns.addAll([
      // Re-add initial mock data
      {
        "id": "intern_1",
        "internName": "Sarah Johnson",
        "batch": "2025-Summer",
        "roles": ["Frontend Developer", "UI/UX Designer"],
        "currentProjects": ["E-commerce Platform"],
        "tasksAssigned": [
          {
            "id": "task_1",
            "title": "Design Login Page",
            "description": "Create responsive login interface with Material Design 3",
            "status": "completed",
            "createdAt": "2025-01-15T10:30:00Z"
          }
        ],
        "createdAt": "2025-01-10T09:00:00Z"
      },
      // Add other initial interns...
    ]);
  }
}
