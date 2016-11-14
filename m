From: rashika@amazon.com (Rashika Kheria)
Date: Mon, 14 Nov 2016 09:57:27 +0100
Subject: [PATCH] NVMe: Call nvme_pci_disable on error path of
 nvme_probe_work
In-Reply-To: <20161112174133.GA10883@infradead.org>
References: <20161101152756.GA32044@ub8ca3ab5e3235612a6d0.ant.amazon.com>
 <20161112174133.GA10883@infradead.org>
Message-ID: <62459369-5c23-8819-d360-58892b4ff1fc@amazon.com>

Hi everyone,

Could you please review the following patch? This solves a regression in 
stable 4.4.y tree.


On 11/12/16 18:41, Christoph Hellwig wrote:
> Bouncing to Keith and linux-nvme
>
> On Tue, Nov 01, 2016@04:27:56PM +0100, Rashika Kheria wrote:
>> Commit d5537e988eec ("NVMe: Don't unmap controller registers on reset"),
>> introduced a regression in which it did not replace nvme_dev_unmap()
>> with nvme_pci_disable() in the error path of nvme_probe_work().
>>
>> This led to the following NVMe driver crash on systems where the devices
>> did not initialise in the first try.
>>
>> BUG: unable to handle kernel paging request at ffffc90006da001c
>> IP: [<ffffffffa027b6bb>] nvme_dev_remove+0x5b/0xf0 [nvme]
>> RIP: e030:[<ffffffffa027b6bb>]  [<ffffffffa027b6bb>]
>> nvme_dev_remove+0x5b/0xf0 [nvme]
>> RSP: e02b:ffff8806659c3cb8  EFLAGS: 00010286
>> RAX: ffffc90006da0000 RBX: ffff88067cbc3000 RCX: 0000000000000006
>> RDX: 0000000000000007 RSI: 0000000000000007 RDI: ffff8806864eda40
>> RBP: ffff8806659c3cd8 R08: 0000000000000006 R09: 000000000000fffe
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88067e087000
>> R13: ffffffffa0281d20 R14: ffff88067e087098 R15: ffff8806799d8598
>> FS:  00007f880d5ba700(0000) GS:ffff8806864e0000(0000)
>> knlGS:0000000000000000
>> CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffc90006da001c CR3: 0000000676a97000 CR4: 0000000000042660
>> Call Trace:
>> [<ffffffffa027b7ea>] nvme_remove+0x9a/0x140 [nvme]
>> [<ffffffff813503ef>] pci_device_remove+0x3f/0xc0
>> [<ffffffff81449869>] ? __pm_runtime_idle+0x89/0x90
>> [<ffffffff8143ed4f>] __device_release_driver+0xaf/0x140
>> [<ffffffff8143eec8>] device_release_driver+0x28/0x40
>> [<ffffffff8143db66>] unbind_store+0x96/0xb0
>> [<ffffffff8143d027>] drv_attr_store+0x27/0x30
>> [<ffffffff8122e279>] sysfs_kf_write+0x39/0x40
>> [<ffffffff8122d9e4>] kernfs_fop_write+0xe4/0x160
>> [<ffffffff811b15df>] __vfs_write+0x2f/0x100
>> [<ffffffff81003640>] ? syscall_slow_exit_work+0x140/0x180
>> [<ffffffff81161db9>] ? vm_mmap_pgoff+0xb9/0xe0
>> [<ffffffff810af981>] ? percpu_down_read+0x11/0x60
>> [<ffffffff811b2bce>] vfs_write+0xbe/0x190
>> [<ffffffff811b2d81>] SyS_write+0x51/0xb0
>> [<ffffffff815b8aee>] entry_SYSCALL_64_fastpath+0x12/0x71
>>
>> Cc: stable at vger.kernel.org # 4.4.y
>> Cc: Jens Axboe <axboe at fb.com>
>> Cc: Keith Busch <keith.busch at intel.com>
>> Cc: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
>> Cc: linux-nvme at lists.infradead.org
>> Fixes: d5537e988eec ("NVMe: Don't unmap controller registers on reset")
>> Signed-off-by: Rashika Kheria <rashika at amazon.de>
>> ---
>>   drivers/nvme/host/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index c851bc5..f5d1579 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3184,7 +3184,7 @@ static void nvme_probe_work(struct work_struct *work)
>>   	nvme_disable_queue(dev, 0);
>>   	nvme_dev_list_remove(dev);
>>    unmap:
>> -	nvme_dev_unmap(dev);
>> +	nvme_pci_disable(dev);
>>    out:
>>   	if (!work_busy(&dev->reset_work))
>>   		nvme_dead_ctrl(dev);
>> -- 
>> 2.10.2
>>
> ---end quoted text---

-- 
Regards,
Rashika

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
