From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Apr 2018 15:37:30 +0200
Subject: [PATCH 2/2 v3] nvme-rdma: Fix command completion race at error
 recovery
In-Reply-To: <1523462824-25643-3-git-send-email-israelr@mellanox.com>
References: <1523462824-25643-1-git-send-email-israelr@mellanox.com>
 <1523462824-25643-3-git-send-email-israelr@mellanox.com>
Message-ID: <20180412133730.GB5791@lst.de>

We really need to keep this code in sync with the various transports,
chances are any race you see in RDMA will happen elsewhere as well.
