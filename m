From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 15:57:07 +0200
Subject: [PATCH] nvmet: Use direct IO for writes
In-Reply-To: <1474481450-5036-1-git-send-email-sagi@grimberg.me>
References: <1474481450-5036-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160922135707.GA14645@lst.de>

On Wed, Sep 21, 2016@11:10:50AM -0700, Sagi Grimberg wrote:
> We're designed to work with high-end devices where
> direct IO makes perfect sense. We noticed that we
> context switch by scheduling kblockd instead of going
> directly to the device without REQ_SYNC for writes.

This looks reasonable.  But I still wonder why we bother to inject delay
for any fast blk-mq device (background: Sagi told me he is observing
issues without this on a NVMe PCIe card backend)
