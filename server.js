require('dotenv').config();
const express = require('express');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const flash = require('connect-flash');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: process.env.SESSION_SECRET || 'crime_rms_secret',
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 1000 * 60 * 60 * 8 } // 8 hours
}));

app.use(flash());

// Make flash messages and session available in all views
app.use((req, res, next) => {
  res.locals.success = req.flash('success');
  res.locals.error = req.flash('error');
  res.locals.officer = req.session.officer || null;
  next();
});

// View engine
app.set('view engine', 'html');
app.engine('html', require('fs').readFile.bind(require('fs')));

// Routes
app.use('/', require('./routes/auth'));
app.use('/', require('./routes/dashboard'));
app.use('/crimes', require('./routes/crimes'));
app.use('/suspects', require('./routes/suspects'));
app.use('/officers', require('./routes/officers'));

// 404 handler
app.use((req, res) => {
  res.status(404).send(`
    <html><body style="font-family:sans-serif;text-align:center;padding:80px;background:#0f172a;color:#e2e8f0">
    <h1 style="font-size:64px;margin:0;color:#ef4444">404</h1>
    <p style="font-size:20px">Page not found</p>
    <a href="/dashboard" style="color:#60a5fa">← Back to Dashboard</a>
    </body></html>
  `);
});

app.listen(PORT, () => {
  console.log(`\n🚔 Crime RMS Server running at http://localhost:${PORT}`);
  console.log(`📋 Default login: admin@crimerms.gov / Admin@123\n`);
});
