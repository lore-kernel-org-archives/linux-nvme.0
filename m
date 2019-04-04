From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Thu, 4 Apr 2019 23:37:14 +0800
Subject: A kernel warning when entering suspend
In-Reply-To: <20190404085524.GA24927@ming.t460p>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
Message-ID: <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>



On 04/04/2019 04:55 PM, Ming Lei wrote:
> On Thu, Apr 04, 2019@08:23:59AM +0000, fin4478 fin4478 wrote:
>> Hi,
>>
>> I do not use suspend/resume but noticed this kernel warning when testing it. This warning is present in earlier kernels too. My system works fine after resume.
>> If there is a patch to fix this, I can test it.
>>
>> [   53.403033] PM: suspend entry (deep)
>> [   53.403034] PM: Syncing filesystems ... done.
>> [   53.404775] Freezing user space processes ... (elapsed 0.001 seconds) done.
>> [   53.405972] OOM killer disabled.
>> [   53.405973] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> [   53.407036] printk: Suspending console(s) (use no_console_suspend to debug)
>> [   53.407491] ACPI Debug:  "RRIO"
>> [   53.407505] serial 00:03: disabled
>> [   53.407560] r8169 0000:07:00.0 enp7s0: Link is Down
>> [   53.415042] sd 5:0:0:0: [sda] Synchronizing SCSI cache
>> [   53.415065] sd 5:0:0:0: [sda] Stopping disk
>> [   53.428943] WARNING: CPU: 10 PID: 3127 at kernel/irq/chip.c:210 irq_startup+0xd6/0xe0
> 
> Looks the 'WARN_ON_ONCE(force)' in irq_startup() is a bit too strict.
> 
> irq_build_affinity_masks() doesn't guarantee that each IRQ's affinity
> can include at least one online CPU.
> 


As the warning is triggered by below line 203,

194 __irq_startup_managed(struct irq_desc *desc, struct cpumask *aff, bool force)
... ...
203         if (cpumask_any_and(aff, cpu_online_mask) >= nr_cpu_ids) {
204                 /*
205                  * Catch code which fiddles with enable_irq() on a managed
206                  * and potentially shutdown IRQ. Chained interrupt
207                  * installment or irq auto probing should not happen on
208                  * managed irqs either.
209                  */
210                 if (WARN_ON_ONCE(force))
211                         return IRQ_STARTUP_ABORT;
212                 /*
213                  * The interrupt was requested, but there is no online CPU
214                  * in it's affinity mask. Put it into managed shutdown
215                  * state and let the cpu hotplug mechanism start it up once
216                  * a CPU in the mask becomes available.
217                  */
218                 return IRQ_STARTUP_ABORT;
219         }


I can reproduce on purpose with qemu (and nvme) with some cpu offline. Here is
related qemu cmdline:

-machine q35 -smp 2,maxcpus=4 \
-device nvme,drive=nvmedrive,serial=deadbeaf1 \
-drive file=test.img,if=none,id=nvmedrive \
-monitor stdio \

As there are only 2 cpus online initially, line 203 may return >= nr_cpu_ids
during suspend/resume.

1. Boot VM with above qemu cmdline.

2. In VM, run "echo freeze > /sys/power/state" and VM (with nvme) will suspend.

3. Run "system_powerdown" in qemu monitor to wakeup VM.

There will be below logs:

[   50.956594] PM: suspend entry (s2idle)
[   50.956595] PM: Syncing filesystems ... done.
[   51.112756] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   51.113772] OOM killer disabled.
[   51.113772] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   51.114776] printk: Suspending console(s) (use no_console_suspend to debug)
[   51.115549] e1000e: EEE TX LPI TIMER: 00000000
[   51.118829] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   51.119221] WARNING: CPU: 0 PID: 2517 at kernel/irq/chip.c:210
irq_startup+0xdc/0xf0
[   51.119222] Modules linked in:
[   51.119223] CPU: 0 PID: 2517 Comm: kworker/u8:9 Not tainted 5.1.0-rc2+ #1
[   51.119224] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   51.119225] Workqueue: events_unbound async_run_entry_fn
[   51.119227] RIP: 0010:irq_startup+0xdc/0xf0
[   51.119228] Code: 31 f6 4c 89 ef e8 24 2d 00 00 85 c0 75 20 48 89 ee 31 d2 4c
89 ef e8 d3 d3 ff ff 48 89 df e8 cb fe ff ff 89 c5 e9 55 ff ff ff <0f> 0b eb b7
0f 0b eb b3 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 53
[   51.119229] RSP: 0018:ffffb7c6808a7c30 EFLAGS: 00010002
[   51.119229] RAX: 0000000000000040 RBX: ffff98933701b400 RCX: 0000000000000040
[   51.119230] RDX: 0000000000000040 RSI: ffffffff98340d60 RDI: ffff98933701b418
[   51.119230] RBP: ffff98933701b418 R08: 0000000000000000 R09: 0000000000000000
[   51.119231] R10: 0000000000000000 R11: ffffffff9824b1a8 R12: 0000000000000001
[   51.119231] R13: 0000000000000001 R14: ffff989336959800 R15: ffff989336d2c900
[   51.119232] FS:  0000000000000000(0000) GS:ffff989338200000(0000)
knlGS:0000000000000000
[   51.119234] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.119235] CR2: 000055d6ae984288 CR3: 000000013360e000 CR4: 00000000000006f0
[   51.119235] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   51.119236] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   51.119236] Call Trace:
[   51.119244]  ? __irq_get_desc_lock+0x46/0x80
[   51.119245]  enable_irq+0x41/0x80
[   51.119247]  nvme_poll_irqdisable+0x122/0x390
[   51.119249]  ? wake_up_q+0x70/0x70
[   51.119251]  __nvme_disable_io_queues+0x167/0x1b0
[   51.119252]  ? nvme_del_queue_end+0x20/0x20
[   51.119254]  nvme_dev_disable+0x1b7/0x1d0
[   51.119255]  nvme_suspend+0x11/0x20
[   51.119257]  pci_pm_suspend+0x7a/0x150
[   51.119258]  ? pci_pm_freeze+0xd0/0xd0
[   51.119259]  dpm_run_callback+0x3c/0x160
[   51.119260]  __device_suspend+0x117/0x450
[   51.119261]  async_suspend+0x15/0x90
[   51.119262]  async_run_entry_fn+0x32/0xe0
[   51.119264]  process_one_work+0x14d/0x3e0
[   51.119265]  worker_thread+0x44/0x410
[   51.119267]  ? create_worker+0x190/0x190
[   51.119268]  kthread+0xf3/0x130
[   51.119270]  ? kthread_destroy_worker+0x40/0x40
[   51.119271]  ret_from_fork+0x35/0x40
[   51.119273] ---[ end trace 7069b223b9a2c9c9 ]---
[   51.139379] sd 0:0:0:0: [sda] Stopping disk
[   59.121791] sd 0:0:0:0: [sda] Starting disk
[   59.124066] nvme nvme0: 4/0/0 default/read/poll queues
[   59.426226] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   59.426750] ata6: SATA link down (SStatus 0 SControl 300)
[   59.427040] ata2: SATA link down (SStatus 0 SControl 300)
[   59.427307] ata5: SATA link down (SStatus 0 SControl 300)
[   59.427569] ata4: SATA link down (SStatus 0 SControl 300)
[   59.428226] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   59.428833] ata3.00: configured for UDMA/100
[   59.429420] ata1.00: configured for UDMA/100
[   59.430248] OOM killer enabled.
[   59.430249] Restarting tasks ... done.
[   59.439243] PM: suspend exit
[   61.719297] e1000e: enp0s2 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx

I cannot reproduce with virtio-blk in similar situation.

Dongli Zhang
