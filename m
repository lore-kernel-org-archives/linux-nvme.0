From: hare@suse.de (Hannes Reinecke)
Date: Fri, 5 Oct 2018 07:50:35 +0200
Subject: [PATCH rfc 1/3] nvme-fabrics: allow discovery subsystems accept a
 kato
In-Reply-To: <20181004212328.30205-2-sagi@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <20181004212328.30205-2-sagi@grimberg.me>
Message-ID: <9623cfac-3841-af4f-5445-0a86fa3bd490@suse.de>

On 10/4/18 11:23 PM, Sagi Grimberg wrote:
> This modifies the behavior of discovery subsystems to accept
> a kato as a preparation to support discovery log change
> events. This also means that now every discovery controller
> will have a default kato value, and for non-persistent connections
> the host needs to pass in a zero kato value (keep_alive_tmo=0).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
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
