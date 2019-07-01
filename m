From: hare@suse.de (Hannes Reinecke)
Date: Mon, 1 Jul 2019 07:48:21 +0200
Subject: [PATCH v5 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <20190628165331.163919-3-bvanassche@acm.org>
References: <20190628165331.163919-1-bvanassche@acm.org>
 <20190628165331.163919-3-bvanassche@acm.org>
Message-ID: <2fd95907-76ec-eaaf-2207-a7280411a605@suse.de>

On 6/28/19 6:53 PM, Bart Van Assche wrote:
> Make the NVMe NAWUN, NAWUPF, NACWU, NPWG, NPWA, NPDG and NOWS attributes
> available to initator systems for the block backend.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Martin K. Petersen <martin.petersen at oracle.com>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>  drivers/nvme/target/admin-cmd.c   |  3 +++
>  drivers/nvme/target/io-cmd-bdev.c | 39 +++++++++++++++++++++++++++++++
>  drivers/nvme/target/nvmet.h       |  8 +++++++
>  3 files changed, 50 insertions(+)
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
