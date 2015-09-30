From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Sep 2015 15:32:40 +0000 (UTC)
Subject: Deadlock on Fast hotplug with NVMe drives
In-Reply-To: <CAPYzm7TRasa6xKtHp=41bD-3DQx1fo5YeT1Zc7CQjaj69AA8ZQ@mail.gmail.com>
References: <CAPYzm7TRasa6xKtHp=41bD-3DQx1fo5YeT1Zc7CQjaj69AA8ZQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509301528120.23840@localhost.lm.intel.com>

On Wed, 30 Sep 2015, Mohana Goli wrote:
> Hi Keith,
>
> I am seeing a kernel freeze ,a possible deadlock when i do hot
> plug/unplug with NVMe drives.
> I have observed that after hot adding the drive,if we remove within 3
> secs Kernel simply freezes.
> Observations:
>
> 1. nvme_dev_scan ,worker  is taking around 2.2 secs when  hot added the device.
> 2. If the device is removed, once scan_work is completed,no issue is seen.
> 3. If the device is removed while scan work is going,remove worker
> thread and scan worker thread both are deadlocked.
> 4. I induced kernel panic when this issue happens,i see remove worker
> is waiting on scan_work to complete and scan_worker is struck while
> adding disk
> 5. nvme_dev_scan completes in less than a second if the device is
> already present and if i do unload and load of the driver.This could
> be because the drive is
>   already powered up and ready to service the IOs,where as in
> hot-added device case drive firmware needs to be up before servicing
> the IOs.
> 6.This is easily reproducible on my setup.
>
> As of now i do not have why this is happening.If you have any comments
> please let me know on this issue.

Thanks for the notice. The IO should timeout and trigger the recovery
action, which cancels all commands and disables the request queues. If
that's not happening, something is broken. Please let me know if you
find anything, and I'll look into it as well.
