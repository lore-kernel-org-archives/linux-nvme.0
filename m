From: hare@suse.de (Hannes Reinecke)
Date: Thu, 19 Oct 2017 07:48:02 +0200
Subject: [PATCH 01/17] block: move REQ_NOWAIT
In-Reply-To: <20171018165258.23212-2-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-2-hch@lst.de>
Message-ID: <8895468d-a36a-9f9c-0086-22e058cf5b23@suse.de>

On 10/18/2017 06:52 PM, Christoph Hellwig wrote:
> This flag should be before the operation-specific REQ_NOUNMAP bit.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  include/linux/blk_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
