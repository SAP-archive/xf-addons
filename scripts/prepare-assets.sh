#!/usr/bin/env bash

set -o errexit # exit immediately if a command exits with a non-zero status.
set -o nounset # exit when script tries to use undeclared variables

readonly RED='\033[0;31m'
readonly NC='\033[0m' # No Color

function prepareAssets() {
        destination=dist

        echo "delete destination folder"
        rm -r ${destination} | true

        echo "Create destination folder"
        mkdir -p ${destination}

        echo "Copy index yaml"
        cp bundles/*.yaml ${destination}

        echo "Copy icons"
        mkdir ${destination}/icons
        cp icons/* ${destination}/icons

        echo "Copy documentation"
        mkdir ${destination}/installation
        mkdir ${destination}/installation/assets

        cp -r installation/assets/* ${destination}/installation/assets
        cp -r installation/style.css ${destination}/installation/style.css

        echo "Copy api docs"
        mkdir ${destination}/api-docs
        cp api-docs/* ${destination}/api-docs
        
        echo "Render installation guide"
        blackfriday-tool -page=true -css="style.css" installation/c4c.md ${destination}/installation/c4c.html
        blackfriday-tool -page=true -css="style.css" installation/marketing.md ${destination}/installation/marketing.html
        blackfriday-tool -page=true -css="style.css" installation/qualtrics.md ${destination}/installation/qualtrics.html

        echo "Zip and copy bundles"
        tar cfvz ${destination}/marketing-connector-0.1.0.tgz -C ./bundles/marketing-connector-0.1.0 .
        tar cfvz ${destination}/c4c-connector-0.1.0.tgz -C ./bundles/c4c-connector-0.1.0 .
        tar cfvz ${destination}/c4c-mock-0.1.0.tgz -C ./bundles/c4c-mock-0.1.0 .
        tar cfvz ${destination}/commerce-mock-0.1.0.tgz -C ./bundles/commerce-mock-0.1.0 .
        tar cfvz ${destination}/marketing-mock-0.1.0.tgz -C ./bundles/marketing-mock-0.1.0 .
	    tar cfvz ${destination}/litmos-connector-0.1.0.tgz -C ./bundles/litmos-connector-0.1.0 .
        tar cfvz ${destination}/qualtrics-connector-0.1.0.tgz -C ./bundles/qualtrics-connector-0.1.0 .
        tar cfvz ${destination}/openconnectors-connector-0.1.0.tgz -C ./bundles/openconnectors-connector-0.1.0 .
        tar cfvz ${destination}/openconnectors-account-0.1.0.tgz -C ./bundles/openconnectors-account-0.1.0 .
        echo "Processing done"
}

prepareAssets

