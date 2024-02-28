# Lambda Layer Python

Module for creating and publishing Lambda Layers for Python runtimes.

## Requirements

- Terraform
- pip

## Example Usage

```hcl
module "lambda_layer" {
    name = "My Lambda Layer"
    description = "This is my lambda layer."

    publish = true

    python_runtime = "python3.9"

    requirements_txt_path = "${path.root}/../requirements.txt"
    source_dir_paths = [
        "${path.root}/../lib"
    ]
}
```