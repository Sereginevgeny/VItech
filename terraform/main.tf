# main.tf
provider "kubernetes" {
  config_path = var.kubeconfig
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace_name
  }
}

resource "kubernetes_ingress" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    rule {
      host = var.ingress_host

      http {
        path {
          path = "/nginx"
          backend {
            service_name = kubernetes_service.nginx_service.metadata.0.name
            service_port = "8080"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx_service" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx"
    }
    port {
      port        = "8080"
      target_port = "8080"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "nginx_pod" {
  metadata {
    name      = "nginx-pod"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    container {
      image = var.nginx_image
      name  = "nginx"

      resources {
        requests = {
          cpu    = var.cpu_request
          memory = var.memory_request
        }
        limits = {
          cpu    = var.cpu_limit
          memory = var.memory_limit
        }
      }

      port {
        container_port = "8080"
      }
    }
    node_selector = {
      dedicated = "dev"
    }
    toleration {
      effect   = "NoExecute"
      key      = "dedicated"
      value    = "dev"
    }
  }
}