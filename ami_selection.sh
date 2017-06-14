#!/bin/bash
case $1 in 
us-east-1) ami_id=ami-0e297018;;
us-east-2) ami_id=ami-43d0f626;;
us-west-1) ami_id=ami-fcd7f59c;;
us-west-2) ami_id=ami-596d6520;;
eu-west-1) ami_id=ami-5ae4f83c;;
eu-west-2) ami_id=ami-ada6b1c9;;
eu-central-1) ami_id=ami-25a4004a;;
ap-northeast-1) ami_id=ami-3a000e5d;;
ap-southeast-1) ami_id=ami-2428ab47;;
ap-southeast-2) ami_id=ami-ac5849cf;;
ca-central-1) ami_id=ami-8cfb44e8;;
*) echo "Region not specified";exit 127;;
echo $ami_id
