Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A762EC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 10:25:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758DB20719
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1T751gTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758DB20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XHyHN7xwGM7Pacc0dQlK+oUTKj0f8OBmGYVGwI2Pygw=; b=1T751gTPGWl+IlBECFz21iv0n
	/Y0NXZjBwdC5Gy6eFqwa08IvenLwsX5xb1TcIo5y/EWw14QK4+j0aDp6i5114zjNZnkq1U3dSbYHo
	oykr7XQ3TouSp/AkYYqwKitbnY90F1IWzXhPNzjJnxLeW9yhi6umh5h+eXXayET+4SL/sr165wbqf
	yNx+6xWmieblYcpBuFSVULRQyI2u54+gkpYexpTS0lUoOM4PATYN9qk0ZQ81r8jCmGByTynQ/+THq
	5jnVIKnrMoTlSkTaPTWB5u/ZiS9Ko9p+l33SDJvekUjtEFcfNZjpLwOFE3QCAnXCfD4Cv8xkPvsLP
	8+s9D+6+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2Xej-0000Ji-CS; Mon, 03 Aug 2020 10:25:21 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2Xef-0000IE-Vc
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 10:25:19 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EC248A083D1D46847631;
 Mon,  3 Aug 2020 18:25:08 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 3 Aug 2020 18:25:05 +0800
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, James Smart
 <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
Date: Mon, 3 Aug 2020 18:25:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200803065852.69987-6-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_062518_561460_723C0546 
X-CRM114-Status: GOOD (  27.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/8/3 14:58, Sagi Grimberg wrote:
> Currently we check if the controller state != LIVE, and
> we directly fail the command under the assumption that this
> is the connect command or an admin command within the
> controller initialization sequence.
> 
> This is wrong, we need to check if the request risking
> controller setup/teardown blocking if not completed and
> only then fail.
> 
> The logic should be:
> - RESETTING, only fail fabrics/admin commands otherwise
>    controller teardown will block. otherwise reset the timer
>    and come back again.
> - CONNECTING, if this is a connect (or an admin command), we fail
>    right away (unblock controller initialization), otherwise we
>    treat it like anything else.
> - otherwise trigger error recovery and reset the timer (the
>    error handler will take care of completing/delaying it).
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 67 +++++++++++++++++++++++++++++-----------
>   1 file changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 44c76ffbb264..a58c6deaf691 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1180,6 +1180,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>   		return;
>   
> +	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
>   	queue_work(nvme_reset_wq, &ctrl->err_work);
>   }
>   
> @@ -1946,6 +1947,22 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>   	return 0;
>   }
>   
> +static void nvme_rdma_complete_timed_out(struct request *rq)
> +{
> +	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_rdma_queue *queue = req->queue;
> +	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
> +
> +	/* fence other contexts that may complete the command */
> +	flush_work(&ctrl->err_work);
> +	nvme_rdma_stop_queue(queue);
There maybe concurrent with error recovery, may cause abnormal because
nvme_rdma_stop_queue will return but the queue is not stoped,
maybe is stopping by the error recovery.
> +	if (blk_mq_request_completed(rq))
> +		return;
> +	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
> +	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +	blk_mq_complete_request(rq);
> +}
> +
>   static enum blk_eh_timer_return
>   nvme_rdma_timeout(struct request *rq, bool reserved)
>   {
> @@ -1956,29 +1973,43 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
>   	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
>   		 rq->tag, nvme_rdma_queue_idx(queue));
>   
> -	/*
> -	 * Restart the timer if a controller reset is already scheduled. Any
> -	 * timed out commands would be handled before entering the connecting
> -	 * state.
> -	 */
> -	if (ctrl->ctrl.state == NVME_CTRL_RESETTING)
> +	switch (ctrl->ctrl.state) {
> +	case NVME_CTRL_RESETTING:
> +		if (!nvme_rdma_queue_idx(queue)) {
> +			/*
> +			 * if we are in teardown we must complete immediately
> +			 * because we may block the teardown sequence (e.g.
> +			 * nvme_disable_ctrl timed out).
> +			 */
> +			nvme_rdma_complete_timed_out(rq);
> +			return BLK_EH_DONE;
> +		}
> +		/*
> +		 * Restart the timer if a controller reset is already scheduled.
> +		 * Any timed out commands would be handled before entering the
> +		 * connecting state.
> +		 */
>   		return BLK_EH_RESET_TIMER;
> -
> -	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
> +	case NVME_CTRL_CONNECTING:
> +		if (reserved || !nvme_rdma_queue_idx(queue)) {
> +			/*
> +			 * if we are connecting we must complete immediately
> +			 * connect (reserved) or admin requests because we may
> +			 * block controller setup sequence.
> +			 */
> +			nvme_rdma_complete_timed_out(rq);
> +			return BLK_EH_DONE;
> +		}
> +		/* fallthru */
> +	default:
>   		/*
> -		 * Teardown immediately if controller times out while starting
> -		 * or we are already started error recovery. all outstanding
> -		 * requests are completed on shutdown, so we return BLK_EH_DONE.
> +		 * every other state should trigger the error recovery
> +		 * which will be handled by the flow and controller state
> +		 * machine
>   		 */
> -		flush_work(&ctrl->err_work);
> -		nvme_rdma_teardown_io_queues(ctrl, false);
> -		nvme_rdma_teardown_admin_queue(ctrl, false);
> -		return BLK_EH_DONE;
> +		nvme_rdma_error_recovery(ctrl);
>   	}
>   
> -	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
> -	nvme_rdma_error_recovery(ctrl);
> -
>   	return BLK_EH_RESET_TIMER;
>   }
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
