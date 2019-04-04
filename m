From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 4 Apr 2019 16:55:26 +0800
Subject: A kernel warning when entering suspend
In-Reply-To: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
Message-ID: <20190404085524.GA24927@ming.t460p>

On Thu, Apr 04, 2019@08:23:59AM +0000, fin4478 fin4478 wrote:
> Hi,
> 
> I do not use suspend/resume but noticed this kernel warning when testing it. This warning is present in earlier kernels too. My system works fine after resume.
> If there is a patch to fix this, I can test it.
> 
> [   53.403033] PM: suspend entry (deep)
> [   53.403034] PM: Syncing filesystems ... done.
> [   53.404775] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   53.405972] OOM killer disabled.
> [   53.405973] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> [   53.407036] printk: Suspending console(s) (use no_console_suspend to debug)
> [   53.407491] ACPI Debug:  "RRIO"
> [   53.407505] serial 00:03: disabled
> [   53.407560] r8169 0000:07:00.0 enp7s0: Link is Down
> [   53.415042] sd 5:0:0:0: [sda] Synchronizing SCSI cache
> [   53.415065] sd 5:0:0:0: [sda] Stopping disk
> [   53.428943] WARNING: CPU: 10 PID: 3127 at kernel/irq/chip.c:210 irq_startup+0xd6/0xe0

Looks the 'WARN_ON_ONCE(force)' in irq_startup() is a bit too strict.

irq_build_affinity_masks() doesn't guarantee that each IRQ's affinity
can include at least one online CPU.


Thanks,
Ming
