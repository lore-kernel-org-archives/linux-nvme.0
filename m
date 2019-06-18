From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 09:52:00 +0200
Subject: [PATCH v3 0/3] NVMe 1.4 Identify Namespace Support
In-Reply-To: <20190617161222.253849-1-bvanassche@acm.org>
References: <20190617161222.253849-1-bvanassche@acm.org>
Message-ID: <aa89ce11-b24b-fdd6-c83f-939124356584@suse.de>

On 6/17/19 6:12 PM, Bart Van Assche wrote:
> Hi Christoph,
> 
> This patch series adds support for several of the new parameters introduced
> in the NVMe 1.4 Identify Namespace command. Please consider these patches
> for kernel version 5.3.
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v2:
> - In the initiator, use AWUPF instead NAWUPF if NAWUPF == 0.
> 
> Changes compared to v1:
> - Added a patch for the NVMe target code that exports these parameters.
> - Limited the physical block size to the value of AWUPF/NAWUPF as appropriate.
> 
> Bart Van Assche (3):
>   nvme: Introduce NVMe 1.4 Identify Namespace fields in struct
>     nvme_id_ns
>   nvmet: Export NVMe namespace attributes
>   nvme: Set physical block size and optimal I/O size according to NVMe
>     1.4
> 
>  drivers/nvme/host/core.c          | 30 +++++++++++++++++++--
>  drivers/nvme/host/nvme.h          |  1 +
>  drivers/nvme/target/admin-cmd.c   |  5 ++++
>  drivers/nvme/target/io-cmd-bdev.c | 45 +++++++++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-file.c | 37 +++++++++++++++++++++++++
>  drivers/nvme/target/nvmet.h       |  2 ++
>  include/linux/nvme.h              | 12 ++++++---
>  7 files changed, 127 insertions(+), 5 deletions(-)
> 
Can you send a patch for nvme-cli, too?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
