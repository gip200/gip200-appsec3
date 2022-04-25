minikube stop
minikube start

eval $(minikube docker-env)

kubectl apply -f db/k8
kubectl apply -f GiftcardSite/k8
kubectl apply -f proxy/k8

minikube service proxy-service

