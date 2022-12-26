#!/bin/bash

create ()
{

if [ ! -z "$1" ] 
    then
        instanceID=`aws autoscaling describe-auto-scaling-groups  --auto-scaling-group-name $1 --query "AutoScalingGroups[*].Instances[0].{InstanceId:InstanceId}"  | jq '.[].InstanceId' | awk -F '"' {'print$2'}`
        instanceType=`aws autoscaling describe-auto-scaling-groups  --auto-scaling-group-name $1 --query "AutoScalingGroups[*].Instances[0].{InstanceType:InstanceType}" |jq '.[].InstanceType' | awk -F '"' {'print$2'}`
        LC=`aws autoscaling describe-launch-configurations --launch-configuration-names $1  | jq '.LaunchConfigurations'`
        Name=`date '+%Y-%m-%d'`
        aws ec2 create-image --instance-id $instanceID --name devops 
        aws autoscaling create-launch-configuration --launch-configuration-name $Name-LC --instance-id $instanceID --instance-type $instanceType
        aws update-auto-scaling-group --auto-scaling-group-name $1 --launch-configuration-name $Name-LC
        echo True
        echo $Name-LC
        return 0
    else
        echo False
        echo 'Please input auto scaling group name'
        return 1
fi
}

create 

