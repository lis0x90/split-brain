# split-brain
Clustering testing network setup

This network setup helps to perform checks on your cluster software with various network issues may happen in production time. 
Overall network setup is preseneted on fugure below:

![Network Structure](https://github.com/lis0x90/split-brain/raw/main/Network-SplitBrain.png)

This setup include: 
* four networks: `n1`, `n2`, `n3`, `n4`. These networks can represent your physical machines. To run process in particular network namespace, you can use `ip netns exec n1 my-app` or for docker `docker run -n n1 myimage`
* two software briges, that can be compared to network hub/switch in real world: `vbr-left` and `vbr-right`
* lines on figure represents virtual links, that will be wires in real world. 

Let's start `nc` server in network `n3`:
```bash
#ip netns exec <network-name> <command>
ip netns exec n3 nc -l 0.0.0.0 8080 
```

Run client and send `hello` to `nc` server from network `n1`:
```bash
echo hello | ip netns exec n1 nc 192.168.10.3 8080
```

For example, to simulate broken connection between two datacenters, just shut down one end of link between two bridges:
```bash 
ip link set vbr-left2right down
```

