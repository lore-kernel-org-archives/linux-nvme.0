From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:28:26 +0200
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <1527436222-15494-18-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072826.GL5618@lst.de>

This seems to miss a call to nvme_dif_remap().  Which btw, I'd rather
merge with sd_dif_prepare/sd_dif_complete and move to the block layer.
