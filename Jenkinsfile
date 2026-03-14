pipeline {
    agent any

    options {
        timeout(time: 30, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
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
                    pkill -f chrome       || true
                    pkill -f chromedriver || true
                    find /tmp -name 'SingletonLock'   -delete 2>/dev/null || true
                    find /tmp -name 'SingletonSocket' -delete 2>/dev/null || true
                    rm -rf /tmp/.com.google.Chrome.*  || true
                    rm -rf /tmp/chrome-*              || true

                    mkdir -p results

                    /var/jenkins_home/.local/bin/robot \
                        --variable BROWSER:headlesschrome \
                        --outputdir results \
                        --output    output.xml \
                        --log       log.html \
                        --report    report.html \
                        tests/
                '''
            }
        }

    }

    post {
        always {
            script {
                if (fileExists('results/output.xml')) {
                    robot outputPath:       'results',
                          logFileName:      'log.html',
                          reportFileName:   'report.html',
                          outputFileName:   'output.xml',
                          passThreshold:     90,
                          unstableThreshold: 80
                } else {
                    echo 'No output.xml found — robot publisher skipped'
                }
            }
            archiveArtifacts artifacts: 'results/**/*',
                             allowEmptyArchive: true
        }
        success { echo 'All tests passed!' }
        failure { echo 'Tests failed — check the Robot report link above' }
    }
}