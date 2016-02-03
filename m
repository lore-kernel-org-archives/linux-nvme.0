From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Wed, 3 Feb 2016 00:35:55 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <20160202164915.GB10728@localhost.localdomain>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
 <1454417099-19332-3-git-send-email-sagig@mellanox.com>
 <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160202164915.GB10728@localhost.localdomain>
Message-ID: <BJXPR01MB1999CBB2644C70CE07E4B28E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

After canceling these requests, the requests and tags are freed. If queues are restarted shortly, these already freed requests will be queue_rq again? This seems not correct.

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Wednesday, February 3, 2016 12:49 AM
To: Wenbo Wang
Cc: Sagi Grimberg; Jens Axboe; linux-nvme at lists.infradead.org
Subject: Re: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination

On Tue, Feb 02, 2016@04:32:33PM +0000, Wenbo Wang wrote:
> If some requests are in q->request_list or ctx->rq_list, does nvme_cancel_io remove them from these lists? If not, will it cause any issue?

It's fine to let them queue there if we expect to restart the controller. We're going to restart the queues shortly.

If we're about to kill the queue, blk-mq's timeout handler kills unstarted requests.
