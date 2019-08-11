From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 11 Aug 2019 17:58:59 +0300
Subject: [PATCH 2/2] nvmet-tcp: fix possible memory leak
In-Reply-To: <20190808205522.24638-2-sagi@grimberg.me>
References: <20190808205522.24638-1-sagi@grimberg.me>
 <20190808205522.24638-2-sagi@grimberg.me>
Message-ID: <62ac1147-18d5-fff6-5571-1a592ddd2ae4@mellanox.com>


On 8/8/2019 11:55 PM, Sagi Grimberg wrote:
> when we uninit a command in error flow we also need to
> free an iovec if it was allocated.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/tcp.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 0d63f3da0117..76e43750b9e5 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1309,6 +1309,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
>   {
>   	nvmet_req_uninit(&cmd->req);
>   	nvmet_tcp_unmap_pdu_iovec(cmd);
> +	kfree(cmd->iov);
>   	if (cmd->req.sg_cnt)
>   		sgl_free(cmd->req.sg);
>   }


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
