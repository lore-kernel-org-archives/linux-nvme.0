From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 28 Mar 2017 13:07:07 +0300
Subject: BUG report: Invalid cross-device link while connecting with various
 nr-io-queues
Message-ID: <910e6625-1256-a6b4-68d3-c946f2b71aaf@mellanox.com>

hi all,

I want to report a bug that I recently saw and haven't got a chance to 
debug it.

after creating 1 subsystem with 1 ns in the target side, I was running 
on the initiator:

for i in `seq 1 24` ; do echo $i && nvme connect -t rdma -n 
testsubsystem -a 1.1.4.11 -s 4420 -nr-io-queues $i && sleep 1 && nvme 
disconnect  -n testsubsystem ; done

I get the following errors:
1
2
3
4
5
6
7
8
9
10
11
12
13
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
14
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
15
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
16
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
17
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
18
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
19
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
20
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
21
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
22
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
23
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
24


partial dmesg:

[1102923.084823] nvme nvme0: creating 10 I/O queues.
[1102923.317094] nvme nvme0: new ctrl: NQN "testsubsystem", addr 
11.212.40.111:4420
[1102924.664949] nvme_rdma_find_get_device: enabling unsafe global rkey
[1102924.722936] nvme nvme0: creating 11 I/O queues.
[1102924.977194] nvme nvme0: new ctrl: NQN "testsubsystem", addr 
11.212.40.111:4420
[1102926.355174] nvme_rdma_find_get_device: enabling unsafe global rkey
[1102926.412981] nvme nvme0: creating 12 I/O queues.
[1102926.686445] nvme nvme0: new ctrl: NQN "testsubsystem", addr 
11.212.40.111:4420
[1102928.031271] nvme_rdma_find_get_device: enabling unsafe global rkey
[1102928.088844] nvme nvme0: creating 13 I/O queues.
[1102928.401410] nvme nvme0: Connect command failed, error wo/DNR bit: 
-16402
[1102928.407720] nvme nvme0: failed to connect i/o queue: -18
[1102928.720957] nvme_rdma_find_get_device: enabling unsafe global rkey
[1102928.777948] nvme nvme0: creating 14 I/O queues.
[1102929.102588] nvme nvme0: Connect command failed, error wo/DNR bit: 
-16402
[1102929.109029] nvme nvme0: failed to connect i/o queue: -18
[1102929.422299] nvme_rdma_find_get_device: enabling unsafe global rkey
[1102929.479662] nvme nvme0: creating 15 I/O queues.
[1102929.828792] nvme nvme0: Connect command failed, error wo/DNR bit: 
-16402
[1102929.835232] nvme nvme0: failed to connect i/o queue: -18


have someone saw it before ?

thanks,
Max
