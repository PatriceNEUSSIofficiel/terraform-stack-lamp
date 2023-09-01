# terraform-stack-lamp

## deploy a stack lamp (php, mysql, phpmyadmin and apache) on a kubernetes cluster using terraform

# How to Setup Lamp Stack on EKS Kubernetes Cluser

Let's follow the steps below to create LAMP stack on Kubernetes Cluser

**Step-1: Clone Git repository:**

We need to clone git repository, in order to download Apache,PHP,MySQL and PhpMyAdmin yaml file.

To clone git repository run the following command.
```
$ git clone https://github.com/PatriceNEUSSIofficiel/terraform-stack-lamp.git
```
Clone output would be like this
```
Cloning into 'terraform-stack-lamp'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 12 (delta 2), reused 12 (delta 2), pack-reused 0
Unpacking objects: 100% (12/12), done.
```

**change the path to config_path and put yours in the mysql.tf and apache.tf files**

```
$ cd cd terraform-stack-lamp/

change the config_path  you config_path directory

**Step-2:Initializing the backend..., Initializing modules..., Initializing provider plugins...**

```
$ terraform init 


**Step-3: Create Apache,PHP,MySQL,PhpMyAdmin Deployment & Service**

Run command below to create Apache, PhpMyAdmin, MySQL & PHP deployment and Service

```

$ terraform plan 

```

$ terraform apply

```

**Step-3: Validate created Deployment,Service and pods**

To check Deployment

```
$ kubectl get deployment
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
apache       1/1     1            1           103s
mysql        1/1     1            1           103s
phpmyadmin   1/1     1            1           103s
```

To check service run following command

```
$ kubectl get svc

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
apache-service       NodePort    10.110.50.108    <none>        80:30002/TCP   65s
mysql-service        ClusterIP   10.104.101.193   <none>        3306/TCP       69s
phpmyadmin-service   NodePort    10.98.43.231     <none>        80:30500/TCP   66s
```

**Check running pods**

```
$ **kubectl get pods -o=wide**

NAME                          READY   STATUS    RESTARTS   AGE
apache-76464cb56f-7dwgf       1/1     Running   0          28s
mysql-7449585c95-wpg5b        1/1     Running   0          28s
phpmyadmin-7ccdd9d998-vvv2g   1/1     Running   0          28s
```

**Test Apache, PHP and PhpMyAdmin access**

User: **root**

Password: **patrice**    						// We setup MySQL root password in our Mysql.tf deployment file.//

**We have successfully setup LAMP stack on EKS Kubernetes cluster.**

**Optional:** Once you have done with LAB, you can delete Service and Deployment.

**To Delete  Deployment:**

```
$ kubectl delete deploy name_of_deployement

```

**TO delete  Service**

```
$ kubectl delete svc name_of_service

```
**Delete PhpMyAdmin pod**
```
kubectl delete name_of_service

```
We have successfully deleted all the deployment, service and pods

