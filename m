From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:41:19 +0200
Subject: [PATCH v2 09/10] nvme_fcloop: fix port deletes and callbacks
In-Reply-To: <20170516001024.5281-10-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-10-jsmart2021@gmail.com>
Message-ID: <517ddff2-1e1e-f07d-bcd9-51502437de3b@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
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
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> ---

Thanks,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
