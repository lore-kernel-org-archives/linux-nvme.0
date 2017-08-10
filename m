From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 10 Aug 2017 20:04:13 +0300
Subject: Bug Report: can't unload nvme module in case of disabled device
In-Reply-To: <20170810085950.GB12494@infradead.org>
References: <f28ebc80-0e67-8af7-79b2-a4b368e4bd83@mellanox.com>
 <20170810085950.GB12494@infradead.org>
Message-ID: <6e1797d9-3b2c-6f9b-a5a8-d23aed778d8b@mellanox.com>



On 8/10/2017 11:59 AM, Christoph Hellwig wrote:
> Is this a PCIe or fabrics controller?  Did you get a chance to bisect
> where this behavior appeared?
>

I'm using PCIe ctrl.
Using 4.13-rc4+ I couldn't even run easier scenario of only unloading 
the nvme module (with SAMSUNG MZPLL1T6HEHP-00003 and Intel P3500/3700 
devices):

[  369.997917] INFO: task modprobe:3709 blocked for more than 120 seconds.
[  370.005215]       Not tainted 4.13.0-rc4+ #21
[  370.010017] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  370.018647] modprobe        D    0  3709   3654 0x00000000
[  370.024695] Call Trace:
[  370.027400]  __schedule+0x1dc/0x780
[  370.031261]  schedule+0x36/0x80
[  370.034756]  blk_mq_freeze_queue_wait+0x4b/0xb0
[  370.039750]  ? remove_wait_queue+0x60/0x60
[  370.044263]  blk_freeze_queue+0x1a/0x20
[  370.048489]  blk_cleanup_queue+0x7f/0x150
[  370.052927]  nvme_dev_remove_admin+0x36/0x50 [nvme]
[  370.058303]  nvme_remove+0xa2/0x130 [nvme]
[  370.062820]  pci_device_remove+0x39/0xc0
[  370.067142]  device_release_driver_internal+0x141/0x200
[  370.072898]  driver_detach+0x3f/0x80
[  370.076852]  bus_remove_driver+0x55/0xd0
[  370.081186]  driver_unregister+0x2c/0x50
[  370.085521]  pci_unregister_driver+0x2a/0xa0
[  370.090227]  nvme_exit+0x10/0xb84 [nvme]
[  370.094562]  SyS_delete_module+0x171/0x250
[  370.099101]  ? exit_to_usermode_loop+0x5e/0x88
[  370.103996]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[  370.109096] RIP: 0033:0x7f146b5106b7
[  370.113037] RSP: 002b:00007ffd2cae12e8 EFLAGS: 00000206 ORIG_RAX: 
00000000000000b0
[  370.121431] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f146b5106b7
[  370.129295] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 
000000000223f5e8
[  370.137167] RBP: 000000000223f580 R08: 00007f146b7d5060 R09: 
00007f146b580a40
[  370.145029] R10: 00007ffd2cae1070 R11: 0000000000000206 R12: 
00007ffd2cae0310
[  370.152890] R13: 0000000000000000 R14: 000000000223f5e8 R15: 
0000000000000000

the new scenario:
1. modprobe nvme
2. sleep 10
3. modprobe -r nvme

works on 4.11.0/4.12.0 but not on 4.13.0-rc4+.
