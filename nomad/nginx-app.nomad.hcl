job "nginx-app" {
  datacenters = ["dc1"]
  type = "service"

  # Parameterizable image tag
  variable "image_tag" {
    type    = string
    default = "latest"
  }

  group "nginx" {
    count = 1

    network {
      port "http" {
        static = 0
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "ghcr.io/${NOMAD_META_OWNER}/devops-intern-final:${var.image_tag}"
        ports = ["http"]
        # map container port 8080 to the dynamic host port
        port_map = {
          http = 8080
        }
      }

      resources {
        cpu    = 100   # MHz
        memory = 64    # MB
      }

      service {
        name = "nginx-app"
        port = "http"
        tags = ["urlprefix-/${NOMAD_ALLOC_ID}/"]
        check {
          type     = "http"
          path     = "/healthz"
          interval = "10s"
          timeout  = "2s"
        }
      }

      restart {
        attempts = 2
        interval = "30s"
        delay    = "15s"
        mode     = "fail"
      }

      update {
        max_parallel      = 1
        min_healthy_time  = "10s"
        healthy_deadline  = "2m"
        auto_revert       = true
        canary            = 0
      }
    }
  }
}
