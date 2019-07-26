apiVersion: apps/v1
kind: Deployment
metadata:
  name: inventoryphp
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: inventoryphp
      version: "1.0"
  template:
    metadata:
      labels:
        app: inventoryphp
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: aliyregistrykeyenv:
        - name: FPM_PM_MAX_CHILDREN
          value: "100"
        - name: FPM_PM_START_SERVERS
          value: "10"
        - name: FPM_PM_MIN_SPARE_SERVERS
          value: "5"
        - name: FPM_PM_MAX_SPARE_SERVERS
          value: "25"
        - name: FPM_MAX_REQUESTS
          value: "10240"
      containers:
      - name: inventoryphp
        image: registry.cn-shenzhen.aliyuncs.com/timedifier/inventoryphp
        env:
        - name: FPM_PM_MAX_CHILDREN
          value: "100"
        - name: FPM_PM_START_SERVERS
          value: "10"
        - name: FPM_PM_MIN_SPARE_SERVERS
          value: "5"
        - name: FPM_PM_MAX_SPARE_SERVERS
          value: "25"
        - name: FPM_MAX_REQUESTS
          value: "10240"
        resources:
          requests:
            memory: "2048Mi"
          limits:
            memory: "2048Mi"
        ports:
        - name: http
          containerPort: 80
        readinessProbe:
          httpGet:
            path: /inventory/backend/web/index.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /inventory/backend/web/index.php
            port: http
          initialDelaySeconds: 120