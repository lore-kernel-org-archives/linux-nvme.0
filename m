From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Thu, 4 Feb 2016 14:28:24 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <20160203012638.GC21046@localhost.localdomain>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
 <1454417099-19332-3-git-send-email-sagig@mellanox.com>
 <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160202164915.GB10728@localhost.localdomain>
 <BJXPR01MB1999CBB2644C70CE07E4B28E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203012638.GC21046@localhost.localdomain>
Message-ID: <BJXPR01MB19990484665533561B21DB3E0D10@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Is the following execution valid?

1. request A is linked in q->request_list
2. device reset
3. all requests (including request A) are cancelled by nvme_dev_disable()->nvme_clear_queue()
4. device restarted
5. flush q->request_list, and request A is again running in queue_rq.         <-- since request A has been cancelled, it shall not be running again

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, February 3, 2016 9:27 AM
To: Wenbo Wang
Cc: Sagi Grimberg; Jens Axboe; linux-nvme at lists.infradead.org
Subject: Re: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination

On Wed, Feb 03, 2016@12:35:55AM +0000, Wenbo Wang wrote:
> After canceling these requests, the requests and tags are freed. If queues are restarted shortly, these already freed requests will be queue_rq again? This seems not correct.

That's not true. We only set DNR if the queue is dead. Otherwise the requests are eligible for requeuing if they haven't exceeded total time.
