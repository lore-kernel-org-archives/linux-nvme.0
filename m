From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Fri, 14 Oct 2016 17:05:00 +0000
Subject: NVME Subsystem Reset Question
In-Reply-To: <20161012173411.GA12681@localhost.localdomain>
References: <CY4PR04MB02171C20ACEE87C3409A47ABEADD0@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161012173411.GA12681@localhost.localdomain>
Message-ID: <CY4PR04MB0217C9B51D7B51A28132D606EADF0@CY4PR04MB0217.namprd04.prod.outlook.com>

Keith,
We agree with your thoughts on the fact that nvme device should recover automatically without requiring a pci bus rescan, but are seeing behavior to the contrary  with our NVME device as well as an Intel 3600 drive we also have.   Both devices disappear of the pci and require a pci bus rescan to show back up after the subsystem reset is done.  

After reading thru the PCI Express spec, it seems like the LTSSM detect state is a transitional state that the device should eventually and automatically leave on its way back to L0 state.   Could you confirm that from your side?  We're just looking for evidence and confirmation from you and the nvme community that this is not correct or expected behavior so  we can convince our firmware team that they need to make a change.  

Thanks in advance for your input.

Jeff Lien

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, October 12, 2016 12:34 PM
To: Jeffrey Lien
Cc: axboe at fb.com; linux-nvme at lists.infradead.org; David Darrington; Nathan Rabe
Subject: Re: NVME Subsystem Reset Question

On Wed, Oct 12, 2016@05:04:40PM +0000, Jeffrey Lien wrote:
> Keith, Jens,
> I have a question on what the state of the nvme device should be after a subsystem reset (ie. Writing "NVMe" to NSSR).   The spec says it should be in LTSSM detect state which seems to mean it no longer showing up on the PCI bus which requires a pci bus rescan to get it back.   Does that match your interpretation?
>
> If so, who's responsible for initiating the bus rescan to get the device back?  I didn't see anything in the driver code that would do this so I'm assuming it would be the App's (that issued the subsystem reset ioctl) responsibility.  Agree?  Or is there something else that should initiate the rescan?

A bus rescan shouldn't be necessary. The device is supposed to go from detect to polling automatically if a receiver is detected, then configuration, recovery and finally L0 without the kernel doing anything. At least that's my understanding.

Since power is never lost, the controllers in the subsystem should have CSTS.NSSRO set to 1 so the driver can observe this after the controller completes link training.

It wouldn't make much sense to require the host do anything to initiate a rescan to detect the pci device after a subsystem reset. Different controllers in the subsystem could be connected to different hosts, and you can't ensure that's coordinated from the host that initiated the subsystem reset.
