From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 23 Aug 2016 09:46:00 -0500
Subject: nvmf host shutdown hangs when nvmf controllers are in
 recovery/reconnect
Message-ID: <00de01d1fd4d$10e44700$32acd500$@opengridcomputing.com>

Hey guys, when I force an nvmf host into kato recovery/reconnect mode by killing
the target, and then reboot the host, it hangs forever because the nvmf host
controllers never get a delete command, so they stay stuck in reconnect state.  

Here is the dmesg log:

<... one nvmf device connected...>

[  255.079939] nvme nvme1: creating 32 I/O queues.
[  255.377218] nvme nvme1: new ctrl: NQN "test-ram0", addr 10.0.1.14:4420


<... target rebooted here via 'reboot -f'...>

[  264.768555] cxgb4 0000:83:00.4: Port 0 link down, reason: Link Down
[  264.777520] cxgb4 0000:83:00.4 eth10: link down
[  265.177225] nvme nvme1: RECV for CQE 0xffff88101d6f3568 failed with status WR
flushed (5)
[  265.177306] nvme nvme1: reconnecting in 10 seconds
[  265.748213] cxgb4 0000:82:00.4: Port 0 link down, reason: Link Down
[  265.755478] cxgb4 0000:82:00.4 eth2: link down
[  266.183927] mlx4_en: eth14: Link Down
[  276.387127] nvme nvme1: rdma_resolve_addr wait failed (-110).
[  283.116153] nvme nvme1: Failed reconnect attempt, requeueing...

<... host 'reboot' issued here...>

Stopping certmonger: [  OK  ]

Running guests on default URI: no running guests.

Stopping libvirtd daemon: [  OK  ]
Stopping atd: [  OK  ]
Shutting down console mouse services: [  OK  ]
Stopping ksmtuned: [  OK  ]
Stopping abrt daemon: [  OK  ]
Stopping sshd: [  OK  ]
Stopping mcelog
Stopping xinetd: [  OK  ]
Stopping crond: [  OK  ]
Stopping automount: [  OK  ]
Stopping HAL daemon: [  OK  ]
Stopping block device availability: Deactivating block devices:
[  OK  ]
Stopping cgdcbxd: [  OK  ]
Stopping lldpad: [  OK  ]
Stopping system message bus: [  OK  ]
Shutting down ca[  290.560113] CacheFiles: File cache on sda2 unregistering
chefilesd: [  290.566076] FS-Cache: Withdrawing cache "mycache"
[  OK  ]
Stopping rpcbind: [  OK  ]
Stopping auditd: [  290.809894] audit: type=1305 audit(1471963093.850:82):
audit_pid=0 old=3011 auid=4294967295 ses=4294967295 res=1
[  OK  ]
[  290.908238] audit: type=1305 audit(1471963093.948:83): audit_enabled=0 old=1
auid=4294967295 ses=4294967295 res=1
Shutting down system logger: [  OK  ]
Shutting down interface eth8:  [  OK  ]
Shutting down loopback interface:  [  OK  ]
Stopping cgconfig service: [  OK  ]
Stopping virt-who: [  OK  ]
[  294.307812] nvme nvme1: rdma_resolve_addr wait failed (-110).
[  301.035260] nvme nvme1: Failed reconnect attempt, requeueing...
[  312.228468] nvme nvme1: rdma_resolve_addr wait failed (-110).
[  312.234310] nvme nvme1: Failed reconnect attempt, requeueing...
[  323.492871] nvme nvme1: rdma_resolve_addr wait failed (-110).
[  323.498713] nvme nvme1: Failed reconnect attempt, requeueing...
[  334.757296] nvme nvme1: rdma_resolve_addr wait failed (-110).
[  334.763162] nvme nvme1: Failed reconnect attempt, requeueing...

<..stuck forever...>
