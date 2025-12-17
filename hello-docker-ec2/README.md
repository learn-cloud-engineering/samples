# hello-world-ec2-container

This project sets up an EC2 instance that runs a "Hello World" application inside a Docker container.

There is no web server running. To view the application you must SSH into the instance.

Check that `docker` is running.

```sh
systemctl status docker
```

Next, check that the container is running.

```sh
sudo docker ps -a
```

Check the logs of the container. You can use either the container id or the container name from the previous command.

```sh
sudo docker logs hello-world-container
```

You can also run the following command to see the desired output.

```sh
sudo docker run --rm hello-world:linux
```

You should see the following output.

![screenshot](/hello-docker-ec2/images/image.png)
