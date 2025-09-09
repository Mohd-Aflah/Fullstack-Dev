# 🎓 Level 1: Backend Engineering Mastery

> **🎯 Enterprise Learning Goal**: Master backend development with Node.js and Appwrite database integration following industry best practices

## 📋 **Module Metadata**

| **Attribute** | **Details** |
|---------------|-------------|
| **Module Level** | Level 1: Backend Engineering Foundation |
| **Technology Focus** | Node.js + Appwrite Backend-as-a-Service |
| **Learning Path** | Enterprise Full-Stack Development Platform |
| **Author** | Mohammed Aflah - Backend Lead at Pro26 |
| **Organization** | Pro26 |
| **Version** | 1.0.0 |
| **License** | Pro26 & Mohd-Aflah - Educational Use Only |

---

## 📚 What You'll Learn

### For Beginners
- What is a backend server and why do we need it?
- How to create REST API endpoints
- Database operations (Create, Read, Update, Delete)
- Environment configuration and security
- API testing and debugging

### For Experienced Developers
- Modern Node.js development patterns
- Appwrite cloud database integration
- API design best practices
- Error handling and validation
- Production-ready backend architecture

## 🛠️ Technology Stack

- **Node.js**: JavaScript runtime for server-side development
- **Appwrite**: Backend-as-a-Service (BaaS) for database and authentication
- **HTTP Module**: Native Node.js web server
- **Environment Variables**: Secure configuration management
- **JSON**: Data exchange format

## 📁 Project Structure

```
01-backend-only/
├── backend/
│   ├── index.js              # 🔧 Appwrite integration & API logic
│   ├── main.js               # 🚀 HTTP server setup and routing
│   ├── mock.js               # 📝 Mock data for development
│   ├── package.json          # 📦 Dependencies and scripts
│   ├── .env                  # ⚙️ Environment configuration
│   ├── .gitignore           # 🚫 Files to exclude from git
│   └── README.md            # 📖 Backend documentation
└── README.md                # 📋 This guide
```

## 🚀 Complete Setup Guide

### Prerequisites Installation

#### 1. Install Node.js
**For Beginners**: Node.js is the runtime that allows JavaScript to run on servers.

**Windows**:
1. Visit [nodejs.org](https://nodejs.org/)
2. Download LTS version (recommended)
3. Run installer and follow instructions

**Mac**:
```bash
# Using Homebrew (recommended)
brew install node

# Or download from nodejs.org
```

**Linux**:
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nodejs npm

# CentOS/RHEL
sudo yum install nodejs npm
```

**Verify Installation**:
```bash
node --version    # Should show v16+ 
npm --version     # Should show 8+
```

#### 2. Code Editor Setup
**Recommended**: Visual Studio Code
- Download from [code.visualstudio.com](https://code.visualstudio.com/)
- Install extensions:
  - "Node.js Extension Pack"
  - "REST Client" (for API testing)
  - "Thunder Client" (alternative to Postman)

### Step-by-Step Development Setup

#### Step 1: Navigate to Project
```bash
# Open terminal/command prompt
cd "c:\Users\moham\OneDrive\Desktop\Pro26\Demo\01-backend-only\backend"

# For Mac/Linux users:
# cd "/path/to/your/Demo/01-backend-only/backend"
```

#### Step 2: Install Dependencies
```bash
npm install
```

**What this does**:
- Downloads required packages (node-appwrite, dotenv)
- Creates `node_modules` folder with dependencies
- Sets up development environment

#### Step 3: Understanding the Environment File
The `.env` file contains configuration settings:

```env
# Development Configuration
USE_MOCK=true                    # Use mock data for learning

# Appwrite Configuration (Cloud Database)
APPWRITE_ENDPOINT=https://fra.cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=your-project-id
APPWRITE_API_KEY=your-api-key
DATABASE_ID=your-database-id
COLLECTION_ID=your-collection-id
```

**For Beginners**: 
- Environment variables keep sensitive data secure
- `USE_MOCK=true` means we use fake data for learning
- Appwrite settings connect to cloud database (when ready)

#### Step 4: Start the Server
```bash
npm start
```

**Expected Output**:
```
🔧 Running in MOCK mode
🚀 Server running on http://localhost:3000
🔧 Mode: MOCK DATA (for development)
📋 Available endpoints:
  GET    /interns - Get all interns
  POST   /interns - Create intern
  GET    /interns/:id - Get specific intern
  PATCH  /interns/:id - Update intern
  DELETE /interns/:id - Delete intern
  GET    /interns/count - Get intern count
  GET    /interns/tasks/summary - Get task summary
```

## 🧪 Testing Your Backend

### Method 1: Using Browser (Beginners)
Open your browser and visit:
- `http://localhost:3000/interns` - See all interns
- `http://localhost:3000/interns/count` - Get total count

### Method 2: Using Command Line
```bash
# Test GET requests
curl http://localhost:3000/interns
curl http://localhost:3000/interns/count

# Test POST request (create new intern)
curl -X POST http://localhost:3000/interns \
  -H "Content-Type: application/json" \
  -d '{
    "internName": "John Doe",
    "batch": "2025-Summer",
    "roles": ["Frontend Developer"],
    "currentProjects": ["Learning Project"]
  }'
```

### Method 3: Using VS Code Extension
1. Install "REST Client" extension
2. Create `test.http` file:
```http
### Get all interns
GET http://localhost:3000/interns

### Get intern count
GET http://localhost:3000/interns/count

### Create new intern
POST http://localhost:3000/interns
Content-Type: application/json

{
  "internName": "Jane Smith",
  "batch": "2025-Fall",
  "roles": ["Backend Developer"],
  "currentProjects": ["API Development"]
}
```

## 📖 Understanding the Code

### main.js - HTTP Server
```javascript
// This creates a web server that listens for requests
const server = http.createServer(async (req, res) => {
  // Set CORS headers (allows frontend to connect)
  res.setHeader('Access-Control-Allow-Origin', '*');
  
  // Parse the URL to understand what the client wants
  const parsedUrl = url.parse(req.url, true);
  const path = parsedUrl.pathname;
  const method = req.method;
  
  // Route handling - decide what to do based on URL
  if (path === '/interns') {
    if (method === 'GET') {
      // Return list of interns
    } else if (method === 'POST') {
      // Create new intern
    }
  }
});
```

**For Beginners**:
- `http.createServer()` creates a web server
- CORS headers allow websites to talk to your API
- URL parsing helps understand what the user wants
- Different HTTP methods (GET, POST, PATCH, DELETE) do different things

### index.js - Database Logic
```javascript
class InternManagement {
  constructor() {
    // Connect to Appwrite database
    this.client = new Client();
    this.databases = new Databases(this.client);
  }
  
  async getAllInterns(queries = []) {
    // Get interns from database with optional filtering
    const response = await this.databases.listDocuments(
      this.databaseId,
      this.collectionId,
      queries
    );
    return response;
  }
}
```

**For Beginners**:
- Classes organize related functions together
- `async/await` handles database operations that take time
- Appwrite handles the complex database stuff for us

## 🔧 Development Workflow

### Daily Development Process
1. **Start Server**: `npm start`
2. **Make Changes**: Edit `.js` files
3. **Restart Server**: `Ctrl+C` then `npm start`
4. **Test Changes**: Use browser/curl/REST client
5. **Repeat**: Continue developing features

### Adding New Features
1. **Plan**: What new endpoint do you need?
2. **Code**: Add route in `main.js`
3. **Logic**: Add business logic in `index.js`
4. **Test**: Verify it works
5. **Document**: Update README if needed

### Common Development Tasks

#### Adding a New API Endpoint
1. **In main.js**, add new route:
```javascript
} else if (path === '/my-new-endpoint') {
  if (method === 'GET') {
    result = await internSystem.myNewMethod();
  }
}
```

2. **In index.js**, add the method:
```javascript
async myNewMethod() {
  // Your logic here
  return { success: true, data: "Hello World" };
}
```

#### Switching from Mock to Real Database
1. **Get Appwrite Account**: Sign up at [appwrite.io](https://appwrite.io)
2. **Create Project**: Follow Appwrite setup guide
3. **Update .env**: Add your Appwrite credentials
4. **Change Mode**: Set `USE_MOCK=false`
5. **Restart**: `npm start`

## 🐛 Troubleshooting

### Common Issues

#### Port Already in Use
```
Error: listen EADDRINUSE: address already in use :::3000
```
**Solutions**:
```bash
# Kill process using port 3000
npx kill-port 3000

# Or use different port
PORT=3001 npm start
```

#### Module Not Found
```
Error: Cannot find module 'dotenv'
```
**Solution**:
```bash
npm install  # Reinstall dependencies
```

#### Permission Denied (Mac/Linux)
```bash
sudo npm install  # Run with admin privileges
```

#### Can't Connect to Appwrite
**Check**:
1. Internet connection
2. Appwrite credentials in `.env`
3. `USE_MOCK=false` setting

## 📚 Learning Exercises

### Beginner Exercises
1. **Explore Mock Data**: Look at `mock.js` to understand data structure
2. **Test All Endpoints**: Use browser to test each API endpoint
3. **Modify Response**: Add a new field to intern data
4. **Create Endpoint**: Add `/health` endpoint that returns server status

### Intermediate Exercises
1. **Add Validation**: Ensure intern name is required
2. **Add Filtering**: Support filtering interns by batch
3. **Add Sorting**: Allow sorting interns by name or date
4. **Error Handling**: Improve error messages

### Advanced Exercises
1. **Add Authentication**: Implement API key validation
2. **Add Logging**: Log all API requests
3. **Add Rate Limiting**: Limit requests per minute
4. **Add Testing**: Write unit tests for API functions

## 🎓 What's Next?

After mastering backend development:

1. **Frontend Development**: Move to `02-frontend-only` to learn Flutter
2. **Integration**: Try `03-backend-frontend-connected` for full-stack
3. **Production**: Complete journey with `04-final-product`

### Key Concepts Mastered
- ✅ REST API design and implementation
- ✅ Database integration with Appwrite
- ✅ Environment configuration
- ✅ Error handling and validation
- ✅ API testing and debugging
- ✅ Mock data for development

## 🔗 Resources

### Essential Reading
- [Node.js Documentation](https://nodejs.org/docs/)
- [Appwrite Documentation](https://appwrite.io/docs)
- [REST API Best Practices](https://restfulapi.net/)
- [HTTP Status Codes](https://httpstatuses.com/)

### Tools
- [Postman](https://www.postman.com/) - API testing
- [Insomnia](https://insomnia.rest/) - Alternative API client
- [VS Code REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client)

### Community
- [Node.js Community](https://nodejs.org/en/get-involved/)
- [Appwrite Discord](https://discord.gg/GSeTUeA)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/node.js)

---

**🎉 Ready to Start?** Follow the setup guide above and begin your backend development journey!

*Remember: Every expert was once a beginner. Take your time, experiment, and don't hesitate to ask questions!*
