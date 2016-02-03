From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Feb 2016 16:38:09 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <BJXPR01MB1992FFD0706FCD368F5AD16E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203144123.GB23910@localhost.localdomain>
 <BJXPR01MB1992FFD0706FCD368F5AD16E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160203163808.GC23910@localhost.localdomain>

On Wed, Feb 03, 2016@04:35:03PM +0000, Wenbo Wang wrote:
> For async io (executed by run_work worker) it should work. However for sync io in blk_mq_run_hw_queue, this seems not help, there is still a window.

Alright, for lack of a better way to sync a stopped queue, the driver's
indication looks like the best we can do at this point.
