From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 27 Oct 2018 09:19:03 +0000
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181027074452.GA15404@lst.de>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>, <20181027074452.GA15404@lst.de>
Message-ID: <SN6PR04MB4510F2A021624A99E18BF4BC86F10@SN6PR04MB4510.namprd04.prod.outlook.com>



From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Christoph Hellwig <hch@lst.de>
Sent: Saturday, October 27, 2018 12:44 AM
To: Keith Busch
Cc: axboe at fb.com; Gwendal Grignou; hch at lst.de; linux-nvme at lists.infradead.org; sagi at grimberg.me
Subject: Re: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
? 
 
On Fri, Oct 26, 2018@04:58:07PM -0600, Keith Busch wrote:
> The quirk is for devices that pre-date the ability to discover the
> capability. Now that we have a spec defined way to know a device's
> deallocate behavior, and this particular device implements that method,
> we should use that instead of a quirk.

The 'Deallocate Logical Block Features' bits 0 and 1 only tell what
is read back from deallocated logic blocks, but it does not guarantee
that all blocks a DSM deallocate is called on are actually deallocated.

That being said I really don't want to add more 'feature hacks' like this,
it is time that we go back to a proper Write Zeroes implementation.

[CK] I'll send out the patch shortly.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
