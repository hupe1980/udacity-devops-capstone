eksctl create cluster -f k8s/cluster.yml
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml