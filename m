From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 25 Jul 2018 08:53:57 -0600
Subject: [PATCH v3 2/3] block: move dif_prepare/dif_complete functions to
 block layer
In-Reply-To: <20180725112247.GA24190@lst.de>
References: <1532508421-2711-1-git-send-email-maxg@mellanox.com>
 <1532508421-2711-2-git-send-email-maxg@mellanox.com>
 <20180725112247.GA24190@lst.de>
Message-ID: <20180725145357.GD14596@localhost.localdomain>

On Wed, Jul 25, 2018@01:22:47PM +0200, Christoph Hellwig wrote:
> > +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
> > +			p = pmap;
> 
> Maybe:
> 
> 			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;

Max pointed out that even with this, we're still calling kunmap_atomic()
with an address potentially at an offset from the page that was kmap'ed.
While currently harmless, perhaps for correctness:

 			pmap = kmap_atomic(iv.bv_page);
			p = pmap + iv.bv_offset;
