From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:45:21 +0200
Subject: [PATCH rfc 16/30] nvme-rdma: move tagset allocation to a
 dedicated routine
In-Reply-To: <1497799324-19598-17-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-17-git-send-email-sagi@grimberg.me>
Message-ID: <20170619124521.GP29061@lst.de>

Looks fine, but how about doing this early in the series?  There's
quite a bit of churn around this code.
