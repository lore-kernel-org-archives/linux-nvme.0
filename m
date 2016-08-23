From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 23 Aug 2016 09:58:13 -0500
Subject: nvmf host shutdown hangs when nvmf controllers are in
 recovery/reconnect
In-Reply-To: <00df01d1fd4d$10ea8890$32bf99b0$@opengridcomputing.com>
References: <00df01d1fd4d$10ea8890$32bf99b0$@opengridcomputing.com>
Message-ID: <00e301d1fd4e$c5868960$50939c20$@opengridcomputing.com>

> Hey guys, when I force an nvmf host into kato recovery/reconnect mode by
> killing the target, and then reboot the host, it hangs forever because the
> nvmf host controllers never get a delete command, so they stay stuck in
> reconnect state.
> 
> Here is the dmesg log:
> 
> <... one nvmf device connected...>
> 
> [  255.079939] nvme nvme1: creating 32 I/O queues.
> [  255.377218] nvme nvme1: new ctrl: NQN "test-ram0", addr 10.0.1.14:4420
> 
> 
> <... target rebooted here via 'reboot -f'...>
> 
> [  264.768555] cxgb4 0000:83:00.4: Port 0 link down, reason: Link Down
> [  264.777520] cxgb4 0000:83:00.4 eth10: link down
> [  265.177225] nvme nvme1: RECV for CQE 0xffff88101d6f3568 failed with
> status WR flushed (5)
> [  265.177306] nvme nvme1: reconnecting in 10 seconds
> [  265.748213] cxgb4 0000:82:00.4: Port 0 link down, reason: Link Down
> [  265.755478] cxgb4 0000:82:00.4 eth2: link down
> [  266.183927] mlx4_en: eth14: Link Down
> [  276.387127] nvme nvme1: rdma_resolve_addr wait failed (-110).
> [  283.116153] nvme nvme1: Failed reconnect attempt, requeueing...
> 
> <... host 'reboot' issued here...>
> 
> Stopping certmonger: [  OK  ]
> 
> Running guests on default URI: no running guests.
> 
> Stopping libvirtd daemon: [  OK  ]
> Stopping atd: [  OK  ]
> Shutting down console mouse services: [  OK  ]
> Stopping ksmtuned: [  OK  ]
> Stopping abrt daemon: [  OK  ]
> Stopping sshd: [  OK  ]
> Stopping mcelog
> Stopping xinetd: [  OK  ]
> Stopping crond: [  OK  ]
> Stopping automount: [  OK  ]
> Stopping HAL daemon: [  OK  ]
> Stopping block device availability: Deactivating block devices:
> [  OK  ]
> Stopping cgdcbxd: [  OK  ]
> Stopping lldpad: [  OK  ]
> Stopping system message bus: [  OK  ]
> Shutting down ca[  290.560113] CacheFiles: File cache on sda2
> unregistering
> chefilesd: [  290.566076] FS-Cache: Withdrawing cache "mycache"
> [  OK  ]
> Stopping rpcbind: [  OK  ]
> Stopping auditd: [  290.809894] audit: type=1305 audit(1471963093.850:82):
> audit_pid=0 old=3011 auid=4294967295 ses=4294967295 res=1
> [  OK  ]
> [  290.908238] audit: type=1305 audit(1471963093.948:83): audit_enabled=0
> old=1 auid=4294967295 ses=4294967295 res=1
> Shutting down system logger: [  OK  ]
> Shutting down interface eth8:  [  OK  ]
> Shutting down loopback interface:  [  OK  ]
> Stopping cgconfig service: [  OK  ]
> Stopping virt-who: [  OK  ]
> [  294.307812] nvme nvme1: rdma_resolve_addr wait failed (-110).
> [  301.035260] nvme nvme1: Failed reconnect attempt, requeueing...
> [  312.228468] nvme nvme1: rdma_resolve_addr wait failed (-110).
> [  312.234310] nvme nvme1: Failed reconnect attempt, requeueing...
> [  323.492871] nvme nvme1: rdma_resolve_addr wait failed (-110).
> [  323.498713] nvme nvme1: Failed reconnect attempt, requeueing...
> [  334.757296] nvme nvme1: rdma_resolve_addr wait failed (-110).
> [  334.763162] nvme nvme1: Failed reconnect attempt, requeueing...
> 
> <..stuck forever...>
> 

Eventually I see this stuck thread:

[  492.971125] INFO: task vgs:4755 blocked for more than 120 seconds.
[  492.977409]       Tainted: G            E
4.8.0-rc2nvmf-4.8-rc-rebased-rc2-harsha+ #16
[  492.985606] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  492.993538] vgs             D ffff880fefadf8e8     0  4755   4754 0x10000080
[  493.000749]  ffff880fefadf8e8 ffffffff81c0d4c0 ffff880fefa1ab80
ffff88103415fd30
[  493.010277]  00000001e7fb1240 ffff880fefadf8b8 ffff880fefadc008
ffff88103ee19300
[  493.019728]  7fffffffffffffff 0000000000000000 0000000000000000
ffff880fefadf938
[  493.029121] Call Trace:
[  493.033295]  [<ffffffff816ddde0>] schedule+0x40/0xb0
[  493.039937]  [<ffffffff816e0a8d>] schedule_timeout+0x2ad/0x410
[  493.047364]  [<ffffffff8132d6d2>] ? blk_flush_plug_list+0x132/0x2e0
[  493.055234]  [<ffffffff810fe67c>] ? ktime_get+0x4c/0xc0
[  493.061957]  [<ffffffff8132c92c>] ? generic_make_request+0xfc/0x1d0
[  493.069721]  [<ffffffff816dd6c4>] io_schedule_timeout+0xa4/0x110
[  493.077160]  [<ffffffff81269cb9>] dio_await_one+0x99/0xe0
[  493.083973]  [<ffffffff8126d359>] do_blockdev_direct_IO+0x919/0xc00
[  493.091636]  [<ffffffff81267350>] ? I_BDEV+0x20/0x20
[  493.097946]  [<ffffffff81267350>] ? I_BDEV+0x20/0x20
[  493.104195]  [<ffffffff8115527b>] ? rb_reserve_next_event+0xdb/0x230
[  493.111831]  [<ffffffff811547ba>] ? rb_commit+0x10a/0x1a0
[  493.118450]  [<ffffffff8126d67a>] __blockdev_direct_IO+0x3a/0x40
[  493.125657]  [<ffffffff81267b83>] blkdev_direct_IO+0x43/0x50
[  493.132468]  [<ffffffff81199ef7>] generic_file_read_iter+0xf7/0x110
[  493.139890]  [<ffffffff81267657>] blkdev_read_iter+0x37/0x40
[  493.146664]  [<ffffffff8122b15c>] __vfs_read+0xfc/0x120
[  493.153009]  [<ffffffff8122b22e>] vfs_read+0xae/0xf0
[  493.158877]  [<ffffffff81249633>] ? __fdget+0x13/0x20
[  493.164810]  [<ffffffff8122bd36>] SyS_read+0x56/0xc0
[  493.170651]  [<ffffffff81003e7d>] do_syscall_64+0x7d/0x230
[  493.177027]  [<ffffffff8106f057>] ? do_page_fault+0x37/0x90
[  493.183474]  [<ffffffff816e1921>] entry_SYSCALL64_slow_path+0x25/0x25
