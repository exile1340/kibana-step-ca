# Kibana with Step CLI and Certificate Renewal

This Docker image extends the official Kibana image with the Step CLI installed for certificate management and a cron job to check for certificate renewal every 5 minutes. The version of the contain is tied to the version of Kibana. If you need a different version, clone the repo, and update the Dockerfile.

Certificate renewal depends upon already having a Step CA running and available: [Step-CA](https://smallstep.com/docs/step-ca/)

## Getting Started

To use this image, you can pull it from Docker Hub or build it locally.



Four Variables must be defined for the TLS certificates to function. Set these values to where the nodes certificates will reside:
```
CERT_LOCATION=certs/kibana.crt # path to kibana node certificate
KEY_LOCATION=certs/kibana.key  # path to kibana node certificate key
CA_URL=https://your-ca-server:port # URL to certificate authority
CA_CERT=certs/ca.pem # path to CA certificate
```

Regular Kibana setting will still need to be set: [Kibana](https://hub.docker.com/_/kibana)

### Pulling from Docker Hub

```bash
docker pull featherjr/kibana-step-ca:8.12.2
```

### Building Locally

Clone this repository and navigate to the directory containing the Dockerfile:

```bash
git clone https://github.com/exile1340/kibana-step-ca.git
cd kibana-step-ca
```

Build the Docker image:

```bash
docker build -t kibana-step-ca:8.12.2 .
```

### Running the Container

To run the Kibana container with Step CLI and certificate renewal:

```bash
docker run -d --name kibana-step-ca -p 5601:5601 -v /path/to/certs:/usr/share/kibana/certs featherjr/kibana-step-ca:8.12.2
```

## Certificate Renewal

The container includes a cron job that checks for certificate renewal every 5 minutes using the `cert-renewal.sh` script. Ensure that the script is correctly configured for your certificate renewal process.

## Customization

You can customize the certificate renewal script and cron job to fit your specific requirements.

## License

This project is licensed under the [GNU v3](LICENSE).

## Acknowledgments

- [kibana Docker Image](https://www.elastic.co/guide/en/kibana/reference/current/docker.html)
- [Smallstep CLI](https://smallstep.com/docs/step-cli)