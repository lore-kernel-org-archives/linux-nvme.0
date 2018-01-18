From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 18 Jan 2018 19:37:38 +0900
Subject: [PATCH 1/1] nvmet: fix PSDT field check in command format
In-Reply-To: <1516208783-4629-1-git-send-email-maxg@mellanox.com>
References: <1516208783-4629-1-git-send-email-maxg@mellanox.com>
Message-ID: <CAA7jzteGib4-mZxoSup1-_dm8LkT=bCPRnGirYiDCDL7JU=vWA@mail.gmail.com>

On Thu, Jan 18, 2018@2:06 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index ab3a247..438e0ba 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -523,9 +523,12 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,

> +       /*
> +         * For fabrics, PSDT field shall describe metadata pointer (MPTR) that
> +         * contains an address of a single contiguous physical buffer that is
> +         * byte aligned.
> +         */

Hi Max,

Indentation of lines except the first one seems starts with
whitespaces instead of tab.
