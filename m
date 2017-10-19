From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 15:52:32 +0200
Subject: [PATCH 4.14-rc fix-regression] nvme-rdma: Fix possible double
 free in reconnect flow
In-Reply-To: <1508410857-13678-1-git-send-email-sagi@grimberg.me>
References: <1508410857-13678-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171019135232.GC21452@lst.de>

> +	if(nvme_rdma_queue_idx(queue) == 0)

missing space before the opening brace, but I can fix that up.
