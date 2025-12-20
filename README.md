# Samples

Sample cloud infrastructure applications built with Terraform.

Each folder is a self contained project. You may use these sample projects as starter code for your own projects.

## Sample projects

- [x] [`hello-world-ec2`](/hello-world-ec2) – A simple hello-world web server hosted on EC2.
- [x] [`hello-nginx-ec2`](/hello-nginx-ec2) – A simple hello-world nginx container hosted on EC2.
- [x] [`hello-docker-ec2`](/hello-docker-ec2) – A simple hello-world docker container hosted on EC2.
- [x] [`hello-static-site-s3`](/hello-static-site-s3) – A simple static site hosted on S3.
- [ ] [`hello-world-ecs`](/hello-world-ecs/) – A simple hello-world container hosted on ECS.

## Requirements

- Install the latest version of `terraform` on your terminal.
- Install the latest version of `aws` on your terminal.
- Configure your `aws` credentials.

Run the following command to check that your `aws` has been configured correctly.

```sh
aws sts get-caller-identity
```

It should return something like this.

```sh
Account: '123456789012'
Arn: arn:aws:iam::123456789012:user/bob
UserId: 'ABC7USERID7EXAMPLE'
```

Otherwise, run this command to configure your `aws` credentials. You will need your AWS Access Key ID and Secret Access Key.

```sh
aws configure
```

## Getting started

You can use the following commands to get started:

### Select the project folder

First, `cd` into the project directory.

```sh
cd <project-folder>
```

IMPORTANT: Check and change the variables in the `variables.tf` file before proceeding.

### Initialize Terraform

You may need first to update your `terraform` CLI to the lastest version.

```sh
terraform init
```

### Validate the configuration

```sh
terraform validate
```

### Run the plan

Run a dry-run of the plan.

```sh
terraform plan
```

You can also create a `tfplan` file.

```sh
terraform plan -out tfplan
```

### Apply the plan

```sh
terraform apply
```

If you have a `tfplan` file, you can `apply` it.

```sh
terraform apply "tfplan"
```

Alternatively, you can `apply` with `--auto-approve` to skip the confirmation prompt.

```sh
terraform apply -auto-approve
```

### Show the current state

See what is currently being deployed (state file).

```sh
terraform show
```

It can also show you the `tfplan` file.

```sh
terraform show "tfplan"
```

### Display outputs

```sh
terraform output
```

### Destroy the resources

```sh
terraform destroy
```

### Run the tests

If a project has a `/tests` folder you can run the `test` command.

```sh
terraform test
```

Use the `-verbose` flag to see details of the plan or state for each `run` block within a test file.

```sh
terraform test -verbose
```

Use the `-filter` flag to run a specific test file.

```sh
terraform test -filter=testfile
```
