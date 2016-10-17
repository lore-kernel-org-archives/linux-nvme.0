From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 17 Oct 2016 14:42:56 +0000
Subject: NVME Subsystem Reset Question
In-Reply-To: <20161014212731.GD19383@localhost.localdomain>
References: <CY4PR04MB02171C20ACEE87C3409A47ABEADD0@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161012173411.GA12681@localhost.localdomain>
 <CY4PR04MB0217C9B51D7B51A28132D606EADF0@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161014212731.GD19383@localhost.localdomain>
Message-ID: <CY4PR04MB02170704032DF827E6327DD3EAD00@CY4PR04MB0217.namprd04.prod.outlook.com>

Keith,
We're using the 3.10.0-493 kernel from a Red hat 7.3 Beta install.  I believe the nvme inbox driver here was back ported from the 4.5 kernel release.   I've attached the dmesg output from both the intel and western digital device.  Both are very similar if not identical.  


Jeff Lien

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Friday, October 14, 2016 4:28 PM
To: Jeffrey Lien
Cc: axboe at fb.com; linux-nvme at lists.infradead.org; David Darrington; Nathan Rabe
Subject: Re: NVME Subsystem Reset Question

On Fri, Oct 14, 2016@05:05:00PM +0000, Jeffrey Lien wrote:
> We agree with your thoughts on the fact that nvme device should recover automatically without requiring a pci bus rescan, but are seeing behavior to the contrary  with our NVME device as well as an Intel 3600 drive we also have.   Both devices disappear of the pci and require a pci bus rescan to show back up after the subsystem reset is done.  

What kernel version are you using? Can you send me a dmesg of the event?
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: subsys-reset-dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161017/ee5043ed/attachment.txt>
