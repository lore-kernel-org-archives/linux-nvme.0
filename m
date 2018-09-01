From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Sep 2018 10:27:03 +0200
Subject: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
 <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
Message-ID: <20180901082703.GA670@lst.de>

On Fri, Aug 31, 2018@09:48:40AM -0600, Logan Gunthorpe wrote:
> Pretty easy. P2P detection is pretty much just pci_p2pdma_distance() ,
> which has nothing to do with the ZONE_DEVICE support.
> 
> (And the distance function makes use of a number of static functions
> which could be combined into a simpler interface, should we need it.)

I'd ?ay lets get things merged as-is, so that we can review the
non-ZONE_DEVICE users.  I'm a little curious how that is going to work,
so having it as a full series would be useful.
