From: hch@lst.de (Christoph Hellwig)
Date: Thu, 30 Jun 2016 08:31:59 +0200
Subject: [PATCH] nvmet-rdma: fix nvmet_rdma_rsp leak
In-Reply-To: <1467221797-2576-1-git-send-email-mlin@kernel.org>
References: <1467221797-2576-1-git-send-email-mlin@kernel.org>
Message-ID: <20160630063159.GA5191@lst.de>

Thanks a lot Ming,

this looks like the real root cause.  Applied to nvmf-all.3.
