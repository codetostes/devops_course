#/bin/bash
RESULT="'wget -qO- https://localhost:8090/'"
wget -q localhost:8090
if [ $? -eq 0 ]
then
    echo 'ok - serviço no ar!'
elif [[ $RESULT == *"Number"* ]]
then
    echo 'ok - number of visits'
    echo $RESULT
else
    echo 'not ok - number os visits'
    exit 1
fi
