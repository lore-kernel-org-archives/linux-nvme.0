From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Aug 2018 13:46:13 +0200
Subject: [PATCH] nvme: fixup crash on failed discovery
In-Reply-To: <20180807104342.44367-1-hare@suse.de>
References: <20180807104342.44367-1-hare@suse.de>
Message-ID: <20180807114613.GA8905@lst.de>

On Tue, Aug 07, 2018@12:43:42PM +0200, Hannes Reinecke wrote:
> When the initial discovery fails the subsystem hasn't been setup,
> and we'll encounter a kernel oops during shutdown.

This looks ok, but I'm curious where we even call nvme_ctrl_use_ana
if we fail early.
