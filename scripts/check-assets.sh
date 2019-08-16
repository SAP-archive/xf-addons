#!/usr/bin/env bash

set -o errexit # exit immediately if a command exits with a non-zero status.
set -o nounset # exit when script tries to use undeclared variables

readonly RED='\033[0;31m'
readonly NC='\033[0m' # No Color

function checkAssets() {
        echo "Checking bundles"
        helm lint ./bundles/c4c-connector-0.1.0/chart/c4c-connector/ --values ./bundles/c4c-connector-0.1.0/plans/default/values.yaml
        helm lint ./bundles/marketing-connector-0.1.0/chart/marketing-connector/ --values ./bundles/marketing-connector-0.1.0/plans/default/values.yaml
        helm lint ./bundles/marketing-mock-0.1.0/chart/marketing-mock/ --values ./bundles/marketing-mock-0.1.0/plans/default/values.yaml
        helm lint ./bundles/commerce-mock-0.1.0/chart/commerce-mock/ --values ./bundles/commerce-mock-0.1.0/plans/default/values.yaml
        helm lint ./bundles/c4c-mock-0.1.0/chart/c4c-mock/ --values ./bundles/c4c-mock-0.1.0/plans/default/values.yaml
	    helm lint ./bundles/litmos-connector-0.1.0/chart/litmos-connector/ --values ./bundles/litmos-connector-0.1.0/plans/default/values.yaml
        helm lint ./bundles/openconnectors-connector-0.1.0/chart/openconnectors-connector/ --values ./bundles/openconnectors-connector-0.1.0/plans/default/values.yaml
       

        echo "Processing done"
}

checkAssets
