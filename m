From: hch@lst.de (Christoph Hellwig)
Date: Tue, 28 Nov 2017 13:36:47 +0100
Subject: [PATCH v3 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <1511370080-23326-1-git-send-email-maxg@mellanox.com>
References: <1511370080-23326-1-git-send-email-maxg@mellanox.com>
Message-ID: <20171128123647.GC30316@lst.de>

Looks good and applied to nvme-4.15.

In the long run I wonder if we want a real queue state machine intead
of the flags..
