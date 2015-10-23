From: keith.busch@intel.com (Busch, Keith)
Date: Fri, 23 Oct 2015 19:31:20 +0000
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <20151023145159.GA2986@localhost.localdomain>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-9-git-send-email-hch@lst.de>
 <20151022181014.GE21840@localhost.localdomain>
 <20151022181240.GA22482@lst.de>
 <20151022203650.GF21840@localhost.localdomain>
 <20151023055715.GC30808@lst.de>
 <20151023145159.GA2986@localhost.localdomain>
Message-ID: <20151023193119.GA9022@localhost.localdomain>

On Fri, Oct 23, 2015@02:51:59PM +0000, Busch, Keith wrote:
> No worries, I'll take care of the rebase and resend for consideration.

Only a little painful. :)

I merged the linux-block for-4.4/integrity, for-4.4/reservations,
for-linus, and for-next, plus all of Christoph's recent NVMe with some
merge conflict fixups, plus a few of my own:

http://git.infradead.org/users/kbusch/linux-nvme.git

The tree is just a convience for me, but just linking it here in hopes
that it's useful. It was a forced push, so abandon older clones if
they exist.

My first merge like this. I hope I got the process "right", but I wouldn't
be surprised there was a smarter way to do it.

I will send out separate patches to the list for the ones that haven't
been reviewed yet. I'll also try to apply some of the other patches
from the list that seem to have been forgotten; the PPC IOMMU issue is
pretty important.
