From: keith.busch@intel.com (Keith Busch)
Date: Fri, 17 Apr 2015 22:17:45 +0000 (UTC)
Subject: [PATCH v2] nvme: consolidate synchronous command submission
 helpers
In-Reply-To: <1429301274-25034-1-git-send-email-hch@lst.de>
References: <1429301274-25034-1-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1504172208360.32385@localhost.lm.intel.com>

On Fri, 17 Apr 2015, Christoph Hellwig wrote:
> -static int nvme_submit_sync_cmd(struct request *req, struct nvme_command *cmd,
> -						u32 *result, unsigned timeout)
> +int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
> +		u32 *result)

A late catch not even caused by your patch, but can we keep the timeout
param? We should honor the requested timeout for passthrough commands,
and it was already broken before, but will be a one-line fix if we don't
remove it here.
