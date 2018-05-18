From: hch@lst.de (Christoph Hellwig)
Date: Fri, 18 May 2018 11:06:33 +0200
Subject: [PATCH V5] nvmet: add simple file backed ns support
In-Reply-To: <BN6PR04MB1203154BDE61CFAD7ED095D986910@BN6PR04MB1203.namprd04.prod.outlook.com>
References: <20180517124714.GA31470@lst.de>
 <BN6PR04MB1203154BDE61CFAD7ED095D986910@BN6PR04MB1203.namprd04.prod.outlook.com>
Message-ID: <20180518090633.GD24436@lst.de>

> > +???? ns->cachep = kmem_cache_create("nvmet-fs",
> 
> what about nvmet-bvec as the name?
> 
> [CK] Also, while we are at it should I change the name of the?
> following functions?currently present?in the io-cmd.c and add
> suffix "bdev" ?

Sounds good to me.  And please use bdev everywhere instead of blk
or blkdev.

> 
> 1.?nvmet_execute_write_zeroes
> 2. nvmet_execute_dsm
> 3. nvmet_execute_discard
> 4. nvmet_discard_range
> 5 .nvmet_discard_range
> 6. nvmet_execute_rw

nvmet_bdev_*

> [CK] Here we only issue sync I/O when nr_bvec > NVMET_MAX_MEMPOOL_BVEC, when
> nr_bvec <=?NVMET_MAX_MEMPOOL_BVEC and we still allocate from mempool which
> will result in?async I/O. We have to make this allocation info (mempool vs kmalloc_arrat)
> accessible in the?callback function by?adding a new member to the struct nvmet_req
> anonymous union.

Sounds good.

> Instead of adding a new member, since we are under memory pressure here can
> we set is_sync unconditionally when we allocate from the mempool and force sync I/O?

I don't think that makes sense.  A lot of I/Os under memory pressure
are probably small, and there is no need to slow them down for no good
reason.
