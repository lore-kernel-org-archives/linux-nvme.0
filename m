From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:12:47 -0700
Subject: [PATCH v6 6/7] nvme-fc: Fail transport errors with
 NVME_SC_HOST_PATH
In-Reply-To: <20190813064304.7344-7-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-7-sagi@grimberg.me>
Message-ID: <170e224c-4587-e767-ce15-142f32530e89@broadcom.com>



On 8/12/2019 11:43 PM, Sagi Grimberg wrote:
> From: James Smart <james.smart at broadcom.com>
>
> NVME_SC_INTERNAL should indicate an internal controller errors
> and not host transport errors. These errors will propagate to
> upper layers (essentially nvme core) and be interpereted as
> transport errors which should not be taken into account for
> namespace state or condition.
>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
