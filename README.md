# XF Add-ons

[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/xf-addons)](https://api.reuse.software/info/github.com/SAP-samples/xf-addons)

Kyma Add-ons for the SAP Cloud Platform Extension Factory (XF) installable via the Service Catalog.

## Description

The SAP CP Extension Factory (XF) is designed to easily extend and mash up different SAP applications and third-party APIs. The [Kyma Helm Broker](https://kyma-project.io/docs/components/helm-broker/) provides a mechanism to easily deploy integration and extension functionality for SAP applications (addons) to a running XF cluster. The `XF Add-ons` are the default set of add-ons for any XF cluster by mainly providing mock addons for SAP Marketing Cloud, SAP Cloud for Customer, and SAP Commerce Cloud.

## Installation

This add-ons repository as defined by [index.yaml](addons/index.yaml) is installed to XF by default.

If you need to install it manually, you need to create a `ClusterAddonsConfiguration` or `AddonsConfiguration` resource in your XF or Kyma cluster using URL `github.com/sap/xf-addons//addons/index.yaml?ref=0.11`:

```yaml
apiVersion: addons.kyma-project.io/v1alpha1
kind: ClusterAddonsConfiguration
metadata:
  name: xf-addons
spec:
  repositories:
    - url: "github.com/sap/xf-addons//addons/index.yaml?ref=0.11"
```

With that, all addons of this repository will be available in your Service Catalog.

To remove the add-ons from your Service Catalog:
`kubectl delete ClusterAddonsConfiguration xf-addons`

## Requirements

All add-ons are based on the [Kyma Helm Broker](https://kyma-project.io/docs/components/helm-broker/) and with that require to follow the [Helm Chart](https://helm.sh/) specification.

## How to obtain support

In case you find a bug or have ideas please open a [Github Issue](https://github.com/SAP/xf-addons/issues). Feel free to contribute by creating a Pull Request.

## License

Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved.
This file is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
