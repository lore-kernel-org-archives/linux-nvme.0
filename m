From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Mar 2015 21:10:36 +0000 (UTC)
Subject: NVMe controller reset
In-Reply-To: <31FEE40556302F408590926A3C4AC65FED54F404@BBYEXM01.pmc-sierra.internal>
References: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>
 <BN1PR0401MB093179FFC1C61856942C2DD0F2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <B58D82457FDA0744A320A2FC5AC253B93BA99F32@fmsmsx104.amr.corp.intel.com>
 <31FEE40556302F408590926A3C4AC65FED54F404@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1503232045420.32385@localhost.lm.intel.com>

On Mon, 23 Mar 2015, David Sariel wrote:
> Hi
> As a matter of fact I was also paying around with reset recently.
> And Keith's note about the pre-3.15 lack of safety explained all the strange things I saw on 3.14.16.

Yeah, the pci core would send FLR to your controller, which should get
it back to its initial state. Prior to 3.15 no one told the device's
*driver* this is happening, so it had to figure out all on its own that
the device is no longer operational. Depending on what you're doing,
that could take awhile.

I think the sysfs entry was meant for virtualization to use prior to
setting direct assignments, so it's not expected there's an active
device driver, but using this entry is not enforcing that and there are
other uses of FLR outside that case. I added the callback notification
in case FLR is a requirement for firmware activation. As of today,
NVMe is still the only callback subscriber.

> I have installed v 3.16.2 and played a little bit more. Particularly, I have added the NVME_IOCTL_RESET to
> See that reset works. What I did is to call the nvme_dev_reset upon the NVME_IOCTL_RESET.
> And resets are working just fine. Even sending multiple resets under traffic only slows the traffic a little bit, but eventually fio
> Manages to run to the completion.

Oh good. The driver should be requeuing commands that were in flight, but
didn't return successfully during the reset operation, so you shouldn't
see IO errors unless your device takes a really long time to shutdown.

> Then I tried to investigate a little bit what happens with reset entry in sysfs on v 3.16.2 and it will be great if somebody could answer the questions I have:
>
> 1) making echo 1 > /sys/class/misc/nvme0/device/reset cause no call to the nvme_dev_reset. And no controller reset was caused in the NVME controller as well.

Right, this does not call nvme_dev_reset because the PCIe reset
occurs outside the nvme notification context. There's no point in
doing the device reset when the PCIe reset is going to undo all your
initialization.

Instead this will call nvme_reset_notify. This either invokes
nvme_dev_shutdown or nvme_dev_resume, depending on the "prepare"
flag. That's pretty much what nvme_dev_reset() does, except in two calls
instead of one.

>So the question is why resets were implemented via the reset_work? Currently resets are delivered to the controller (turning CC enable to 0 etc) under a several conditions:
> readl(&dev->bar->csts) & NVME_CSTS_CFS && dev->initialized and then the work is only scheduled. What is the rational? Can't we just read the /sys/class/misc/nvme0/device/reset  and call to the nvme_dev_reset (of course subject to take the rcu_read_lock/ rcu_read_unlock)

The reset_work is used because the detection of the conditions that
require a device reset occur in a context that can't perform a device
shutdown and initialization.

> 2) Is it ok to add NVME_IOCTL_RESET in case the rational for resets with sysfs/ reset_work combination is not intended to work with multiple resets under traffic? The code I have tested is very simple:

I've always gotten negative reactions to adding IOCTLs. I'm totally okay
with it, though.

The only problem with your implementation is that it allows multiple
shutdowns and initializations to occur on the same device at the same
time. That's not safe for a lot of reasons in the existing implementation.
For example, the init may be accessing unmapped bars, or you could have
two processes bit-banging the CC register. The reset_work can be used
to ensure there's only one.
