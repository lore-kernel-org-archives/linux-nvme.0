From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:40:55 +0200
Subject: [PATCH v2 08/10] nvme_fc: remove extra controller reference taken
 on reconnect
In-Reply-To: <20170516001024.5281-9-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-9-jsmart2021@gmail.com>
Message-ID: <9a80e931-454d-c4bf-620d-1b2078b23919@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
> fix extra controller reference taken on reconnect by moving
> reference to initial controller create
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
