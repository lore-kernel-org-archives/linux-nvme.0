From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Wed, 3 Feb 2016 00:19:46 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <20160202172503.GC10728@localhost.localdomain>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160202172503.GC10728@localhost.localdomain>
Message-ID: <BJXPR01MB19992B07FA623851AC93FB7E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

I used mdelay but not sleep.



-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, February 3, 2016 1:25 AM
To: Wenbo Wang
Cc: Jens Axboe; Wenbo Wang; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org; Wenwei.Tao
Subject: Re: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended

On Tue, Feb 02, 2016@07:15:57AM +0000, Wenbo Wang wrote:
> Jens,
> 
> I did the following test to validate the issue.
> 
> 1. Modify code as below to increase the chance of races.
> 	Add 10s delay after nvme_dev_unmap() in nvme_dev_disable()
> 	Add 10s delay before __nvme_submit_cmd()

If running sync IO, preempt is disabled. You can't just put a 10 second delay there. Wouldn't you hit a "scheduling while atomic" bug instead?

If blk-mq is running the h/w context from its work queue, that might be a different issue. Maybe we can change the "cancel_delayed_work" to "cancel_delayed_work_sync" in blk_mq_stop_hw_queues.

If there's still a window where blk-mq can insert a request after the driver requested to stop queues, I think we should try to close it with the block layer.
