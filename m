From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 14:58:17 +0300
Subject: [PATCH] nvmet-rdma: prevent possible race condition for queue
 state
In-Reply-To: <77FF42D3D537D24484F0BF5E2458C0C08506BE27@EXMAIL1.taec.toshiba.com>
References: <77FF42D3D537D24484F0BF5E2458C0C08506BE27@EXMAIL1.taec.toshiba.com>
Message-ID: <99f5789f-0d6a-0166-dab6-b156200e9de5@grimberg.me>


> This patch prevents possible race condition for queue state when the state may be changed before take a lock.
>   
> 
> kernel v4.9.36

Patch format is incorrect, please generate it using git-format-patch.

> --- a/drivers/nvme/target/rdma.c     2017-07-10 10:11:02.003751067 +0300
> +++ b/drivers/nvme/target/rdma.c    2017-07-10 10:09:42.137755664 +0300
> @@ -767,7 +767,11 @@
>          if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
>                  unsigned long flags;
> 
>                  spin_lock_irqsave(&queue->state_lock, flags);
> +               if (queue->state == NVMET_RDMA_Q_LIVE){

		   if (queue->state == NVMET_RDMA_Q_LIVE) {

> +                      spin_unlock_irqrestore(&queue->state_lock, flags);
> +                       goto handle_command;
> +               }

Indentation doesn't look correct, did you use tab-spacing?
Please run checkpatch before submitting v2.

The logic looks correct to me, but it really needs documentation, maybe
the below?
--
		spin_lock_irqsave(&queue->state_lock, flags);
		switch (queue->state) {
		case NVMET_RDMA_Q_LIVE:
			/*
			 * we raced with connection establishment, go
			 * ahead and handle the command.
			 */
			spin_unlock_irqrestore(&queue->state_lock, flags);
			goto handle_cmd;
		case NVMET_RDMA_Q_CONNECTING:
			/* defer until connection is established */
			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
			break;
		default:
			/* Nothing to do with the response */
			nvmet_rdma_put_rsp(rsp);
		}
		spin_unlock_irqrestore(&queue->state_lock, flags);
		return;
--
