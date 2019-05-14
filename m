From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:12:07 +0200
Subject: [PATCH 1/7] nvmet: add transport discovery change op
In-Reply-To: <20190513224314.24169-2-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-2-jsmart2021@gmail.com>
Message-ID: <3ea977e2-0b26-6b8f-63b4-c54fbe801dc2@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> Some transports, such as FC-NVME, support discovery controller change
> events without the use of a persistent discovery controller. FC receives
> events via RSCN from the FC Fabric Controller or subsystem FC port.
> 
> This patch adds a nvmet transport op that is called whenever a
> discovery change event occurs in the nvmet layer.
> 
> To facilitate the callback without adding another layer to cross into
> core.c to reference the transport ops, the port structure snapshots
> the transport ops when the port is enabled and clears them when disabled.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/nvme/target/core.c      | 2 ++
>   drivers/nvme/target/discovery.c | 4 ++++
>   drivers/nvme/target/nvmet.h     | 2 ++
>   3 files changed, 8 insertions(+)
> 
I like the idea, and something like this is in fact required when 
restarting nvmetcli.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
