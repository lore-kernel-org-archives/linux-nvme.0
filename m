From: keith.busch@intel.com (Keith Busch)
Date: Thu, 4 Feb 2016 15:44:54 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <BJXPR01MB19990484665533561B21DB3E0D10@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
 <1454417099-19332-3-git-send-email-sagig@mellanox.com>
 <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160202164915.GB10728@localhost.localdomain>
 <BJXPR01MB1999CBB2644C70CE07E4B28E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203012638.GC21046@localhost.localdomain>
 <BJXPR01MB19990484665533561B21DB3E0D10@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160204154454.GB28747@localhost.localdomain>

On Thu, Feb 04, 2016@02:28:24PM +0000, Wenbo Wang wrote:
> Is the following execution valid?
> 
> 1. request A is linked in q->request_list

q->request_list? Do you mean q->requeue_list?

> 2. device reset
> 3. all requests (including request A) are cancelled by nvme_dev_disable()->nvme_clear_queue()

If the request is on some list owned by the request_queue, it was not
started by the driver, and nvme_clear_queue doesn't do anything to it.

> 4. device restarted
> 5. flush q->request_list, and request A is again running in queue_rq.         <-- since request A has been cancelled, it shall not be running again

Request A was not cancelled if it was never started. It will be submitted
when the driver restarts the queues h/w contexts.

Cancelling a command with the controller does not mean ending the request
in the block layer.
