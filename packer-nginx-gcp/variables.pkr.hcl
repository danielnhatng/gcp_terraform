variable "account_file" {
    type    = string
}

variable "image_description"{
    type = string
}

variable "image_name"{
    type = string
}

variable "project_id"{
    type = string
}

variable "source_image_family"{
    type = string
}

variable "ssh_username"{
    type = string
}

variable "zone"{
    type = string
}

variable "image_labels" {
    type = map(string)
}