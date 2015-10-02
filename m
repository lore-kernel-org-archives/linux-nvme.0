From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 21:27:28 +0000 (UTC)
Subject: [PATCH 4/7] nvme: merge nvme_dev_start, nvme_dev_resume and
 nvme_async_probe
In-Reply-To: <1443808699-4738-5-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-5-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510022119550.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> And give the resulting function a sensible name.  This keeps all the
> error handling in a single place and will allow for further improvements
> to it.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

This, and the next patch by extension, are in conflict with the
linux-block/for-linus. We had to move where the irq affinity hint
is set due to the scanning occuring in yet-another-work-queue.

The simplication is great though, feel free to add my review if you
spin another.

Reviewed-by: Keith Busch <keith.busch at intel.com>
