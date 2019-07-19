From: hare@suse.de (Hannes Reinecke)
Date: Fri, 19 Jul 2019 15:49:15 +0200
Subject: [PATCH v2 2/3] nvme: enable aen also for discovery controllers
In-Reply-To: <20190712180211.26333-3-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-3-sagi@grimberg.me>
Message-ID: <1eab16e4-b7ca-2676-64c9-9a270769ea12@suse.de>

On 7/12/19 8:02 PM, Sagi Grimberg wrote:
> If the controller supports discovery log page change events,
> we want to enable it on the host side as well.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
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
