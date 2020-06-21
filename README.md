# Digitalocean kubernetes terraform script

A terraform script to create a kubernetes cluster with necessary addons.

## Included components

* A kubernetes cluster with variables to tweak the cluster size, node type etc.
* Container registry to push images
* Metrics server setup so that we can view pod and node memory/cpu usages using `kubectl top` command
* Ingress and nginx ingress for setting up reverse proxy
* Helm provider, for installing packages in the cluster using terraform
* cert-manager setup in the cluster for automatically issuing ssl certificates to ingress endpoints
* A run.sh script to setup everything without worrying about terraform commands


## Prerequisites

* doctl (digitalocean command line tool)
* kubectl
* terraform
* kuebctl terraform provider (https://gavinbunney.github.io/terraform-provider-kubectl/docs/provider.html)


## Run

Clone the repo and modify the following:

* open letsencrypt-issuer.yaml file and replace your email id in place of
    `your_email@address.com`
* open main.tf and tweak the variables as required or leave it as it is use
    defaults
* login to doctl using `doctl auth`  command
* open `run.sh` and replace `$CLUSTER` with name of your cluster as defined in
    `main.tf` or export the cluster name as ``export CLUSTER=yourcluster``
* initialize terraform using ``terraform init``

Run the following command to create the cluster

```
./run.sh apply

```
`run.sh` accept the following commands other than `apply`

* ``run.sh plan`` run terraform plan and show the planned output
* ``run.sh display`` show digitalocean token
* ``run.sh kubeconfig`` generate kubernetes config for created cluster
* ``run.sh ip`` show ip of the cluster


## Destroy

if you want to destroy the cluster, run the following command

```
terraform destroy
```
