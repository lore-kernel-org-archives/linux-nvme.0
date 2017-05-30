From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 May 2017 10:20:57 -0400
Subject: [PATCH] nvme/pci: Remove watchdog timer
In-Reply-To: <20170528094152.GB14199@lst.de>
References: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
 <20170528094152.GB14199@lst.de>
Message-ID: <20170530142057.GA2845@localhost.localdomain>

On Sun, May 28, 2017@11:41:52AM +0200, Christoph Hellwig wrote:
> 
> Otherwise this looks good to me, but I'd like to defer it until
> we have the multiple reset issue sorted out, to avoid conflicts.

That's okay to defer till after that settles. I'll need to respin this
anyway since I mistakely re-read CSTS instead of reading it once.

I am hoping to get this in this round since it would quiet a lot of
errors I'm frequently pinged on: a non-posted request during a hotremove
downstream a switch creates a lot of problems for hardware if you don't
have DPC enabled.

One thing I'm just realizing, though, this will break subsystem reset.
We were depending on the watchdog to detect that event, but now we require
an IO timeout. It's easy enough to fix that from the host initiating
the NSSR, but there's no way to notify other hosts connected to the
same subsystem.

Despite that, I still think this patch is still a step in the right
direction for previously mentioned reasons.
