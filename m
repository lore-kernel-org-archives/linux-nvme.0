From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Sep 2017 11:17:14 -0400
Subject: [PATCH] nvme/pci: Print invalid SGL only once
In-Reply-To: <20170915145553.GA1147@lst.de>
References: <1505415974-13489-1-git-send-email-keith.busch@intel.com>
 <20170915145553.GA1147@lst.de>
Message-ID: <20170915151713.GD8878@localhost.localdomain>

On Fri, Sep 15, 2017@04:55:53PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 14, 2017@03:06:14PM -0400, Keith Busch wrote:
> > The WARN_ONCE macro returns true if the condition is true, not if the
> > warn was raised, so we're printing the scatter list every time it's
> > invalid. This is excessive and makes debugging harder, so this patch
> > prints it just once.
> 
> Please use the printk_ratelimited() helper instead.

Hmm, I don't want to rate limit the prints. That may log only partial
SGLs, or even worse, interleave parts from multiple errors. We want
to see an entire SGL for a single error, like what WARN_ONCE does.
A single occurrence is usually sufficient to work backwards to see how
the breakage occurred.
