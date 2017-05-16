From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:35:05 +0200
Subject: [PATCH v2 05/10] nvme_fc: set logging level on resets/deletes
In-Reply-To: <20170516001024.5281-6-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-6-jsmart2021@gmail.com>
Message-ID: <247183dd-767a-42e2-1425-e24df346d406@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
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
