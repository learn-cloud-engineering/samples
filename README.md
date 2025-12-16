# Samples

Each folder is a self contained project.

## Sample projects

- [x] [`hello-world-ec2`](/hello-world-ec2) – A simple hello-world web server hosted on EC2.
- [ ] `hello-world-container-ec2` – A simple hello-world container hosted on EC2.
- [ ] `hello-world-ecs` – A simple hello-world container hosted on ECS.

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

First `cd` into the project directory.

```sh
cd <project-folder>
```

IMPORTANT: Check and change the variables in the `variables.tf` file before proceeding.

Initialize Terraform. You may need first to update your `terraform` CLI to the lastest version.

```sh
terraform init
```

Validate the configuration.

```sh
terraform validate
```

Create a plan file.

```sh
terraform plan -out "tfplan"
```

Apply the plan.

```sh
terraform apply "tfplan"
```

Alternatively, you can `apply` with `--auto-approve` to skip the confirmation prompt.

```sh
terraform apply "tfplan" -auto-approve
```

See what is currently being deployed (state file).

```sh
terraform show
```

It can also show you the `tfplan` file.

```sh
terraform show "tfplan"
```

Display the values of the outputs.

```sh
terraform output
```

Destroy the resources.

```sh
terraform destroy
```
