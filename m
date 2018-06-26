From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 26 Jun 2018 03:29:13 +0000
Subject: [PATCH V2] nvmet: use shared workqueue for file-ns
In-Reply-To: <BYAPR04MB450206FFEE99E01912AF260E864B0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180623023427.22532-1-chaitanya.kulkarni@wdc.com>,
 <5d85fd98-fffd-e326-8aee-7976d1e8921a@grimberg.me>,
 <BYAPR04MB450206FFEE99E01912AF260E864B0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <BYAPR04MB45022CF0740F2484E168B0B086490@BYAPR04MB4502.namprd04.prod.outlook.com>

Sagi, can you please let me know if you still want me to use the
system hipri workqueue and send a new version?

From: Chaitanya Kulkarni
Sent: Sunday, June 24, 2018 11:08 AM
To: Sagi Grimberg; linux-nvme at lists.infradead.org
Cc: hch at lst.de
Subject: Re: [PATCH V2] nvmet: use shared workqueue for file-ns
? 

Thanks for the review comments Sagi, please see the inline reply.


From: Sagi Grimberg <sagi@grimberg.me>
Sent: Sunday, June 24, 2018 9:57 AM
To: Chaitanya Kulkarni; linux-nvme at lists.infradead.org
Cc: hch at lst.de
Subject: Re: [PATCH V2] nvmet: use shared workqueue for file-ns
? 
?


On 06/23/2018 05:34 AM, Chaitanya Kulkarni wrote:
> This patch removes the per-ns workqueue and adds a global workqueue
> which is shared across all the namespaces of multiple subsystems to
> offload the I/O submission for buffered I/Os when namespace is
> file-backed.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
> Changes since V1 :-
> 1. Don't use per subsys based workqueue, make it global.
> ---
>?? drivers/nvme/target/core.c??????? |? 7 +++++++
>?? drivers/nvme/target/io-cmd-file.c | 17 +++--------------
>?? drivers/nvme/target/nvmet.h?????? |? 3 ++-
>?? 3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 322f7cfc37a4..f0e8b8250344 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -18,6 +18,7 @@
>?? 
>?? #include "nvmet.h"
>?? 
> +struct workqueue_struct *file_wq;
>?? static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>?? static DEFINE_IDA(cntlid_ida);
>?? 
> @@ -1110,6 +1111,11 @@ static int __init nvmet_init(void)
>?? {
>??????? int error;
>?? 
> +???? file_wq = alloc_workqueue("nvmet-file", WQ_MEM_RECLAIM, 0);

Can you explain why this needs mem reclaim? And whats wrong with system
workqueues? (maybe higpri even?)

[CK] Reclaim is for ensuring forward progress, as we have added the forward progress
under reclaim for file I/O path I thought we should use this for work queue also.

If we use the system work queues then we might end up exhausting/overusing the system
resource especially if we have a large number of file-backed ns configured with buffered I/Os,
please let me know if you still preferred the use of system workqueue I'll update in the next
version.

Otherwise, I'll send the V3 with changing the name "nvmet-file" -> "nvmet-buffered-io-wq" and
conditionally removing the WQ_MEM_RECLAIM based on your reply.

If we end up keeping it, maybe call it nvmet_buffered_io_wq to
make it clear what it is designed for.

[CK] Sounds good.
    
