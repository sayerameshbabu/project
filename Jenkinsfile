pipeline {
    agent any

	stages{
		stage("installations"){
			steps{
				node('ansible-node') {
    					sh 'ansible-playbook -i hosts.ini installations-playbook.yml -v'
				}
			}
		}
		stage("performance test"){
			steps{
				//sh 'mvn  sonar:sonar    -Dsonar.host.url=http://52.90.141.244:9000    -Dsonar.login=eb1030f73a9954a75c5f07cef1dc46866e817764'
				node('build-node') {
					sh 'git clone '
    					sh 'mvn test'
					sh 'mvn sonar:sonar  -Dsonar.host.url=http://107.21.199.197:9000 -Dsonar.login=10ed36917b9f03140367a856dbfa564dedf29370'
				}
			}
		}
		stage("build"){
			steps{
				node('build-node'){
					sh 'mvn clean package'
				}
			}
		}
		stage("release"){
			steps{
				sh 'mvn deploy'
			}
		}
		stage("deploy"){
			steps{
				deploy adapters: [tomcat7(credentialsId: 'tomcat-admin', path: '', url: 'http://52.90.141.244:7777/')], contextPath: 'calc', war: '**/*.war'
			}
		}
	}
}
