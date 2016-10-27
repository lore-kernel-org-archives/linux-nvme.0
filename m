From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 10:28:36 +0200
Subject: [PATCH 06/12] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
In-Reply-To: <3944826d-bfde-f1e6-40ec-2c9a3c259e3a@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <3944826d-bfde-f1e6-40ec-2c9a3c259e3a@sandisk.com>
Message-ID: <20161027082836.pafo4gosudwc4mix@linux-x5ow.site>

On Wed, Oct 26, 2016@03:53:39PM -0700, Bart Van Assche wrote:
> Most blk_mq_requeue_request() and blk_mq_add_to_requeue_list() calls
> are followed by kicking the requeue list. Hence add an argument to
> these two functions that allows to kick the requeue list. This was
> proposed by Christoph Hellwig.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Christoph Hellwig <hch at lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
