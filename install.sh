echo "installing PSO into your K8s cluster"


echo "cloning git repo"
sleep 5s

git clone https://github.com/purestorage/helm-charts.git

echo "getting helm please wait"
sleep 5s
wget https://get.helm.sh/helm-v3.2.0-rc.1-linux-amd64.tar.gz

echo "installing helm please wait some more"
sleep 3s
tar -xvf helm-v3.2.0-rc.1-linux-amd64.tar.gz

echo "copying helm to bin again.... wait!"
sleep 2s
cd linux-amd64/
sudo cp helm /usr/local/bin

echo "adding repos for pure to help"
sleep 2s
helm repo add pure https://purestorage.github.io/helm-charts

echo "updating repo"
sleep 4s
helm repo update

echo "lets check the repo for pure"
sleep 4s
helm search repo pure-csi

git clone https://github.com/opslounge/values.git

cd /root/values/

kubectl create namespace pureflash

helm install pure-storage-driver pure/pure-csi -n pureflash -f values.yaml


sleep 30s
echo "............performing PSO smoketest................."
cd /root
git clone https://github.com/opslounge/PSO.git

/root/PSO/wordpress/./make

kubectl get pvc 

echo "done"
