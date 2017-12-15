From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Dec 2017 06:53:23 -0800
Subject: [PATCH] NVMe: Format fix when going from 4k sector size to 512
 bytes
In-Reply-To: <yq1fu8cmyvo.fsf@oracle.com>
References: <20171214204936.17793-1-jeff.lien@wdc.com>
 <yq1fu8cmyvo.fsf@oracle.com>
Message-ID: <20171215145323.GA16214@infradead.org>

On Thu, Dec 14, 2017@10:52:11PM -0500, Martin K. Petersen wrote:
> 
> Jeff,
> 
> > +	blk_queue_logical_block_size(disk->queue, bs);
> > +	blk_queue_physical_block_size(ns->queue, bs);
> 
> A bit messy that you mix ns->queue and disk->queue.

It's not just ugly, but actually broken.  We must use disk->queue
both times to correctly handle multipathing.
