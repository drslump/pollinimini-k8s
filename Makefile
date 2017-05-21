setup:
	kubectl apply -f setup.yaml

secrets:
	# Remove any existing secrets so we can re-create them
	kubectl delete secret --namespace=kube-system basic-auth || true
	kubectl delete secret --namespace=pollinimini basic-auth || true

	# Generated with: htpasswd -nb <user> <pwd> | pass insert -mf pollinimini/basic-auth
	# Note: traefik requires the secret file to be named "auth" and exist on the ingress namespace
	kubectl create secret generic basic-auth --namespace=kube-system --from-literal=auth=`pass pollinimini/basic-auth`
	kubectl create secret generic basic-auth --namespace=pollinimini --from-literal=auth=`pass pollinimini/basic-auth`

