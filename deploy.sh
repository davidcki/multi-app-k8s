docker build -t davidcki/multi-client:latest -t davidcki/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davidcki/multi-server:latest -t davidcki/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davidcki/multi-worker:latest -t davidcki/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davidcki/multi-client:latest
docker push davidcki/multi-server:latest
docker push davidcki/multi-worker:latest

docker push davidcki/multi-client:$SHA
docker push davidcki/multi-server:$SHA
docker push davidcki/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployments/client-deployment server=davidcki/multi-client:$SHA
kubectl set image deployments/server-deployment server=davidcki/multi-server:$SHA
kubectl set image deployments/worker-deployment server=davidcki/multi-worker:$SHA
