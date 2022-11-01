pipeline{
  agent any
  stages{
    stage("git checkout"){
      steps{
              git branch:'main', credentialsId: 'github-creds', url: 'https://github.com/greeshmagit/tf-asg-globant.git'
           }
    }
    stage("terraform initiation")
      steps{
              sh 'terraform init'
           }   
    }
    stage("terraform action"){
      steps{
              echo "Terraform action stage"
              sh 'terraform action --auto-approve'
           }
    }
  }
}
  
