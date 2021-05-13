#!/bin/bash
set -ex

ip netns add n1
ip netns add n2
ip netns add n3
ip netns add n4
ip link add vbr-left type bridge 
ip link add vbr-right type bridge 
ip link add veth-n1 type veth peer name vbr-left-n1
ip link add veth-n2 type veth peer name vbr-left-n2
ip link add veth-n3 type veth peer name vbr-right-n3
ip link add veth-n4 type veth peer name vbr-right-n4
ip link set veth-n1 netns n1
ip link set veth-n2 netns n2
ip link set veth-n3 netns n3
ip link set veth-n4 netns n4
ip link set vbr-left-n1 master vbr-left
ip link set vbr-left-n2 master vbr-left
ip link set vbr-right-n3 master vbr-right
ip link set vbr-right-n4 master vbr-right
ip -n n1 addr add 192.168.10.1/24 dev veth-n1 
ip -n n2 addr add 192.168.10.2/24 dev veth-n2 
ip -n n3 addr add 192.168.10.3/24 dev veth-n3
ip -n n4 addr add 192.168.10.4/24 dev veth-n4
ip addr add 192.168.10.100/24 dev vbr-left
ip addr add 192.168.10.200/24 dev vbr-right
ip -n n1 link set lo up
ip -n n2 link set lo up
ip -n n3 link set lo up
ip -n n4 link set lo up
ip -n n1 link set veth-n1 up 
ip -n n2 link set veth-n2 up 
ip -n n3 link set veth-n3 up 
ip -n n4 link set veth-n4 up 
ip link set dev vbr-left up
ip link set dev vbr-right up
ip link set vbr-left-n1 up
ip link set vbr-left-n2 up
ip link set vbr-right-n3 up
ip link set vbr-right-n4 up

# add link between two bridges 
ip link add vbr-left2right type veth peer name vbr-right2left
ip link set vbr-left2right master vbr-left
ip link set vbr-right2left master vbr-right
ip link set vbr-left2right up
ip link set vbr-right2left up
