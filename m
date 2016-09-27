From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 27 Sep 2016 09:47:34 +0200
Subject: [PATCH 2/9] dm: Fix a race condition related to stopping and
 starting queues
In-Reply-To: <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
Message-ID: <20160927074734.pbgz4bbb7xpnkxre@linux-x5ow.site>

On Mon, Sep 26, 2016@11:26:50AM -0700, Bart Van Assche wrote:
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

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
