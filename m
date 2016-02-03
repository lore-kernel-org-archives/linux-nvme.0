From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Feb 2016 01:26:39 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <BJXPR01MB1999CBB2644C70CE07E4B28E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
 <1454417099-19332-3-git-send-email-sagig@mellanox.com>
 <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160202164915.GB10728@localhost.localdomain>
 <BJXPR01MB1999CBB2644C70CE07E4B28E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160203012638.GC21046@localhost.localdomain>

On Wed, Feb 03, 2016@12:35:55AM +0000, Wenbo Wang wrote:
> After canceling these requests, the requests and tags are freed. If queues are restarted shortly, these already freed requests will be queue_rq again? This seems not correct.

That's not true. We only set DNR if the queue is dead. Otherwise the
requests are eligible for requeuing if they haven't exceeded total time.
