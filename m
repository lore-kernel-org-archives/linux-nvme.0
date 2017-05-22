From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 22 May 2017 09:43:11 +0200
Subject: [PATCH v2 3/3] blk-mq: remove blk_mq_abort_requeue_list()
In-Reply-To: <20170520035605.21785-4-ming.lei@redhat.com>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-4-ming.lei@redhat.com>
Message-ID: <36461789-9377-a245-0920-5e6ee671f5bb@suse.de>

On 05/20/2017 05:56 AM, Ming Lei wrote:
> No one uses it any more, so remove it.
> 
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
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
