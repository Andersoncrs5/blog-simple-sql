CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password VARCHAR(50) NOT NULL,
    bio TEXT,
    avatar_url TEXT,
    createdAt TIMESTAMP DEFAULT NOW()
);
 
create TABLE user_metrics (
	id BIGINT primary key,
	followers_count INTEGER default 0,
	following_count INTEGER default 0,
	posts_count INTEGER default 0,
	comments_count INTEGER default 0,
	likes_given_count INTEGER default 0,
	deslikes_given_count INTEGER default 0,
	shares_count INTEGER default 0,
	reports_received_count INTEGER default 0,
	reputation_score NUMERIC(3,2) default 0.0,
	mediaUploads_count INTEGER default 0,
	savedPosts_count INTEGER default 0,
	savedComments_count INTEGER default 0,
	savedMedia_count INTEGER default 0,
	createdAt TIMESTAMP DEFAULT NOW(),
	updatedAt TIMESTAMP DEFAULT NOW(),
	last_login TIMESTAMP DEFAULT NOW(),
	userId BIGINT NOT NULL,
	CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
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

CREATE TABLE favorite_comment (  
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    commentId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_comment FOREIGN KEY (commentId) REFERENCES comments(id) ON DELETE CASCADE
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

CREATE TABLE recover_email (
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    token VARCHAR(255) NOT NULL,
    expiresAt TIMESTAMP NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE reports (
    id BIGSERIAL PRIMARY KEY,
    reporterId BIGINT NOT NULL,
    targetType VARCHAR(50) NOT NULL,  -- 'post', 'comment', 'user'
    targetId BIGINT NOT NULL,
    reason TEXT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_reporter FOREIGN KEY (reporterId) REFERENCES users(id) ON DELETE CASCADE
);

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

CREATE TABLE post_metrics (
    postId BIGINT PRIMARY KEY,
    likes INTEGER DEFAULT 0,
    dislikes INTEGER DEFAULT 0,
    shares INTEGER DEFAULT 0,
    bookmarks INTEGER DEFAULT 0,
    comments INTEGER DEFAULT 0,
    reportCount INTEGER DEFAULT 0,
    editedTimes INTEGER DEFAULT 0,
    engagementScore NUMERIC(3,2) default 0.0,
    favorites INTEGER DEFAULT 0,
    updatedAt TIMESTAMP DEFAULT NOW(),
    lastInteractionAt TIMESTAMP null,
    CONSTRAINT fk_post FOREIGN KEY (postId) REFERENCES posts(id) ON DELETE CASCADE
);

CREATE TABLE comment_metrics (
	id BIGINT PRIMARY KEY,
	likes INTEGER DEFAULT 0,
	dislikes INTEGER DEFAULT 0,
	reportCount INTEGER DEFAULT 0,
	editedTimes INTEGER DEFAULT 0,
	engagementScore NUMERIC(3,2) default 0.0,
	lastInteractionAt TIMESTAMP null,
	favoritesCount INTEGER DEFAULT 0,
	commentId BIGINT NOT NULL,
	CONSTRAINT fk_comment FOREIGN KEY (commentId) REFERENCES comments(id) ON DELETE CASCADE
);

CREATE TABLE attachments (
    id BIGSERIAL PRIMARY KEY,
    url TEXT NOT NULL,
    type VARCHAR(50), -- image, video, document, etc.
    postId BIGINT,
    commentId BIGINT,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_post FOREIGN KEY (postId) REFERENCES posts(id) ON DELETE CASCADE,
    CONSTRAINT fk_comment FOREIGN KEY (commentId) REFERENCES comments(id) ON DELETE CASCADE
);

CREATE TABLE user_settings (
    userId BIGINT PRIMARY KEY,
    language VARCHAR(10) DEFAULT 'pt-BR',
    dark_mode BOOLEAN DEFAULT FALSE,
    notify_email BOOLEAN DEFAULT TRUE,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE user_feedback (
    id BIGSERIAL PRIMARY KEY,
    userId BIGINT NOT NULL,
    subject VARCHAR(150) NOT NULL,
    message TEXT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE user_blocks (
    id BIGSERIAL PRIMARY KEY,
    blockerId BIGINT NOT NULL,
    blockedId BIGINT NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_blocker FOREIGN KEY (blockerId) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_blocked FOREIGN KEY (blockedId) REFERENCES users(id) ON DELETE CASCADE
);
