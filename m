From: keith.busch@gmail.com (Keith Busch)
Date: Sat, 10 Aug 2019 08:19:16 -0600
Subject: [PATCH v5 2/7] nvme: return a proper status for sync commands
 failure
In-Reply-To: <20190809221211.21157-3-sagi@grimberg.me>
References: <20190809221211.21157-1-sagi@grimberg.me>
 <20190809221211.21157-3-sagi@grimberg.me>
Message-ID: <CAOSXXT607=1L5TywNgpi242kcKP-P64Bz4atUgQ6iT=B41HV1A@mail.gmail.com>

On Fri, Aug 9, 2019@4:12 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -805,7 +805,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>                 ret = -EINTR;
>         else
> -               ret = nvme_req(req)->status;
> +               ret = nvme_error_status(req);
>   out:
>         blk_mq_free_request(req);
>         return ret;
> @@ -896,7 +896,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>                 ret = -EINTR;
>         else
> -               ret = nvme_req(req)->status;
> +               ret = nvme_error_status(req);
>         if (result)
>                 *result = le32_to_cpu(nvme_req(req)->result.u32);
>         if (meta && !ret && !write) {
> --

Fine for the driver initiated commands, but no for user commands.
Tooling definitely wants to see the NVMe status directly, and we'll
break them all if we change this API.
