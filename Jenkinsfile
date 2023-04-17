pipeline{
  agent any
  stages{
    stage("git checkout"){
      steps{
              git branch:'main', credentialsId: 'github-creds', url: 'https://github.com/greeshmagit/tf-asg-globant.git'
           }
    }
    stage("terraform initiation"){
      steps{
              sh 'terraform init'
           }   
    }
    stage("terraform validate"){
       steps{
                 echo "Terraform validation"
                 sh 'terraform validate'
            }
    }
    stage("terraform  plan"){
       steps{
                 echo "Terraform plan"
                 sh 'terraform plan'
            }
    }
    stage("terraform action"){
      steps{
              echo "Terraform action stage"
              sh 'terraform action --auto-approve'
           }
    }
    stage("terraform destroy"){
      steps{
              echo "destroying terraform apply"
              sh 'terraform destroy'
           }
    }
  }
}
  
