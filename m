From: hare@suse.de (Hannes Reinecke)
Date: Fri, 19 Jul 2019 15:48:43 +0200
Subject: [PATCH v2 1/3] nvme-fabrics: allow discovery subsystems accept a
 kato
In-Reply-To: <20190712180211.26333-2-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-2-sagi@grimberg.me>
Message-ID: <ed3d604d-5a35-4508-8361-41aafaf2bc1d@suse.de>

On 7/12/19 8:02 PM, Sagi Grimberg wrote:
> This modifies the behavior of discovery subsystems to accept
> a kato as a preparation to support discovery log change
> events. This also means that now every discovery controller
> will have a default kato value, and for non-persistent connections
> the host needs to pass in a zero kato value (keep_alive_tmo=0).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
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
