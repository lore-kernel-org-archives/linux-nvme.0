From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 10:18:36 +0200
Subject: [PATCH 04/12] blk-mq: Move more code into
 blk_mq_direct_issue_request()
In-Reply-To: <32b0bd88-cb8e-754a-89fc-b1825778b05a@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <32b0bd88-cb8e-754a-89fc-b1825778b05a@sandisk.com>
Message-ID: <20161027081836.e7c5f4whw6uectes@linux-x5ow.site>

On Wed, Oct 26, 2016@03:52:35PM -0700, Bart Van Assche wrote:
> Move the "hctx stopped" test and the insert request calls into
> blk_mq_direct_issue_request(). Rename that function into
> blk_mq_try_issue_directly() to reflect its new semantics. Pass
> the hctx pointer to that function instead of looking it up a
> second time. These changes avoid that code has to be duplicated
> in the next patch.
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
