From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 15 Nov 2018 12:39:30 -0700
Subject: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
In-Reply-To: <20181115193658.GA7921@roeck-us.net>
References: <20181115191126.GA16973@roeck-us.net>
 <20181115193658.GA7921@roeck-us.net>
Message-ID: <7bbc8187-2f99-c1e3-bec9-817fa3ead18f@kernel.dk>

On 11/15/18 12:36 PM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018@11:11:26AM -0800, Guenter Roeck wrote:
>> On Wed, Nov 14, 2018@10:12:44AM -0700, Jens Axboe wrote:
>>>
>>> I think the below patch should fix it.
>>>
>>
>> I spoke too early. sparc64, next-20181115:
>>
>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
>> [   14.263496] ------------[ cut here ]------------
>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
>> [   14.264265] Trying to free already-free IRQ 9
>> [   14.264519] Modules linked in:
>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
>> [   14.265899] Call Trace:
>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
>> [   14.268825]  [0000000000000000]           (null)
>> [   14.269089] irq event stamp: 32796
>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
>>
>> Looks like an error during probe followed by an error cleanup problem.
>>
> On sparc64, pci_alloc_irq_vectors_affinity() returns -EINVAL (possibly
> because the controller doesn't support MSI).
> 
> [   16.554753] nvme nvme0: pci function 0000:02:00.0
> [   16.622894] nvme 0000:02:00.0: pre alloc: nr_io_queues: 2 result: 0
> [   16.623814] nvme 0000:02:00.0: post alloc: nr_io_queues: 2 result: -22
> [   16.625047] nvme nvme0: Removing after probe failure status: -5
> 
> ... and, as result, allocating a single (legacy) interrupt isn't even tried.
> 
> I didn't try to track down the cleanup failure.

OK, then this isn't a new failure in terms of whether the nvme device will
work, it's just a cleanup issue.

That's less severe than the previous hang :-)

-- 
Jens Axboe
