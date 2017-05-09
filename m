From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 9 May 2017 08:54:00 +0200
Subject: [PATCH] nvme_fc: set logging level on resets/deletes
In-Reply-To: <58f12888-7c66-88e2-5a31-3dbb3f3b886d@gmail.com>
References: <20170425223234.3958-1-jsmart2021@gmail.com>
 <552d0a62-d74d-f20b-049f-11338b701c5f@suse.de>
 <58f12888-7c66-88e2-5a31-3dbb3f3b886d@gmail.com>
Message-ID: <43be8f95-d967-7f8e-df34-8133ea9ca1d1@suse.de>

On 05/08/2017 06:35 PM, James Smart wrote:
> On 5/8/2017 2:31 AM, Johannes Thumshirn wrote:
>> Can you maybe change the above two messages to dev_debug()? I have a gut
>> feeling that they might become handy one day.
> 
> After debugging things, I didn't find these providing anything of value,
> thus their deletion. The debug message of the connecting-to subnqn is
> more than enough to derive this (e.g. is it the discovery nqn or not; as
> only discovery ctrl would not attempt io queues), and additional actions
> on the link, as well as messages by the target as it creates queues was
> enough.
> 
> -- james
> 

OK fair enough,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
