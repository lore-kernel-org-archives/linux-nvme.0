From: hch@lst.de (Christoph Hellwig)
Date: Sun, 6 Nov 2016 20:29:44 +0100
Subject: [PATCH v1] nvmet-rdma: don't forget to delete a queue from the
 list of connection failed
In-Reply-To: <1478453448-17520-1-git-send-email-sagi@grimberg.me>
References: <1478453448-17520-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161106192944.GA18397@lst.de>

On Sun, Nov 06, 2016@07:30:48PM +0200, Sagi Grimberg wrote:
> In case we accepted a queue connection and it failed, we might not
> remove the queue from the list until we unload and clean it up.
> We should delete it from the queue list on the relevant handler.

I think for this to work we'll also need to initialize
->queue_list when allocating the queue.
