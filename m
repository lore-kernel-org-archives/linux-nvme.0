From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Mar 2015 15:31:25 +0000 (UTC)
Subject: NVMe controller reset
In-Reply-To: <31FEE40556302F408590926A3C4AC65FED550BAB@BBYEXM01.pmc-sierra.internal>
References: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>
 <BN1PR0401MB093179FFC1C61856942C2DD0F2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <B58D82457FDA0744A320A2FC5AC253B93BA99F32@fmsmsx104.amr.corp.intel.com>
 <31FEE40556302F408590926A3C4AC65FED54F404@BBYEXM01.pmc-sierra.internal>
 <alpine.LNX.2.00.1503232045420.32385@localhost.lm.intel.com>
 <31FEE40556302F408590926A3C4AC65FED550BAB@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1503251458451.32385@localhost.lm.intel.com>

On Wed, 25 Mar 2015, David Sariel wrote:
> Hi Keith,
> Thanks a lot for the prompt and detailed explanations.
> I have fixed the issue with multiple shutdowns and initializations at might
> occur at the same time according to your suggestion.
>
> static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
> 							unsigned long arg)
>
> ...
> case NVME_IOCTL_RESET:
>        ns->dev->reset_workfn = nvme_reset_failed_dev;
>        queue_work(nvme_workq, &ns->dev->reset_work);
> ...

I don't think we want to queue it if it's already running a reset. Just
queue if work_busy(&dev->reset_work) isn't true and return -EBUSY or
block if it is.

Would a user application expect this reset to run asynchronously? I'm
not sure, but if not, we can add a flush_work(&dev->reset_work) at the
end.

And let's make this available only from the management handle's ioctl
nvme_dev_ioctl() rather than a namespace's.

> I can send you a pull request for the addition of the "reset" in the
> nvme-cli. But what do you suggest considering the NVME_IOCTL_RESET addition?
> It can be added to the latest kernel, but actually it comes for pre 3.15
> versions (because on post 3.15 versions echo 1 > /sys/../reset works just
> fine).

Sure, I'll merge nvmecli when the ioctl is applied to the kernel.

I think we should take the ioctl reset so it can be back-ported to
older kernels as well as provide a reset method to virtual devices
that don't get a sysfs entry.
