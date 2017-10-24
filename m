From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:05:58 +0200
Subject: [PATCH 03/17] block: provide a direct_make_request helper
In-Reply-To: <20171023145126.2471-4-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-4-hch@lst.de>
Message-ID: <330023d9-b2de-04da-01c5-4d71e910f332@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> This helper allows reinserting a bio into a new queue without much
> overhead, but requires all queue limits to be the same for the upper
> and lower queues, and it does not provide any recursion preventions.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  block/blk-core.c       | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/blkdev.h |  1 +
>  2 files changed, 35 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
