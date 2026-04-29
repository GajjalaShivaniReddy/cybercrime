
-- Crime Record Management System - Database Schema
-- Run this in MySQL to set up the database

CREATE DATABASE IF NOT EXISTS crime_rms;
USE crime_rms;

-- Officers / Users table
CREATE TABLE IF NOT EXISTS officers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    badge_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'officer', 'viewer') DEFAULT 'officer',
    department VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Suspects / Criminals table
CREATE TABLE IF NOT EXISTS suspects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    nationality VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    id_number VARCHAR(50),
    photo_url VARCHAR(255),
    notes TEXT,
    status ENUM('suspect', 'arrested', 'convicted', 'acquitted', 'wanted') DEFAULT 'suspect',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crime types
CREATE TABLE IF NOT EXISTS crime_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category ENUM('violent', 'property', 'financial', 'cyber', 'drug', 'other') NOT NULL,
    description TEXT,
    severity ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium'
);

-- Crimes table
CREATE TABLE IF NOT EXISTS crimes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    case_number VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    crime_type_id INT,
    description TEXT,
    location VARCHAR(255),
    crime_date DATETIME NOT NULL,
    reported_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('open', 'under_investigation', 'solved', 'closed', 'cold') DEFAULT 'open',
    severity ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
    assigned_officer_id INT,
    evidence TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crime_type_id) REFERENCES crime_types(id) ON DELETE SET NULL,
    FOREIGN KEY (assigned_officer_id) REFERENCES officers(id) ON DELETE SET NULL
);

-- Crime-Suspect linking table (many-to-many)
CREATE TABLE IF NOT EXISTS crime_suspects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    crime_id INT NOT NULL,
    suspect_id INT NOT NULL,
    role ENUM('primary', 'accomplice', 'witness', 'victim') DEFAULT 'primary',
    notes TEXT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (crime_id) REFERENCES crimes(id) ON DELETE CASCADE,
    FOREIGN KEY (suspect_id) REFERENCES suspects(id) ON DELETE CASCADE,
    UNIQUE KEY unique_crime_suspect (crime_id, suspect_id)
);

-- Seed: Crime types
INSERT INTO crime_types (name, category, description, severity) VALUES
('Theft', 'property', 'Taking property without permission', 'medium'),
('Robbery', 'violent', 'Taking property using force or threats', 'high'),
('Assault', 'violent', 'Physical attack on another person', 'high'),
('Burglary', 'property', 'Breaking into a property with intent to commit crime', 'high'),
('Fraud', 'financial', 'Deception for financial gain', 'medium'),
('Cybercrime', 'cyber', 'Criminal activities involving computers', 'high'),
('Drug Possession', 'drug', 'Possession of illegal substances', 'medium'),
('Murder', 'violent', 'Unlawful killing of a person', 'critical'),
('Vandalism', 'property', 'Deliberate destruction of property', 'low'),
('Extortion', 'financial', 'Obtaining something by threats', 'high');

-- Seed: Default admin officer (password: Admin@123)
INSERT INTO officers (name, badge_number, email, password_hash, role, department, phone) VALUES
('System Administrator', 'ADMIN001', 'admin@crimerms.gov', '$2b$10$rKj8D9X5.dq9mQKzP3Wqv.xjECvj1yIPi0Q.VZN7d7gGnwj3zJ2Ji', 'admin', 'Administration', '+91-9000000000');

COMMIT;
