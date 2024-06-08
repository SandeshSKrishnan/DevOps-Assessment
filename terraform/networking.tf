resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_config.cidr_block
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.vpc_config.subnet_cidr_block
  availability_zone = var.vpc_config.availability_zone
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.routetable.id
}


resource "aws_service_discovery_private_dns_namespace" "pt_notification" {
  name        = var.service_discovery_config.namespace_name
  description = var.service_discovery_config.namespace_description
  vpc         = aws_vpc.myvpc.id
}

resource "aws_service_discovery_service" "notification_svc" {
  name = var.service_discovery_config.notification_service_name

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.pt_notification.id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }
}

resource "aws_service_discovery_service" "email_svc" {
  name = var.service_discovery_config.email_service_name

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.pt_notification.id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }
}

resource "aws_sqs_queue" "pt_notification_queue" {
  name = var.queue_name
}

resource "aws_iam_role_policy" "ecs_sqs_policy" {
  name = var.policy_name
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Effect   = "Allow",
        Resource = aws_sqs_queue.pt_notification_queue.arn
      }
    ]
  })
}