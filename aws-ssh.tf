# create key pair

# resource "tls_private_key" "opsschool_project_rsa_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "opsschool_project_key" {
#   key_name   = "opsschool_project_keypair"
#   public_key = "${tls_private_key.opsschool_project_rsa_key.public_key_openssh}"
# }


# resource "null_resource" "chmod_400_key" {
#   provisioner "local-exec" {
#     command = "chmod 400 ${path.module}/${local_file.private_key.filename}"
#   }
# }

# resource "local_file" "private_key" {
#   sensitive_content = "${tls_private_key.opsschool_project_rsa_key.private_key_pem}"
#   filename          = "${var.pem_key_name}"
# }
