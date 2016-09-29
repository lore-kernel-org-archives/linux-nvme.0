From: hare@suse.de (Hannes Reinecke)
Date: Thu, 29 Sep 2016 07:52:01 +0200
Subject: [PATCH v2 4/7] blk-mq: Introduce blk_quiesce_queue() and
 blk_resume_queue()
In-Reply-To: <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com>
Message-ID: <6bc9d7e6-3db0-6bc5-b7cf-668278367303@suse.de>

On 09/29/2016 01:59 AM, Bart Van Assche wrote:
> blk_quiesce_queue() prevents that new queue_rq() invocations
> occur and waits until ongoing invocations have finished. This
> function does *not* wait until all outstanding requests have
> finished (this means invocation of request.end_io()).
> blk_resume_queue() resumes normal I/O processing.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  block/blk-mq.c         | 137 ++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/blk-mq.h |   2 +
>  include/linux/blkdev.h |   5 ++
>  3 files changed, 131 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
