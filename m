From: hare@suse.de (Hannes Reinecke)
Date: Sat, 10 Aug 2019 14:11:01 +0200
Subject: [PATCH v3 6/7] nvme-fc: Fail transport errors with
 NVME_SC_HOST_PATH
In-Reply-To: <20190808205325.24036-7-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-7-sagi@grimberg.me>
Message-ID: <6d1b8c1e-27b0-1701-3ec1-c0f314d12886@suse.de>

On 8/8/19 10:53 PM, Sagi Grimberg wrote:
> From: James Smart <james.smart at broadcom.com>
> 
> NVME_SC_INTERNAL should indicate an internal controller errors
> and not host transport errors. These errors will propagate to
> upper layers (essentially nvme core) and be interpereted as
> transport errors which should not be taken into account for
> namespace state or condition.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fc.c | 37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
