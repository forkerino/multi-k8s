docker build -t forkerino/multi-client:latest -t forkerino/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t forkerino/multi-server:latest -t forkerino/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t forkerino/multi-worker:latest -t forkerino/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push forkerino/multi-client:latest
docker push forkerino/multi-server:latest
docker push forkerino/multi-worker:latest

docker push forkerino/multi-client:$SHA
docker push forkerino/multi-server:$SHA
docker push forkerino/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=forkerino/multi-client:$SHA
kubectl set image deployments/server-deployment server=forkerino/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=forkerino/multi-worker:$SHA
