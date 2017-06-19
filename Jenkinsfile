properties([parameters([
        string(defaultValue: 'https://github.com/hapx101/javaapp.git', description: 'Git repo URL', name: 'git_repo'),
        string(defaultValue: '*/Dockerhub', description: 'git branch', name: 'git_branch'),
        string(defaultValue: '7e8d43a5-00ea-43b9-b6d4-8f1bfe7b5e40', description: 'dockerhub key', name: 'docker_hub_key'),
        string(defaultValue: '/opt/apache-maven-3.5.0/bin', description: 'maven home', name: 'maven_home'),
        string(defaultValue: 'hapx', description: 'docker hub account', name: 'docker_hub_account'),
        string(defaultValue: 'trial', description: 'docker hub repo', name: 'docker_hub_repo')])])
node {
        stage 'SCM polling'
        git url: "${params.git_repo}, branch: ${params.git_branch}"

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
