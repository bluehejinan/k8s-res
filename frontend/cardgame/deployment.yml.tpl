apiVersion: apps/v1
kind: Deployment
metadata:
  name: cardgamefrontend
  namespace: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cardgamefrontend
      version: "1.0"
  template:
    metadata:
      labels:
        app: cardgamefrontend
        version: "1.0"
    spec:
      imagePullSecrets:
      - name: aliyregistrykey
      containers:
      - name: cardgamefrontend
        image: registry.cn-shenzhen.aliyuncs.com/timedifier/cardgamefrontend
        resources:
          requests:
            memory: "256Mi"
          limits:
            memory: "256Mi"
        ports:
        - name: http
          containerPort: 8080
        readinessProbe:
          tcpSocket:
            port: http
          initialDelaySeconds: 20
          periodSeconds: 15
          failureThreshold: 6
        livenessProbe:
          tcpSocket:
            port: http
          initialDelaySeconds: 120