pipeline {
    agent any

    stages {
        stage('checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'pat-token-github-latest', url: 'https://github.com/Sundharabalaji-1Cloudhub/website-repo']])
            }
        }

        stage('installing dependencies') {
            steps {
                 sh '''
                    #!/bin/sh

                    # Install nvm
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | sh

                    # Load nvm into the current shell
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

                    # Install Node.js (stable version)
                    nvm install node
                    nvm use node

                    # Ensure npm is in the PATH
                    export PATH="$NVM_DIR/versions/node/$(nvm current)/bin:$PATH"

                    # Verify npm is available
                    npm --version
                    npm install
                '''
            }
        }

        stage('Build') {
            steps {
                 sh '''
                    #!/bin/sh

                    # Install nvm
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | sh

                    # Load nvm into the current shell
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

                    # Install Node.js (stable version)
                    nvm install node
                    nvm use node

                    # Ensure npm is in the PATH
                    export PATH="$NVM_DIR/versions/node/$(nvm current)/bin:$PATH"

                    # Verify npm is available
                    npm --version
                    npm run build
                '''
            }
            post {
                success {
                    // Archive the build artifacts
                    archiveArtifacts artifacts: 'build/**/*', fingerprint: true
                }
            }
        }
    }
      post {
        success {
            // Send email notification for success
            emailext (
                subject: "Pipeline Success: ${env.JOB_NAME}",
                body: "React CI Pipeline Success: ${env.JOB_NAME} - Build ${currentBuild.number} has finished successfully. View details: ${env.BUILD_URL}",
                to: "sundharabalaji@1cloudhub.com",
                attachLog: true,
                replyTo: "sundharabalaji@1cloudhub.com",
            )
        }
        failure {
            // Send email notification for failure
            
            emailext (
                subject: "Pipeline Failure: ${env.JOB_NAME}",
                body: "React CI Pipeline Failure: ${env.JOB_NAME} - Build ${currentBuild.number} has failed. View details: ${env.BUILD_URL}",
                to: "sundharabalaji@1cloudhub.com",
                attachLog: true,
                replyTo: "sundharabalaji@1cloudhub.com",
            )
        }
    }
    
}
