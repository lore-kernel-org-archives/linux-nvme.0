From: hare@suse.de (Hannes Reinecke)
Date: Thu, 27 Oct 2016 07:50:12 +0200
Subject: [PATCH 04/12] blk-mq: Move more code into
 blk_mq_direct_issue_request()
In-Reply-To: <32b0bd88-cb8e-754a-89fc-b1825778b05a@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <32b0bd88-cb8e-754a-89fc-b1825778b05a@sandisk.com>
Message-ID: <65a0c5f7-4650-14ea-3d28-b1a8e338b97b@suse.de>

On 10/27/2016 12:52 AM, Bart Van Assche wrote:
> Move the "hctx stopped" test and the insert request calls into
> blk_mq_direct_issue_request(). Rename that function into
> blk_mq_try_issue_directly() to reflect its new semantics. Pass
> the hctx pointer to that function instead of looking it up a
> second time. These changes avoid that code has to be duplicated
> in the next patch.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  block/blk-mq.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
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
