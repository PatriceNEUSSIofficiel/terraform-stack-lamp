provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_deployment" "apache_deployment" {
  metadata {
    name      = "apache"
    namespace = "patrice"
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "apache"
      }
    }

    template {
      metadata {
        labels = {
          app = "apache"
        }
      }
      spec {
        container {
          name  = "apache"
          image = "httpd:latest"

          port {
            container_port = 80
          }
        }

         node_name = "master"
      }
    }
  }
}



resource "kubernetes_service" "apache_service" {
  depends_on = [ kubernetes_deployment.apache_deployment ]
  metadata {
    name      = "apache-service"
    namespace = "patrice"
  }
  spec {
    selector = {
      app = "apache"
    }
    type     = "NodePort"
    port {
      name       = "http-port"
      port       = 80
      target_port = 80
      node_port = 30002
    }
  }
}