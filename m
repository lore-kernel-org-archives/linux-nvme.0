From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 21:35:28 +0200
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <20170113074420.GA25814@lst.de>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
Message-ID: <9a459692-05dc-bfc8-e08e-8bb7c5a99ac8@grimberg.me>


> This seems like a fix for 4.10-rc as the old code is buggy on
> not DMA coherent architectures, so I suspect it should go in without
> being based on Barts cleanup.

It does,

We should also give it a stable 4.8+ tag.

I'll queue this for nvme rc4 pull-req.
