CREATE TABLE IF NOT EXISTS gps_trackers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    tracker_name VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(identifier)
);

INSERT INTO gps_trackers (owner_id, tracker_name, frequency) VALUES (1, 'Default Tracker', 'default');