From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 May 2017 10:18:08 +0200
Subject: [PATCH 1/7] nvme: rename uuid to nguid in nvme_ns
In-Reply-To: <7e97c34f8ab586615cb57b22a36db2eeb0ccc57f.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <7e97c34f8ab586615cb57b22a36db2eeb0ccc57f.1496131397.git.jthumshirn@suse.de>
Message-ID: <0f70925e-9671-dcf3-7aae-2f4d0125c919@suse.de>

On 05/30/2017 10:08 AM, Johannes Thumshirn wrote:
> The uuid field in the nvme_ns structure represents the nguid field
> from the identify namespace command. And as NVMe 1.3 introduced an
> UUID in the NVMe Namespace Identification Descriptor this will
> collide.
> 
> So rename the uuid to nguid to prevent any further
> confusion. Unfortunately we export the nguid to sysfs in the uuid
> sysfs attribute, but this can't be changed anymore without possibly
> breaking existing userspace.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 10 +++++-----
>  drivers/nvme/host/nvme.h |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
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
