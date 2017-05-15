From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:20:02 +0200
Subject: [PATCH 01/10] nvme_fc: get rid of local reconnect_delay
In-Reply-To: <20170513190309.25417-2-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-2-jsmart2021@gmail.com>
Message-ID: <11a410ef-e9ab-336e-8b1f-3911627b1d62@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> Remove the local copy of reconnect_delay.
> Use the value in the controller options directly.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/fc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
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
