# split-brain
Clustering testing network setup

This network setup helps to perform checks on your cluster software with various network issues may happen in production time. 
Overall network setup is preseneted on fugure below:

![Network Structure](https://github.com/lis0x90/split-brain/raw/main/Network-SplitBrain.png)

This setup include: 
* four networks: `n1`, `n2`, `n3`, `n4`. For example, this networks can represent your physical machine. You can run process in this network namespace using `ip netns exec n1 my-app` or for docker `docker run -n n1 myimage`
* two software briges, that can be compared to network hub/switch in real world: `vbr-left` and `vbr-right`
* lines on figure represents virtual links, that represents wires in real world. 

For example, to simulate broken connection between two datacenters, just shut down one end of link between two briges:
```bash 
ip link set vbr-left2right down
```
