resource "aws_appmesh_mesh" "pt_notification" {
  name = var.appmesh_config.mesh_name
}

resource "aws_appmesh_virtual_node" "notif_node" {
  mesh_name = aws_appmesh_mesh.pt_notification.name
  name      = var.appmesh_config.notif_node_name 

  spec {
    listener {
      port_mapping {
        port     = var.appmesh_config.port
        protocol = var.appmesh_config.protocol
      }
    }

    service_discovery {
      aws_cloud_map {
        namespace_name = aws_service_discovery_private_dns_namespace.pt_notification.name
        service_name   = aws_service_discovery_service.notification_svc.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "notification_service" {
  mesh_name = aws_appmesh_mesh.pt_notification.name
  name      = "${var.service_discovery_config.notification_svc}.${var.appmesh_config.namespace_name}.public"

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.notif_node.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "email_node" {
  mesh_name = aws_appmesh_mesh.pt_notification.name
  name      = var.appmesh_config.email_node_name

  spec {
    listener {
      port_mapping {
        port     = var.appmesh_config.port
        protocol = var.appmesh_config.protocol
      }
    }

    service_discovery {
      aws_cloud_map {
        namespace_name = aws_service_discovery_private_dns_namespace.pt_notification.name
        service_name   = aws_service_discovery_service.email_svc.name
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "email_service" {
  mesh_name = aws_appmesh_mesh.pt_notification.name
  name      = "${var.service_discovery_config.email_svc}.${var.appmesh_config.namespace_name}.public"

  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.email_node.name
      }
    }
  }
}
