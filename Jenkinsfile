pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                script {
                    // Clean up the directory if it already exists to avoid Git clone errors
                    if (fileExists('retail-store-sample-app')) {
                        sh 'rm -rf retail-store-sample-app'
                    }
                }
            }
        }

        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository afresh
                    sh 'git clone https://github.com/aws-containers/retail-store-sample-app.git'
                }
            }
        }

       stage('Update Docker Compose') {
    steps {
        script {
            // Navigate to the docker-compose directory and update image tags
            sh '''
            cd retail-store-sample-app/deploy/docker-compose
            sed -i 's|image: .*retail-store-sample-ui.*|image: public.ecr.aws/aws-containers/retail-store-sample-ui:latest|g' docker-compose.yml
            sed -i 's|image: .*retail-store-sample-catalog.*|image: public.ecr.aws/aws-containers/retail-store-sample-catalog:latest|g' docker-compose.yml
            sed -i 's|image: .*retail-store-sample-cart.*|image: public.ecr.aws/aws-containers/retail-store-sample-cart:latest|g' docker-compose.yml
            sed -i 's|image: .*retail-store-sample-orders.*|image: public.ecr.aws/aws-containers/retail-store-sample-orders:latest|g' docker-compose.yml
            sed -i 's|image: .*retail-store-sample-checkout.*|image: public.ecr.aws/aws-containers/retail-store-sample-checkout:latest|g' docker-compose.yml
            sed -i 's|image: .*retail-store-sample-assets.*|image: public.ecr.aws/aws-containers/retail-store-sample-assets:latest|g' docker-compose.yml
            '''
        }
    }
}


        stage('Deploy to Digital Ocean') {
            steps {
                script {
                    // Replace 'digital-ocean-ssh' with the actual ID for SSH credentials
                    sshagent(['digital-ocean-ssh']) {
                        sh '''
                        # Define the host IP or domain name of your Digital Ocean droplet
                        DROPLET_IP='178.128.81.172'

                        # Copy the repository to the droplet
                        scp -r retail-store-sample-app root@$DROPLET_IP:/root/retail-app

                        # Connect to the droplet and run docker-compose
                        ssh root@$DROPLET_IP 'cd /root/retail-app/retail-store-sample-app/dist/docker-compose && MYSQL_PASSWORD='password' docker compose up -d'
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up the .env file after execution
            script {
                if (fileExists('retail-store-sample-app/deploy/docker-compose/.env')) {
                    sh 'rm -f retail-store-sample-app/deploy/docker-compose/.env'
                }
            }
            echo 'Pipeline execution complete.'
        }

        failure {
            echo 'Pipeline failed to execute!'
        }
    }
}
