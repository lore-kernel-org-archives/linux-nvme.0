From: hare@suse.de (Hannes Reinecke)
Date: Thu, 27 Oct 2016 07:48:12 +0200
Subject: [PATCH 02/12] blk-mq: Introduce blk_mq_hctx_stopped()
In-Reply-To: <0de50789-e3b7-0a07-73c1-4fb87b1f957e@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <0de50789-e3b7-0a07-73c1-4fb87b1f957e@sandisk.com>
Message-ID: <68cef993-c450-69cc-f238-37535ca3b01d@suse.de>

On 10/27/2016 12:51 AM, Bart Van Assche wrote:
> Multiple functions test the BLK_MQ_S_STOPPED bit so introduce
> a helper function that performs this test.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  block/blk-mq.c | 12 ++++++------
>  block/blk-mq.h |  5 +++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
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
