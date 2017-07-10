From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 16:51:23 -0700
Subject: [PATCH 4/7] nvme: Centralize blk-mq tag and AEN counts
In-Reply-To: <1499444581-28268-5-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-5-git-send-email-keith.busch@intel.com>
Message-ID: <bdf949a5-6938-c267-9105-eae0b2d87e0e@broadcom.com>

On 7/7/2017 9:22 AM, Keith Busch wrote:
> All the drivers were duplicating AEN accounting, yet they all depend on
> the core to use the exact same settings of a single AEN to be deducted
> from the tagset depth. This patch moves admin queue command accounting
> to the core.
>
>

Looks good.

Reviewed-by: James Smart <james.smart at broadcom.com>
