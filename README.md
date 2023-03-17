# Docker_Deploy

Deploys an AWS EC2 instance with underlying network fabric, provisions docker on instance using CloudInit, Terraforms a docker container on the instance.

Set AWS_ACCESS_KEY, AWS_SECRET_KEY and MY_IP as github secrets. Setting your own IP here will ensure that only you and the github runner IP can SSH to the EC2 instance.

- Note that the github runner IP allowed SSH rule will persist while the instance remains built, this value will change each time the workflow is run and a new runner is used. Other github runners will receive this public IP address and be allowed inbound through the firewall, however the EC2 instance itself is not accessible via SSH without a matching private key so the risk is very low.

Set backend.hcl to an S3 bucket you have access to. Ensure access to this bucket is not public as this will contain plaintext secrets - such as a private key used to access the EC2 instance.

Generate an AWS key pair and input the name into /Infra/terraform.tvars - This will ensure you can access the EC2 instance directly with your own key-pair if required.
