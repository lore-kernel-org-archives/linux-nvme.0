From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:10:47 -0700
Subject: [PATCH v6 3/7] nvme: make nvme_identify_ns propagate errors back
In-Reply-To: <20190813064304.7344-4-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-4-sagi@grimberg.me>
Message-ID: <3b0b8d89-ed03-3e76-0203-0c45431e4b6b@broadcom.com>



On 8/12/2019 11:43 PM, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that it failed,
> but don't know why. Make nvme_identify_ns propagate the error back.
> Note that if the return status from nvme_submit_sync_cmd() is positive
> then we convert it from a blk_status_t to a negative errno.
>
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>


Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
