From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 20 Jan 2016 11:22:28 +0100
Subject: [PATCH] NVMe: init nvme queue before enabling irq
In-Reply-To: <569F59B1.3040207@dev.mellanox.co.il>
References: <1453265860-31080-1-git-send-email-mail_weber_wang@163.com>
 <20160120090931.GO2742@c203.arch.suse.de>
 <BJXPR01MB199909E00F32CCC29F15C43E0C20@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <569F59B1.3040207@dev.mellanox.co.il>
Message-ID: <20160120102228.GP2742@c203.arch.suse.de>

On Wed, Jan 20, 2016@11:56:01AM +0200, Sagi Grimberg wrote:
> 
> >>If it can cause a kernel panic shouldn't it go through stable then as well?
> >
> >Sorry, not quite understand this comment.
> >The "reset process" is the nvme device reset process (performed by nvme_reset_work()) triggered by device fail condition.
> >During normal boot up, nvmeq door bell is initialized in nvme_alloc_queue() which happens before enabling irq, so there is no error.
> >During nvme device reset process, nvme_alloc_queue() is skipped and the race condition exists.
> 
> I think what Johannes meant was that this patch should include a
> "CC: stable at vger.kernel.org" tag.
> 

Exactly. This makes work for us distribution people a lot easier (i.e. we do
not have to manually scan all commits and decide if we need to backport a
patch or not)

Thanks

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
