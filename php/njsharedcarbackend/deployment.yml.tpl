apiVersion: apps/v1
kind: Deployment
metadata:
  name: njsharedcarbackendphp
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: njsharedcarbackendphp
      version: "1.0"
  template:
    metadata:
      labels:
        app: njsharedcarbackendphp
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: whlaliyregistrykey
      containers:
      - name: njsharedcarbackendphp
        image: registry.cn-shenzhen.aliyuncs.com/marcoreus/njsharedcarbackend
        resources:
          requests:
            memory: "512Mi"
          limits:
            memory: "512Mi"
        ports:
        - name: http
          containerPort: 80
        readinessProbe:
          httpGet:
            path: /njsharedcarbackend/backend/web/index.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /njsharedcarbackend/backend/web/index.php
            port: http
          initialDelaySeconds: 120