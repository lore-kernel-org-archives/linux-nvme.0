From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Apr 2016 10:41:52 +0200
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <1461619219-18144-2-git-send-email-mlin@kernel.org>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
Message-ID: <20160426084152.GA1904@lst.de>

On Mon, Apr 25, 2016@02:20:18PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> Switch to RCU freeing the namespace structure so that
> nvme_start_queues, nvme_stop_queues and nvme_kill_queues would
> be able to get away with only a RCU read side critical section.
> 
> Suggested-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
