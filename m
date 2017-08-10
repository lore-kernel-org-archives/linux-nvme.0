From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Aug 2017 15:17:17 -0400
Subject: Bug Report: can't unload nvme module in case of disabled device
In-Reply-To: <20170810164536.GC14634@localhost.localdomain>
References: <f28ebc80-0e67-8af7-79b2-a4b368e4bd83@mellanox.com>
 <20170810164536.GC14634@localhost.localdomain>
Message-ID: <20170810191717.GA1604@localhost.localdomain>

On Thu, Aug 10, 2017@12:45:36PM -0400, Keith Busch wrote:
> On Tue, Aug 01, 2017@03:58:10PM +0300, Max Gurtovoy wrote:
> > Hi all,
> > 
> > I would like to report a bug that reproduced by the following steps (I'm
> > using 4.13.0-rc3+):
> > 
> > 1. modprobe nvme
> > 2. echo 0 >  /sys/block/nvme0n1/device/device/enable
> > 3. nvme list (stuck for more than 1-2 mins)
> > 4. modprobe -r nvme (stuck forever)
> > 
> > log:
> > 
> > [ 1342.388888] nvme nvme0: controller is down; will reset: CSTS=0x3,
> > PCI_STATUS=0x10
> > [ 1476.021392] INFO: task kworker/u98:1:436 blocked for more than 120
> > seconds.
> > [ 1476.029072]       Not tainted 4.13.0-rc3+ #19
> > [ 1476.033878] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [ 1476.042505] kworker/u98:1   D    0   436      2 0x00000000
> > [ 1476.048569] Workqueue: nvme-wq nvme_reset_work [nvme]
> > [ 1476.054133] Call Trace:
> > [ 1476.056862]  __schedule+0x1dc/0x780
> > [ 1476.060706]  schedule+0x36/0x80
> > [ 1476.064180]  blk_mq_freeze_queue_wait+0x4b/0xb0
> > [ 1476.069175]  ? remove_wait_queue+0x60/0x60
> > [ 1476.073693]  nvme_wait_freeze+0x33/0x50 [nvme_core]
> > [ 1476.079068]  nvme_reset_work+0x6b9/0xc40 [nvme]
> > [ 1476.084075]  ? __switch_to+0x23e/0x4a0
> > [ 1476.088209]  process_one_work+0x149/0x360
> > [ 1476.092625]  worker_thread+0x4d/0x3c0
> > [ 1476.096692]  kthread+0x109/0x140
> > [ 1476.100247]  ? rescuer_thread+0x380/0x380
> > [ 1476.104664]  ? kthread_park+0x60/0x60
> > [ 1476.108698]  ret_from_fork+0x25/0x30
> 
> This looks like a path does not pair the freeze start with the reset's
> freeze wait. I'll have to see what the pci 'enable' sysfs entry does.

I see how the freeze start/stops are not paired in this scenario:
nvme_dev_disable doesn't start the freeze if the pci device isn't
disabled. It uses this to know if it is disabling the device twice.

In this test, though, you are disabling the pci device without the
driver's knowledge, so that breaks that logic. In light of that, we'll
need different criteria to know when the driver should start a freeze.
I'll test some things out and send a patch.
