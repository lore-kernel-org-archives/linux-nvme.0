From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Sat, 6 Apr 2019 23:31:51 +0800
Subject: A kernel warning when entering suspend
In-Reply-To: <a72ed150-8210-2dad-fa14-423ae5fd4589@oracle.com>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>
 <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p>
 <a72ed150-8210-2dad-fa14-423ae5fd4589@oracle.com>
Message-ID: <5088f9f9-678d-4e67-daf0-c8f9629baeea@oracle.com>



On 04/06/2019 10:29 PM, Dongli Zhang wrote:
> 
> 
> On 04/05/2019 06:19 AM, Ming Lei wrote:
>> Hi Thomas,
>>
>> On Thu, Apr 04, 2019@06:18:16PM +0200, Thomas Gleixner wrote:
>>> On Thu, 4 Apr 2019, Dongli Zhang wrote:
>>>>
>>>>
>>>> On 04/04/2019 04:55 PM, Ming Lei wrote:
>>>>> On Thu, Apr 04, 2019@08:23:59AM +0000, fin4478 fin4478 wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I do not use suspend/resume but noticed this kernel warning when testing it. This warning is present in earlier kernels too. My system works fine after resume.
>>>>>> If there is a patch to fix this, I can test it.
>>>>>>
>>>>>> [   53.403033] PM: suspend entry (deep)
>>>>>> [   53.403034] PM: Syncing filesystems ... done.
>>>>>> [   53.404775] Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>>>> [   53.405972] OOM killer disabled.
>>>>>> [   53.405973] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>>>>> [   53.407036] printk: Suspending console(s) (use no_console_suspend to debug)
>>>>>> [   53.407491] ACPI Debug:  "RRIO"
>>>>>> [   53.407505] serial 00:03: disabled
>>>>>> [   53.407560] r8169 0000:07:00.0 enp7s0: Link is Down
>>>>>> [   53.415042] sd 5:0:0:0: [sda] Synchronizing SCSI cache
>>>>>> [   53.415065] sd 5:0:0:0: [sda] Stopping disk
>>>>>> [   53.428943] WARNING: CPU: 10 PID: 3127 at kernel/irq/chip.c:210 irq_startup+0xd6/0xe0
>>>>>
>>>>> Looks the 'WARN_ON_ONCE(force)' in irq_startup() is a bit too strict.
>>>>>
>>>>> irq_build_affinity_masks() doesn't guarantee that each IRQ's affinity
>>>>> can include at least one online CPU.
>>>>>
>>>> As the warning is triggered by below line 203,
>>>
>>> Yeah, that's obvious.
>>>
>>>> I can reproduce on purpose with qemu (and nvme) with some cpu offline. Here is
>>>> related qemu cmdline:
>>>>
>>>> -machine q35 -smp 2,maxcpus=4 \
>>>> -device nvme,drive=nvmedrive,serial=deadbeaf1 \
>>>> -drive file=test.img,if=none,id=nvmedrive \
>>>> -monitor stdio \
>>>>
>>>> As there are only 2 cpus online initially, line 203 may return >= nr_cpu_ids
>>>> during suspend/resume.
>>>>
>>>> 1. Boot VM with above qemu cmdline.
>>>>
>>>> 2. In VM, run "echo freeze > /sys/power/state" and VM (with nvme) will suspend.
>>>>
>>>> 3. Run "system_powerdown" in qemu monitor to wakeup VM.
>>>>
>>>> There will be below logs:
>>>>
>>>> [   50.956594] PM: suspend entry (s2idle)
>>>> [   50.956595] PM: Syncing filesystems ... done.
>>>> [   51.112756] Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>> [   51.113772] OOM killer disabled.
>>>> [   51.113772] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>>> [   51.114776] printk: Suspending console(s) (use no_console_suspend to debug)
>>>> [   51.115549] e1000e: EEE TX LPI TIMER: 00000000
>>>> [   51.118829] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>> [   51.119221] WARNING: CPU: 0 PID: 2517 at kernel/irq/chip.c:210
>>>> irq_startup+0xdc/0xf0
>>>> [   51.119222] Modules linked in:
>>>> [   51.119223] CPU: 0 PID: 2517 Comm: kworker/u8:9 Not tainted 5.1.0-rc2+ #1
>>>> [   51.119224] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>> rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>>>> [   51.119225] Workqueue: events_unbound async_run_entry_fn
>>>> [   51.119227] RIP: 0010:irq_startup+0xdc/0xf0
>>>> [   51.119228] Code: 31 f6 4c 89 ef e8 24 2d 00 00 85 c0 75 20 48 89 ee 31 d2 4c
>>>> 89 ef e8 d3 d3 ff ff 48 89 df e8 cb fe ff ff 89 c5 e9 55 ff ff ff <0f> 0b eb b7
>>>> 0f 0b eb b3 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 53
>>>> [   51.119229] RSP: 0018:ffffb7c6808a7c30 EFLAGS: 00010002
>>>> [   51.119229] RAX: 0000000000000040 RBX: ffff98933701b400 RCX: 0000000000000040
>>>> [   51.119230] RDX: 0000000000000040 RSI: ffffffff98340d60 RDI: ffff98933701b418
>>>> [   51.119230] RBP: ffff98933701b418 R08: 0000000000000000 R09: 0000000000000000
>>>> [   51.119231] R10: 0000000000000000 R11: ffffffff9824b1a8 R12: 0000000000000001
>>>> [   51.119231] R13: 0000000000000001 R14: ffff989336959800 R15: ffff989336d2c900
>>>> [   51.119232] FS:  0000000000000000(0000) GS:ffff989338200000(0000)
>>>> knlGS:0000000000000000
>>>> [   51.119234] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   51.119235] CR2: 000055d6ae984288 CR3: 000000013360e000 CR4: 00000000000006f0
>>>> [   51.119235] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [   51.119236] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [   51.119236] Call Trace:
>>>> [   51.119244]  ? __irq_get_desc_lock+0x46/0x80
>>>> [   51.119245]  enable_irq+0x41/0x80
>>>
>>> Why is this enabling an interrupt which is managed and bound to an offline
>>> CPU?
>>
>> I understand it is hard for driver to check if one interrupt is bound to any
>> online CPU because CPU hotplug may happen any time. Especially now
>> managed irq takes static affinity(mapping), almost every driver doesn't
>> handle CPU hotplug event.
>>
> 
> To suspend, the driver would reclaim and should process all completed request
> from cq ring buffer, between disable_irq() and enable_irq() as from line 1096 to
> 1098.
> 
> 1080 static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
> ...
> 1091         if (nvmeq->cq_vector == -1) {
> 1092                 spin_lock(&nvmeq->cq_poll_lock);
> 1093                 found = nvme_process_cq(nvmeq, &start, &end, tag);
> 1094                 spin_unlock(&nvmeq->cq_poll_lock);
> 1095         } else {
> 1096                 disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> 1097                 found = nvme_process_cq(nvmeq, &start, &end, tag);
> 1098                 enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> 1099         }
> 
> As Ming mentioned, it is hard for driver to check if one interrupt is bound to
> any online CPU because CPU hotplug may happen any time.
> 
> If there is way to know that, more specifically, if there is way to know if all
> cpus in the affinity of one io queue are offline, there is no need to
> disable_irq/enable_irq in order to call nvme_process_cq() for that io queue?


Eero pointed to this patch set: https://patchwork.kernel.org/patch/10708055/

I seems due to below which removes the fast path cqe_pending check.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b2a8a9f4b564c7d923597828d93cd1f69ce40e0


I am not able to reproduce anymore with below patch:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d..90f6e80 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1083,6 +1083,9 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq,
unsigned int tag)
        u16 start, end;
        int found;

+       if (!nvme_cqe_pending(nvmeq))
+               return 0;
+
        /*
         * For a poll queue we need to protect against the polling thread
         * using the CQ lock.  For normal interrupt driven threads we have

Dongli Zhang
