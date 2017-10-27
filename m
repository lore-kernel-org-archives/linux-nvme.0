From: hare@suse.de (Hannes Reinecke)
Date: Fri, 27 Oct 2017 09:16:06 +0200
Subject: [PATCH v4 5/5] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <20171025234317.13302-6-jsmart2021@gmail.com>
References: <20171025234317.13302-1-jsmart2021@gmail.com>
 <20171025234317.13302-6-jsmart2021@gmail.com>
Message-ID: <d79f9cf9-a910-4dfb-3cf1-d26a6c0326a5@suse.de>

On 10/26/2017 01:43 AM, James Smart wrote:
> This patch adds the dev_loss_tmo functionality to the transport.
> 
> When a remoteport is unregistered (connectivity lost), the following
> actions are taken:
> - the remoteport is marked DELETED
> - the time when dev_loss_tmo would expire is set in the remoteport
> - all controllers on the remoteport are reset.
> 
> After a controller resets, it will stall in a RECONNECTING state
> waiting for one of the following:
> - the controller will continue to attempt reconnect per max_retries
>   and reconnect_delay. As no remoteport connectivity, the reconnect
>   attempt will immediately fail. if max reconnects has not been
>   reached, a new reconnect_delay timer will be schedule. If the
>   current time plus another reconnect_delay exceeds when dev_loss_tmo
>   expires on the remote port, then the reconnect_delay will be
>   shortend to schedule no later than when dev_loss_tmo expires.
>   if max reconnect attempts are reached (e.g. ctrl_loss_tmo reached)
>   or dev_loss_tmo ix exceeded without connectivity, the controller
>   is deleted.
> - the remoteport is re-registered prior to dev_loss_tmo expiring.
>   The resume of the remoteport will immediately attempt to reconnect
>   each of its suspended controllers.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 281 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 242 insertions(+), 39 deletions(-)
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
