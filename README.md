# XF Addons
Addon bundles for the SAP Cloud Platform Extension Factory (XF) installable via the Service Catalog.

## Description
The SAP CP Extension Factory (XF) is designed to easily extend and mash up different SAP applications and third-party APIs. The [Kyma Helm Broker](https://kyma-project.io/docs/components/helm-broker/) provides a mechanism to easily deploy integration and extension functionality for SAP applications (addons) to a running XF cluster. The `XF Addons` are the default set of addons for any XF cluster by mainly providing connector and mock bundles for SAP Marketing Cloud, SAP Cloud for Customer, and SAP Commerce Cloud.

## Installation
This addons repository as defined by [index.yaml](bundles/index.yaml) is installed to XF by default.

If you need to install it manually, you need to upload the addon artifacts to a web server with location UPLOAD_DIR using `make preapre && make upload UPLOAD_DIR`. 
In your XF or Kyma cluster you then need to create a configMap using following commands:

```
kubectl create configmap xf-addons-repo -n kyma-system --from-literal=URLs=https://UPLOAD_DIR/index.yaml
kubectl label configmap xf-addons-repo -n kyma-system helm-broker-repo=true
```
With that, all addons of this repository will be available in your Service Catalog.

To remove the addons from your Service Catalog:
`kubectl delete configmap xf-addons-repo -n kyma-system`

## Development
If you update the addons and re-upload them to your web server, you need to trigger a scan by the service catalog at your XF or Kyma cluster by calling:
`svcat sync broker helm-broker --scope cluster`
where svcat is the [Service Catalog CLI](https://svc-cat.io/docs/cli/)
### Development Phases

#### Pushing to Branch
If you push to a branch then the addon artifactes are uploaded to the staging location only (https://storage.googleapis.com/faros-stage-base-xf-bundles/index.yaml).
#### Merging to master
If you merge a branch to the master then the addon artifactes are uploaded to the staging (https://storage.googleapis.com/faros-stage-base-xf-bundles/index.yaml) and pre-production (https://storage.googleapis.com/faros-int-base-xf-bundles/index.yaml) locations.

#### Adding a Tag
If you add a tag in github then the addon artifactes are uploaded to the production location only (https://storage.googleapis.com/faros-prod-base-xf-bundles/index.yaml).

## Requirements
All addon bundles are based on the [Kyma Helm Broker](https://kyma-project.io/docs/components/helm-broker/) and with that require to follow the [Helm Chart](https://helm.sh/) specification.

## Known Issues
The connector addons based on MQTT (currently marketing-connector) are using an experimental way of integration. MQTT based integration will be an official feature of XF soon.

## How to obtain support
In case you find a bug or have ideas please open a [Github Issue](https://github.com/SAP/xf-addons/issues). Feel free to contribute by creating a Pull Request.

## License
Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
This file is licensed under the `SAP SAMPLE CODE LICENSE` except as noted otherwise in the [LICENSE](LICENSE) file.
