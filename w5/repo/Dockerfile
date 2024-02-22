FROM python:3.10-alpine

# Set the working directory to /code
WORKDIR /code

# Copy the requirements.txt file into the container
COPY requirements.txt /code

# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt

# Copy the rest of the working directory contents into the container
COPY . /code

# Run app.py when the container launches
#ENTRYPOINT ["python3"]
CMD ["python3", "-m","app","run","--host=0.0.0.0"]
