From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 10:15:08 +0200
Subject: [PATCH 02/12] blk-mq: Introduce blk_mq_hctx_stopped()
In-Reply-To: <0de50789-e3b7-0a07-73c1-4fb87b1f957e@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <0de50789-e3b7-0a07-73c1-4fb87b1f957e@sandisk.com>
Message-ID: <20161027081508.6tip6extcglzacyw@linux-x5ow.site>

On Wed, Oct 26, 2016@03:51:33PM -0700, Bart Van Assche wrote:
> Multiple functions test the BLK_MQ_S_STOPPED bit so introduce
> a helper function that performs this test.
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
