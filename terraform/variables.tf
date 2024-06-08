variable "appmesh_config" {
  description = "Configuration for the App Mesh"
  type = object({
    mesh_name                 : string
    notif_node_name           : string
    email_node_name           : string
    port                      : number
    protocol                  : string
    namespace_name            : string
  })
  default = {
    mesh_name                 = "pt_notification"
    notif_node_name           = "notif-node"
    email_node_name           = "email-node"
    port                      = 3000
    protocol                  = "http"
    namespace_name            = "pt_notification"
  }
}

variable "vpc_config" {
  description = "Configuration for the VPC"
  type = object({
    cidr_block         : string
    subnet1_cidr_block : string
    subnet2_cidr_block : string
    availability_zone  : string
  })
  default = {
    cidr_block         = "10.0.0.0/16"
    subnet1_cidr_block = "10.0.1.0/24"
    subnet2_cidr_block = "10.0.2.0/24"
    availability_zone  = "us-east-1a"
  }
}

variable "service_discovery_config" {
  description = "Variables related to AWS Service Discovery"
  
  type = object({
    namespace_name            = string
    namespace_description     = string
    notification_svc          = string
    email_svc                 = string
  })

  default = {
    namespace_name            = "pt_notification"
    namespace_description     = "Private DNS namespace for the pt-notification"
    notification_svc          = "notification-svc"
    email_svc                 = "email-svc"
  }
}

variable "queue_name" {
  description                 = "SQS Queue name"
  default                     = "pt_notification_queue"
}

variable "policy_name" {
  description                 = "ECS SQS policy definition"
  default                     = "ecs-sqs-policy"
}