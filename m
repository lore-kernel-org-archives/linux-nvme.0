From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Feb 2017 09:31:10 +0100
Subject: [PATCHv1] nvmet-rdma: Support 16K worth of inline data for
 write commands
In-Reply-To: <1486507882-23688-1-git-send-email-parav@mellanox.com>
References: <1486507882-23688-1-git-send-email-parav@mellanox.com>
Message-ID: <20170208083110.GC7629@lst.de>

Hi Parav,

I like this in principle, but I'm really worried about the resource
consumption of just enabling this by default.  I think we need
a tunable in configfs for the max inline data, and for the queue
depth at least, and maybe reduce the queue depth a bit by default
to compensate for the much higher per-queue memory usage.
