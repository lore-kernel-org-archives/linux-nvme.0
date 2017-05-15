From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:21:25 +0200
Subject: [PATCH 02/10] nvme_fc: Support ctrl_loss_tmo
In-Reply-To: <20170513190309.25417-3-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-3-jsmart2021@gmail.com>
Message-ID: <8982f301-c151-fb0a-68a4-710b81cce8eb@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> Sync with Sagi's recent addition of ctrl_loss_tmo in the core fabrics
> layer.
> 
> Remove local connect limits and connect_attempts variable.
> Use fabrics new nr_connects variable and use of nvmf_should_reconnect()
> Refactor duplicate reconnect failure code.
> 
> Addresses review comment by Sagi on controller reset support:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 116 +++++++++++++++++++++----------------------------
>  1 file changed, 49 insertions(+), 67 deletions(-)
> 
Makes one wonder if we shouldn't move the entire 'dev_loss_tmo' thingie
into the block-layer altogether ...
Anyway:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
