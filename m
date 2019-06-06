From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 10:31:26 +0200
Subject: [PATCH 1/1] nvme-rdma: use dynamic dma mapping per command
In-Reply-To: <7db16b61-f29a-2fe9-5e58-8f84d208016e@mellanox.com>
References: <1559749293-32649-1-git-send-email-maxg@mellanox.com>
 <20190606064537.GE27033@lst.de>
 <7db16b61-f29a-2fe9-5e58-8f84d208016e@mellanox.com>
Message-ID: <20190606083126.GA28979@lst.de>

On Thu, Jun 06, 2019@10:38:08AM +0300, Max Gurtovoy wrote:
> But I'm not sure we would like to move it to post_send and add more if/else 
> on the fast path.

We shouldn't need an if / else if we also map the AEN SQE just like
the ones for the normal requests.
