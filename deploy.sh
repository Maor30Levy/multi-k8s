docker build -t maor30levy/multi-client:latest -t maor30levy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maor30levy/multi-server:latest -t maor30levy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maor30levy/multi-worker:latest -t maor30levy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push maor30levy/multi-client:latest
docker push maor30levy/multi-server:latest
docker push maor30levy/multi-worker:latest
docker push maor30levy/multi-client:$SHA
docker push maor30levy/multi-server:$SHA
docker push maor30levy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=maor30levy/multi-client:$SHA
kubectl set image deployments/server-deployment server=maor30levy/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=maor30levy/multi-worker:$SHA
