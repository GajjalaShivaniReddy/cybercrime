USE crime_rms;
SELECT * FROM crimes;

SELECT * FROM suspects;

SELECT * FROM crime_suspects;

SELECT * FROM crime_types;

USE crime_rms;

DELETE FROM crime_types;

ALTER TABLE crime_types AUTO_INCREMENT = 1;

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

SELECT * FROM crime_types;