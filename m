From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:45:00 +0200
Subject: [PATCH 09/10] nvme_fcloop: fix port deletes and callbacks
In-Reply-To: <20170513190309.25417-10-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-10-jsmart2021@gmail.com>
Message-ID: <a94ab92e-f085-ea86-751b-825ee5a725f1@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> Now that there are potentially long delays between when a
> remoteport or targetport delete calls is made and when the
> callback occurs (dev_loss_tmo timeout), no longer block in the
> delete routines and move the final nport puts to the callbacks.
> 
> Moved the fcloop_nport_get/put/free routines to avoid forward
> declarations.
> 
> Ensure port_info structs used in registrations are nulled in
> case fields are not set (ex: devloss_tmo values).
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> this is version 3 of the patch:
> v2: cut on nvme-4.12
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
