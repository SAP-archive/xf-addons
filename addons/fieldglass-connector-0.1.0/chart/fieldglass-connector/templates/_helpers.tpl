{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bundle.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "eb_server" -}}
{{- printf "%s-%s.%s" .Values.gatewayServerHost .Release.Namespace .Values.cluster_domain | trimAll " " -}}
{{- end -}}

{{- define "oauth_server" -}}
{{- printf "%s%s" .Values.system_url "/api/oauth2/v2.0/token?grant_type=client_credentials&response_type=token" | trimAll " " -}}
{{- end -}}

{{- define "oauth_proxy_service" -}}
{{- printf "http://%s.%s:8080" .Values.oAuthProxyName .Release.Namespace | trimAll " " | quote -}}
{{- end -}}


    

