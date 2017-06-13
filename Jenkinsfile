node {
        def git_repo = 'https://github.com/hapx101/javaapp.git'
        def docker_hub_key = '7e8d43a5-00ea-43b9-b6d4-8f1bfe7b5e40'
        def maven_home = '/opt/apache-maven-3.5.0/bin'
        def aws_ecr_account_url = 'https://016866562124.dkr.ecr.ap-northeast-1.amazonaws.com'
        def aws_ecr_repo = 'trial'
        def aws_ecr_repo_url = "${aws_ecr_account_url}/${aws_ecr_repo}"
        def docker_hub_account = 'hapx'
        def docker_hub_repo = 'trial'
        def aws_region = 'ap-northeast-1'
        def aws_ecr_repo_key = 'c7d52f05-c3ad-4001-a188-17d44560f4b3'
        def aws_cli_home = '~/.local/bin'
        def aws_ecs_service_name = 'trial'
        def aws_ecs_cluster_name = 'trial'
        def aws_ecs_task_definition = 'trial'
        def aws_ecs_task_desired_count = '1'
        def aws_ecs_instance_type = 't2.micro'
        def aws_ecs_key_name = 'wow'
        def aws_ecs_subnet_id = '3e4b0248'
        def service_value = 'create'
        def service_option = '--service-name'
        
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
        
        stage 'AWS ECR image push'
        sh "${aws_cli_home}/aws ecr get-login --no-include-email --region ${aws_region}"
        docker.withRegistry ("${aws_ecr_account_url}/${aws_ecr_repo}", "ecr:${aws_region}:${aws_ecr_repo_key}") {
                sh 'ls -lart'
                aws_pkg.push "v${BUILD_NUMBER}"
        }
        
        stage 'ECS cluster creation'
        sh "${aws_cli_home}/aws ec2 run-instances --instance-type ${aws_ecs_instance_type} --image-id ami-f63f6f91 --key-name ${aws_ecs_key_name} --count 1 --subnet-id subnet-${aws_ecs_subnet_id} --iam-instance-profile Name=ecsInstanceRole --user-data file://ecs_cluster_user_data.sh"
        sh "${aws_cli_home}/aws ecs create-cluster --cluster-name \"${aws_ecs_cluster_name}\""
        
        stage 'ECS task definition'
        sh "${aws_cli_home}/aws ecs register-task-definition --cli-input-json file://task_definition.json"
        
        stage 'ECS service definition'
        def service_script = "${aws_cli_home}/aws ecs list-services --cluster ${aws_ecs_cluster_name} | grep 'service/${aws_ecs_service_name}'"
        def service_status = sh(returnStdout: true, script: "${service_script} || true") 
        if ("${service_status}" != '') {
                service_value = 'update'
                service_option = '--service'
        }
        sh "${aws_cli_home}/aws ecs ${service_value}-service --cluster ${aws_ecs_cluster_name} ${service_option} ${aws_ecs_service_name} --task-definition ${aws_ecs_task_definition} --desired-count ${aws_ecs_task_desired_count}"
}
