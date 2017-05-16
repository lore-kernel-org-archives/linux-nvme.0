From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:32:38 +0200
Subject: [PATCH v2 01/10] nvme_fc: get rid of local reconnect_delay
In-Reply-To: <20170516001024.5281-2-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-2-jsmart2021@gmail.com>
Message-ID: <ba936229-2b54-398a-54d0-f74a6da87112@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
> Remove the local copy of reconnect_delay.
> Use the value in the controller options directly.
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
