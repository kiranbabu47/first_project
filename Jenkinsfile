pipeline {
    agent any

    environment {
        ORACLE_HOST = '192.168.29.171'
        ORACLE_USER = 'oracle'
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out source code from Git..."
                checkout scm
            }
        }

        stage('Oracle Server Connectivity') {
            steps {
                sshagent(['oracle-primary-ssh']) {
                    sh '''
                        echo "========================================"
                        echo "Testing SSH connectivity..."
                        echo "========================================"

                        ssh -o StrictHostKeyChecking=no \
                            ${ORACLE_USER}@${ORACLE_HOST} \
                            "hostname"
                    '''
                }
            }
        }

        stage('Oracle Server Health Check') {
            steps {
                sshagent(['oracle-primary-ssh']) {
                    sh '''
                        echo "========================================"
                        echo "Running Oracle db orcl health check..."
                        echo "========================================"

                        scp -o StrictHostKeyChecking=no \
                            scripts/oracle_db_health_check.sh \
                            ${ORACLE_USER}@${ORACLE_HOST}:/tmp/oracle_db_health_check.sh

                        ssh -o StrictHostKeyChecking=no \
                            ${ORACLE_USER}@${ORACLE_HOST} \
                            "chmod +x /tmp/oracle_db_health_check.sh && \
                             /tmp/oracle_db_health_check.sh"
                    '''
                }
            }
        }
    }

    post {

        success {
            echo '========================================'
            echo 'Oracle Primary health check PASSED.'
            echo '========================================'
        }

        failure {
            echo '========================================'
            echo 'Oracle Primary health check FAILED.'
            echo '========================================'
        }

        always {
            echo 'Jenkins pipeline execution completed.'
        }
    }
}
