data "temporary_directory" "python" {
  name = "python"
}

resource "null_resource" "pip_install" {

    triggers = { everytime = timestamp() }

    provisioner local-exec {
      command = "pip install -r ${var.requirements_txt_path} -t ${data.temporary_directory.python.id} --isolated --quiet"
    }

    depends_on = [ data.temporary_directory.python ]
}

resource "null_resource" "copy_directory" {
    triggers = { everytime = timestamp() }
    for_each = var.source_dir_paths

    provisioner local-exec {
      command = "cp -Ra ${each.key} ${data.temporary_directory.python.id}"
    }

    depends_on = [ data.temporary_directory.python ]
}

data "archive_file" "lambda_layer" {
    type = "zip"
    source_dir = data.temporary_directory.python.id
    output_path = "${data.temporary_directory.python.id}/../lambda_layer.zip"
    depends_on = [ null_resource.pip_install, null_resource.copy_directory ]
}

resource "aws_lambda_layer_version" "this" {

  count = var.publish ? 1 : 0

  layer_name = var.name
  description = var.description
  compatible_runtimes = ["python3.9"]

  filename = data.archive_file.lambda_layer.output_path
}