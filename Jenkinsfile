pipeline {
  agent any
  tools {
      terraform "terraform"
  }
  options {
        ansiColor('xterm')
    }
      
  parameters
    {
   string(name: 'TF_VAR_access_key' ,defaultValue: 'ASIAYHJRINSEJGXZEKF6')
   string(name: 'TF_VAR_secret_key' ,defaultValue: '2kW8awYyh2gQ1ml+jVZsxomWTsRfjaapw+ACpGi8')
   string(name: 'TF_VAR_aws_session_token' ,defaultValue: 'IQoJb3JpZ2luX2VjEGYaCXVzLWVhc3QtMSJIMEYCIQCQGn2d2AvABcJ4EBu2p/xNREV6cV7I2a8ImAWzCQV1mwIhAIWRSwYmCWDarhb3iT4RzOf2syG9BzugQyy2wjXAQt2/KqUDCM///////////wEQARoMNTY1NDI4MzgyODU2IgynjxJ7oakMZYZyTGUq+QJ8lwPfG0COJLCuwBkSz79zUic7eT6qLjmvzbF8Z+61wqEaO5DKzSPWnacGGBfdjGUPLQUvtVa6H1uhIk7UqTu8I9tgSGZmcM5RSgaJXcta3V03ms5udqBmVC5SjCif5qgPf8NujHXy2An7+0sU2PKFDr2WGG35Z5OGgnoKrc9+R36ojS0OGkwHK8o9As4ANC9JMP3vvvi5EU4hl92UhA/p2/8Yjj5c5W4yx/tDP/uUjIkTR9F59EbPsJjPsYohumsAdrvni09qNKpAlOwULMTwtxqXSkL8pyKBW+AYihOXQZp1JZp3rBq3PYUWdhChzgn0CWKNCJ3VtMuhDYoCwYrjKEhxBuibkYDKCKjyzSG7X4cgWQNIPeJJP567dL/LGTL89+Qx4HcCHyzQWmlrJB+rsTYX3oD7HfJxZpEu1PScnL9GoCcMAS+zrNzA9AyKGDesyf7ZQOu7uDa8LPGl1/RMSj6AJDlA6RKZbKY1/+Bb3v9vft+KDXN23jD91eyXBjqlAQvPJgbpUo8eTod+8NqxaA6F9qKz1NGYAPys7pEUSnkiKHVo98LiUmW2KdDh3xLR27EzHCGHSCQZB1VmREG4K1+auwdDtm9xxpGlSGOBTBofon3fO5Uoiy3aZx0w8jjc/IlbW1paCIG+igI3sJZ+sudDtSRwXiQ39/0had+Le0J7QSfNs2qZQEtDScpgQIWq/TBFfJj5AdnD1H+jAINworzsbnsGgg==')
   string(name: 'ec2_user' ,defaultValue: 'centos')
   string(name: 'ami_id' ,defaultValue: 'ami-0ff760d16d9497662')
   string(name: 'region' ,defaultValue: 'eu-west-1')  
   string(name: 'key_name' ,defaultValue: 'nlpivr-prod-eu-west-1')  
   string(name: 'sg_name' ,defaultValue: 'nlpivr-prod-cassandra-sg')    
   string(name: 'instance_name' ,defaultValue: 'nlpivr-prod-cassandra')
   string(name: 'vpc_id' ,defaultValue: 'vpc-00f1604684f6dd127')  
   string(name: 'subnet_id1' ,defaultValue: 'subnet-0bd0e3b4958fba718')
   string(name: 'subnet_id2' ,defaultValue: 'subnet-096a978ad69597a16')
   string(name: 'subnet_id3' ,defaultValue: 'subnet-0d672c5649a56088d')   
      
                 
  booleanParam(name: 'terraform_apply', defaultValue: false, description: 'Select to Run terraform apply command')
  booleanParam(name: 'terraform_destroy', defaultValue: false, description: 'Select to Run terraform destroy command') 
      
  
    }

  stages {

    stage('Git Checkout') {
      steps {
        git branch: 'Jenkins-Job', credentialsId: 'svc-usjenkins-devops', url: 'git@github.worldpay.com:Docet-USA/ansible-elk.git'
      }
    }
 stage('Copy Var') {
      steps{
            sh 'ls -lart'    
            sh "pwd"
            echo "cd terraform-scripts"
            dir('terraform-scripts') {
                  sh "pwd"

                  sh 'echo "access_key = \\"${TF_VAR_access_key}\\"" >> ./terraform.tfvars'
                  sh 'echo "secret_key = \\"${TF_VAR_secret_key}\\"" >> ./terraform.tfvars'
                  sh 'echo "aws_session_token = \\"${TF_VAR_aws_session_token}\\"" >> ./terraform.tfvars'
                  sh 'echo "user = \\"${ec2_user}\\"" >> ./terraform.tfvars' 
                  sh 'echo "ami_ID = \\"${ami_id}\\"" >> ./terraform.tfvars'     
                  sh 'echo "region = \\"${region}\\"" >> ./terraform.tfvars'  
                  sh 'echo "PemkeyName = \\"${key_name}\\"" >> ./terraform.tfvars' 
                  sh 'echo "instance_name = \\"${instance_name}\\"" >> ./terraform.tfvars'
                  sh 'echo "sg_name = \\"${sg_name}\\"" >> ./terraform.tfvars' 
                  sh 'echo "vpc_id = \\"${vpc_id}\\"" >> ./terraform.tfvars'
                  sh 'echo "subnet_ids = [\\"${subnet_id1}\\",\\"${subnet_id2}\\",\\"${subnet_id2}\\"]" >> ./terraform.tfvars'

               
                  
                     
            }
            
     
}
   }
    stage('Terraform Init') {
      steps {
      ansiColor('xterm') {
         sh "pwd"
        dir('terraform-scripts') {
          sh "pwd"
          sh label: '', script: 'terraform init'
        }
        sh "pwd"
      }
      }
    }
   
    stage('Terraform apply') {
       when{
       expression { params.terraform_apply}
     }
      steps {
         ansiColor('xterm') {
         sh "pwd"
        dir('terraform-scripts') {
     sh label: '', script: 'terraform apply --auto-approve'
        }
        sh "pwd"
         }
      }
    }
    
    
    stage('Terraform destroy') {
       when{
       expression { params.terraform_destroy}
     }
      steps {
         ansiColor('xterm') {
         sh "pwd"
        dir('terraform-scripts') {
     sh label: '', script: 'terraform destroy --auto-approve'
        }
        sh "pwd"
         }
      }
    }
    
    
   stage('ansible playbook')
    {
      when{
       expression { params.terraform_apply}
     }
      steps {
        sh "pwd"
      sh 'cd ansible-scripts'
    dir('ansible-scripts') {
      sh "pwd"
      //sh 'chmod 400 ../../pem-keys/*.pem'
      sh 'chmod 400 ../../../pem-keys/"${key_name}".pem'
      sh 'ansible-playbook -i hosts.ini main.yml'   
    }
    sh "pwd"
        
     
     
      }
    }
   
    
  }
}
