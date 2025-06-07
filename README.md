# SimpleTimeService - Particle41 DevOps Challenge

## 📌 Project Overview

**SimpleTimeService** is a minimalist web application that returns a JSON object with the current server timestamp and the IP address of the client making the request.

This project demonstrates:
- A simple web service containerized using Docker
- Secure container practices (non-root user)
- Infrastructure deployment on AWS using Terraform
- ECS or EKS orchestration for app hosting
- Proper documentation and automation for DevOps pipelines

---

## 🧱 Project Structure

```bash
.
├── app/                  # Source code and Dockerfile
│   ├── main.py
│   └── Dockerfile
├── terraform/            # Terraform IaC files
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── .gitignore
└── README.md

🛠️ Prerequisites

| Tool      | Description                      | Installation Link                                                                                    |
| --------- | -------------------------------- | --------------------------------------------------------------------------------------  |
| Docker    | Build and run containers         | [Install Docker](https://docs.docker.com/get-docker/)                                   |
| Git       | Clone this repository            | [Install Git](https://git-scm.com/downloads)                                           |
| AWS CLI   | Interact with AWS via CLI        | [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) |
| Terraform | Provision infrastructure as code | [Install Terraform](https://developer.hashicorp.com/terraform/install)                 |
| Python 3  | For SimpleTimeService backend    | [Install Python](https://www.python.org/downloads/)                                    |



🔐 AWS Authentication
Make sure you're authenticated to AWS:
aws configure


Set up your AWS credentials using aws configure, or use environment variables:
export AWS_ACCESS_KEY_ID=your-access-key
export AWS_SECRET_ACCESS_KEY=your-secret-key
export AWS_DEFAULT_REGION=your-region


🧑‍💻 Part 1 - Application and Docker

1️⃣ Clone this repo
git clone https://github.com/ajit131997/simpletimeservice.git
cd simpletimeservice/app

2️⃣ Build the Docker Image
docker build -t simpletimeservice .

3️⃣ Run the Docker Container
docker run -p 8080:8080 simpletimeservice

4️⃣ Test the App
Visit http://localhost:8080 or use curl:

curl http://localhost:8080
Expected Output:

{
  "timestamp": "2025-06-07T10:24:00",
  "ip": "127.0.0.1"
}


☁️ Part 2 - AWS Infrastructure via Terraform

1️⃣ Navigate to the Terraform Directory
cd terraform/

2️⃣ Initialize Terraform
terraform init

3️⃣ Preview the Plan
terraform plan

4️⃣ Apply the Plan
terraform apply

5️⃣ Access the Application
Once deployed, Terraform will output the Load Balancer URL:

Outputs:

load_balancer_dns_name = "http://<alb-dns-name>"
Open this URL in your browser to test the app.

📄 terraform.tfvars Example

region         = "ap-south-1"
app_name       = "simpletimeservice"
environment    = "dev"
docker_image   = "ajit131997/simpletimeservice:latest"


🔒 Security Note
Never commit your AWS credentials, secrets, or .tfstate files to public repos.
