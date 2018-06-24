From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Jun 2018 19:57:38 +0300
Subject: [PATCH V2] nvmet: use shared workqueue for file-ns
In-Reply-To: <20180623023427.22532-1-chaitanya.kulkarni@wdc.com>
References: <20180623023427.22532-1-chaitanya.kulkarni@wdc.com>
Message-ID: <5d85fd98-fffd-e326-8aee-7976d1e8921a@grimberg.me>



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
>   drivers/nvme/target/core.c        |  7 +++++++
>   drivers/nvme/target/io-cmd-file.c | 17 +++--------------
>   drivers/nvme/target/nvmet.h       |  3 ++-
>   3 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 322f7cfc37a4..f0e8b8250344 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -18,6 +18,7 @@
>   
>   #include "nvmet.h"
>   
> +struct workqueue_struct *file_wq;
>   static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>   static DEFINE_IDA(cntlid_ida);
>   
> @@ -1110,6 +1111,11 @@ static int __init nvmet_init(void)
>   {
>   	int error;
>   
> +	file_wq = alloc_workqueue("nvmet-file", WQ_MEM_RECLAIM, 0);

Can you explain why this needs mem reclaim? And whats wrong with system
workqueues? (maybe higpri even?)

If we end up keeping it, maybe call it nvmet_buffered_io_wq to
make it clear what it is designed for.
