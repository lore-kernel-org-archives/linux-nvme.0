From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Sep 2016 11:41:09 +0300
Subject: [PATCH] admin-cmd: Added smart-log command support.
In-Reply-To: <1472759103-16538-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1472759103-16538-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <ac203b28-39ed-4f2a-b0fc-f586e43c9346@grimberg.me>


> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 47c564b..7ab9c93 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -14,6 +14,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  #include <linux/module.h>
>  #include <generated/utsrelease.h>
> +#include <asm/unaligned.h>
>  #include "nvmet.h"
>
>  u32 nvmet_get_log_page_len(struct nvme_command *cmd)
> @@ -29,8 +30,84 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
>  	return len;
>  }
>
> +static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
> +		struct nvme_smart_log *slog)
> +{
> +	u16 status;
> +	struct nvmet_ns *ns;
> +	u64 host_reads, host_writes, data_units_read, data_units_written;
> +
> +	status = NVME_SC_SUCCESS;
> +	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->get_log_page.nsid);
> +	if (!ns) {
> +		status = NVME_SC_INVALID_NS;
> +		pr_err("nvmet : Counld not find namespace id : %d\n",
> +				le32_to_cpu(req->cmd->get_log_page.nsid));
> +		goto out;
> +	}
> +
> +	host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
> +	data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
> +	host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
> +	data_units_written = part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
> +
> +	put_unaligned_le64(host_reads, &slog->host_reads[0]);
> +	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
> +	put_unaligned_le64(host_writes, &slog->host_writes[0]);
> +	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
> +	nvmet_put_namespace(ns);
> +out:
> +	return status;
> +}

Given that we don't own the namespaces, I'm wandering if this is the
correct way to do this... I'm not at all convinced that having something
else reading/writing to the blkdevs other than nvmf is a valid/useful
use-case but in this situation we won't get correct log information
(or at least the semantics is wrong).

Should we maintain these statistics in the target stack instead?
