apiVersion: apps/v1
kind: Deployment
metadata:
  name: questionmanagement
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: questionmanagement
      version: "1.0"
  template:
    metadata:
      labels:
        app: questionmanagement
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: whlaliyregistrykey
      containers:
      - name: questionmanagement
        image: registry.cn-shenzhen.aliyuncs.com/marcoreus/questionmanagement
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
            path: /questionmanagement/backend/web/index.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /questionmanagement/backend/web/index.php
            port: http
          initialDelaySeconds: 120