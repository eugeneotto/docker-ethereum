#!/bin/sh
set -e

mkdir -p /home/ethereum/.ethereum
chmod 700 /home/ethereum/.ethereum
chown -R ethereum /home/ethereum/.ethereum

exec gosu ethereum geth --rpc --rpcaddr 0.0.0.0 --ws --wsaddr 0.0.0.0 --syncmode fast
