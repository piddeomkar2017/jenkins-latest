pipeline{
    agent any
    environment{
        PATH = "/opt/maven/bin:$PATH"
        imagename = "omkarpidde/my-docker-image"
        registryCredential = 'docker-cred'
        DOCKERHUB_CREDENTIALS=credentials('docker-cred')
        dockerImage = ''
    }
    stages{
        stage("git checkout"){
            steps{
                git branch: 'main', url: 'https://github.com/piddeomkar2017/jenkins-latest.git'
            }
        }
        stage("Build"){
            steps{
                sh "mvn clean install"
            }
        }
        stage("Building Docker image"){
            steps{
                sh "docker build -t $imagename ."
            }
        }
        stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}
