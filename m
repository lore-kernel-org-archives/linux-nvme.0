From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Aug 2019 17:29:47 +0300
Subject: [PATCH v7 04/14] nvmet: make nvmet_copy_ns_identifier() non-static
In-Reply-To: <20190801234514.7941-5-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-5-logang@deltatee.com>
Message-ID: <43951ad9-873b-5bbe-b627-0ad4610fbb11@mellanox.com>


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> This function will be needed by the upcoming passthru code.

Same here. As a standalone commit I can't take a lot from here.

Maybe should be squashed ?


>
> [chaitanya.kulkarni at wdc.com: this was factored out of a patch
>   originally authored by Chaitanya]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 4 ++--
>   drivers/nvme/target/nvmet.h     | 2 ++
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 4dc12ea52f23..eeb24f606d00 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -506,8 +506,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> -				    void *id, off_t *off)
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off)
>   {
>   	struct nvme_ns_id_desc desc = {
>   		.nidt = type,
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 217a787952e8..d1a0a3190a24 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -489,6 +489,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
>   u16 nvmet_file_flush(struct nvmet_req *req);
>   void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
>   
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
> +			     void *id, off_t *off);
>   static inline u32 nvmet_rw_len(struct nvmet_req *req)
>   {
>   	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
