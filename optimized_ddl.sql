-- Optimized DDL Query 1:
CREATE TABLE Users ( id SERIAL PRIMARY KEY username VARCHAR(255) DEFAULT NULL, email VARCHAR(255) NOT NULL UNIQUE, role VARCHAR(50) NOT NULL, phone VARCHAR(50) NOT NULL, profilePicture VARCHAR(255) NOT NULL, isOnline BOOLEAN, loginVerificationCode VARCHAR(255) NOT NULL, loginVerificationCodeExpires TIMESTAMP, googleId VARCHAR(255) NOT NULL, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
Tables Involved:  Channels Operation Type: INSERT JOIN Conditions: None WHERE Conditions: None Optimized DDL: 
CREATE TABLE Channels ( id SERIAL PRIMARY KEY organisationId INTEGER, name VARCHAR(255) NOT NULL, description TEXT,)

-- Optimized DDL Query 2:
CREATE TABLE Organisations ( id SERIAL PRIMARY KEY owner_id INT REFERENCES Users(id), name VARCHAR(255) NOT NULL, joinLink VARCHAR(255) NOT NULL, url VARCHAR(255) NOT NULL, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
Explanation: In this query, we have used the foreign key constraint to ensure that the owner_id column in the Organisations table references the id column in the Users table. This constraint ensures that the owner of each organisation is a valid user in the system. We have also used the default values for the createdAt and updatedAt columns to automatically populate these fields with the current timestamp when a new row is inserted or updated, respectively. Additionally, we have used the ON UPDATE CURRENT

-- Optimized DDL Query 3:
CREATE TABLE Channels ( id SERIAL PRIMARY KEY name VARCHAR(255) NOT NULL, title VARCHAR(255) DEFAULT 'This is the beginning of the channel', description TEXT, organisation_id INT REFERENCES Organisations(id), isChannel BOOLEAN DEFAULT TRUE, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
Optimized DDL: 
CREATE TABLE Channels ( id SERIAL PRIMARY KEY name VARCHAR(255) NOT NULL, title VARCHAR(255) DEFAULT 'This is the beginning of the channel', description TEXT, organisation_id INT REFERENCES Organisations(id), isChannel BOOLEAN DEFAULT TRUE, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT)

-- Optimized DDL Query 4:
CREATE TABLE Conversations ( id SERIAL PRIMARY KEY name VARCHAR(255) DEFAULT NULL, description TEXT, isSelf BOOLEAN DEFAULT FALSE, organisation_id INT REFERENCES Organisations(id), createdBy_id INT REFERENCES Users(id), isConversation BOOLEAN DEFAULT TRUE, isOnline BOOLEAN DEFAULT FALSE, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
Constraints: 
ALTER TABLE Conversations ADD CONSTRAINT fk_conversations_users_createdby_id FOREIGN KEY (createdBy_id) REFERENCES Users(id);

ALTER TABLE Conversations ADD CONSTRAINT fk_conversations_organisations_id FOREIGN KEY (organisation_id) REFERENCES Organisations(id);

-- Optimized DDL Query 5:
CREATE TABLE Messages ( id SERIAL PRIMARY KEY sender_id INT REFERENCES Users(id), content TEXT, channel_id INT REFERENCES Channels(id), organisation_id INT REFERENCES Organisations(id), conversation_id INT REFERENCES Conversations(id), isBookmarked BOOLEAN DEFAULT FALSE, isSelf BOOLEAN DEFAULT FALSE, hasRead BOOLEAN DEFAULT FALSE, type VARCHAR(50) NOT NULL, createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );

-- Optimized DDL Query 6:
ALTER TABLE Threads ADD CONSTRAINT fk_sender_id FOREIGN KEY (sender_id) REFERENCES Users(id);

ALTER TABLE Threads ADD CONSTRAINT fk_message_id FOREIGN KEY (message_id) REFERENCES Messages(id);

ALTER TABLE Threads ADD CONSTRAINT unique_threads UNIQUE (sender_id, message_id);

ALTER TABLE Threads ADD CONSTRAINT unique_threads_content UNIQUE (content);

ALTER TABLE Threads ADD CONSTRAINT unique_threads_message_id_content UNIQUE (message_id, content);

ALTER TABLE Threads ADD CONSTRAINT unique_threads_message_id_content_sender_id UNIQUE (message_id, content, sender_id);

ALTER TABLE Threads ADD CONSTRAINT unique_threads_message_id_content_sender_id_content UNIQUE (message_id, content, sender_id, content);

ALTER TABLE Threads ADD CONSTRAINT unique_threads_message_id_content_sender_id_content_updated_at

