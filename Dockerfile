FROM python:3

# Install dependencies

RUN apt update && apt install -y bash
RUN pip install aws-sam-cli

# Default environment variable

ENV SAM_CLI_TELEMETRY 0
ENV AWS_DEFAULT_REGION us-east-1
ENV SAM_DEFAULT_TEMPLATE template.yml

# Setup entrypoint

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
