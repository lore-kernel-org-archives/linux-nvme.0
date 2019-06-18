From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 09:49:38 +0200
Subject: [PATCH v3 1/3] nvme: Introduce NVMe 1.4 Identify Namespace fields
 in struct nvme_id_ns
In-Reply-To: <20190617161222.253849-2-bvanassche@acm.org>
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-2-bvanassche@acm.org>
Message-ID: <19a0ab1b-8f41-ef74-f20e-6d6807638440@suse.de>

On 6/17/19 6:12 PM, Bart Van Assche wrote:
> Several new fields have been introduced in version 1.4 of the NVMe spec
> at offsets that were defined as reserved in version 1.3d of the NVMe
> spec. Update the definition of the nvme_id_ns data structure such that
> it is in sync with version 1.4 of the NVMe spec. This change preserves
> backwards compatibility.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reviewed-by: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>  include/linux/nvme.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
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
