From: hare@suse.de (Hannes Reinecke)
Date: Tue, 27 Sep 2016 08:21:40 +0200
Subject: [PATCH 2/9] dm: Fix a race condition related to stopping and
 starting queues
In-Reply-To: <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
Message-ID: <34f2c5c0-1bae-7ce7-9f60-446412ec641e@suse.de>

On 09/26/2016 08:26 PM, Bart Van Assche wrote:
> Ensure that all ongoing dm_mq_queue_rq() and dm_mq_requeue_request()
> calls have stopped before setting the "queue stopped" flag. This
> allows to remove the "queue stopped" test from dm_mq_queue_rq() and
> dm_mq_requeue_request(). This patch fixes a race condition because
> dm_mq_queue_rq() is called without holding the queue lock and hence
> BLK_MQ_S_STOPPED can be set at any time while dm_mq_queue_rq() is
> in progress.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Mike Snitzer <snitzer at redhat.com>
> ---
>  drivers/md/dm-rq.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
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
