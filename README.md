# Blog Project - Database Schema

Description

This project is a simple blog system designed to manage users, posts, categories, comments, and favorite posts. The database is structured using PostgreSQL, and it ensures data integrity with relationships between tables.

Database: projects

This schema includes the following tables:

### 1. users

Stores user information.

id: Unique identifier for the user.

name: User's full name.

email: User's email address.

password: User's hashed password.

createdAt: Timestamp when the user is created.

### 2. posts

Stores blog posts created by users.

id: Unique identifier for the post.

title: Post title.

content: The main body of the post.

category: Category of the post.

viewed: Number of times the post has been viewed.

userId: Foreign key referencing users(id).

createdAt: Timestamp when the post is created.

### 3. categories

Stores post categories.

id: Unique identifier for the category.

name: Category name.

is_active: Boolean flag to indicate if the category is active.

userId: Foreign key referencing users(id).

createdAt: Timestamp when the category is created.

### 4. comments

Stores comments on posts.

id: Unique identifier for the comment.

content: Comment content.

userId: Foreign key referencing users(id).

postId: Foreign key referencing posts(id).

parent_id: Foreign key referencing comments(id), allowing nested comments.

createdAt: Timestamp when the comment is created.

### 5. favorite_post

Stores favorite posts for users.

id: Unique identifier for the favorite.

userId: Foreign key referencing users(id).

postId: Foreign key referencing posts(id).

createdAt: Timestamp when the favorite is created.

## Features

Users can create blog posts and assign categories.

Users can comment on posts with support for nested comments.

Users can mark posts as favorites.

Tracks post views and categories.

Supports user and category management.

Technologies Used

PostgreSQL (Database)