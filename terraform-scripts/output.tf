output "Elastic_search" {
  value =join("\n", aws_instance.ES.*.private_ip)
}
output "Logstash" {
  value = join("\n", aws_instance.LS.*.private_ip)
}
output "Kibana" {
  value = join("\n", aws_instance.KI.*.private_ip)
}


resource "local_file" "hosts_cfg" {
  content = templatefile("hosts.tpl",
    {
      es  = aws_instance.ES.*.private_ip
      logstash = aws_instance.LS.*.private_ip
      kibana = aws_instance.KI.*.private_ip
      usr = var.user
      pemkey = var.PemkeyName
    }    
  )
  
   filename = "../ansible-scripts/hosts.ini"
}
