From: hch@lst.de (Christoph Hellwig)
Date: Mon, 6 Nov 2017 17:48:39 +0100
Subject: [PATCH] nvme-rdma: Use mr pool
In-Reply-To: <1509982181-6340-1-git-send-email-israelr@mellanox.com>
References: <1509982181-6340-1-git-send-email-israelr@mellanox.com>
Message-ID: <20171106164839.GA27494@lst.de>

Do you have any performance numbers for this change?

Also we shouldn't need the hack for the flush special case in
nvme_rdma_post_send once we stop embedding the MR in struct request.
