node {
        def git_repo = 'https://github.com/hapx101/javaapp.git'
        def docker_hub_key = '7e8d43a5-00ea-43b9-b6d4-8f1bfe7b5e40'
        def maven_home = '/opt/apache-maven-3.5.0/bin'
        def docker_hub_account = 'hapx'
        def docker_hub_repo = 'trial'
        
        stage 'SCM polling'
        git url: "${git_repo}"

        stage 'Maven build'
        sh "${maven_home}/mvn clean install"
        archive 'target/*.war'

        stage 'Docker image build'
        def pkg = docker.build ("${docker_hub_account}/${docker_hub_repo}", '.')
        def aws_pkg = docker.build ("${aws_ecr_repo}", '.')

        stage 'DockerHub Push'
        docker.withRegistry ('https://index.docker.io/v1', "${docker_hub_key}") {
                sh 'ls -lart'
                pkg.push "v${BUILD_NUMBER}"
        }
