We need to Run Dockerfile first to create an image that we use to deply and only run 1 time and put this image to aws ecr
docker build . \
  --file $dockerfile \
  --build-arg KUBE_LATEST_VERSION="v1.18.8" \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --tag aws-kubectl \

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin <ecr url>
docker push <ecr url>/aws-kubectl:v1

And to deploy the app to k8s we use 

