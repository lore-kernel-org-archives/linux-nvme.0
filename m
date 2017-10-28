From: hch@lst.de (Christoph Hellwig)
Date: Sat, 28 Oct 2017 08:32:52 +0200
Subject: [PATCH 16/17] nvme: implement multipath access to nvme subsystems
In-Reply-To: <104278cd-0383-71e0-45c2-750108723b8b@suse.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-17-hch@lst.de>
 <104278cd-0383-71e0-45c2-750108723b8b@suse.de>
Message-ID: <20171028063252.GA13998@lst.de>

> Sure this works?

It does.

> nvme_req_needs_retry() checks blk_noretry_request():

> The original idea here was to _set_ these bits on multipath path devices
> so that they won't attempt any retry, but rather forward the I/O error
> to the multipath device itself for failover.
> So if these bits are set (as they should be for multipathed devices)
> we'll never attempt any failover...

While that might have been the "original" idea, it isn't what this code
does.  We never set any of the REQ_FAILFAST_* bits in
nvme_ns_head_make_request.  In NVMe there aren't really any device
equivalents of REQ_FAILFAST_ that make sense for multipath.  The only
one that we map to is the limited retry bit, and that is media centric,
so a failver would not help.
