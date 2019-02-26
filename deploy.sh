docker build -t henriquerusca/multi-client:latest -t henriquerusca/multi-client:$SHA ./client
docker build -t henriquerusca/multi-server:latest -t henriquerusca/multi-server:$SHA ./server
docker build -t henriquerusca/multi-worker:latest -t henriquerusca/multi-worker:$SHA ./worker
docker push henriquerusca/multi-client:latest
docker push henriquerusca/multi-server:latest
docker push henriquerusca/multi-worker:latest
docker push henriquerusca/multi-client:$SHA
docker push henriquerusca/multi-server:$SHA
docker push henriquerusca/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=henriquerusca/multi-server:$SHA
kubectl set image deployments/client-deployment client=henriquerusca/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=henriquerusca/multi-worker:$SHA
