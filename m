From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 08:58:15 +0200
Subject: [PATCH v2 2/2] nvme: use a single NVME_AQ_DEPTH and relax it to 32
In-Reply-To: <1497791759-5754-2-git-send-email-sagi@grimberg.me>
References: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
 <1497791759-5754-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170619065815.GA12938@lst.de>

Looks fine, and I can't see any good reason for the large number
on PCIe either:

Reviewed-by: Christoph Hellwig <hch at lst.de>
