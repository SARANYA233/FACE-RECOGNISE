#STEP:1 : CREATING INSTANCES

provider "aws"{
	region = "ap-south-1"
	profile = "default"
}

resource "aws_instance" "os1" {

ami = "ami-010aff33ed5991201"
instance_type= "t2.micro"
tags = {
	Name = "FR OS"
	}
}

output "public_ip_is" {
	value = aws_instance.os1.public_ip
}

output "availability_zone_is" {
	value = aws_instance.os1.availability_zone
}

#STEP:2 : CREATING VOLUME

resource "aws_ebs_volume" "VOLUME-TF" {
  availability_zone = aws_instance.os1.availability_zone
  size              = 5

  tags = {
    Name = "HARD_DISK_TF"
  }
}

output "volume_id_is" {
	value = aws_ebs_volume.VOLUME-TF.id
}

#STEP:3 : ATTACH VOLUME TO INSTANCE

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.VOLUME-TF.id
  instance_id = aws_instance.os1.id
}

output "volume_attachment_details" {
	value = aws_volume_attachment.ebs_att
}
