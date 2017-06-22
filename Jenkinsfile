properties([parameters([
        string(defaultValue: 'https://github.com/mamatabongale/javaapp.git', description: 'Git repo URL', name: 'git_repo'),
        string(defaultValue: 'Dockerhub', description: 'git branch', name: 'GIT_BRANCH'),
        string(defaultValue: '885593d5-f859-4376-9d2d-d850f6a2c1a7', description: 'dockerhub key', name: 'docker_hub_key'),
        string(defaultValue: '/opt/apache-maven-3.5.0/bin', description: 'maven home', name: 'maven_home'),
        string(defaultValue: 'mamata', description: 'docker hub account', name: 'docker_hub_account'),
        string(defaultValue: 'trial', description: 'docker hub repo', name: 'docker_hub_repo')])])
node {
        stage 'SCM polling'
        checkout scm
        
        stage 'Maven build'
        sh "${params.maven_home}/mvn clean install"
        archive 'target/*.war'

        stage 'Docker image build'
        def pkg = docker.build ("${params.docker_hub_account}/${params.docker_hub_repo}", '.')
        def aws_pkg = docker.build ("${params.aws_ecr_repo}", '.')

        stage 'DockerHub Push'
        docker.withRegistry ('https://index.docker.io/v1', "${params.docker_hub_key}") {
                sh 'ls -lart'
                pkg.push "v${BUILD_NUMBER}"
        }
}
