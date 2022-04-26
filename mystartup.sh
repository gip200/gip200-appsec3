minikube stop
minikube start --namespace lab3space

eval $(minikube docker-env)

kubectl create -f lab3space.yaml

kubectl apply -f db/k8
kubectl apply -f GiftcardSite/k8
kubectl apply -f proxy/k8

sleep 60
minikube service proxy-service -n lab3space


