From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 16:16:23 +0200
Subject: [PATCH 1/3] RDMA/device: Fix device removal notification when
 ib_clients set .add callout to NULL
In-Reply-To: <1498644338-19719-2-git-send-email-sagi@grimberg.me>
References: <1498644338-19719-1-git-send-email-sagi@grimberg.me>
 <1498644338-19719-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170628141623.GB1894@lst.de>

The subject looks a bit odd to me, I'd say something like

RDMA/core: make ib_device.add method optional

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
