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
    }
}
