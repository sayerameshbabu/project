pipeline {
    agent any

	stages{
		stage("docker build1"){
			steps{
				node('build-node'){
					sh 'rm -rf /home/centos/project'
					sh '(cd /home/centos/ && git clone https://github.com/sayerameshbabu/project.git ) || (cd /home/centos/project && git pull --all )'
    					sh 'cd /home/centos/project/ && mvn clean package'
					sh '(docker stop calculatorContainer && docker rm calculatorContainer) || echo "container is nor running" '
					sh 'cd /home/centos/project && docker build -t sayerameshbabu/javacalc .'
					sh 'docker run --name calculatorContainer -dt -p 8082:8080 sayerameshbabu/javacalc '
					sh 'echo "docker container running on port 8082" '
				}
			}
		}
		
		stage("installations"){
			steps{
				node('ansible-node') {
					sh 'sudo yum install git -y'
					sh '(cd /home/centos/ &&  git clone https://github.com/sayerameshbabu/project.git) || (cd /home/centos/project &&  git pull --all)'
    					sh 'cd /home/centos/ && ansible-playbook -i ./project/hosts.ini ./project/installations-playbook.yml -v'
				}
			}
		}
		stage("kubernetes-setup"){
			steps{
				node('ansible-node'){
					sh 'cd /home/centos/ && ansible-playbook -i ./project/hosts.ini ./project/kuberenetes-kops-setup-playbook.yml -v'	
				}
			}
		}
		stage("performance test"){
			steps{
				//sh 'mvn  sonar:sonar    -Dsonar.host.url=http://52.90.141.244:9000    -Dsonar.login=eb1030f73a9954a75c5f07cef1dc46866e817764'
				node('build-node') {
					sh 'rm -rf /home/centos/project'
					sh '(cd /home/centos/ && git clone https://github.com/sayerameshbabu/project.git ) || (cd /home/centos/project && git pull --all )'
    					sh 'cd /home/centos/project/ && mvn test'
					sh 'cd /home/centos/project/ && mvn sonar:sonar  -Dsonar.host.url=http://54.89.20.138:9000 -Dsonar.login=10ed36917b9f03140367a856dbfa564dedf29370'
				}
			}
		}
		stage("build"){
			steps{
				node('build-node'){
					sh 'cd /home/centos/project/ && mvn clean package'
				}
			}
		}
		stage("release"){
			steps{
				node('build-node'){
					sh 'cd /home/centos/project && mvn deploy'
				}
			}
		}
		stage("deploy"){
			steps{
				node('build-node'){
					sh 'cp /home/centos/project/target/*.war /home/centos/apache-tomcat-7.0.94/webapps/'
				}
			}
		}
		stage("docker build2"){
			steps{
				node('build-node'){
					sh '(docker stop calculatorContainer && docker rm calculatorContainer) || echo "container is nor running" '
					sh 'cd /home/centos/project && docker build -t sayerameshbabu/javacalc .'
					sh 'docker run --name calculatorContainer -dt -p 8082:8080 sayerameshbabu/javacalc '
					sh 'echo "docker container running on port 8082" '
				}
			}
		}
	}
}
