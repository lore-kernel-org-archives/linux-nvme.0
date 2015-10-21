From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 21 Oct 2015 19:10:55 +0000
Subject: [PATCH 04/18] nvme: add a vendor field to struct nvme_dev
In-Reply-To: <1445453891.3307.41.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-5-git-send-email-hch@lst.de>
 <1445453891.3307.41.camel@linux.intel.com>
Message-ID: <20151021191054.GA18645@localhost.localdomain>

On Wed, Oct 21, 2015@11:58:11AM -0700, J Freyensee wrote:
> On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> > -		sprintf(&inq_response[8], "%04x", to_pci_dev(dev
> > ->dev)->vendor);
> > +		sprintf(&inq_response[8], "%04x", dev->vendor);
> 
> I'm ok with this patch, but I wanted to ask the question for my own
> benefit, what is the Linux kernel open-source practice of using
> sprintf() and string settings?  I typically try to use snprintf().

Generally yes, snprintf is preferred, though the usage in this specific
example is more similar to a memcpy. We know the buffer size and the
length being copied into it is fixed; sprintf is just convenient.
