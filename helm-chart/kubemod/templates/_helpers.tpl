{{/*
Expand the name of the chart.
*/}}
{{- define "kubemod.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubemod.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubemod.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubemod.labels" -}}
helm.sh/chart: {{ include "kubemod.chart" . }}
{{ include "kubemod.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubemod.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubemod.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubemod.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubemod.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "kubemod.webhook.admissionReviewVersions" }}
- admissionReviewVersions:
  - v1beta1
{{- end }}

{{- define "kubemod.webhook.clientConfig" }}
  clientConfig:
    caBundle: Cg==
    service:
      name: {{ include "kubemod.fullname" . }}-webhook-service
      namespace: {{ .Release.Namespace }}
      path: /dragnet-webhook
{{- end }}

{{- define "kubemod.webhook" }}
{{ include "kubemod.webhook.admissionReviewVersions" . }}
{{ include "kubemod.webhook.clientConfig" . }}
{{ toYaml .webhook | nindent 2}}
{{- end }}
