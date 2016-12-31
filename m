From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 30 Dec 2016 19:51:08 -0800
Subject: [PATCH v4 0/6] SED OPAL Library
In-Reply-To: <20161230225252.GA3716@sbauer-Z170X-UD5>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <20161230082826.GA30378@infradead.org>
 <20161230225252.GA3716@sbauer-Z170X-UD5>
Message-ID: <20161231035108.GA18886@infradead.org>

On Fri, Dec 30, 2016@03:52:53PM -0700, Scott Bauer wrote:
> On Fri, Dec 30, 2016@12:28:26AM -0800, Christoph Hellwig wrote:
> > Hi Scott,
> > 
> > do you have a pointer to the userspace using this ioctls?  Over the
> > holidays I finally managed to put a test system for my collection of m.2
> > key M cards together, so I should be able to test the code, which I'd
> > definitively like to do before ACKing.  More comments on the code itself
> > will follow soon.
> 
> 
> We've enabled the supporte into nvmecli you can pull my branch here:
> https://github.com/ScottyBauer/nvme-cli/tree/sed-nvme

Can we move this out of nvme-cli into a separate tool?  I'd like to use
your code to support ATA disk as well.  (and that should give us SCSI
for free, but I don't have access to a SCSI disk with OPAL support)
