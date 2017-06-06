From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Jun 2017 08:24:49 +0200
Subject: [PATCH v4 5/8] nvme: get list of namespace descriptors
In-Reply-To: <20170604103649.22130-6-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-6-jthumshirn@suse.de>
Message-ID: <2233fdbb-5ca3-4007-43f2-affa24e23b1f@suse.de>

On 06/04/2017 12:36 PM, Johannes Thumshirn wrote:
> If a target identifies itself as NVMe 1.3 compliant, try to get the
> list of Namespace Identification Descriptors and populate the UUID,
> NGUID and EUI64 fileds in the NVMe namespace structure with these
> values.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 88 insertions(+)
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
