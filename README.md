# Smart Home Terraform Infrastructure 🏠✨

Welcome to my Smart Home Terraform Infrastructure project! As an exploration into the power of Infrastructure as Code (IaC) with Terraform, this project aims to simulate a smart home network within AWS. It's designed to demonstrate how to provision and manage a network of microservices that could represent a smart home system, including services for status reporting, lighting, heating, and authorization.

## About This Project 📖

This Terraform project is a hands-on demonstration of creating and managing AWS resources to deploy a mock smart home network. The infrastructure includes a variety of AWS services, structured in a modular way for ease of understanding and scalability. Whether you're new to Terraform or looking to see it applied in a comprehensive project, this repository offers valuable insights.

### Features:

- **VPC Configuration:** A custom Virtual Private Cloud (VPC) to securely host all services.
- **Microservices Deployment:** Separate microservices for lighting, heating, status, and authorization.
- **Database Integration:** DynamoDB tables for persistent storage of service data.
- **Scalability:** Autoscaling groups and load balancers to handle varying loads.
- **Security:** Well-defined security groups to ensure the integrity of the network.

## Getting Started 🚀

To get this infrastructure up and running on your AWS account, follow these steps:

### Prerequisites

- Terraform installed on your machine.
- An AWS account and the AWS CLI configured with your credentials.
- Basic familiarity with AWS services and Terraform syntax.

### Installation

1. **Clone the Repository**

   Start by cloning this repository to your local machine:

   ```bash
   git clone https://github.com/AlexGuyNichols/terraform-project.git
2. **Initialize Terraform**

Navigate to the project directory and initialize Terraform. This step will download the necessary providers and prepare your project for deployment:
- cd terraform-project
- terraform init

3. **Apply the Terraform Configuration**
Apply the Terraform configuration to provision the AWS resources:
- terraform apply

Confirm the action when prompted, and Terraform will begin creating the infrastructure.

### Project Structure 🗂

This project is organized into several modules, each responsible for a different aspect of the smart home network. Here's a brief overview:

  modules/vpc: Configures the network environment.
  modules/security: Defines security groups for different services.
  modules/app-servers: Deploys EC2 instances for the microservices.
  modules/database: Sets up DynamoDB tables for data storage.
  modules/load_balancing: Implements load balancing for high availability.
  modules/autoscaling_group: Manages autoscaling for the services.
  
### Cleaning Up 🧽

To avoid incurring unnecessary charges, remember to destroy the resources once you're done:

terraform destroy

### Thank you for exploring my Smart Home Terraform Infrastructure project. I hope it provides you with a solid foundation for your own Terraform and AWS adventures!
