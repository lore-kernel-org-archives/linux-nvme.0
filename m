From: pickup112@gmail.com (=?UTF-8?B?5p2O5pil?=)
Date: Wed, 16 May 2018 13:57:33 +0800
Subject: can not load more than 51 nvme rdma device
Message-ID: <CAGpjB9J2F3VhGnPe+uXSmuu-H0dTfbQT+5fOem4j_vsBcwGfwQ@mail.gmail.com>

Hi:

I encountered a problem of nvme-rdma on mellanox network card.
Thanks in advance for your help.


# Problem Description

## Steps to Reproduce
* Two nodes (nodeA, nodeB) are linked through the mellanox 56Gb
connectX-3 network card.
* nodeA outputs 100 disks through 100 subsystems via nvmet-rdma, one disk
per subsystem.
* Load the disk with "nvme connect" on nodeB. When it is loaded into
the 51st disk, it will complain ```Failed to write to
/dev/nvme-fabrics: Cannot allocate memory```. The disk load command is as
follows, using 10 queues to load the disk:

```
nvme connect -t rdma -a 172.16.128.51 -s 4421 -n s01.4421.01
--nr-io-queues=10 -k 1 -l 6000 -c 1 -q woqu
```

* If you load the disk with 1 queue at this time, it can be loaded
successfully without error.

* Additional Information: This problem does not occur when we load
with a 100GbE network adapter.


## log information
* When the nodeB is normally loaded, the /var/log/message information is as
follows:

```
May 8 19:10:37 qdata-lite52-dev kernel: nvme nvme47: creating 10 I/O queues.
May 8 19:10:37 qdata-lite52-dev kernel: nvme nvme47: new ctrl: NQN
"s01.4421.48", addr 172.16.128.51:4421
```


* Warning message when loading the 50th disk
```
May 8 15:26:55 qdata-lite52-dev kernel: nvme nvme50: creating 10 I/O queues.
May 8 15:26:55 qdata-lite52-dev kernel: blk-mq: reduced tag depth (128 ->
16)
May 8 15:26:55 qdata-lite52-dev kernel: nvme nvme50: new ctrl: NQN
"s01.4421.45", addr 172.16.128.51:4421
```


* Error will be reported when loading the 51st disk
```
May 8 15:26:55 qdata-lite52-dev kernel: blk-mq: reduced tag depth (31 -> 15)
May 8 15:26:55 qdata-lite52-dev kernel: nvme nvme51: creating 10 I/O queues.
May 8 15:26:55 qdata-lite52-dev kernel: blk-mq: failed to allocate request
map
```


## environment

* OS?rhel 7.4
* network card?56Gb ConnectX-3
```
44:00.0 Network controller: Mellanox Technologies MT27500 Family
[ConnectX-3]
```


-- 
pickup.li
