From: hare@suse.de (Hannes Reinecke)
Date: Thu, 19 Oct 2017 07:48:29 +0200
Subject: [PATCH 02/17] block: add REQ_DRV bit
In-Reply-To: <20171018165258.23212-3-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-3-hch@lst.de>
Message-ID: <74620ec2-91ed-b76d-4bc3-46b5f5e03e14@suse.de>

On 10/18/2017 06:52 PM, Christoph Hellwig wrote:
> Set aside a bit in the request/bio flags for driver use.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  include/linux/blk_types.h | 5 +++++
>  1 file changed, 5 insertions(+)
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
