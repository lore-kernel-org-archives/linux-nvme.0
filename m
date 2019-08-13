From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Aug 2019 19:01:44 +0200
Subject: [PATCHv3] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <20190812075147.79598-1-hare@suse.de>
References: <20190812075147.79598-1-hare@suse.de>
Message-ID: <20190813170144.GA10269@lst.de>

On Mon, Aug 12, 2019@09:51:47AM +0200, Hannes Reinecke wrote:
> If the DNR bit is set we should not retry the command, even if
> the standard status evaluation indicates so.

What problem is this even trying to solve?  Nothing in the
documentation of BLK_STS_TARGET says it should be retried any more
or less than other error code.

If you really care about a retryable vs not retryable distinction
at the block layer we need to propagate the equivalent of the DNR
bit.
