From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Jun 2017 08:25:41 +0200
Subject: [PATCH v4 7/8] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170604103649.22130-8-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-8-jthumshirn@suse.de>
Message-ID: <62a79172-2269-8113-f1e5-9769f78746c6@suse.de>

On 06/04/2017 12:36 PM, Johannes Thumshirn wrote:
> Allow overriding the announced NVMe Version of a via configfs.
> 
> This is particularly helpful when debugging new features for the host
> or target side without bumping the hard coded version (as the target
> might not be fully compliant to the announced version yet).
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h           |  4 ++++
>  2 files changed, 38 insertions(+)
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
