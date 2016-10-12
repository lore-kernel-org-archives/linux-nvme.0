From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Wed, 12 Oct 2016 17:04:40 +0000
Subject: NVME Subsystem Reset Question
Message-ID: <CY4PR04MB02171C20ACEE87C3409A47ABEADD0@CY4PR04MB0217.namprd04.prod.outlook.com>

Keith, Jens,
I have a question on what the state of the nvme device should be after a subsystem reset (ie. Writing "NVMe" to NSSR).   The spec says it should be in LTSSM detect state which seems to mean it no longer showing up on the PCI bus which requires a pci bus rescan to get it back.   Does that match your interpretation?   

If so, who's responsible for initiating the bus rescan to get the device back?  I didn't see anything in the driver code that would do this so I'm assuming it would be the App's (that issued the subsystem reset ioctl) responsibility.  Agree?  Or is there something else that should initiate the rescan?

Thanks

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien at hgst.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124
