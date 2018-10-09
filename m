From: james.smart@broadcom.com (James Smart)
Date: Tue, 9 Oct 2018 11:41:52 -0700
Subject: [PATCH 08/16] nvme-fc: Rework the request initialization code
In-Reply-To: <20181008212854.68310-9-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
 <20181008212854.68310-9-bvanassche@acm.org>
Message-ID: <05c37494-6030-911b-69c6-b539201a8521@broadcom.com>



On 10/8/2018 2:28 PM, Bart Van Assche wrote:
> Instead of setting and then clearing the first_sgl pointer for AEN requests,
> leave that pointer zero. This patch does not change how requests are
> initialized but avoids that Coverity reports the following complaint for
> nvme_fc_init_aen_ops():
>
> CID 1418400 (#1 of 1): Out-of-bounds access (OVERRUN)
> 4. overrun-buffer-val: Overrunning buffer pointed to by aen_op of 312 bytes by passing it to a function which accesses it at byte offset 312.
>
> Cc: James Smart <james.smart at broadcom.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>


Looks good.

Reviewed-by:? James Smart <james.smart at broadcom.com>
