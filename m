From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:11:35 -0700
Subject: [PATCH v6 4/7] nvme: make nvme_report_ns_ids propagate error back
In-Reply-To: <20190813064304.7344-5-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-5-sagi@grimberg.me>
Message-ID: <bf57c09e-be57-19d2-0ab8-adf95021baae@broadcom.com>



On 8/12/2019 11:43 PM, Sagi Grimberg wrote:
> And make the callers check the return status and propagate
> back accordingly. Also print the return status.
>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
>
>


Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
