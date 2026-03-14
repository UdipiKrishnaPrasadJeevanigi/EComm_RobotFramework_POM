pipeline {
    agent any

    environment {
        PYTHONUNBUFFERED = '1'
        PATH = "/var/jenkins_home/.local/bin:${env.PATH}"
    }

    stages {
        stage('Setup Environment') {
            steps {
                sh '''
                    pip install --upgrade pip --break-system-packages
                    pip install -r requirements.txt --break-system-packages
                '''
            }
        }

        stage('Run Robot Framework Tests') {
            steps {
                sh '''
                    robot --outputdir results tests/
                '''
            }
        }
    }

    post {
        always {
            // Archive test results
            archiveArtifacts artifacts: 'results/**/*', allowEmptyArchive: true

            // Publish Robot Framework results
            robot outputPath: 'results',
                  logFileName: 'log.html',
                  reportFileName: 'report.html',
                  outputFileName: 'output.xml'
        }
    }
}