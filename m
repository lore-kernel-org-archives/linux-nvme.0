From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 11 Aug 2019 17:57:59 +0300
Subject: [PATCH 1/2] nvmet-tcp: fix possible NULL deref
In-Reply-To: <20190808205522.24638-1-sagi@grimberg.me>
References: <20190808205522.24638-1-sagi@grimberg.me>
Message-ID: <5bff9385-b853-4868-6f78-2b9611fc479d@mellanox.com>


On 8/8/2019 11:55 PM, Sagi Grimberg wrote:
> We must only call sgl_free for sgl that we actually
> allocated.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/tcp.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 69b83fa0c76c..0d63f3da0117 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -348,7 +348,8 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
>   
>   	return 0;
>   err:
> -	sgl_free(cmd->req.sg);
> +	if (cmd->req.sg_cnt)
> +		sgl_free(cmd->req.sg);


what about zeroing the sg_cnt during nvmet_tcp_get_cmd ?

and NULLify the cmd->req.sg as well in nvmet_tcp_get_cmd ?


>   	return NVME_SC_INTERNAL;
>   }
>   
> @@ -553,7 +554,8 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
>   
>   	if (queue->nvme_sq.sqhd_disabled) {
>   		kfree(cmd->iov);
> -		sgl_free(cmd->req.sg);
> +		if (cmd->req.sg_cnt)
> +			sgl_free(cmd->req.sg);
>   	}
>   
>   	return 1;
> @@ -584,7 +586,8 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>   		return -EAGAIN;
>   
>   	kfree(cmd->iov);
> -	sgl_free(cmd->req.sg);
> +	if (cmd->req.sg_cnt)
> +		sgl_free(cmd->req.sg);
>   	cmd->queue->snd_cmd = NULL;
>   	nvmet_tcp_put_cmd(cmd);
>   	return 1;
> @@ -1306,7 +1309,8 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
>   {
>   	nvmet_req_uninit(&cmd->req);
>   	nvmet_tcp_unmap_pdu_iovec(cmd);
> -	sgl_free(cmd->req.sg);
> +	if (cmd->req.sg_cnt)
> +		sgl_free(cmd->req.sg);
>   }
>   
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
