From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:41:35 +0200
Subject: [PATCH 08/10] nvme_fc: remove extra controller reference taken on
 reconnect
In-Reply-To: <20170513190309.25417-9-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-9-jsmart2021@gmail.com>
Message-ID: <f0eff2b1-1c69-e3a3-1607-1e9238c52376@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> fix extra controller reference taken on reconnect by moving
> reference to initial controller create
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> this is version 3 of the patch:
> v2: per review: moved location of where ref taken
> 
>  drivers/nvme/host/fc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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
