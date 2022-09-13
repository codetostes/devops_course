#/bin/bash
RESULT="'wget -qO- https://localhost:8090/'"
wget -q localhost:8090
if [ $RESULT == *"Number"* ]
then
    echo $RESULT
elif [[ $? -eq 0 ]]
then
    echo 'Service UP, but wrong return'
else
    echo 'Service on ERROR'
    exit 1
fi