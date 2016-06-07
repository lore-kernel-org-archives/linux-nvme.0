From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Jun 2016 13:58:42 -0400
Subject: Question on Patch - NVMe: Shutdown controller only for power-off
In-Reply-To: <BL2PR04MB163B82FED551339CEDC2116925D0@BL2PR04MB163.namprd04.prod.outlook.com>
References: <BL2PR04MB163B82FED551339CEDC2116925D0@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <20160607175840.GC28414@localhost.localdomain>

On Tue, Jun 07, 2016@05:29:01PM +0000, Jeff Lien wrote:
> Keith, Jens,
> 
> I have a question on the subject matter patch that was pushed on 1/12/2016.   In the nvme_reset_work function in pci.c, the following comment doesn't seem to match what the code is doing.
> 
> 1893         /*
> 1894          * If we're called to reset a live controller first shut it down before
> 1895          * moving on.
> 1896          */
> 1897         if (dev->bar)
> 1898                 nvme_dev_disable(dev, false);
> 
> 
> Calling nvme_dev_disable with a shutdown parm of false does not shutdown the device.   Am I reading the comment or code wrong here?   We're going thru this code path on a sysfs reset_controller to reset the device and activate a new level of fw and expected a shutdown to happen like it did in the 3.10.0-327 kernel.   I'm thinking the shutdown parm should be true in this call.

It still disables the controller but it doesn't hit the shutdown bits. Why
do you need toggle CC.SHN for firmware activation? That's not a valid
firmware activation requirement according to the spec.
