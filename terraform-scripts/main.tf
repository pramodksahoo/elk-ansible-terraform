terraform {
  required_version = ">= 1.0.11"
}

resource "aws_instance" "ES" {

  count = var.ES_Number_of_instances     
  ami = var.ami_ID
  instance_type = var.ec2_instance_type
  
  subnet_id =  element(var.subnet_ids , count.index)
  vpc_security_group_ids = [module.security_group[0].id]
  key_name = var.PemkeyName
  
  tags = {
    Name = var.ES_instance_name==""?"${var.project_name}_es_${count.index+1}":"${var.ES_instance_name}-${count.index+1}"
         }
  depends_on = [module.security_group]

}




resource "aws_instance" "LS" {

  count = var.LS_Number_of_instances     
  ami = var.ami_ID
  instance_type = var.ec2_instance_type
  
  subnet_id =  element(var.subnet_ids , count.index)
  vpc_security_group_ids = [module.security_group[0].id]
  key_name = var.PemkeyName
  
  tags = {
    Name = var.LS_instance_name==""?"${var.project_name}_ls_${count.index+1}":"${var.LS_instance_name}-${count.index+1}"
         }
  depends_on = [module.security_group]
}


resource "aws_instance" "KI" {

  count = var.KI_Number_of_instances     
  ami = var.ami_ID
  instance_type = var.ec2_instance_type
  
  subnet_id =  element(var.subnet_ids , count.index)
  vpc_security_group_ids = [module.security_group[0].id]
  key_name = var.PemkeyName
  
  tags = {
    Name = var.KI_instance_name==""?"${var.project_name}_ki":"${var.KI_instance_name}"
         }

  depends_on = [module.security_group]

}


