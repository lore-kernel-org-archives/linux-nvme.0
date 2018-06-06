From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 14:31:52 +0200
Subject: [PATCH v4 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <be1138dce21044c9f3249a519f6049dcd7756c99.1528219321.git.swise@opengridcomputing.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <be1138dce21044c9f3249a519f6049dcd7756c99.1528219321.git.swise@opengridcomputing.com>
Message-ID: <20180606123152.GB13736@lst.de>

On Tue, Jun 05, 2018@10:16:41AM -0700, Steve Wise wrote:
> The code was checking bit 20 instead of bit 2.  Also fixed the log entry.
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>

Thanks, added to nvme-4.18.
