variable "source_dir_paths" {
    type = set(string)
    default = []
}

variable "requirements_txt_path" {
    type = string
}

variable "python_runtime" {
    type = string
    default = "python3.9"
}

variable "publish" {
    type = bool
    default = true
    description = "Whether to publish the Lambda Layer."
}

variable "name" {
    type = string
    description = "Name of Lambda Layer"
}

variable "description" {
    type = string
    description = "Description of Lambda Layer"
}