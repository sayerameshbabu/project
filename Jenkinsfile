pipeline {
    agent any

	stages{
		stage("unit test"){
			steps{
				sh 'mvn test'
			}
		}
		stage("performance test"){
			steps{
				//sh 'mvn  sonar:sonar    -Dsonar.host.url=http://52.90.141.244:9000    -Dsonar.login=eb1030f73a9954a75c5f07cef1dc46866e817764'
				echo "testing"
			}
		}
		stage("build"){
			steps{
				sh 'mvn clean package'
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
