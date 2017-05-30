From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 May 2017 10:21:17 +0200
Subject: [PATCH 3/7] nvmet: add eui64 field to nvme_ns and populate via
 configfs
In-Reply-To: <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
Message-ID: <ee1bfd8c-08a0-4a6c-8371-f52c6ba0ffc4@suse.de>

On 05/30/2017 10:08 AM, Johannes Thumshirn wrote:
> Add the EUI-64 field from the NVMe Namespace Identification Descriptor
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
