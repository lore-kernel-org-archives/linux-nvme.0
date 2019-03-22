From: kbusch@kernel.org (Keith Busch)
Date: Fri, 22 Mar 2019 11:37:36 -0600
Subject: [RFC] optimize nvme single segment I/O
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190322173736.GC31194@localhost.localdomain>

On Thu, Mar 21, 2019@04:10:22PM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> with all the discussion on small I/O performance lately I thought
> it was time off to dust my old idea to optimize this path a bit
> by avoiding to build a scatterlist.  I've only done very basic
> testing because I've been a bit busy, but I thought it might be
> worthwhile to get it out for feedback.

Tests well here with a measurable IOPs improvement at lower queue depths.

Series looks good to me, especially patch 5! :p

Reviewed-by: Keith Busch <keith.busch at intel.com>
