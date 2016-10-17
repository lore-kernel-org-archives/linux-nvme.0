From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 17 Oct 2016 18:34:21 +0000
Subject: NVME Subsystem Reset Question
In-Reply-To: <20161017162043.GB19846@localhost.localdomain>
References: <CY4PR04MB02171C20ACEE87C3409A47ABEADD0@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161012173411.GA12681@localhost.localdomain>
 <CY4PR04MB0217C9B51D7B51A28132D606EADF0@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161014212731.GD19383@localhost.localdomain>
 <CY4PR04MB02170704032DF827E6327DD3EAD00@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161017162043.GB19846@localhost.localdomain>
Message-ID: <CY4PR04MB02172F37924BC33EE0E7E51BEAD00@CY4PR04MB0217.namprd04.prod.outlook.com>

I'm using the nvme cli to send the subsystem reset - "nvme subsystem-reset /dev/nvme0".


Jeff Lien

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Monday, October 17, 2016 11:21 AM
To: Jeffrey Lien
Cc: axboe at fb.com; Nathan Rabe; David Darrington; linux-nvme at lists.infradead.org
Subject: Re: NVME Subsystem Reset Question

On Mon, Oct 17, 2016@02:42:56PM +0000, Jeffrey Lien wrote:
> We're using the 3.10.0-493 kernel from a Red hat 7.3 Beta install.  I believe the nvme inbox driver here was back ported from the 4.5 kernel release.   I've attached the dmesg output from both the intel and western digital device.  Both are very similar if not identical.  

It does appear the link is disabled when the driver's health check runs. It may be possible it observes all 1's on a transient link state change in the health check. I'm not sure right now of a safe way to distinguish a permanently disabled device vs a transient condition with the information available.

How are you sending a subsystem reset? On the Intel device, I assumed you were using a D3600, but this looks like a P3600 based on the model and firmware revision. That controller doesn't support subsystem reset, so the ioctl method should have returned -ENOTTY.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
