From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 13 Jan 2017 21:42:43 +0200
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <1484261109-3316-1-git-send-email-parav@mellanox.com>
 <20170113074420.GA25814@lst.de>
 <VI1PR0502MB30086F641A07262801C02A28D1780@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <1f8d3db6-03b7-6c8f-8010-4ab964a87f3c@grimberg.me>


> Doug needs to rebase to above git tree.
> Followed by Bart's patches, followed by my changes in his tree.
> Without that, Linux-next will get compile error because ib_dma_xx won't be defined.
> Let me know, I have 4.10-rc patch also tested.

No need, we'll jest keep the patch as is, no compile error
will generate.
