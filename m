From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 16 May 2017 09:38:25 +0200
Subject: [PATCH v2 06/10] nvmet_fc: Reduce work_q count
In-Reply-To: <20170516001024.5281-7-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-7-jsmart2021@gmail.com>
Message-ID: <fcdbfb78-02fd-6f9e-2dc9-c604a2de6c65@suse.de>

On 05/16/2017 02:10 AM, James Smart wrote:
> Instead of a work_q per controller queue, make 1 per cpu and have
> controller queues post work elements to the work_q.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
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
