From: hch@lst.de (Christoph Hellwig)
Date: Sun, 6 Nov 2016 17:43:54 +0100
Subject: [PATCH] nvmet-rdma: add queue to queue list only if connection
 established
In-Reply-To: <1478425690-32460-1-git-send-email-sagi@grimberg.me>
References: <1478425690-32460-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161106164354.GH15675@lst.de>

On Sun, Nov 06, 2016@11:48:10AM +0200, Sagi Grimberg wrote:
> In case we accepted a queue connection and it failed, we might not
> remove the queue from the list. Instead of dealing with it, simply
> add the insert the queue only if we successfully established.

But that means we'd potentionally leak it when unloading the module,
if that happens at just the wrong time, don't we?
