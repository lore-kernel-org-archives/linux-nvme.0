From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 09 Oct 2015 09:57:44 -0700
Subject: [PATCH] nvme: move to a new drivers/nvme/host directory
In-Reply-To: <alpine.LNX.2.00.1510091622320.27742@localhost.lm.intel.com>
References: <1444407426-23072-1-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510091622320.27742@localhost.lm.intel.com>
Message-ID: <1444409864.2791.5.camel@linux.intel.com>

On Fri, 2015-10-09@16:30 +0000, Keith Busch wrote:
> On Fri, 9 Oct 2015, Christoph Hellwig wrote:
> > From: Jay Sternberg <jay.e.sternberg at intel.com>
> > 
> > This patch moves the NVMe driver from drivers/block/ to its own new
> > drivers/nvme/host/ directory.  This is in preparation of splitting 
> > the
> > current monolithic driver up and add support for the upcoming NVMe
> > over Fabrics standard.  The drivers/nvme/host/ is chose to leave 
> > space
> > for a NVMe target implementation in addition to this host side 
> > driver.
> > 
> > Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
> > [hch: rebased, renamed core.c to pci.c, slight tweaks]
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> 
> Looks good to me!
> 
> Acked-by: Keith Busch <keith.busch at intel.com>

Dido.

Acked-by: James Freyensee <james_p_freyensee at linux.intel.com>

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
