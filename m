From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:46:01 +0200
Subject: [PATCH rfc 17/30] nvme-rdma: move admin specific resources to
 alloc_queue
In-Reply-To: <1497799324-19598-18-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-18-git-send-email-sagi@grimberg.me>
Message-ID: <20170619124601.GQ29061@lst.de>

On Sun, Jun 18, 2017@06:21:51PM +0300, Sagi Grimberg wrote:
> We're trying to make admin queue configuration generic, so
> move the rdma specifics to the queue allocation (based on
> the queue index passed).

Needs at least a comment, and probably factoring into a little
helper.  And once we have that helper it sounds like this might
be a good callout from the core?
