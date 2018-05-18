From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 18 May 2018 02:09:42 -0700
Subject: [PATCH] nvmet-loop: use nr_phys_segments when map rq to sgl
In-Reply-To: <20180511063815.14911-1-chaitanya.kulkarni@wdc.com>
References: <20180511063815.14911-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180518090942.GB31336@infradead.org>

On Fri, May 11, 2018@02:38:15AM -0400, Chaitanya Kulkarni wrote:
> This patch replaces blk_rq_payload_bytes() with
> blk_rq_nr_phys_segments(). For the payloadless requests like
> write-zeroes it will trigger BUD_ON() at
> sg_alloc_table_chained() since blk_rq_nr_phys_segments()
> will evaluate to 0 due to nature of the request.

Sorry for the noise, actually looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
