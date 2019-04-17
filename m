From: hare@suse.de (Hannes Reinecke)
Date: Wed, 17 Apr 2019 14:02:55 +0200
Subject: [PATCH V6 3/9] blk-mq: free hw queue's resource in hctx's release
 handler
In-Reply-To: <20190417034410.31957-4-ming.lei@redhat.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-4-ming.lei@redhat.com>
Message-ID: <ec6aed0d-a6dc-f829-46f4-10140c7c37df@suse.de>

On 4/17/19 5:44 AM, Ming Lei wrote:
> Once blk_cleanup_queue() returns, tags shouldn't be used any more,
> because blk_mq_free_tag_set() may be called. Commit 45a9c9d909b2
> ("blk-mq: Fix a use-after-free") fixes this issue exactly.
> 
> However, that commit introduces another issue. Before 45a9c9d909b2,
> we are allowed to run queue during cleaning up queue if the queue's
> kobj refcount is held. After that commit, queue can't be run during
> queue cleaning up, otherwise oops can be triggered easily because
> some fields of hctx are freed by blk_mq_free_queue() in blk_cleanup_queue().
> 
> We have invented ways for addressing this kind of issue before, such as:
> 
> 	8dc765d438f1 ("SCSI: fix queue cleanup race before queue initialization is done")
> 	c2856ae2f315 ("blk-mq: quiesce queue before freeing queue")
> 
> But still can't cover all cases, recently James reports another such
> kind of issue:
> 
> 	https://marc.info/?l=linux-scsi&m=155389088124782&w=2
> 
> This issue can be quite hard to address by previous way, given
> scsi_run_queue() may run requeues for other LUNs.
> 
> Fixes the above issue by freeing hctx's resources in its release handler, and this
> way is safe becasue tags isn't needed for freeing such hctx resource.
> 
> This approach follows typical design pattern wrt. kobject's release handler.
> 
> Cc: Dongli Zhang <dongli.zhang at oracle.com>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: linux-scsi at vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen at oracle.com>,
> Cc: Christoph Hellwig <hch at lst.de>,
> Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang at oracle.com>
> Reported-by: James Smart <james.smart at broadcom.com>
> Fixes: 45a9c9d909b2 ("blk-mq: Fix a use-after-free")
> Cc: stable at vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>   block/blk-core.c     | 2 +-
>   block/blk-mq-sysfs.c | 6 ++++++
>   block/blk-mq.c       | 8 ++------
>   block/blk-mq.h       | 2 +-
>   4 files changed, 10 insertions(+), 8 deletions(-)
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
