pipeline {
    agent any
    environment {
        terraform_version = '0.12.26'
        packer_version = '1.6.6'
        access_key = credentials('jenkins-aws-access-key-id')
        secret_key = credentials('jenkins-aws-secret-access-key')
        owner = credentials('aws-owner')
        env_dev = 'Dev'
        env_prod = 'Prod'
    }
    stages {
        stage('Generate AMI') {
            steps {
                dir('./packer'){
                    sh 'ls -la; pwd; packer build -var \'environment=\'$env_dev\'\'  template.json'
                }
            }
        }
        stage('Terraform Deploy'){
            steps {
                dir('./terraform'){
                    sh "terraform init"
                    sh 'terraform plan -var \'owner=\'$owner\'\''
                    sh 'terraform apply -auto-approve -var \'owner=\'$owner\'\''
                    sh 'hostname=$(terraform output publicIp)'
                }
            }
        }

        stage('Performance Testing'){
            steps {
                echo 'Installing k6'
                sh 'sudo chmod +x setup_k6.sh'
                sh 'sudo ./setup_k6.sh'
                echo 'Running K6 performance tests...'
                sh 'k6 run -e MY_HOSTNAME=\'$hostname\' loadtests/performance-test.js'
            }
        }

        stage('Rename AMI and shutdown Test VM'){
            steps {
                dir('./terraform-CD'){
                    sh "terraform init"
                    sh 'terraform plan -var \'owner=\'$owner\'\''
                    sh 'terraform apply -auto-approve -var \'owner=\'$owner\'\''
                }
                dir('./terraform'){
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
