Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D14C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:54:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF502173E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OhIxFeex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T047mYy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF502173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lwwnCVbnEAZ4PRvkBNZUS8eQQQDHSMZhylI7nWcEopU=; b=OhIxFeex/qCAdJWKLB7J2E37l
	HRfsXQenD42rEp65UuNppaJrQwFOoHphh62EmwkiAox17QvwGS5t+Z4HEb/cN2uPTYAG1Zgx23/U+
	cPcOy2BxGdgBkq8EbupOERYvlNRR7/qCYeW7dgoIAb/BGMrQNPC3wvM0mJfhmh/AFZ5QSbsqHfO3A
	vW4vHmvLYF/Soo0szuOmVhZmcoQpad4EkQ54JOzNYAyqAzCXy8U3+yEQphBsrqubLuU1dUhmjfddz
	Wun3OX4Qdy80zFHN92O8PGJpWGPYeSlGhETMsxAwKAIg7zTdHjXZPXiGxxNeItBMcySskROXq+JzE
	u/znzkHtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3ly5-0001td-SN; Thu, 06 Aug 2020 19:54:25 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3ly3-0001sd-Ix
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:54:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596743662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hj5x0qXFdph81A07hffdEjVdvBdvVRLRqnyJmIJbkLM=;
 b=T047mYy6MrC7UpMW1zmO6WBtxe1R+8cQA8hGVbqKRuSWhDhcbT2nPHSAw0DQNsYe+U8DcO
 Knj+DvUinVKoy5X/6XG81ifpW4FkFyJfSbOU9D9iKaNPeXub8DIFgxWJhpkFMp8sHX+rtI
 RB169O3owRyc/hXjVIaDB30qNWQVvKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-8U-JM77JMC6zEFCEslFVUA-1; Thu, 06 Aug 2020 15:52:48 -0400
X-MC-Unique: 8U-JM77JMC6zEFCEslFVUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C5D31009447;
 Thu,  6 Aug 2020 19:52:47 +0000 (UTC)
Received: from [10.10.112.205] (ovpn-112-205.rdu2.redhat.com [10.10.112.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41CDE1001B2B;
 Thu,  6 Aug 2020 19:52:43 +0000 (UTC)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <f2d0d1cb-f4d5-4b47-4b76-ba7d5198c74d@redhat.com>
Date: Thu, 6 Aug 2020 14:52:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200803065852.69987-6-sagi@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_155423_673506_E2382BFA 
X-CRM114-Status: GOOD (  32.30  )
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


Hi Sagi,

On 08/03/2020 01:58 AM, Sagi Grimberg wrote:
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
> +	flush_work(&ctrl->err_work) > +	nvme_rdma_stop_queue(queue);
> +	if (blk_mq_request_completed(rq))
> +		return;
> +	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
> +	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +	blk_mq_complete_request(rq);


If keep_alive times out, is is possible we try and
blk_mq_free_request() twice for same request.

blk_mq_complete_request
  nvme_rdma_complete_rq
   blk_mq_end_request
    __blk_mq_end_request
     rq->end_io(rq, error) - nvme_keep_alive_end_io
      blk_mq_free_request
       __blk_mq_free_request
         rq->mq_hctx = NULL;
.
.
.
return BLK_EH_DONE to blk_mq_rq_timed_out

And then before returning from blk_mq_check_expired
back down

rq->end_io(rq, 0)
  nvme_keep_alive_end_io
   blk_mq_free_request
    atomic_dec(&hctx->nr_active)

since rq->mq_hctx is now NULL, crash in blk_mq_free_request

Thanks,
David



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
