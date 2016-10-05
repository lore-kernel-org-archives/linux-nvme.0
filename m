From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Oct 2016 15:42:05 +0200
Subject: [PATCH rfc 4/6] nvme: don't consume cq in queue_rq
In-Reply-To: <1475660534-16681-5-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-5-git-send-email-sagi@grimberg.me>
Message-ID: <20161005134205.zxlpp5o4wfnqqzuy@linux-x5ow.site>

On Wed, Oct 05, 2016@12:42:12PM +0300, Sagi Grimberg wrote:
> Now that we have irq-poll we don't need to flow
> control our queues from the submission path. It
> doesn't make sense to completely drain the completion
> queue for each submit (or budgeting it either).
> 
> Also, now we can remove the forward declaration of
> nvme_process_cq.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
