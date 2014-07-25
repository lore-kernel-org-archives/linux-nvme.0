From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Fri, 25 Jul 2014 23:49:27 +0000
Subject: [PATCH] NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus >
 online queues
In-Reply-To: <alpine.LRH.2.03.1407251723330.4703@AMR>
References: <53D2CFFB.8010908@micron.com>
 <alpine.LRH.2.03.1407251723330.4703@AMR>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9944773B9@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Keith Busch [mailto:keith.busch at intel.com]
> Sent: Friday, July 25, 2014 4:41 PM
> To: Sam Bradshaw (sbradshaw)
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Correctly handle IOCTL_SUBMIT_IO when cpus >
> online queues
> 
> On Fri, 25 Jul 2014, Sam Bradshaw wrote:
> > nvme_submit_io_cmd() use smp_processor_id() to pick an IO queue index.
> This patch
> > fixes the case where there are more cpus from which the ioctl call
> can originate
> > than online queues, which can happen when a device supports or was
> allocated fewer
> > interrupt vectors than exist cpu cores.
> 
> Oh you're right, but I think the idea was to use the queue associated
> with the cpu, though the code was clearly broken before.
> 
> -	return nvme_submit_sync_cmd(dev, smp_processor_id() + 1, cmd,
> result,
> +	return nvme_submit_sync_cmd(dev, this_cpu_read(*dev->io_queues),
> cmd, result,
>   							NVME_IO_TIMEOUT);

Agreed.  The above is more consistent with other queue selection paths.

Do you want to send an updated patch or should I?

-Sam
