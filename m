From: hare@suse.de (Hannes Reinecke)
Date: Thu, 27 Oct 2016 07:49:13 +0200
Subject: [PATCH 03/12] blk-mq: Introduce blk_mq_queue_stopped()
In-Reply-To: <f68b2997-8b0d-7aea-2859-5fbda4f6bf71@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <f68b2997-8b0d-7aea-2859-5fbda4f6bf71@sandisk.com>
Message-ID: <d1afa90c-b1ee-8185-0fac-40a812ed195c@suse.de>

On 10/27/2016 12:52 AM, Bart Van Assche wrote:
> The function blk_queue_stopped() allows to test whether or not a
> traditional request queue has been stopped. Introduce a helper
> function that allows block drivers to query easily whether or not
> one or more hardware contexts of a blk-mq queue have been stopped.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>  block/blk-mq.c         | 20 ++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 21 insertions(+)
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
