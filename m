From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 12 Sep 2017 14:59:57 +0300
Subject: [PATCH] nvmet: bump NVMET_NR_QUEUES to 128
In-Reply-To: <20170911231450.20409-1-jsmart2021@gmail.com>
References: <20170911231450.20409-1-jsmart2021@gmail.com>
Message-ID: <a6e9c362-d213-4eb3-1d15-fa564e16c1c3@mellanox.com>



On 9/12/2017 2:14 AM, James Smart wrote:
> Raise the max number of IO queues to 128. There are several hosts with
> more than 64 cpus/threads.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>   drivers/nvme/target/nvmet.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

I guess it's about time as more and more systems use > 64 cpus,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
