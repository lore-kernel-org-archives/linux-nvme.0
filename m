From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:17:55 +0200
Subject: [PATCH 3/7] nvme-fcloop: Add support for nvmet discovery_event op
In-Reply-To: <20190513224314.24169-4-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-4-jsmart2021@gmail.com>
Message-ID: <cdf07591-fbab-d72b-381d-a8e301bf3363@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> Update fcloop to support the discovery_event operation and
> invoke a nvme rescan. In a real fc adapter, this would generate an
> RSCN, which the host would receive and convert into a nvme rescan
> on the remote port specified in the rscn payload.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/nvme/target/fcloop.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
