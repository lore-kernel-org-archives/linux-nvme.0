From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 20 Jan 2016 11:56:01 +0200
Subject: [PATCH] NVMe: init nvme queue before enabling irq
In-Reply-To: <BJXPR01MB199909E00F32CCC29F15C43E0C20@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1453265860-31080-1-git-send-email-mail_weber_wang@163.com>
 <20160120090931.GO2742@c203.arch.suse.de>
 <BJXPR01MB199909E00F32CCC29F15C43E0C20@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <569F59B1.3040207@dev.mellanox.co.il>


>> If it can cause a kernel panic shouldn't it go through stable then as well?
>
> Sorry, not quite understand this comment.
> The "reset process" is the nvme device reset process (performed by nvme_reset_work()) triggered by device fail condition.
> During normal boot up, nvmeq door bell is initialized in nvme_alloc_queue() which happens before enabling irq, so there is no error.
> During nvme device reset process, nvme_alloc_queue() is skipped and the race condition exists.

I think what Johannes meant was that this patch should include a
"CC: stable at vger.kernel.org" tag.
