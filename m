From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Sun, 25 Mar 2018 19:15:01 -0700
Subject: [PATCH 2/2] nvmet: make the error message more generic
In-Reply-To: <20180324203201.27087-2-chaitanya.kulkarni@wdc.com>
References: <20180324203201.27087-1-chaitanya.kulkarni@wdc.com>
 <20180324203201.27087-2-chaitanya.kulkarni@wdc.com>
Message-ID: <CAK0tqikLo-udQw8JLTsQYqzo6HGVJ=Z1E4fumYO-cFyG3SJG=Q@mail.gmail.com>

Oops, missing sign-off will resend this patch.

On Sat, Mar 24, 2018 at 1:32 PM, Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
> nvmet_check_ctrl_status() is called from admin-cmd.c along
> with io-cmd.c, make the error message more generic.
> ---
>  drivers/nvme/target/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index a78029e..841e55a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -710,13 +710,13 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
>  u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
>  {
>         if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
> -               pr_err("got io cmd %d while CC.EN == 0 on qid = %d\n",
> +               pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
>                        cmd->common.opcode, req->sq->qid);
>                 return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
>         }
>
>         if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
> -               pr_err("got io cmd %d while CSTS.RDY == 0 on qid = %d\n",
> +               pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
>                        cmd->common.opcode, req->sq->qid);
>                 req->ns = NULL;
>                 return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
> --
> 2.9.5
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
