From: hare@suse.de (Hannes Reinecke)
Date: Fri, 5 Oct 2018 07:51:56 +0200
Subject: [PATCH rfc 3/3] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20181004212328.30205-4-sagi@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <20181004212328.30205-4-sagi@grimberg.me>
Message-ID: <d6560272-571e-93f1-9644-911e524e2a37@suse.de>

On 10/4/18 11:23 PM, Sagi Grimberg wrote:
> Provide userspace with nvme discovery controller device instance,
> controller traddr and trsvcid. We'd expect userspace to handle
> this event by issuing a discovery + connect.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
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
