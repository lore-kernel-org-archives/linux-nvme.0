Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A914C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/CVOE+Z8neDm9lUsCBc6Cnh9TUe3ZI0uIOD6Q/D0XQ=; b=YsRwPY+1lakQxgft1G5IiVCFuE
	vwzYjZcK+qOLZPrJewSOJHf95ggf+87CFHLW0Zs4HTWuA+uOIf45BsMJVtvYDNjqPQdKIpDIQ1vxh
	jtdjdqB91+ycw47bKc1O505GPOQf1uXjrsqgKacpwUVlpx943RCqpA2BEAlmWl3gUAnbwYVC+eae5
	XHcXOyPBpsaZw0qTFE7gMukNssb79Clm0Cn5gJHQvwzTWemMZ3nKp9t4tLJE01KdKY9hShq/f/Lw9
	1b2tJbRSTwbTXJ/uKV19XPMUQTwRXKZ2Hye+l8k3+rhYOp+0Xwiohtnl7Ajlw9apbzmNOTIKYzXkW
	+zIlO1oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC03J-00FJUg-HQ; Thu, 14 Jul 2022 14:42:53 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC03G-00FJRY-Ff
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 14:42:52 +0000
Received: by mail-wm1-f46.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so1370531wmj.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Jul 2022 07:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q/CVOE+Z8neDm9lUsCBc6Cnh9TUe3ZI0uIOD6Q/D0XQ=;
        b=mJVr2GrQHnXdgg/nNHh6xeYmrXUIEQj5oW8Ibu9oAp2wJA3KScDurW04k3Z+9BT55p
         TUoLyBWgf3RIAYqHcxTaY/Jyuy/J5QrR1r1QjqWhvmTaS/krb2RtnHSkIbRZOUpvA8l7
         4crC7F0cY8uf4V0odoIQBttD9utvRm5nnFUpviAst5ABDK97rRcyxdVkdrFIj+KtV8AJ
         ElJASXkVGX9BMc+Cn1pHJ3RauRbYB1WbiduBFup5t1Eic78/tJ4760eim8Uqy1giSTs4
         +8+uYZvRDJlw6DSyODUEOehv0JcE0MQx3KKB+zAjf6yWjB8memi4fWcGnsPap5l5Vd1H
         YhlQ==
X-Gm-Message-State: AJIora9lze2iv2/+uXEkM5zSNlDIjb1np7hoAPto5on7p4DmLG4yg9l3
	pjjwGEkoW7Lzs0+TBIr5ok/nH4aYFME=
X-Google-Smtp-Source: AGRyM1uTXpQeGz5qUJao7blPcyoPpQ+HEedS7uisikYUlt38nA4FJiB4/mW3FXt+CRyZZybLby6siQ==
X-Received: by 2002:a05:600c:2411:b0:3a2:e09a:6cb8 with SMTP id 17-20020a05600c241100b003a2e09a6cb8mr9277133wmp.44.1657809766086;
        Thu, 14 Jul 2022 07:42:46 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y18-20020a05600c365200b003a2c67aa6c0sm2563205wmq.23.2022.07.14.07.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 07:42:45 -0700 (PDT)
Message-ID: <49be3b16-9c99-460b-e321-c2727c159d9c@grimberg.me>
Date: Thu, 14 Jul 2022 17:42:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-tcp: delay error recovery after link drop
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220714122703.67621-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220714122703.67621-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_074250_558292_496864EB 
X-CRM114-Status: GOOD (  28.88  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When the connection unexpectedly closes we must not start error
> recovery right away, as the controller might not have registered
> the connection failure and so retrying commands directly will
> might lead to data corruption.
> So wait for KATO before starting error recovery to be on the safe
> side; chances are the commands will time out before that anyway.

We can't just blindly adding kato to the error recovery because that
by definition creates a intrinsic delay for I/O failover. There is
absolutely no reason what-so-ever to do that. kato can be arbitrarily
long.

If the controller needs this delay, then it should signal this
somehow in its capabilities. This is not something that we can just
blindly do. So this needs to go through the TWG.

Also, how come this is TCP specific anyway? This talks about a
controller that has a dangling inflight command that he cannot fence
yet hence cannot serve failover I/O. RDMA should have the same thing.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c           | 37 +++++++++++++++++++++----------
>   drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++++++++
>   2 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a7848e430a5c..70096a2e8762 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -167,7 +167,7 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> -	struct work_struct	err_work;
> +	struct delayed_work	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> @@ -522,13 +522,21 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->ddgst_remaining = 0;
>   }
>   
> -static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> +static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl, bool delay)
>   {
> +	int tmo = delay ? (ctrl->kato ? ctrl->kato : NVME_DEFAULT_KATO) : 0;
> +
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>   		return;
>   
> -	dev_warn(ctrl->device, "starting error recovery\n");
> -	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
> +	if (tmo)
> +		dev_warn(ctrl->device,
> +			 "delaying error recovery by %d seconds\n", tmo);
> +	else
> +		dev_warn(ctrl->device,
> +			 "starting error recovery\n");
> +	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work,
> +			   tmo * HZ);
>   }
>   
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> @@ -542,7 +550,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		dev_err(queue->ctrl->ctrl.device,
>   			"got bad cqe.command_id %#x on queue %d\n",
>   			cqe->command_id, nvme_tcp_queue_id(queue));
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl, false);
>   		return -EINVAL;
>   	}
>   
> @@ -584,7 +592,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
>   		dev_err(queue->ctrl->ctrl.device,
>   			"queue %d tag %#x SUCCESS set but not last PDU\n",
>   			nvme_tcp_queue_id(queue), rq->tag);
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl, false);
>   		return -EPROTO;
>   	}
>   
> @@ -895,7 +903,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>   			dev_err(queue->ctrl->ctrl.device,
>   				"receive failed:  %d\n", result);
>   			queue->rd_enabled = false;
> -			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl, false);
>   			return result;
>   		}
>   	}
> @@ -943,7 +951,12 @@ static void nvme_tcp_state_change(struct sock *sk)
>   	case TCP_LAST_ACK:
>   	case TCP_FIN_WAIT1:
>   	case TCP_FIN_WAIT2:
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		/*
> +		 * We cannot start error recovery right away, as we need
> +		 * to wait for KATO to trigger to give the controller a
> +		 * chance to detect the failure.
> +		 */
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl, true);
>   		break;
>   	default:
>   		dev_info(queue->ctrl->ctrl.device,
> @@ -2171,7 +2184,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   {
>   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
> -				struct nvme_tcp_ctrl, err_work);
> +				struct nvme_tcp_ctrl, err_work.work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
>   	nvme_auth_stop(ctrl);
> @@ -2195,7 +2208,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   
>   static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>   {
> -	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
> +	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work.work);
>   	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
>   
>   	nvme_tcp_teardown_io_queues(ctrl, shutdown);
> @@ -2355,7 +2368,7 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
>   	 * LIVE state should trigger the normal error recovery which will
>   	 * handle completing this request.
>   	 */
> -	nvme_tcp_error_recovery(ctrl);
> +	nvme_tcp_error_recovery(ctrl, false);
>   	return BLK_EH_RESET_TIMER;
>   }
>   
> @@ -2596,7 +2609,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   
>   	INIT_DELAYED_WORK(&ctrl->connect_work,
>   			nvme_tcp_reconnect_ctrl_work);
> -	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
> +	INIT_DELAYED_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
>   	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
>   
>   	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 27a72504d31c..bbeeeeaedc9b 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -157,6 +157,24 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>   		req->error_loc = offsetof(struct nvme_rw_command, nsid);
>   		break;
>   	case BLK_STS_IOERR:
> +		switch (req->cmd->common.opcode) {
> +		case nvme_cmd_read:
> +			status = NVME_SC_READ_ERROR;
> +			req->error_loc = offsetof(struct nvme_rw_command,
> +						  slba);
> +			break;
> +		case nvme_cmd_write:
> +			status = NVME_SC_WRITE_FAULT;
> +			req->error_loc = offsetof(struct nvme_rw_command,
> +						  slba);
> +			break;
> +		default:
> +			status = NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
> +			req->error_loc = offsetof(struct nvme_common_command,
> +						  opcode);
> +			break;
> +		}
> +		break;

unrelated hunk.

>   	default:
>   		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>   		req->error_loc = offsetof(struct nvme_common_command, opcode);

