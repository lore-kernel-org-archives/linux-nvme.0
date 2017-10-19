From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 17:07:50 +0200
Subject: [PATCH v2 4.14-rc fix-regression] nvme-rdma: Fix possible
 double free in reconnect flow
In-Reply-To: <1508418030-23031-1-git-send-email-sagi@grimberg.me>
References: <1508418030-23031-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171019150750.GA24204@lst.de>

Applied to nvme-4.14 after fixing this:

> +	if(nvme_rdma_queue_idx(queue) == 0)

whitespace issue and adding some curly braces.
