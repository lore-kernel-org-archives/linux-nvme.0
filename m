From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:26:03 +0200
Subject: [PATCH 05/10] nvme_fc: set logging level on resets/deletes
In-Reply-To: <20170513190309.25417-6-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-6-jsmart2021@gmail.com>
Message-ID: <91ace3cc-5206-6366-db4b-5248f4b62ac9@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> Per the review by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Looked at existing warn vs info vs err dev_xxx levels for the messages
> printed on reconnects and deletes:
> - Resets due to error and resets transitioned to deletes are dev_warn
> - Other reset/disconnect messages are dev_info
> - Removed chatty io queue related messages
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> this is version 2 of the patch:
> v2: remove admin-requested delete info message as deletes are common
>  for discovery controllers
> 
>  drivers/nvme/host/fc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
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
