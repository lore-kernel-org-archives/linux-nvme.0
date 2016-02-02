From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 17:25:03 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160202172503.GC10728@localhost.localdomain>

On Tue, Feb 02, 2016@07:15:57AM +0000, Wenbo Wang wrote:
> Jens,
> 
> I did the following test to validate the issue.
> 
> 1. Modify code as below to increase the chance of races.
> 	Add 10s delay after nvme_dev_unmap() in nvme_dev_disable()
> 	Add 10s delay before __nvme_submit_cmd()

If running sync IO, preempt is disabled. You can't just put a 10 second
delay there. Wouldn't you hit a "scheduling while atomic" bug instead?

If blk-mq is running the h/w context from its work queue, that might
be a different issue. Maybe we can change the "cancel_delayed_work" to
"cancel_delayed_work_sync" in blk_mq_stop_hw_queues.

If there's still a window where blk-mq can insert a request after the
driver requested to stop queues, I think we should try to close it with
the block layer.
