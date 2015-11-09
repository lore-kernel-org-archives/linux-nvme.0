From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Nov 2015 21:43:42 +0000
Subject: [PATCH 07/12] nvme: special case AEN requests
In-Reply-To: <1446885906-20967-8-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-8-git-send-email-hch@lst.de>
Message-ID: <20151109214038.GE5386@localhost.localdomain>

On Sat, Nov 07, 2015@09:45:01AM +0100, Christoph Hellwig wrote:
> +		if (unlikely(nvmeq->qid == 0 &&
> +				cqe.command_id < NVME_NR_AEN_COMMANDS)) {
> +			nvme_finish_aen_cmd(nvmeq->dev, &cqe);
> +			continue;

As long as we're guaranteed the "reserved" tags are the lowest possible
tag values, this'll work. But that seems more coincidence than by design.
