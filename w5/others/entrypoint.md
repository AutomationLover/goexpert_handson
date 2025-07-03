Below is a step-by-step guide to help you understand the CMD and Entrypoint instructions in Docker, based on the script you've provided:

### Step 1: Understanding CMD

1. **Create a Dockerfile with CMD:**
   - Create a file named `Dockerfile.cmd`.
   - Use the Alpine image as the base:
     ```dockerfile
     FROM alpine:3.20
     CMD ["echo", "hello from cmd in Dockerfile.cmd"]
     ```
   - This CMD instruction sets a default command that will be executed when a container is started.

2. **Build the Docker Image:**
   - Open a terminal and navigate to the directory containing `Dockerfile.cmd`.
   - Run the following command to build the Docker image:
     ```bash
     docker build -t cmd-example -f Dockerfile.cmd .
     ```

3. **Run the Docker Container:**
   - Execute the built image:
     ```bash
     docker run --rm cmd-example
     ```
     ```bash
     --rm                               Automatically remove the container and its associated anonymous volumes when it exits
     ```
   - This will output: `hello from cmd in Dockerfile.cmd`.

4. **Override CMD:**
   - You can override the CMD instruction by adding a command at the end of the `docker run` command:
     ```bash
     docker run --rm cmd-example echo "hello from CMD in the terminal"
     ```
   - This will output: `hello from CMD in the terminal`.

### Step 2: Understanding Entrypoint

1. **Create a Dockerfile with Entrypoint:**
   - Create a file named `Dockerfile.entrypoint`.
   - Use the Alpine image and define an Entrypoint:
     ```dockerfile
     FROM alpine:3.20
     ENTRYPOINT ["echo", "hello from Entrypoint in Dockerfile.entrypoint"]
     ```

2. **Build the Docker Image:**
   - In the terminal, build the image:
     ```bash
     docker build -t entrypoint-example -f Dockerfile.entrypoint .
     ```

3. **Run the Docker Container:**
   - Execute the built image:
     ```bash
     docker run --rm entrypoint-example
     ```
   - This will output: `hello from Entrypoint in Dockerfile.entrypoint`.

4. **Extend Entrypoint:**
   - Add arguments to the `docker run` command to append them to the Entrypoint:
     ```bash
     docker run --rm entrypoint-example "and appended string"
     ```
   - This will output: `hello from Entrypoint in Dockerfile.entrypoint and appended string`.

5. **Override Entrypoint:**
   - To override Entrypoint, use the `--entrypoint` flag:
     ```bash
     docker run --rm --entrypoint echo entrypoint-example "Overridden entrypoint"
     ```
   - This will output: `Overridden entrypoint`.

### Step 3: Combining CMD and Entrypoint

1. **Create a Dockerfile Combining Both:**
   - Create a file named `Dockerfile`.
   - Define an Entrypoint and a CMD:
     ```dockerfile
     FROM alpine:3.20
     ENTRYPOINT ["echo"]
     CMD ["default message"]
     ```

2. **Build the Docker Image:**
   - Build the image with:
     ```bash
     docker build -t cmd-entrypoint-example .
     ```

3. **Run the Docker Container:**
   - Execute the built image:
     ```bash
     docker run --rm cmd-entrypoint-example
     ```
   - This will output: `default message`.

4. **Override CMD with Custom Message:**
   - You can provide a custom message:
     ```bash
     docker run --rm cmd-entrypoint-example "custom message"
     ```
   - This will output: `custom message`.

### Summary

- **CMD**: Sets the default command and is easily overridden by specifying a command in `docker run`.
- **Entrypoint**: Sets the default executable, which appends additional arguments provided in `docker run`.
- **Combining**: Entrypoint sets the executable while CMD provides default arguments. Arguments in `docker run` override CMD but are appended to the Entrypoint.

This guide should help you get hands-on with CMD and Entrypoint in Docker. Feel free to experiment with different commands and see how Docker behaves!
