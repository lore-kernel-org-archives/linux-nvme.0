From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Jun 2017 08:24:22 +0200
Subject: [PATCH v4 4/8] nvmet: add uuid field to nvme_ns and populate via
 configfs
In-Reply-To: <20170604103649.22130-5-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-5-jthumshirn@suse.de>
Message-ID: <337ea3d1-ec11-aed7-6387-f47ffa1e5c93@suse.de>

On 06/04/2017 12:36 PM, Johannes Thumshirn wrote:
> Add the UUID field from the NVMe Namespace Identification Descriptor
> to the nvmet_ns structure and allow it's population via configfs.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/configfs.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
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
