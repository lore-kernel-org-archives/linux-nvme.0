From: brandon.schulz@hgst.com (Brandon Schulz)
Date: Tue, 17 Mar 2015 20:45:06 +0000
Subject: NVMe controller reset
In-Reply-To: <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>
References: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>
Message-ID: <BN1PR0401MB093179FFC1C61856942C2DD0F2030@BN1PR0401MB0931.namprd04.prod.outlook.com>

I see.  Thanks for the response.

So this won't work for the back-ports to 2.6.32-ish kernels, as you mentioned, so does anyone have a preference for how it is done there?

We're going to have to implement a mechanism, and if there are strong opinions against implementing it as an ioctl, I'd like to hear them before we go write the code and submit the patches.

My objective here is to find an acceptable mechanism that can eventually be pulled into the older distro kernels.  If I'm going about this the wrong way, please let me know.

Thanks,
Brandon



-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Tuesday, March 17, 2015 3:30 PM
To: Brandon Schulz
Cc: linux-nvme at lists.infradead.org
Subject: Re: NVMe controller reset

On Tue, 17 Mar 2015, Brandon Schulz wrote:
> What is the preferred way (if there is one) to force a controller reset from user-space?
>
> If, for example, a user-space tool was going to do a firmware activate that required a controller reset, how would one trigger the reset?  I do not see an ioctl defined for this today, or am I missing something?

Like this:

   # echo 1 > /sys/class/nvme/nvme<#>/device/reset

This assumes you're using kernel >= 4.0. Before that'd, the entry was under "class/misc" instead of "class/nvme". It was moved to a new class because 'misc' wasn't giving us enough minors to have more than several dozen NVMe drives in a system, but I want hundreds.

It also assumes you're using a kernel >= 3.15. While the sysfs entry exists pre-3.15, it wasn't safe to use because there was no notification callback for drivers to subscribe to.

Had I known what a pain it was to back-port the pci callback to older kernels (it apparently breaks kABI), I would have used an nvme specific sysfs entry, but that's where we are today.
