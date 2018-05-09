From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 May 2018 09:31:45 +0200
Subject: [PATCH 4/5] block: BLK_STS_NEXUS is a path failure
In-Reply-To: <20180504112845.38820-5-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-5-hare@suse.de>
Message-ID: <20180509073145.GC20363@lst.de>

On Fri, May 04, 2018@01:28:44PM +0200, Hannes Reinecke wrote:
> A block error of BLK_STS_NEXUS is equivalent to a path failure,
> so blk_path_error() should reflect this.

BLK_STS_NEXUS is the replacement of -EBADE, which in the old
world order was labelled 'critical nexus"' and is claim to be
used for reservation conflicts, in which case we should not rety
on another path.
