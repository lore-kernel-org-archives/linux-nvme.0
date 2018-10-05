From: hare@suse.de (Hannes Reinecke)
Date: Fri, 5 Oct 2018 07:51:22 +0200
Subject: [PATCH rfc 2/3] nvme: enable aen also for discovery controllers
In-Reply-To: <20181004212328.30205-3-sagi@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <20181004212328.30205-3-sagi@grimberg.me>
Message-ID: <ea85e444-5c17-83e4-cf66-90ef7f9aabfc@suse.de>

On 10/4/18 11:23 PM, Sagi Grimberg wrote:
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
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
