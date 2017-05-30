From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 May 2017 10:20:36 +0200
Subject: [PATCH 2/7] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <4aecbc794651073b2812341dc63e1f2918cc6a82.1496131397.git.jthumshirn@suse.de>
Message-ID: <4eb8b53c-6c27-55f8-91e8-deb439a7a43d@suse.de>

On 05/30/2017 10:08 AM, Johannes Thumshirn wrote:
> Add the UUID field from the NVMe Namespace Identification Descriptor
> to the nvmet_ns structure and allow it's population via configfs.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/configfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/target/nvmet.h    |  1 +
>  2 files changed, 49 insertions(+)
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
