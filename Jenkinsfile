pipeline {
    agent any

    environment {
        HOME_URL    = "https://www.tecskool.com"   // or use credentials()
        BROWSER     = "headlesschrome"
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
                    mkdir -p results
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