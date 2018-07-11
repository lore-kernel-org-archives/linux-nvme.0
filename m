From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Jul 2018 12:38:17 +0300
Subject: [PATCH for-4.18 1/2] nvmet: fix file discard return status
In-Reply-To: <BYAPR04MB4502CAAE428C7E06589E78B2865B0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180710111702.12541-1-sagi@grimberg.me>
 <BYAPR04MB4502CAAE428C7E06589E78B2865B0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <b7d6bea0-371c-721c-1568-be5b48bb41cc@grimberg.me>


> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 67e3757504db..46f202b1e2b3 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -235,6 +235,7 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
>   static void nvmet_file_execute_discard(struct nvmet_req *req)
>   {
>          int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> +       u16 status = NVME_SC_SUCCESS;

No need to initialize status because we are always iterating at least
once.

>          struct nvme_dsm_range range;
>          loff_t offset;
>          loff_t len;
> @@ -243,18 +244,20 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
>          for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
>                  ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
>                                  sizeof(range));
> -               if (ret)
> +               if (ret) {
> +                       status = NVME_SC_INTERNAL | NVME_SC_DNR;
>                          break;
> +               }

nvmet_copy_from_sgl failure returns NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR
which we should propagate back.

I'll send an updated patch that makes ret type u16.
