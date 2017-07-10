From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 16:40:50 -0700
Subject: [PATCH 2/7] nvme/fc: Fix admin queue depth setup
In-Reply-To: <1499444581-28268-3-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-3-git-send-email-keith.busch@intel.com>
Message-ID: <f7b3a218-cb76-f1f7-3ece-22bde0c88cfe@broadcom.com>

On 7/7/2017 9:22 AM, Keith Busch wrote:
> The NVME_FC_AQ_BLKMQ_DEPTH is one less than what we actually want the
> admin queue's depth to be since it subtracts the AEN entry.
>
> We also need to subtract 1 from the blk-mq depth to always leave an
> empty queue entry, and to not collide command id with the AEN request.

I don't have an issue with what changed, but have a few comments.

Why not kill the NVME_FC_NR_AEN_COMMANDS define and  correct the 
NVME_FC_AQ_BLKMQ_DEPTH define with NVME_NR_AERS as well ?

Given AEN_CMDID_BASE is NVME_FC_AQ_BLKMQ_DEPTH + 1 there never should 
have been a collision regardless.

Agree with the -1 for empty queue levels. Although the reserved tag for 
Connect assured it was never an issue.

Note: the logic for the above are in the rdma transport as well.

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
