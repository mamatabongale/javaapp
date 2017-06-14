#!/bin/bash
if [ -n "$1" ]
then
  sed -i "s/family_def/${1}/g" task_definition.json
else
  echo "task definition required. Exitting..."
  exit 127
fi
if [ -n "$2" ]
then
  sed -i "s/repo_name/${2}/g" task_definition.json
else
  echo "repo details required. Exitting..."
  exit 127
fi
if [ -n "$3" ]
then
  sed -i "s/image_name/${3}/g" task_definition.json
else
  echo "image name required. Exitting..."
  exit 127
fi
if [ -n "$4" ]
then
  sed -i "s/image_tag/${4}/g" task_definition.json
else
  echo "image tag required. Exitting..."
  exit 127
fi
if [ -n "$5" ]
then
  sed -i "s/name_def/${5}/g" task_definition.json
else
  echo "name required. Exitting..."
  exit 127
fi
if [ -n "$6" ]
then
  sed -i "s/memory_def/${6}/g" task_definition.json
else
  echo "memory definition required. Exitting..."
  exit 127
fi
if [ -n "$7" ]
then
  sed -i "s/container_port_def/${7}/g" task_definition.json
else
  echo "container_port_def required. Exitting..."
  exit 127
fi
if [ -n "$8" ]
then
  sed -i "s/host_port_def/${8}/g" task_definition.json
else
  echo "host_port_def required. Exitting..."
  exit 127
fi
