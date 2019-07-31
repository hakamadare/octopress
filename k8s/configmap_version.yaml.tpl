---
apiVersion: v1
kind: ConfigMap
metadata:
  name: someguyontheinternet-version
data:
  version: "CIRCLE_SHA1"
