# Utilize a lightweight Python base image
FROM python:3.11-slim

# Define the working directory within the container
WORKDIR /app

# Install system dependencies required for machine learning libraries (optional)
# Scikit-learn and pandas typically require these shared libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file first to optimize Docker layer caching
COPY requirements.txt .

# Install Python libraries without retaining the pip cache to minimize image size
RUN pip install --no-cache-dir -r requirements.txt

# Transfer the remaining project files into the image
COPY . .

# 1. Inform Docker that the container will listen on port 8888
EXPOSE 8888

# 2. Command to initialize the Jupyter server and ensure container persistence
# The --ip=0.0.0.0 flag enables external connections
# An empty token is specified to bypass authentication for tutorial accessibility
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
