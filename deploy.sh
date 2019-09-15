docker build -t ti3rn1210/multi-client:latest -t ti3rn1210/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ti3rn1210/multi-server:latest -t ti3rn1210/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ti3rn1210/multi-worker:latest -t ti3rn1210/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ti3rn1210/multi-client:latest
docker push ti3rn1210/multi-server:latest
docker push ti3rn1210/multi-worker:latest

docker push ti3rn1210/multi-client:$SHA
docker push ti3rn1210/multi-server:$SHA
docker push ti3rn1210/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ti3rn1210/multi-server:$SHA
kubectl set image deployments/client-deployment client=ti3rn1210/multi-client:$SHA
kubestl set image deployments/worker-deployment worker=ti3rn1210/multi-worker:$SHA
