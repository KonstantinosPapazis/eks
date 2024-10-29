apiVersion: v1
clusters:
- cluster:
    server: "${endpoint}"
    certificate-authority-data: "${cert_data}"
  name: "${cluster_name}"
contexts:
- context:
    cluster: "${cluster_name}"
    user: "aws"
  name: "${cluster_name}"
current-context: "${cluster_name}"
kind: Config
preferences: {}
users:
- name: "aws"
  user:
    token: "${token}"
