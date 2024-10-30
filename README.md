# Retail Store Sample Application

## Overview
This is a sample retail store application deployed using Jenkins pipeline to a Digital Ocean droplet. The application demonstrates a microservices architecture using various AWS container images.

## Project Structure
```
.
├── image/                  
├── terraform/             
│   ├── .terraform/        
│   ├── main.tf           
│   ├── output.tf         
│   ├── provider.tf       
│   └── variabel.tf      
├── .gitignore          
├── Jenkinsfile          
└── README.md            
```

## Microservices Architecture

The application uses the following AWS container images:
- `retail-store-sample-ui:latest`
- `retail-store-sample-catalog:latest`
- `retail-store-sample-cart:latest`
- `retail-store-sample-orders:latest`
- `retail-store-sample-checkout:latest`
- `retail-store-sample-assets:latest`

All images are pulled from the public ECR repository: `public.ecr.aws/aws-containers/`

## Prerequisites

- Jenkins server with following plugins:
  - SSH Agent Plugin
  - Pipeline Plugin
- Docker and Docker Compose on the target Digital Ocean droplet
- SSH access to Digital Ocean droplet
- Git access to the repository

## Jenkins Pipeline Configuration

### Pipeline Stages

1. **Preparation**
   - Cleans up existing workspace
   - Removes any previous clone of the repository
   ```groovy
   stage('Preparation') {
       steps {
           script {
               if (fileExists('retail-store-sample-app')) {
                   sh 'rm -rf retail-store-sample-app'
               }
           }
       }
   }
   ```

2. **Clone Repository**
   - Clones the retail store sample application
   - Source: `https://github.com/aws-containers/retail-store-sample-app.git`
   ```groovy
   stage('Clone Repository') {
       steps {
           script {
               sh 'git clone https://github.com/aws-containers/retail-store-sample-app.git'
           }
       }
   }
   ```

3. **Update Docker Compose**
   - Updates image tags in docker-compose.yml
   - Sets all services to use latest tags from public ECR
   - Location: `retail-store-sample-app/deploy/docker-compose/docker-compose.yml`

4. **Deploy to Digital Ocean**
   - Copies application to Digital Ocean droplet
   - Deploys using Docker Compose
   - Target path: `/root/retail-app`
   - Runs with MySQL password configuration

### Required Jenkins Credentials

1. SSH Agent Configuration:
   - Credential ID: `digital-ocean-ssh`
   - Type: SSH Username with private key
   - Scope: Global
   - Description: Digital Ocean droplet SSH access

### Environment Variables

- `DROPLET_IP`: '178.128.81.172'
- `MYSQL_PASSWORD`: 'password'

## Deployment Configuration

### Digital Ocean Setup
1. Droplet must have Docker and Docker Compose installed
2. SSH access must be configured for root user
3. Required ports must be open:
   - 22 (SSH)
   - 80 (HTTP)
   - 8888 (Application)

### Docker Compose Configuration
The application is deployed using Docker Compose with the following services:
- UI Service
- Catalog Service
- Cart Service
- Orders Service
- Checkout Service
- Assets Service

## Pipeline Execution

### Running the Pipeline
1. Configure a new Pipeline job in Jenkins
2. Set the pipeline definition to "Pipeline script from SCM"
3. Configure Git repository URL
4. Set the script path to "Jenkinsfile"
5. Save and run the pipeline

### Post-Deployment Steps
The pipeline includes post-execution cleanup:
- Removes any .env files
- Cleans up workspace
- Logs execution status

### Error Handling
The pipeline includes:
- Automatic cleanup in case of failure
- Error logging
- Status reporting

## Troubleshooting

Common Issues and Solutions:

1. **SSH Connection Failures**
   ```bash
   # Verify SSH access
   ssh -i <path-to-key> root@178.128.81.172
   ```

2. **Docker Compose Errors**
   ```bash
   # Check Docker service status
   systemctl status docker
   
   # View container logs
   docker compose logs
   ```

3. **Pipeline Failures**
   - Check Jenkins console output
   - Verify credentials in Jenkins
   - Ensure Digital Ocean droplet is accessible

## Monitoring

1. **Application Logs**
   ```bash
   # View container logs
   docker compose logs -f
   ```

2. **Pipeline Logs**
   - Available in Jenkins job console output
   - Build history in Jenkins


