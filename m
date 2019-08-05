From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Aug 2019 11:24:45 -0700
Subject: [PATCH] nvmet: fix data units read and written counters in SMART
 log
In-Reply-To: <1564970259-12279-1-git-send-email-tomwu@mellanox.com>
References: <1564970259-12279-1-git-send-email-tomwu@mellanox.com>
Message-ID: <8cbab0aa-51c7-b33a-46a3-5a85debc023c@grimberg.me>


> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 9f72d51..acbadbe 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -85,6 +85,9 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
>   	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
>   	data_units_written = part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
>   
> +	data_units_read = DIV_ROUND_UP(data_units_read, 1000);
> +	data_units_written = DIV_ROUND_UP(data_units_written, 1000);
> +

How about either modifying the actual retrieval or move the fixups right 
next to the initial setting...
