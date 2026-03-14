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
                sh """
                    # Kill any stale Chrome from previous builds
                    pkill -f chrome      || true
                    pkill -f chromedriver || true

                    # Delete Chrome singleton lock files (root cause of the error)
                    find /tmp -name 'SingletonLock'   -delete 2>/dev/null || true
                    find /tmp -name 'SingletonSocket' -delete 2>/dev/null || true
                    find /tmp -name 'SingletonCookie' -delete 2>/dev/null || true
                    rm -rf /tmp/.com.google.Chrome.* || true
                    rm -rf /tmp/chrome-* || true

                    mkdir -p ${RESULTS_DIR}
                    robot \
                        --variable HOME_URL:${HOME_URL} \
                        --variable BROWSER:${BROWSER} \
                        --variable BUILD_NUMBER:${BUILD_NUMBER} \
                        --outputdir ${RESULTS_DIR} \
                        --output    output.xml \
                        --log       log.html \
                        --report    report.html \
                        tests/
                """
            }
        }
    }

    post {
         always {
            script {
                if (fileExists("${RESULTS_DIR}/output.xml")) {
                    robot outputPath:       "${RESULTS_DIR}",
                          logFileName:      'log.html',
                          reportFileName:   'report.html',
                          outputFileName:   'output.xml',
                          passThreshold:    90,
                          unstableThreshold: 80
                } else {
                    echo "No output.xml — robot publisher skipped"
                }
            }
            archiveArtifacts artifacts: "${RESULTS_DIR}/**/*",
                             allowEmptyArchive: true
        }
        success { echo "Build passed!" }
        failure { echo "Tests failed — check Robot report" }
    }
}