From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 09:50:22 +0200
Subject: [PATCH v3 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <20190617161222.253849-3-bvanassche@acm.org>
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-3-bvanassche@acm.org>
Message-ID: <13f7742d-cdd1-a446-ae76-a3cf2cbe4b6a@suse.de>

On 6/17/19 6:12 PM, Bart Van Assche wrote:
> Make the NVMe NAWUN, NAWUPF, NACWU, NPWG, NPWA, NPDG and NOWS attributes
> available to initator systems.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Martin K. Petersen <martin.petersen at oracle.com>
> Cc: Hannes Reinecke <hare at suse.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>  drivers/nvme/target/admin-cmd.c   |  5 ++++
>  drivers/nvme/target/io-cmd-bdev.c | 45 +++++++++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-file.c | 37 +++++++++++++++++++++++++
>  drivers/nvme/target/nvmet.h       |  2 ++
>  4 files changed, 89 insertions(+)
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
