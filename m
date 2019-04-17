From: hare@suse.de (Hannes Reinecke)
Date: Wed, 17 Apr 2019 14:03:42 +0200
Subject: [PATCH V6 4/9] blk-mq: move all hctx alloction & initialization
 into __blk_mq_alloc_and_init_hctx
In-Reply-To: <20190417034410.31957-5-ming.lei@redhat.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-5-ming.lei@redhat.com>
Message-ID: <37609e16-351a-fc5b-68bf-8ac7cc2608cb@suse.de>

On 4/17/19 5:44 AM, Ming Lei wrote:
> Move all hctx related allocation and initialization into
> __blk_mq_alloc_and_init_hctx, and prepare for splitting blk_mq_alloc_and_init_hctx
> into real two functions, one is for allocate everything, and another is for
> initializing everyting.
> 
> Cc: Dongli Zhang <dongli.zhang at oracle.com>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: linux-scsi at vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen at oracle.com>,
> Cc: Christoph Hellwig <hch at lst.de>,
> Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang at oracle.com>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>   block/blk-mq.c | 93 +++++++++++++++++++++++++++-------------------------------
>   1 file changed, 44 insertions(+), 49 deletions(-)
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
