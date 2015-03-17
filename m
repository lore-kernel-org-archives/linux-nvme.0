From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 Mar 2015 20:30:23 +0000 (UTC)
Subject: NVMe controller reset
In-Reply-To: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
References: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
Message-ID: <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>

On Tue, 17 Mar 2015, Brandon Schulz wrote:
> What is the preferred way (if there is one) to force a controller reset from user-space?
>
> If, for example, a user-space tool was going to do a firmware activate that required a controller reset, how would one trigger the reset?  I do not see an ioctl defined for this today, or am I missing something?

Like this:

   # echo 1 > /sys/class/nvme/nvme<#>/device/reset

This assumes you're using kernel >= 4.0. Before that'd, the entry was
under "class/misc" instead of "class/nvme". It was moved to a new class
because 'misc' wasn't giving us enough minors to have more than several
dozen NVMe drives in a system, but I want hundreds.

It also assumes you're using a kernel >= 3.15. While the sysfs entry
exists pre-3.15, it wasn't safe to use because there was no notification
callback for drivers to subscribe to.

Had I known what a pain it was to back-port the pci callback to older
kernels (it apparently breaks kABI), I would have used an nvme specific
sysfs entry, but that's where we are today.
