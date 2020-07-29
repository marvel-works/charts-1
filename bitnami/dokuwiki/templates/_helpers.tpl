{{/*
Return the proper full name
*/}}
{{- define "dokuwiki.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}

{{/*
Return the proper certificate image name
*/}}
{{- define "certificates.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.certificates.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper DokuWiki image name
*/}}
{{- define "dokuwiki.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper image name (for the metrics image)
*/}}
{{- define "dokuwiki.metrics.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.metrics.image "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "dokuwiki.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image .Values.metrics.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Return  the proper Storage Class
*/}}
{{- define "dokuwiki.storageClass" -}}
{{- include "common.storage.class" ( dict "persistence" .Values.persistence "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "dokuwiki.deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/* Dokuwiki credential secret name */}}
{{- define "dokuwiki.secretName" -}}
{{- coalesce .Values.existingSecret (include "dokuwiki.fullname" .) -}}
{{- end -}}

{{/* Check if there are rolling tags in the images */}}
{{- define "dokuwiki.checkRollingTags" -}}
{{- include "common.warnings.rollingTag" .Values.image -}}
{{- include "common.warnings.rollingTag" .Values.metrics.image -}}
{{- end -}}
