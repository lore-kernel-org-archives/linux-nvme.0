From: keith.busch@intel.com (Busch, Keith)
Date: Fri, 23 Oct 2015 14:51:59 +0000
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <20151023055715.GC30808@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-9-git-send-email-hch@lst.de>
 <20151022181014.GE21840@localhost.localdomain>
 <20151022181240.GA22482@lst.de>
 <20151022203650.GF21840@localhost.localdomain>
 <20151023055715.GC30808@lst.de>
Message-ID: <20151023145159.GA2986@localhost.localdomain>

On Fri, Oct 23, 2015@07:57:15AM +0200, Christoph Hellwig wrote:
> I guess we need to sort out this life time model in more detail later
> as the existing one you restored here looks a bit odd to me.  Nothing
> I'll be able to finish this week, though.

We just don't want the character device to be available to accept new
opens after the physical device was removed, so I think it has to be in
the "remove" path rather than after the reference count drops to 0.

> Thanks.  So what's the plan for the patches in it?  They'll clash a bit
> with the PR API and integrity branches due to all the moves.  But those
> are also the reason why I'd really like to see it go into 4.4.  Do you
> need help with a rebase?

No worries, I'll take care of the rebase and resend for consideration.
