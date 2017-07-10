From: james.smart@broadcom.com (James Smart)
Date: Mon, 10 Jul 2017 16:53:08 -0700
Subject: [PATCH 5/7] nvme: Only one AEN request
In-Reply-To: <1499444581-28268-6-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-6-git-send-email-keith.busch@intel.com>
Message-ID: <f0eb9803-05f7-e2bf-ee6f-c93743606fcf@broadcom.com>

On 7/7/2017 9:22 AM, Keith Busch wrote:
> This driver issues only one AEN request, so all the logic to handle
> multiple ones is unnecessary. Even if we did allow multiple ones, the
> implementation is broken as it will create command id collisions. For
> those two reasons, this patch deletes all the aer index usage, assuming
> there's only one.
>
> As a consequence of removing the event limit, the core's callback for
> these events is simplified to only handle the successful case. The
> "abort" status handling for AER has been broken for some time anyway:
> it was meant to reclaim the aer count from a driver cancelled command
> after a reset, but that was relying on blk-mq to manage the reserved
> tags. We don't use blk-mq tags for AER, though, so we will never see a
> synthesized abort status.
>

Looks good

Reviewed-by: James Smart  <james.smart at broadcom.com>
