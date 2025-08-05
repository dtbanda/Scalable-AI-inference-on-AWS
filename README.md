# 🚀 Scalable Small Language Model (SLM) Inference API on AWS

This project showcases the deployment of Liquid AI SLM (Small Language Model) as a secure, scalable REST API on **AWS** using **FastAPI**, **Docker**, and **Terraform**. It is designed as a production-grade infrastructure template for clients looking to serve machine learning models in the cloud.

---

## 📌 Project Highlights

- ✅ Lightweight SML (Small Language Model) served via REST API
- 🐳 Dockerized and hosted on AWS EC2
- 🛡️ Secured using IAM roles, key-based SSH, and environment secrets
- 🔄 Terraform for full Infrastructure as Code (EC2, S3, IAM)
- 📊 Logs all requests to AWS CloudWatch
- 🔗 Integration with API Gateway for public access

---

## 💼 Use Case

**Client Scenario**:  
Designed for AI product teams, startups, or researchers who want to host lightweight LLMs in a private cloud environment with full control over their data, costs, scalability, and API access.

**This infrastructure simulates a real-world use case of a language model API:**
- Replace OpenAI/Anthropic dependency
- Run in regulated or air-gapped environments
- Reduce costs for frequent inference workloads

---

## 🧠 Tech Stack

| Layer            | Tools Used                      |
|------------------|----------------------------------|
| Inference Model  | Hugging Face `(https://huggingface.co/LiquidAI/LFM2-350M)` |
| API Framework    | FastAPI                         |
| Containerization | Docker                          |
| Cloud Infra      | AWS EC2, S3, IAM, CloudWatch     |
| IaC              | Terraform                       |
| Monitoring       | AWS CloudWatch Logs             |

---

## 📐 Architecture

![AI Inference Architecture](./assets/architecture-diagram.png)

---

## 🚀 Deployment Overview (Sensitive information redacted)

1. **Terraform run and docker hub image pull**
Navigate to infrastructure directory in project. Run:
   > terraform init
   > terraform plan
   > terraform apply
This does the following:
   - Starts up an AWS t4g.small EC2 instance.
   - Configure AWS CLI
   - Deploy EC2 + IAM roles + Security Group via Terraform
On start, the script user_data.sh is run.
It pulls the Docker images from Docker Hub and runs the Docker container.
   > docker pull dtbanda/slm-pi-app:arm64
   > docker run -dp 8000:8000 dtbanda/slm-pi-app:arm64 

🔐 Security & Cost Notes
- Deployed in private VPC, with security groups restricting public traffic.
- IAM roles are limited to necessary services (S3, CloudWatch).
- Spot instances or Graviton-based EC2 options for cost reduction.
- HTTPS enabled via AWS Certificate Manager (or self-signed in dev).

👨‍💻 Author
Dalitso Banda
Cloud + AI Infrastructure Engineer
| 📧 dalitso.banda@dtbinsights.com |

