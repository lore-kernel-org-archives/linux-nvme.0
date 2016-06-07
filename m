From: Jeff.Lien@hgst.com (Jeff Lien)
Date: Tue, 7 Jun 2016 18:42:00 +0000
Subject: Question on Patch - NVMe: Shutdown controller only for power-off
In-Reply-To: <20160607175840.GC28414@localhost.localdomain>
References: <BL2PR04MB163B82FED551339CEDC2116925D0@BL2PR04MB163.namprd04.prod.outlook.com>,
 <20160607175840.GC28414@localhost.localdomain>
Message-ID: <BL2PR04MB163077C4D3CD0E5075DF8E3925D0@BL2PR04MB163.namprd04.prod.outlook.com>

Keith,
The issue isn't that the fw activate requires a shutdown; it's more that the HGST controller takes much longer to execute the nvme_disable_ctrl if it hasn't been shutdown first.  This issue caused us to add a longer delay before the first read of the csts reg in nvme_wait_ready.

Rather than adding a delay in nvme_disable_controller, I think the better option would be to shutdown the controller.  The comment says "If we're called to reset a live controller first shut it down" so in this case I think the shutdown parm should be true.

----------------------------------------------------------
Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
Western Digital Corporation
e.  jeff.lien at hgst.com
o.  +1-507-322-2416
m. +1-507-273-9124





________________________________________
From: Keith Busch <keith.busch@intel.com>
Sent: Tuesday, June 07, 2016 12:58:42 PM
To: Jeff Lien
Cc: axboe at fb.com; linux-nvme at lists.infradead.org; David Darrington; Guilherme G. Piccoli; Murali N Iyer
Subject: Re: Question on Patch - NVMe: Shutdown controller only for power-off

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
