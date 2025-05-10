CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password VARCHAR(50) NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW()
);

CREATE TABLE posts (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(150) NOT NULL,
    viewed INTEGER DEFAULT 0,
    userId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    is_active BOOLEAN DEFAULT FALSE,
    userId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id BIGSERIAL PRIMARY KEY,
    content VARCHAR(500) NOT NULL,
    userId BIGINT NOT NULL,
    postId BIGINT NOT NULL,
    parent_id BIGINT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_post FOREIGN KEY (postId) REFERENCES posts(id) ON DELETE CASCADE,
    CONSTRAINT fk_parent_comment FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);

CREATE TABLE favorite_post (  
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    postId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_post FOREIGN KEY (postId) REFERENCES posts(id) ON DELETE CASCADE
);

CREATE TABLE followers (
    id BIGSERIAL PRIMARY KEY,
    followerId BIGINT NOT NULL,
    followedId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_follower FOREIGN KEY (followerId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_followed FOREIGN KEY (followedId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE post_likes (
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    postId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_post FOREIGN KEY (postId) REFERENCES posts(id) ON DELETE CASCADE
);

CREATE TABLE comment_likes (
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    commentId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_comment FOREIGN KEY (commentId) REFERENCES comments(id) ON DELETE CASCADE
);

-- Tabela recover_email
CREATE TABLE recover_email (
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expiresAt TIMESTAMP NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

-- Tabela reports
CREATE TABLE reports (
    id BIGSERIAL PRIMARY KEY,
    reporterId BIGINT NOT NULL,
    targetType VARCHAR(50) NOT NULL,  -- 'post', 'comment', 'user'
    targetId BIGINT NOT NULL,
    reason TEXT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_reporter FOREIGN KEY (reporterId) REFERENCES users(id) ON DELETE CASCADE
);

-- Tabela messages
CREATE TABLE messages (
    id BIGSERIAL PRIMARY KEY,
    senderId BIGINT NOT NULL,
    receiverId BIGINT NOT NULL,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_sender FOREIGN KEY (senderId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_receiver FOREIGN KEY (receiverId) REFERENCES users(id) ON DELETE CASCADE
);
