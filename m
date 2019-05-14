From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:17:36 +0200
Subject: [PATCH 2/7] nvmet_fc: add transport discovery change event
 callback support
In-Reply-To: <20190513224314.24169-3-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-3-jsmart2021@gmail.com>
Message-ID: <63cca277-f3f8-7c86-c9ea-8ea7fdf76671@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> This patch adds support for the nvmet discovery_change transport op.
> In turn, the transport adds it's own LLDD api callback discovery_event
> op to request the LLDD to generate an RSCN for the discovery change.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/nvme/target/fc.c       | 11 +++++++++++
>   include/linux/nvme-fc-driver.h |  6 ++++++
>   2 files changed, 17 insertions(+)
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
