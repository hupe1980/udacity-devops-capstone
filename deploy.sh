repository=hupe1980/udacity-devops-capstone-frontend
buildtag=$(git rev-parse --short HEAD)

docker build ./frontend --tag $repository:$buildtag
docker push $repository:$buildtag
kubectl set image deployment/frontend frontend=$repository:$buildtag