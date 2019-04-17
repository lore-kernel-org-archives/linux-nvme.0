From: hare@suse.de (Hannes Reinecke)
Date: Wed, 17 Apr 2019 14:00:25 +0200
Subject: [PATCH V6 2/9] blk-mq: move cancel of requeue_work into
 blk_mq_release
In-Reply-To: <20190417034410.31957-3-ming.lei@redhat.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-3-ming.lei@redhat.com>
Message-ID: <12f1c64b-c9ad-bc2f-1557-d71d182ca0fd@suse.de>

On 4/17/19 5:44 AM, Ming Lei wrote:
> With holding queue's kobject refcount, it is safe for driver
> to schedule requeue. However, blk_mq_kick_requeue_list() may
> be called after blk_sync_queue() is done because of concurrent
> requeue activities, then requeue work may not be completed when
> freeing queue, and kernel oops is triggered.
> 
> So moving the cancel of requeue_work into blk_mq_release() for
> avoiding race between requeue and freeing queue.
> 
> Cc: Dongli Zhang <dongli.zhang at oracle.com>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: linux-scsi at vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen at oracle.com>,
> Cc: Christoph Hellwig <hch at lst.de>,
> Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang at oracle.com>
> Reviewed-by: Bart Van Assche <bvanassche at acm.org>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>   block/blk-core.c | 1 -
>   block/blk-mq.c   | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
