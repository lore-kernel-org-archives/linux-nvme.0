From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 6 Aug 2015 23:34:15 -0700
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <55C39B3A.5030201@dev.mellanox.co.il>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
 <55C39B3A.5030201@dev.mellanox.co.il>
Message-ID: <20150807063415.GA31458@infradead.org>

On Thu, Aug 06, 2015@08:36:58PM +0300, Sagi Grimberg wrote:
> >+	if (!queue_virt_boundary(q))
> >+		return false;
> >+	return offset ||
> >+		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
> 
> I'm wandering if it deserves an unlikely() statement given it really
> depends on the application workload...

I'd prefer to not micro-optimize using unlikely unless we have a really
good reason for it.
