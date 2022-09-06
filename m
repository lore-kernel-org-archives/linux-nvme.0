Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB50ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2uos4qcq77XyZi+QLWSsLxTIMm4PMSnC9k0cFgolUE=; b=Mse8xTy4FdjWMrTGdoGppp3yoi
	CDP4fiL+fLpDsKGrqHiCCRNmeHUC+JArVDRIT/t5k7IyYZv668gsd9PtIuTQXfSh/Lq5pPjSc4bIv
	05RpLhcHre3XF6nlvW0ja26+fDFzhZ3NZW9Qweb9M+XJpPOJ2EGEDMiiKA4FGhatcRFEVSU7jr4SF
	7vFk6jXqj4DxoEgVQ0BqRDAscoPfdVM0yd2mkiNQlG25Zoc6MaK4VNZ1PQp2ay54ZS5dbVJaE3ACH
	c9s5VjxlZkTMCelggQyL75Y95BLj6RTxy9ywq6+3y5nOV1vL+uKAnbHVneulP9ySY5kLwgouh0qjI
	4a5yeCSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVcTF-00Fzaa-4i; Tue, 06 Sep 2022 17:34:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVcQd-00Fxqr-6o
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 17:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662485521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2uos4qcq77XyZi+QLWSsLxTIMm4PMSnC9k0cFgolUE=;
	b=RilR1HioO2Xpu+lVlZPHVVMfUZacR0ZjuiYDG5lIFzEZo/yAjU5txgEzkYoKhPOrQ5oIl9
	Fj2LJLA7Iqbkz89Lj5iPgwMuftHPO385wgZQeYDtlhReXmBzYc/Pc8YXWR+8GuHlRZi0AU
	U1KXSiTfgfFTvEDRjvdAYm+8msydA3c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-ddyU9z8RMQWmK8GhD_uTaQ-1; Tue, 06 Sep 2022 13:30:06 -0400
X-MC-Unique: ddyU9z8RMQWmK8GhD_uTaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32A321C006AB;
	Tue,  6 Sep 2022 17:30:06 +0000 (UTC)
Received: from [10.22.8.246] (unknown [10.22.8.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C40F340C141D;
	Tue,  6 Sep 2022 17:30:05 +0000 (UTC)
Message-ID: <86f1824d-72d4-72e3-0071-4a07aeb04b7b@redhat.com>
Date: Tue, 6 Sep 2022 13:30:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nvme-tcp: delay error recovery after link drop
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20220714122703.67621-1-hare@suse.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220714122703.67621-1-hare@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_103203_502540_9530EF81 
X-CRM114-Status: GOOD (  30.81  )
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

I think the problem Hannes is trying to address with this patch is: the Spec currently says:

Base 2.0 3.3.2.4

If an NVMe Transport connection is lost as a result of an NVMe Transport error, then before performing
recovery actions related to commands sent on I/O queues associated with that NVMe Transport connection,
the host should wait for at least the longer of:

- the NVMe Keep Alive timeout; or
- the underlying fabric transport timeout, if any.

I'm not sure the NVMe/TCP host stack obeys this rule.

The problem is, when the host fails to follow this rule, some NVMe/TCP controllers are found to corrupt data during cable pull 
tests.

/John

On 7/14/22 08:27, Hannes Reinecke wrote:
> When the connection unexpectedly closes we must not start error
> recovery right away, as the controller might not have registered
> the connection failure and so retrying commands directly will
> might lead to data corruption.
> So wait for KATO before starting error recovery to be on the safe
> side; chances are the commands will time out before that anyway.
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
>   	default:
>   		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>   		req->error_loc = offsetof(struct nvme_common_command, opcode);


