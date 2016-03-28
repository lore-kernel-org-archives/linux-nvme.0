From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Mar 2016 22:54:11 +0000
Subject: nvme device timeout
In-Reply-To: <36E8D38D6B771A4BBDB1C0D800158A51865EF73D@SSIEXCH-MB3.ssi.samsung.com>
References: <CAHOCc18wCgprYh1k0m0ow1FhU51J-1JN-X2Fj-8VKHDVi-Zo9Q@mail.gmail.com>
 <20160328172423.GA22481@localhost.localdomain>
 <36E8D38D6B771A4BBDB1C0D800158A51865EF73D@SSIEXCH-MB3.ssi.samsung.com>
Message-ID: <20160328225411.GB27195@localhost.localdomain>

Hi Judy,

There are two different things that I noticed from the tester's report,
but I may have inadvertently made them seem related.

First, the reporter says he doesn't see his device in 'lspci' after the
driver gave up on it. That happened because the driver requests removal
on controller failure, and I wanted to point that out that approach may
be overreaching the driver's responsibility. This has absolutely nothing
to do with polling for completions(*).

The polling feature was moved/removed because it shouldn't be necessary
and hides issues that we should be aware of. When it was originally
proposed to remove polling, I mentioned we may possibly discover some
controllers were unknowingly relying on it. I'm not sure yet if this
report is such an issue vs something else entirely.

As far as bringing the driver initiated polling back, we can talk about
that. Do you have a real need for this feature?


* Note, the "polling" I'm referring should not to be confused with block
  layer driven IO polling. That's a completely different feature and
  not related or affected with this issue.


On Mon, Mar 28, 2016@10:30:57PM +0000, Judy Brock-SSI wrote:
> Hi,
> 
> 
> 	>>We used to poll the drive for completions immediately after controller enable completed, so every command could have been polled. That was moved a little later in initialization in 4.5 (and removed entirely in 4.6 ...).
> 
> 	>>  Removing the device from the pci topology might be a bit heavy handed. We really only need to unbind the driver in this case (will send a different patch).
> 
> Maybe I'm misunderstanding but unbinding the driver in this case instead of removing the driver from the PCI topology the device still doesn't achieve what polling for completions immediately after controller enable completes used to do, does it? I mean, identify will still fail in such cases without the polling. 
> 
> Why was that support removed and why not reinstate it?
> 
> Thanks,
> Judy
> 
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Keith Busch
> Sent: Monday, March 28, 2016 10:24 AM
> To: Tim Mohlmann
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: nvme device timeout
> 
> On Mon, Mar 28, 2016@07:44:20PM +0300, Tim Mohlmann wrote:
> > Hi,
> > 
> > During boot my nvme device is not showing up. I've found the following 
> > dmesg output from nvme:
> > [    0.634251] nvme 0000:04:00.0: PCI INT A: no GSI
> > [   61.703015] nvme 0000:04:00.0: I/O 0 QID 0 timeout, disable controller
> > [   61.704028] nvme 0000:04:00.0: Identify Controller failed (-4)
> > [   61.705016] nvme 0000:04:00.0: Removing after probe failure status: -5
> > 
> > lspci does not list device anymore.
> 
> Thanks for mentioning that. Removing the device from the pci topology might be a bit heavy handed. We really only need to unbind the driver in this case (will send a different patch).
>  
> > This problem occured after upgrading my kernel from 4.4.5 to 4.5-rc7.
> 
> I'll venture a guess that you were unknowingly relying on the driver's polling completion feature, and your controller doesn't support legacy irq.
> 
> We used to poll the drive for completions immediately after controller enable completed, so every command could have been polled. That was moved a little later in initialization in 4.5 (and removed entirely in 4.6 ...).
> 
> > I'm new to posting about bugs in the kernel, so please advise how I 
> > can provide you with more meaningful info.
> 
> Could you apply the test patch below (created against 4.5-stable), and confirm if it still fails?
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 680f578..b9c989c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1945,17 +1945,16 @@ static void nvme_reset_work(struct work_struct *work)
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
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
