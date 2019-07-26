apiVersion: apps/v1
kind: Deployment
metadata:
  name: managementsystemphp
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: managementsystemphp
      version: "1.0"
  template:
    metadata:
      labels:
        app: managementsystemphp
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: aliyregistrykey
      containers:
      - name: managementsystemphp
        image: registry.cn-shenzhen.aliyuncs.com/timedifier/managementsystemphp
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
            path: /ManagementSystem/backend/web/info.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /ManagementSystem/backend/web/info.php
            port: http
          initialDelaySeconds: 120