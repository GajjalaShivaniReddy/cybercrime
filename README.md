# 🔰 Crime Record Management System
### DBMS Mini Project — Node.js + MySQL

---

## 📋 Features
- 🔐 Officer login system with roles (Admin / Officer / Viewer)
- 📋 Full CRUD for Crime Cases (Add, View, Edit, Delete)
- 👤 Full CRUD for Suspects/Criminals
- 🔗 Link suspects to crimes with roles (Primary, Accomplice, Witness, Victim)
- 🔍 Search & filter records by status, severity, name, etc.
- 📊 Dashboard with live stats
- 🛡️ Admin panel for officer management



## 🚀 Setup Instructions

### Prerequisites
- Node.js (v16+)
- MySQL (v8+)

### Step 1: Database Setup
```sql
-- Open MySQL and run:
mysql -u root -p < schema.sql
```

### Step 2: Install Dependencies
```bash
npm install
```

### Step 3: Configure Environment
```bash
cp .env.example .env
# Edit .env with your MySQL credentials
```

### Step 4: Start the Server
```bash
npm start
# or for development with auto-reload:
npm run dev
```

### Step 5: Access the App
Open: **http://localhost:3000**

---

## 🔑 Default Login
| Field | Value |
|-------|-------|
| Email | admin@crimerms.gov |
| Password | Admin@123 |

---

## 🗃️ Database Schema

### Tables
| Table | Purpose |
|-------|---------|
| `officers` | System users (admin/officer/viewer) |
| `suspects` | Criminal/suspect records |
| `crime_types` | Categories of crimes |
| `crimes` | Crime case records |
| `crime_suspects` | Many-to-many: crimes ↔ suspects |

---

## 📁 Project Structure
```
crime-rms/
├── server.js          # Entry point
├── schema.sql         # Database setup
├── .env.example       # Environment config template
├── config/
│   └── db.js          # MySQL connection pool
├── middleware/
│   └── auth.js        # Session authentication
├── routes/
│   ├── layout.js      # HTML layout template
│   ├── auth.js        # Login / Logout
│   ├── dashboard.js   # Dashboard stats
│   ├── crimes.js      # Crime CRUD
│   ├── suspects.js    # Suspect CRUD
│   └── officers.js    # Officer management
└── public/
    ├── css/style.css  # Stylesheet
    └── js/app.js      # Frontend JS
```

---

## 🛠️ Tech Stack
- **Backend**: Node.js + Express.js
- **Database**: MySQL with mysql2 driver
- **Auth**: express-session + bcryptjs
- **Frontend**: Vanilla HTML/CSS/JS (dark theme)
