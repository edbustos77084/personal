# Kubernetes Notes

### Service - NodePort
One method to connect your container to the outside world

service-definition.yml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service

spec:
  type: NodePort
  ports:
  - targetPort:80
  port: 80
  nodePort: 30008
selector:
  app: myapp
  type: front-end
