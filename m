From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:54:36 -0700
Subject: [PATCH] nvme-pci: ensure nvme_timeout complete before
 initializing procedure
In-Reply-To: <20180122201423.GA30427@lst.de>
References: <1516607585-1525-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180122201423.GA30427@lst.de>
Message-ID: <20180122215436.GS12043@localhost.localdomain>

On Mon, Jan 22, 2018@09:14:23PM +0100, Christoph Hellwig wrote:
> > Link: https://lkml.org/lkml/2018/1/19/68
> > Suggested-by: Keith Busch <keith.busch at intel.com>
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> > Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> 
> Why does this have a signoff from Keith?

Right, I hadn't signed off that. I just trying to get feeback if
someting like that was closing the theoretical gap, which it does.

I actually have something similar in my patch queue I was about to send
around this area, though. I don't like having the IO path take on the
error handling, and I think ending unstarted requests directly will be
better long term.
