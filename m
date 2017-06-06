From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Jun 2017 08:26:05 +0200
Subject: [PATCH v4 8/8] nvmet: use NVME_IDENTIFY_DATA_SIZE
In-Reply-To: <20170604103649.22130-9-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-9-jthumshirn@suse.de>
Message-ID: <851fde3e-054c-89d4-9033-ccfb96877d0f@suse.de>

On 06/04/2017 12:36 PM, Johannes Thumshirn wrote:
> Use NVME_IDENTIFY_DATA_SIZE define instead of hard coding the magic
> 4096 value.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 4 ++--
>  drivers/nvme/target/discovery.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
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
