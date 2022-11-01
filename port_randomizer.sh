#!/bin/bash

echo -e "\n\n\e[1mPORT RANDOMIZER!\e[0m"
echo -e '\nEnter path to config folder
example: ~/.juno/config \n'
function workingFolder {  
	read -p "Path: " WORKING_DIRECTORY 
	echo 'export WORKING_DIRECTORY='${WORKING_DIRECTORY} >> $HOME/.bash_profile
	source $HOME/.bash_profile
	sleep 1
    APP=$WORKING_DIRECTORY/app.toml
    CONFIG=$WORKING_DIRECTORY/config.toml
    if [ -f "$APP" ]; then
        echo -e ""
    else 
        echo -e "\n$APP does not exist."
        exit 1
    fi
    if [ -f "$CONFIG" ]; then
        echo -e ""
    else 
        echo -e "\n $CONFIG does not exist.\n"
        exit 1
    fi
}
# Port generation and replacment 
function portABCI {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    proxy_app="$(cat $CONFIG | grep proxy_app | sed -n 's/.*:\([^",]*\)[",]*$/\1/p')"
    if [ "${status}" != "0" ]; then 
        sed -i 's/'$proxy_app'/'$random_port'/' $CONFIG
        echo -e "ABCI: $random_port";
    fi
    sleep 1

}

function portRPC {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    laddr="$(cat $CONFIG | grep laddr -m 2 | sed -n 's/.*:\([^",]*\)[",]*$/\1/p' | tail -n 1)" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$laddr'/'$random_port'/' $CONFIG
        echo -e "RPC: $random_port";
    fi
    sleep 1
}

function portP2P {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    laddr="$(cat $CONFIG | grep laddr | sed -n 's/.*:\([^",]*\)[",]*$/\1/p' | tail -n 1)" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$laddr'/'$random_port'/' $CONFIG
        echo -e "P2P: $random_port";
    fi
    sleep 1
}

function portPPROF {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    laddr="$(cat $CONFIG | grep pprof_laddr | sed -n 's/.*:\([^",]*\)[",]*$/\1/p')" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$laddr'/'$random_port'/' $CONFIG
        echo -e "PPROF: $random_port";
    fi
    sleep 1
}

function portPROMETHEUS {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    laddr="$(cat $CONFIG | grep prometheus_listen_addr | sed -n 's/.*:\([^",]*\)[",]*$/\1/p')" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$laddr'/'$random_port'/' $CONFIG
        echo -e "Prometheus: $random_port";
    fi
    sleep 1
}

function portAPI {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    address="$(cat $APP | grep address -m 1 | sed -n 's/.*:\([^",]*\)[",]*$/\1/p')" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$address'/'$random_port'/' $APP
        echo -e "API: $random_port";
    fi
    sleep 1
}

function portROSETTA {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    address="$(cat $APP | grep address -m 2 | tail -n1 | sed -n 's/.*:\([^",]*\)[",]*$/\1/p')" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$address'/'$random_port'/' $APP
        echo -e "Rosetta: $random_port";
    fi
    sleep 1
}

function portgRPC {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    address="$(cat $APP | grep address -m 4 | sed -n 's/.*:\([^",]*\)[",]*$/\1/p' | tail -n 1)" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$address'/'$random_port'/' $APP
        echo -e "gRPC: $random_port";
    fi
    sleep 1
}

function portgRPC_WEB {
    random_port=$(( ((RANDOM<<15)|RANDOM) % 49152 + 10000 ))
    status="$(nc -z 127.0.0.1 $random_port < /dev/null &>/dev/null; echo $?)"
    address="$(cat $APP | grep address | sed -n 's/.*:\([^",]*\)[",]*$/\1/p' | tail -n 1)" 
    if [ "${status}" != "0" ]; then
        sed -i 's/'$address'/'$random_port'/' $APP
        echo -e "gRPC_WEB: $random_port";
    fi
    sleep 1
}

function portChange() {
    workingFolder
    portABCI
    portRPC
    portPPROF
    portP2P
    portPROMETHEUS
    portAPI
    portROSETTA
    portgRPC
    portgRPC_WEB
}

portChange             
echo -e "\n\e[1mNew ports are ready\n\e[0m"
exit 0


