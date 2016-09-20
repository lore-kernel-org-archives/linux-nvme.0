From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Sep 2016 22:08:03 +0200
Subject: [PATCH] nvme-rdma: Fix early queue flags settings
In-Reply-To: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
References: <1474397848-19013-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160920200803.GA839@lst.de>

On Tue, Sep 20, 2016@11:57:28AM -0700, Sagi Grimberg wrote:
> When we reconnect we can't really clear the
> queue flags (DELETING flag in specific) because
> we might end up trigerring a use-after-free condition
> if we fail to establish the rdma connection.

Can you add a comment explaining this to the assignment?  Looking
at the patch it looks like black magic to be, and that's even
after reading the above changelog..
