pipeline {
    // agent { docker { image 'python:3.5.1' } }
    agent any
    stages {
        stage('build') {
            steps {
                //sh 'python --version'
		sh label: 'runVirusScan', script: '''dirToScan="/home/carlo/Downloads"
		echo "Attempting to run ClamAV against "$dirToScan

		cd $dirToScan
		pwd

		virus-scan'''
            }
        }
	stage('notification'){
		steps {
		mail bcc: '', body: 'Virus Scan ran against ubuntu Downloads folder', cc: '', from: 'carloesanchez@gmail.com', replyTo: '', subject: 'Virus Scan Completed', to: 'carloesanchez@gmail.com'
		}
	}
    }
}
