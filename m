From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Aug 2019 10:22:25 -0700
Subject: [PATCH] nvme/target/admin-cmd.c: Fix a bug in
 'nvmet_execute_get_log_page_error'
In-Reply-To: <20190815124348.125105-1-amit.engel@dell.com>
References: <20190815124348.125105-1-amit.engel@dell.com>
Message-ID: <ca9ad5ba-6199-cc0b-176a-9f8ccf7870a5@grimberg.me>


> From: Amit <amit.engel at emc.com>
> 
> ensure that nvmet_copy_to_sgl does not exceed data_len
> 
> Signed-off-by: Amit <amit.engel at emc.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 51800a9ce9a9..fd7749727f55 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -40,13 +40,14 @@ static void nvmet_execute_get_log_page_error(struct nvmet_req *req)
>   	u16 status = NVME_SC_SUCCESS;
>   	unsigned long flags;
>   	off_t offset = 0;
> +	size_t num_of_sgl_slots = req->data_len/sizeof(struct nvme_error_slot);

This should be do_div.
