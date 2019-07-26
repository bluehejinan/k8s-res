apiVersion: apps/v1
kind: Deployment
metadata:
  name: sharecarbackendphp
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sharecarbackendphp
      version: "1.0"
  template:
    metadata:
      labels:
        app: sharecarbackendphp
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: whlaliyregistrykey
      containers:
      - name: sharecarbackendphp
        image: registry.cn-shenzhen.aliyuncs.com/marcoreus/sharecarbackend
        resources:
          requests:
            memory: "1024Mi"
          limits:
            memory: "1024Mi"
        ports:
        - name: http
          containerPort: 80
        readinessProbe:
          httpGet:
            path: /sharedCarBackend/backend/web/index.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /sharedCarBackend/backend/web/index.php
            port: http
          initialDelaySeconds: 120