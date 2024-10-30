# Retail Store Sample Application

## Overview
This is a sample retail store application demonstrating a microservices architecture using various technologies. The application consists of multiple services that work together to provide a complete e-commerce experience.

## Project Structure
```
.
├── image/               
├── terraform/             
│   ├── .terraform/        
│   ├── main.tf           
│   ├── output.tf       
│   ├── provider.tf      
│   ├── terraform.tfvars 
│   └── variabel.tf      
├── nginx-proxy/         # Nginx reverse proxy configuration
├── .gitignore           # Git ignore rules
├── Jenkinsfile          # Jenkins pipeline configuration
└── README.md            # Project documentation
```

## Architecture

The application consists of the following microservices:

- **UI Service** - Frontend interface (Java/Spring Boot)
- **Catalog Service** - Product catalog management (Go)
- **Cart Service** - Shopping cart functionality (Java/Spring Boot)
- **Orders Service** - Order processing (Java/Spring Boot)
- **Checkout Service** - Payment processing (Node.js)
- **Assets Service** - Static asset management

## Prerequisites

- Docker and Docker Compose
- Terraform >= 1.0.0
- Jenkins
- Git
- Digital Ocean account
- Nginx

## Infrastructure Setup

### Initial Configuration

1. Clone the repository:
```bash
git clone https://github.com/aws-containers/retail-store-sample-app.git
cd retail-store-sample-app
```

2. Update Terraform variables:
- Navigate to the `terraform` directory
- Modify `terraform.tfvars` with your specific values
- Update `provider.tf` with your Digital Ocean credentials

3. Initialize and apply Terraform:
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## CI/CD Pipeline

The CI/CD pipeline is implemented using Jenkins. The configuration is stored in the `Jenkinsfile` at the root of the repository.

### Pipeline Stages:
1. **Preparation** - Clean workspace and prepare environment
2. **Clone Repository** - Clone the application source code
3. **Create Nginx Configuration** - Set up reverse proxy configuration
4. **Update Docker Compose** - Update image tags and configurations
5. **Deploy to Digital Ocean** - Deploy the application to Digital Ocean droplet

### Pipeline Setup:
1. Configure Jenkins with required credentials:
   - SSH credentials for Digital Ocean droplet access
   - Git repository access credentials

2. Create a new Jenkins Pipeline job:
   - Point to your repository
   - Configure the pipeline to use the Jenkinsfile

## Infrastructure Management

### Creating New Resources
To add new infrastructure components:
1. Modify the Terraform files in the `terraform` directory
2. Apply changes:
```bash
cd terraform
terraform plan
terraform apply
```

### Destroying Infrastructure
To tear down the infrastructure:
```bash
cd terraform
terraform destroy
```

## Nginx Proxy Configuration

The application uses Nginx as a reverse proxy with the following features:
- HTTP/HTTPS support
- Gzip compression
- WebSocket support
- Custom logging
- Load balancing (if configured)

## Security Considerations

- Store sensitive information in Jenkins credentials
- Regularly update dependencies and Docker images
- Implement proper access controls for your infrastructure
- Use secure HTTPS connections
- Regularly audit access logs

## Access the Application
The application can be accessed at: http://sample-app.com
(Replace with your actual domain or IP address)

## Monitoring and Logging

- Application logs are available in the Docker container logs
- Nginx access and error logs are stored in `/var/log/nginx/`
- Infrastructure monitoring can be implemented using your preferred monitoring solution

## Troubleshooting

Common issues and solutions:
1. Nginx proxy connection issues:
   - Check Nginx configuration
   - Verify port mappings
   - Check service health status

2. Pipeline deployment failures:
   - Verify Jenkins credentials
   - Check Digital Ocean droplet connectivity
   - Review Jenkins pipeline logs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

[Include your license information here]
