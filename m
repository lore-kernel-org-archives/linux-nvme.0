From: hare@suse.de (Hannes Reinecke)
Date: Fri, 2 Nov 2018 09:00:19 +0100
Subject: [PATCH v2 1/4] nvme: introduce ctrl attributes enumeration
In-Reply-To: <20181030174344.20171-2-sagi@grimberg.me>
References: <20181030174344.20171-1-sagi@grimberg.me>
 <20181030174344.20171-2-sagi@grimberg.me>
Message-ID: <bf4d0bbb-f0a4-cdd3-820e-e1416684ddc4@suse.de>

On 10/30/18 6:43 PM, Sagi Grimberg wrote:
> We are growing more controller attributes, so use
> a proper enumeration for it. For now just add the
> 128-bit hostid which we support.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/admin-cmd.c | 2 +-
>   include/linux/nvme.h            | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
