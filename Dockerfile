# Use the official Python image from Docker Hub
FROM python:3

# Set the working directory in the container
WORKDIR /flask_app

# Copy the dependencies file
COPY requirements.txt .

# Install Flask and other dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project directory into the container
COPY . .

# Expose the port that the app runs on
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "flask_app.py"]

