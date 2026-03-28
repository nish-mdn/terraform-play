output "instance_id" {
  value       = try(aws_instance.this[0].id, "")
  description = "EC2 instance id"
}

output "instance_public_ip" {
  value       = try(aws_instance.this[0].public_ip, "")
  description = "EC2 public IP (if any)"
}

output "key_name" {
  value       = local.key_name
  description = "Key pair name used for EC2"
}

