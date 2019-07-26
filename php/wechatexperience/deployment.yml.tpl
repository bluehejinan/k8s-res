apiVersion: apps/v1
kind: Deployment
metadata:
  name: wechatexperiencephp
  namespace: bbs
spec:
  replicas: 1
  selector:
    matchLabels:
      app: wechatexperiencephp
      version: "1.0"
  template:
    metadata:
      labels:
        app: wechatexperiencephp
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: aliyregistrykey
      containers:
      - name: wechatexperiencephp
        image: registry.cn-shenzhen.aliyuncs.com/timedifier/wechatexperiencephp
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
        volumeMounts:
        - mountPath: /app/wechatExperience/backend/web/upload/
          name: wechatexperiencephp-www-data
          subPath: upload
        ports:
        - name: http
          containerPort: 80
        readinessProbe:
          httpGet:
            path: /wechatExperience/backend/web/index.php
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          httpGet:
            path: /wechatExperience/backend/web/index.php
            port: http
          initialDelaySeconds: 120
      volumes:
      - name: wechatexperiencephp-www-data
        persistentVolumeClaim:
          claimName: wechatexperience-php-www-pvc
          