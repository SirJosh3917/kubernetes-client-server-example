# setup private registry so that kubernetes when it goes to pull an image can pull our images

# NOTE: if you ever have to stop/start minikube, this helped https://stackoverflow.com/a/62201372

eval $(minikube docker-env --shell bash)

# if the registry doesn't work, try uncomment these lines this
# sudo mkdir /sys/fs/cgroup/systemd
# sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd

# https://docs.docker.com/registry/deploying/
docker run -d -p 5100:5000 --restart always --name registry registry:2

# build client and server
docker build -f Dockerfile.client . -t localhost:5100/kubeclient
docker push localhost:5100/kubeclient
docker build -f Dockerfile.server . -t localhost:5100/kubeserver
docker push localhost:5100/kubeserver

# run deployment (delete first incase running this script again)
kubectl delete -f ./deployment.yaml
kubectl apply -f ./deployment.yaml

# now, run `kubectl get pods`, find the name of the server/client pod, and run `kubectl logs <pod name>`
# you should see `received ping` or `pong` in your console!
