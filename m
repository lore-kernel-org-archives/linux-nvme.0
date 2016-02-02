From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 16:49:15 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
 <1454417099-19332-3-git-send-email-sagig@mellanox.com>
 <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160202164915.GB10728@localhost.localdomain>

On Tue, Feb 02, 2016@04:32:33PM +0000, Wenbo Wang wrote:
> If some requests are in q->request_list or ctx->rq_list, does nvme_cancel_io remove them from these lists? If not, will it cause any issue?

It's fine to let them queue there if we expect to restart the
controller. We're going to restart the queues shortly.

If we're about to kill the queue, blk-mq's timeout handler kills
unstarted requests.
