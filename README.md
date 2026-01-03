# Besstami – Java EE Web Application

## 📌 Project Overview

Besstami is a Java EE web application developed as an academic project, inspired by the Bankati concept. The project demonstrates a comprehensive understanding of Java EE fundamentals, MVC architecture, and 3-tier application design. 

The primary focus is on clean architecture, separation of concerns, and proper implementation of core JEE components including Servlets, JSP, Filters, and Listeners, rather than building a production-ready system.

## 🎯 Project Objectives

- Apply Java EE (JEE) concepts in a practical web application
- Implement a robust 3-tier architecture following the MVC pattern
- Practice comprehensive request handling, session management, and access control
- Understand persistence logic through custom file-based storage
- Deliver a well-structured, maintainable, and academically sound project
- Demonstrate mastery of core JEE components without relying on frameworks

## ✨ Core Features

### User Management
- User authentication and authorization
- Secure session management
- Role-based access control

### Application Functionality
- Data creation, update, and retrieval operations
- Request filtering for security and access control
- Application lifecycle management using listeners
- Resource protection and controlled access

### Architecture Highlights
- Clear separation between presentation, business logic, and data access layers
- Custom persistence layer without external database dependencies
- Filter chain for request preprocessing and security
- Event-driven lifecycle management

## 🛠️ Technologies Used

### Backend / Core
- **Java EE (JEE)**
- **Servlets** (Request handling and control)
- **Filters** (Security and preprocessing)
- **Listeners** (Lifecycle management)

### Frontend
- **JSP** (JavaServer Pages)
- **JSTL** (JSP Standard Tag Library)
- **Expression Language (EL)**

### Architecture & Tools
- **Design Pattern**: MVC (Model-View-Controller)
- **Architecture**: 3-Tier Architecture
- **Server**: Apache Tomcat
- **Persistence**: File-based storage (TXT files)
- **IDE**: Eclipse / IntelliJ IDEA
- **Java Version**: JDK 8+

## 🧱 Project Architecture

### 3-Tier Architecture

The application follows a strict 3-tier architecture to ensure maintainability, scalability, and clarity:

#### 1️⃣ Presentation Layer
- **Components**: JSP pages, JSTL tags, Expression Language
- **Responsibility**: UI rendering and user interaction
- **Focus**: Clean, maintainable view logic without business rules

#### 2️⃣ Business Layer
- **Components**: Business logic classes, service layer
- **Responsibility**: Application rules, data validation, and business processes
- **Focus**: Acts as an intermediary between controllers and data access

#### 3️⃣ Data Access Layer (DAO)
- **Components**: DAO classes, file I/O handlers
- **Responsibility**: Data persistence management
- **Operations**:
  - Reading data from text files
  - Writing and updating stored information
  - Data integrity management

### MVC Pattern Implementation

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │ HTTP Request
       ↓
┌─────────────────┐
│   Controller    │ ← Servlets
│   (Servlets)    │
└────────┬────────┘
         │
    ┌────┴────┐
    ↓         ↓
┌───────┐ ┌──────┐
│ Model │ │ View │
│(Beans)│ │ (JSP)│
└───┬───┘ └──────┘
    │
    ↓
┌────────┐
│  DAO   │
└────────┘
    │
    ↓
┌─────────┐
│ TXT File│
└─────────┘
```

**Components**:
- **Model**: Java beans/POJOs representing business entities
- **View**: JSP pages using JSTL and EL for rendering
- **Controller**: Servlets handling HTTP requests and orchestrating flow

This structure ensures a clear separation of responsibilities and follows standard JEE best practices.

## 💾 Persistence Layer

### File-Based Storage Strategy

**Key Design Decisions**:
- No external database (MySQL, PostgreSQL, etc.)
- Data stored in text (TXT) files
- Custom DAO implementation for file operations

### Educational Rationale

This approach was chosen intentionally to focus on:
- File I/O handling in Java
- DAO design pattern implementation
- Core JEE concepts without framework dependencies
- Understanding persistence fundamentals
- Resource management and error handling

## 🛡️ Filters & Listeners

### Filters

**Purpose**: Request preprocessing and security enforcement

**Implemented Filters**:
- **Authentication Filter**: Validates user sessions before accessing protected resources
- **Access Control Filter**: Checks user permissions and roles
- **Request Preprocessing**: Handles encoding, logging, and request validation

### Listeners

**Purpose**: Application lifecycle and event management

**Implemented Listeners**:
- **ServletContextListener**: Application startup initialization and shutdown cleanup
- **HttpSessionListener**: Session lifecycle management and tracking
- **ServletRequestListener**: Request-level event handling

## 🚀 Installation & Deployment

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Tomcat 8.5+ or 9.x
- IDE (Eclipse or IntelliJ IDEA)
- Basic understanding of Java EE concepts

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/besstami.git
   ```

2. **Import into IDE**
   - Open Eclipse or IntelliJ IDEA
   - Import as existing project
   - Ensure project structure is recognized

3. **Configure Apache Tomcat**
   - Add Tomcat server to your IDE
   - Set deployment directory
   - Configure server ports if needed

4. **Deploy the application**
   - Build the project (Maven/Gradle if applicable)
   - Deploy to Tomcat server
   - Start the server

5. **Access the application**
   ```
   http://localhost:8080/Besstami
   ```

### Deployment Structure

```
Besstami/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controllers/    # Servlets
│   │   │   ├── models/         # Business entities
│   │   │   ├── dao/            # Data access layer
│   │   │   ├── filters/        # Request filters
│   │   │   └── listeners/      # Application listeners
│   │   ├── webapp/
│   │   │   ├── WEB-INF/
│   │   │   │   └── web.xml     # Deployment descriptor
│   │   │   ├── views/          # JSP pages
│   │   │   └── resources/      # CSS, JS, images
│   │   └── data/               # TXT files for persistence
└── pom.xml (if using Maven)
```

## 📊 Project Status

✅ Complete implementation of 3-tier architecture  
✅ MVC pattern properly applied  
✅ Custom file-based persistence layer  
✅ Security filters and access control  
✅ Session management and listeners  
✅ Academic documentation and screenshots

## 🎓 Academic Context

**Project Type**: Academic Java EE Project  
**Purpose**: Learning and demonstrating Java EE, MVC, and web application architecture  
**Level**: 4th Year Computer & Network Engineering  
**Evaluation-Oriented**: Designed to meet academic standards and best practices  
**Scope**: Educational project, not intended for production use

### Learning Outcomes

This project demonstrates understanding of:
- Java EE web application development
- MVC architectural pattern
- Multi-tier application design
- Servlet API and lifecycle
- Session management and security
- Filter chains and listeners
- Custom persistence implementation
- Clean code and separation of concerns

## 🛠️ Future Enhancements (Beyond Academic Scope)

- Database integration (MySQL/PostgreSQL)
- RESTful API implementation
- Frontend framework integration (Angular/React)
- Spring Framework migration
- Enhanced security (OAuth2, JWT)
- Unit and integration testing
- Logging framework (Log4j, SLF4J)
- Deployment containerization (Docker)

## 👨‍💻 Author

**Anas Lahmidi**  
🔗 GitHub: [github.com/anasthe03](https://github.com/anasthe03)  
💼 LinkedIn: [linkedin.com/in/lahmidianas](https://www.linkedin.com/in/lahmidianas/)

## 📄 License

This project is developed for educational purposes only.

---

**Note**: This project represents an academic exercise in Java EE fundamentals. It prioritizes clean architecture and proper implementation of core JEE concepts over production-ready features.
