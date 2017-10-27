From: james.smart@broadcom.com (James Smart)
Date: Fri, 27 Oct 2017 13:09:46 -0700
Subject: [PATCH 2/3] nvme-fc: Check if queue is ready in queue_rq
In-Reply-To: <1508847922-26699-3-git-send-email-sagi@grimberg.me>
References: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
 <1508847922-26699-3-git-send-email-sagi@grimberg.me>
Message-ID: <8283bcee-394e-af25-b6ce-bf48e218d7a2@broadcom.com>

On 10/24/2017 5:25 AM, Sagi Grimberg wrote:
> In case the queue is not LIVE (fully functional
> and connected in the nvmf level), we cannot
> allow any commands other than connect to pass
> through.
>
> Add a new queue state flag NVME_FC_Q_LIVE which is
> set after nvmf connect and cleared in queue teardown.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>
looks fine

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
