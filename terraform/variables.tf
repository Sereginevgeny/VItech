
variable "kubeconfig" {
    type = string
    default = "~/.kube/config"
}

variable "namespace_name" {
    type = string
    default = "nginx-namespace"
}

variable "ingress_host" {
    type = string
    default = "localhost/"
}

variable "nginx_image" {
    type = string
    default = "nginx:latest"
}

variable "cpu_request" {
    type = string
    default = "1000m"
}

variable "memory_request" {
    type = string
    default = "1Gi"
}

variable "cpu_limit" {
    type = string
    default = "2000m"
}

variable "memory_limit" {
    type = string
    default = "2Gi"
}