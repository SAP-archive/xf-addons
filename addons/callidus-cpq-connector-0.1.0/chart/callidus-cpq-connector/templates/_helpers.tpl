{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bundle.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "oauth_proxy_service" -}}
{{- printf "http://%s.%s:8080" .Values.apiProxyName .Release.Namespace | trimAll " " | quote -}}
{{- end -}}

{{- define "api_spec_url" -}}
{{- printf "%s%s" .Values.system_url .Values.apiSpecPath | trimAll " " | quote -}}
{{- end -}}

{{- define "formparameters_csv" -}}
{{- printf "grant_type=password,username=%s,password=%s,domain=%s" .Values.username .Values.password .Values.domain| trimAll " " | quote - | b64enc}}
{{- end -}}

{{- define "headers_csv" -}}
{{- printf "Content-Type=application/x-www-form-urlencoded" | trimAll " " | quote - | b64enc}}
{{- end -}}

{{- define "oauthURL" -}}
{{- printf "%s/basic/api/token" .Values.system_url | trimAll " " | quote - | b64enc}}
{{- end -}}







    

