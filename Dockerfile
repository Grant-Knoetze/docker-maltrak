# Use Amazon Linux as the base image
FROM amazonlinux:latest

# Set the working directory
WORKDIR /home/caldera

# Install necessary packages
RUN yum update -y && \
    yum groupinstall -y "Development Tools" && \
    yum install -y python3 git haproxy gcc python3-pip python3-devel openssl && \
    yum clean all

# Clone the Caldera repository
RUN git clone https://github.com/mitre/caldera.git --recursive --branch 4.1.0

# Change directory to caldera
WORKDIR /home/caldera/caldera

# Create and activate a virtual environment
RUN python3 -m venv venv

# Upgrade pip and install Python dependencies in the virtual environment
RUN venv/bin/pip install --upgrade pip
RUN venv/bin/pip install -r requirements.txt

# Additional Python dependencies
RUN venv/bin/pip install marshmallow-enum==1.5.1
RUN venv/bin/pip install ldap3==2.7
RUN venv/bin/pip install aioftp==0.21.4

# Ensure local.yml is properly created
RUN if [ ! -f /home/caldera/caldera/conf/local.yml ]; then \
        echo "Creating local.yml with default values"; \
        crypt_salt=$(openssl rand -base64 32 | tr -d '\n'); \
        encryption_key=$(openssl rand -base64 32 | tr -d '\n'); \
        echo "crypt_salt: \"$crypt_salt\"" > /home/caldera/caldera/conf/local.yml; \
        echo "encryption_key: \"$encryption_key\"" >> /home/caldera/caldera/conf/local.yml; \
        echo "red: LabPass1" >> /home/caldera/caldera/conf/local.yml; \
        echo "blue: LabPass1" >> /home/caldera/caldera/conf/local.yml; \
        echo "requirements:" >> /home/caldera/caldera/conf/local.yml; \
        echo "  requirement1: param1" >> /home/caldera/caldera/conf/local.yml; \
        echo "  requirement2: param2" >> /home/caldera/caldera/conf/local.yml; \
        echo "plugins: []" >> /home/caldera/caldera/conf/local.yml; \
        echo "app:" >> /home/caldera/caldera/conf/local.yml; \
        echo "  contact:" >> /home/caldera/caldera/conf/local.yml; \
        echo "    dns: localhost:53" >> /home/caldera/caldera/conf/local.yml; \
        echo "    tcp: localhost:8080" >> /home/caldera/caldera/conf/local.yml; \
        echo "    udp: localhost:9000" >> /home/caldera/caldera/conf/local.yml; \
        echo "    slack: {api_key: xoxb-000000000000-000000000000-XXXXXXXXXXXXXXXXXXXXXXXX}" >> /home/caldera/caldera/conf/local.yml; \
     fi

# Adjust permissions and ownership
RUN chmod -R 777 /home/caldera/caldera
RUN chmod 777 /home/caldera/caldera/conf/local.yml

# Print the content of local.yml for debugging purposes
RUN cat /home/caldera/caldera/conf/local.yml

# Expose port 8888 (default port for Caldera)
EXPOSE 8888

# Start Caldera using the virtual environment's Python
CMD ["venv/bin/python", "server.py"]










