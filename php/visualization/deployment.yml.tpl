apiVersion: apps/v1
kind: Deployment
metadata:
  name: visualizationphp
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: visualizationphp
      version: "1.0"
  template:
    metadata:
      labels:
        app: visualizationphp
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: aliyregistrykey
      containers:
      - name: visualizationphp
        image: registry.cn-shenzhen.aliyuncs.com/timedifier/visualizationphp
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
            path: /visualization/backend/web/info.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /visualization/backend/web/info.php
            port: http
          initialDelaySeconds: 120