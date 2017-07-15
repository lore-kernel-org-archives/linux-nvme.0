From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 15 Jul 2017 01:50:08 -0700
Subject: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe
 driver.
In-Reply-To: <20170714210623.GB24365@localhost.localdomain>
References: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>
 <20170714210623.GB24365@localhost.localdomain>
Message-ID: <20170715085008.GB25753@infradead.org>

On Fri, Jul 14, 2017@05:06:24PM -0400, Keith Busch wrote:
> > 2. Set up the IO size threshold to determine whether to use
> >     SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
> >     use SGL only for IOs which are >= 4096 in the size).
> 
> For this to really make a difference, you should clear
> blk_queue_virt_boundary for SGL capable devices.

SGLs make sense for bigger I/O alone.  But not having to set the
blk_queue_virt_boundary would be another benefit, Although you'll
probably need a 64k page size system for that to matter in practice.

I remember Max had a patch for fabrics to support the Mellanox arbitrary
SGL registrations, which should share some core code with allowing
that for PCIe with SGLs.

Max, what happened to that?
