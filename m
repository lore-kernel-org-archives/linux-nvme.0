From: fin4478@hotmail.com (fin4478 fin4478)
Date: Sat, 6 Apr 2019 16:12:12 +0000
Subject: A kernel warning when entering suspend
In-Reply-To: <5088f9f9-678d-4e67-daf0-c8f9629baeea@oracle.com>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <dbc75de4-aefc-b7da-e86a-91da37f463cf@oracle.com>
 <alpine.DEB.2.21.1904041812350.1802@nanos.tec.linutronix.de>
 <20190404221948.GB30656@ming.t460p>
 <a72ed150-8210-2dad-fa14-423ae5fd4589@oracle.com>
 <5088f9f9-678d-4e67-daf0-c8f9629baeea@oracle.com>
Message-ID: <AM6PR06MB50635FC76FFD74DA6C423182A1520@AM6PR06MB5063.eurprd06.prod.outlook.com>

On Sat, 6 Apr 2019 23:31:51 +0800
Dongli Zhang <dongli.zhang@oracle.com> wrote:


> I am not able to reproduce anymore with below patch:
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a90cf5d..90f6e80 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1083,6 +1083,9 @@ static int nvme_poll_irqdisable(struct
> nvme_queue *nvmeq, unsigned int tag)
>         u16 start, end;
>         int found;
> 
> +       if (!nvme_cqe_pending(nvmeq))
> +               return 0;
> +
>         /*
>          * For a poll queue we need to protect against the polling
> thread
>          * using the CQ lock.  For normal interrupt driven threads we
> have
> 
> Dongli Zhang

Confirming. This bug is fixed with this patch.
[   48.690299] PM: suspend entry (deep)
[   48.690300] PM: Syncing filesystems ... done.
[   48.691215] Freezing user space processes ... (elapsed 0.000
seconds) done. [   48.692025] OOM killer disabled.
[   48.692025] Freezing remaining freezable tasks ... (elapsed 0.000
seconds) done. [   48.693033] printk: Suspending console(s) (use
no_console_suspend to debug) [   48.693569] r8169 0000:07:00.0 enp7s0:
Link is Down [   48.693586] serial 00:03: disabled
[   48.702049] sd 5:0:0:0: [sda] Synchronizing SCSI cache
[   48.702076] sd 5:0:0:0: [sda] Stopping disk
[   49.049134] ACPI: Preparing to enter system sleep state S3
[   49.353355] PM: Saving platform NVS memory
[   49.353362] Disabling non-boot CPUs ...
[   49.354764] smpboot: CPU 1 is now offline

Thank You.
