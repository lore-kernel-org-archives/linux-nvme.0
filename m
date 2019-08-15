From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:05:15 -0700
Subject: [PATCH v6 2/7] nvme: return a proper status for sync commands
 failure
In-Reply-To: <20190813064304.7344-3-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-3-sagi@grimberg.me>
Message-ID: <12b07987-4190-d1b9-22b1-468ad9f8f540@broadcom.com>



On 8/12/2019 11:42 PM, Sagi Grimberg wrote:
> callers should not rely on raw nvme status, instead return
> is more appropriate blk_status_t.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>


Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
