
# 🚀 3-Tier Application Deployment using Docker, EC2 and MongoDB Atlas

This guide explains how to deploy the **3-Tier Application** from the GitHub repository below on an AWS EC2 instance using Docker and MongoDB Atlas.

The architecture contains three layers:

* **Frontend** → Nginx
* **Backend** → Node.js API
* **Database** → MongoDB Atlas (Cloud)

---

# 🟢 STEP 1: Launch EC2 Instance (Ubuntu)

Go to:

```
AWS Console → EC2 → Launch Instance
```

### Select

* **AMI:** Ubuntu Server 22.04 LTS
* **Instance Type:** c7i-flex.large (Recommended for Docker builds)
* **Storage:** 30 GB

---

## 🔐 Configure Security Group

| Port | Purpose          |
| ---- | ---------------- |
| 22   | SSH              |
| 5000 | Backend API      |
| 80   | Frontend         |
| 443  | HTTPS (Optional) |

Launch the instance.

---

# 🟢 STEP 2: Connect to EC2

From your local machine:

```bash
ssh -i your-key.pem ubuntu@your-public-ip
```

---

# 🟢 STEP 3: Install Docker

Update packages and install Docker.

```bash
sudo apt update
sudo apt install docker.io -y
```

Enable and start Docker:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

---

# 🟢 STEP 4: Clone the Application Repository

Clone the GitHub project on the EC2 instance.

```bash
git clone https://github.com/orion-pax77/3-tier-project.git
```

---

# 🟢 STEP 5: Setup MongoDB Atlas Database

Create a MongoDB cloud database.

### 1. Create an Account

Go to MongoDB Atlas website and create an account.

---

### 2. Create Project

Click:

```
New Project → Enter Project Name → Create Project
```

---

### 3. Build Database Cluster

Select:

* **Cluster Type:** M0 Free Tier
* **Cloud Provider:** AWS
* **Region:** Closest region

Click **Create Cluster**.

---

### 4. Create Database User

Go to:

```
Database Access → Add New Database User
```

Add:

```
Username
Password
```

Give **Read and Write access**.

---

### 5. Configure Network Access

Go to:

```
Network Access → Add IP Address
```

Add:

```
0.0.0.0/0
```

(This allows connections from your server)

---

### 6. Copy Connection String

Example:

```
mongodb+srv://username:password@cluster0.mongodb.net/mydb
```

This will be used inside the backend application.

---

# 🟢 STEP 6: Configure Backend Application

Navigate to the backend folder.

```bash
cd 3-tier-project/Application-Code/backend
```

Open the backend server file.

```bash
nano server.js
```

Update the locahost with MongoDB connection string using the MongoDB Atlas driver.


```javascript
const MONGO_URI = process.env.MONGO_URI || 'mongodb+srv://<localhost>:27017/taskmanager';
```

Save and exit.

---

# 🟢 STEP 7: Build Backend Docker Image

Build the backend Docker image.

```bash
docker build -t orionpax77/3-tier:backend .
```

Run the backend container.

```bash
docker run -d -p 5000:5000 orionpax77/3-tier:backend
```

Verify running containers.

```bash
docker ps
```

---

# 🟢 STEP 8: Configure Frontend Application

Navigate to the frontend folder.

```bash
cd ../frontend
```

Open the Nginx configuration file.

```bash
nano nginx.conf
```

Update the backend service IP.

```
proxy_pass http://<EC2-PUBLIC-IP>:5000;
```

Save and exit.

---

# 🟢 STEP 9: Build Frontend Docker Image

Build the frontend Docker image.

```bash
docker build -t orionpax77/3-tier:frontend .
```

Run the frontend container.

```bash
docker run -d -p 80:80 orionpax77/3-tier:frontend
```

Check running containers.

```bash
docker ps
```

---

# 🟢 STEP 10: Access the Application

Open your browser and access:

```
http://<EC2-PUBLIC-IP>
```

Your **3-Tier application will be live**.

---


# 🏗 Final Architecture

```
User
  │
  ▼
Frontend (Nginx - Port 80)
  │
  ▼
Backend (Node.js - Port 5000)
  │
  ▼
MongoDB Atlas (Cloud Database)
```

---
