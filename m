From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Oct 2016 17:27:32 -0400
Subject: NVME Subsystem Reset Question
In-Reply-To: <CY4PR04MB0217C9B51D7B51A28132D606EADF0@CY4PR04MB0217.namprd04.prod.outlook.com>
References: <CY4PR04MB02171C20ACEE87C3409A47ABEADD0@CY4PR04MB0217.namprd04.prod.outlook.com>
 <20161012173411.GA12681@localhost.localdomain>
 <CY4PR04MB0217C9B51D7B51A28132D606EADF0@CY4PR04MB0217.namprd04.prod.outlook.com>
Message-ID: <20161014212731.GD19383@localhost.localdomain>

On Fri, Oct 14, 2016@05:05:00PM +0000, Jeffrey Lien wrote:
> We agree with your thoughts on the fact that nvme device should recover automatically without requiring a pci bus rescan, but are seeing behavior to the contrary  with our NVME device as well as an Intel 3600 drive we also have.   Both devices disappear of the pci and require a pci bus rescan to show back up after the subsystem reset is done.  

What kernel version are you using? Can you send me a dmesg of the event?
