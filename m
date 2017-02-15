From: hch@lst.de (hch@lst.de)
Date: Wed, 15 Feb 2017 17:15:23 +0100
Subject: [PATCH] nvmet: Avoid writing fabric_ops, queue pointers on
 every request.
In-Reply-To: <fbe16be7-ed21-d231-471e-cdffe346264b@grimberg.me>
References: <1486507066-23168-1-git-send-email-parav@mellanox.com>
 <5bcb5982-36a6-67f5-8416-45e321235fa9@grimberg.me>
 <VI1PR0502MB3008C2598C5492B2EB4D1E55D1420@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <700fde5d-3b84-2279-4176-c871364d4b97@grimberg.me>
 <VI1PR0502MB3008753C22DDAD6B5C20FC57D1590@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <fbe16be7-ed21-d231-471e-cdffe346264b@grimberg.me>
Message-ID: <20170215161523.GA27837@lst.de>

On Wed, Feb 15, 2017@10:58:32AM +0200, Sagi Grimberg wrote:
> Yep, forgot that the sq/cq are referenced from the rsp which is
> per-queue.
>
> Christoph, James, can I get an ack from you guys?

I really hate the nvmet_req_fabric_ops_init and
nvmet_req_link_to_nvme_queues helpers, just use direct assignments
instead of trivial helpers with crazy long names.

I need to look at it a bit more for the a real review.
