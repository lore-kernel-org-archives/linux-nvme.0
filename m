From: hch@lst.de (Christoph Hellwig)
Date: Sat, 10 Oct 2015 08:55:14 +0200
Subject: [PATCH 1/3] nvme: add missing unmaps in nvme_queue_rq
In-Reply-To: <561851EB.1070503@dev.mellanox.co.il>
References: <1444409756-7317-1-git-send-email-hch@lst.de>
 <1444409756-7317-2-git-send-email-hch@lst.de>
 <561851EB.1070503@dev.mellanox.co.il>
Message-ID: <20151010065514.GB17885@lst.de>

On Sat, Oct 10, 2015@02:46:51AM +0300, Sagi Grimberg wrote:
> Would it be better to unmap the data sg once at error_cmd tag?

We'd need unmap versions of the error_cmd and retry_cmd goto labels,
which was too much churn for this quick fix.  Patch 3 now has a single
exit path with a ret variable for the helper this has been factored out
to, so this has been taken care off there.
