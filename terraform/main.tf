# AWS Access keys
variable "aws_access_key" {
  description = "Access-key-for-AWS"
  default = "no_access_key_value_found"
}

variable "aws_secret_key" {
  description = "Secret-key-for-AWS"
  default = "no_secret_key_value_found"
}

provider "aws" {
	region = "eu-west-3"
	access_key = var.aws_access_key
	secret_key = var.aws_secret_key
}

# EC2 instance resource 
resource "aws_instance" "proton" {
	ami = "ami-00983e8a26e4c9bd9"   # Ubuntu 22.04 LTS
	instance_type = "t2.micro"
  key_name = aws_key_pair.proton.key_name

  # 30GB Elastic Block Storage Assigned to the instance
  root_block_device {
    volume_size = 30 # in GB
    volume_type = "gp2"
  }

  # Tags
  tags = {
		Name = "Proton Ubuntu 22.04 LTS"
    Role = "production"
	}
  
  # Bash script to provision the server. Installs requirements to manage from ansible, and ssh keys
  provisioner "file" {
    source="provision.sh"
    destination="/tmp/provision.sh"
  }

  # Extra ssh key to be managed from ansible-manager host
  provisioner "file" {
    source="ansible-node.pub"
    destination="/tmp/ansible-node.pub"
  }

  # Extra ssh key to connect to the codechallenge repo (to deploy app with ansistrano)
  provisioner "file" {
    source="gitHubkey.pem"
    destination="/tmp/gitHubKey"
  }

  # Executes the provisioner bash script
  provisioner "remote-exec" {
    inline=[
      "sudo chmod +x /tmp/provision.sh",
      "sudo /tmp/provision.sh"
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.proton_key.private_key_pem
    timeout     = "4m"
  }

  # Link the EC2 instance with a security group
  vpc_security_group_ids = [aws_security_group.proton.id]
}

# Resource to create a ssh key pair
resource "tls_private_key" "proton_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Ssh keypair resource for the EC2 instance
resource "aws_key_pair" "proton" {
  key_name   = "proton_key"       # Create a "proton_key" to AWS!!
  public_key = tls_private_key.proton_key.public_key_openssh

  provisioner "local-exec" { # Create a "proton_key.pem" to your computer!!
    command = "echo '${tls_private_key.proton_key.private_key_pem}' > ./proton_key.pem"
  }
}

# Security group resource for the EC2 instance allows incomming traffic to HTTP and SSH ports
resource "aws_security_group" "proton" {
	name = "proton-tcp-security-group"
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

  ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}