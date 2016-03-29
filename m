From: muhlemmer@gmail.com (Tim Mohlmann)
Date: Tue, 29 Mar 2016 20:17:11 +0300
Subject: nvme device timeout
In-Reply-To: <20160329143818.GC27195@localhost.localdomain>
References: <1604554248.106551459228253752.JavaMail.weblogic@epmlwas03c>
 <20160329143818.GC27195@localhost.localdomain>
Message-ID: <56FAB897.30201@gmail.com>

The last patch worked and made my nvme device to show again, with UEFI
disabled. Tested against vanilla 4.5.0 sources

Like I wrote in other messages in this thread, before upgrading to 4.5 I
ran into problems about the nvme not showing when UEFI boot is enabled.
I assume this is something completely different. Should I open a new
thread in this ML, file a bug at kernel.org or use the lkml?

On 03/29/2016 05:38 PM, Keith Busch wrote:
> Thanks, good catch!
> 
> Have you confirmed that this controller is indeed relying on polling
> completions during early init, or do you want to try a fix for kthread
> polling? The test patch is appeneded below if you still need to confirm
> it.
> 
> If the controller really doesn't work with legacy interrupts, would it
> be possible to permanently set the PCI interrupt pin register to 0? You
> shouldn't advertise the capability if it doesn't work, and the driver
> would have used MSI-x if that was the case.
> 
> If we absolutely need to add a quirk, either polling or force using
> MSI-x sound like possible solutions.
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 680f578..05eb152 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1371,12 +1371,6 @@ static int nvme_kthread(void *data)
>  			int i;
>  			u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
> -			/*
> -			 * Skip controllers currently under reset.
> -			 */
> -			if (work_pending(&dev->reset_work) || work_busy(&dev->reset_work))
> -				continue;
> -
>  			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
>  							csts & NVME_CSTS_CFS) {
>  				if (queue_work(nvme_workq, &dev->reset_work)) {
> @@ -1945,17 +1939,16 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> -	result = nvme_init_identify(&dev->ctrl);
> +	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
> +	result = nvme_dev_list_add(dev);
>  	if (result)
>  		goto out;
>  
> -	result = nvme_setup_io_queues(dev);
> +	result = nvme_init_identify(&dev->ctrl);
>  	if (result)
>  		goto out;
>  
> -	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
> -
> -	result = nvme_dev_list_add(dev);
> +	result = nvme_setup_io_queues(dev);
>  	if (result)
>  		goto out;
>  
> --
>
