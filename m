Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE0C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:52:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFC420708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yHE6YRuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFC420708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bPvfbySjrLR3aXgwIV3xqmQlv/pvN/IWXp2hd+3KVzY=; b=yHE6YRuyKDxNzrpw1gP8lbuN4
	EMggFa7uCC9a1CATxFxOtHcXGij1jMKBlO8YhVE6tObaUI4OkiUNTlKzFUROW0aodgQssOqkEP26Q
	TUrqfAN8+9xpbTBSgz5z8fN64BS9XEcJF9JrXk0L8ZdXjgC5uflgEPTzJcXuG3AWybExNxCYAVpru
	qw9fdNP8Op8TPMkSqcdd0WifLyMDf/GMy+5xexDcXzL1pj5VQZIlVvNxrlAHw8F18C5T/jIBe8LoQ
	a4Wn82QEE2Pcx4RkBOJgdblMr3Af3aEIHdNEUB2L8vvcKHpQUemUrniRTifbSwVCVbptK8BU2wSrE
	uqonC3ryw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6TZs-0006RS-7Q; Fri, 14 Aug 2020 06:52:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6TZp-0006Qv-CW
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:52:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C6A9668CEE; Fri, 14 Aug 2020 08:52:30 +0200 (CEST)
Date: Fri, 14 Aug 2020 08:52:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
Message-ID: <20200814065230.GD1719@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200806191127.592062-8-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_025233_565955_A6864059 
X-CRM114-Status: GOOD (  23.69  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06, 2020 at 12:11:26PM -0700, Sagi Grimberg wrote:
> Currently we check if the controller state != LIVE, and
> we directly fail the command under the assumption that this
> is the connect command or an admin command within the
> controller initialization sequence.
> 
> This is wrong, we need to check if the request risking
> controller setup/teardown blocking if not completed and
> only then fail.

FYI: you can use up to 73 characters in the commit log..

> +++ b/drivers/nvme/host/rdma.c
> @@ -1185,6 +1185,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>  	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>  		return;
>  
> +	dev_warn(ctrl->ctrl.device, "starting error recovery\n");

Should this really be a warning?  I'd turn this down to _info.

> +static void nvme_rdma_complete_timed_out(struct request *rq)
> +{
> +	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_rdma_queue *queue = req->queue;
> +	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
> +
> +	/* fence other contexts that may complete the command */
> +	mutex_lock(&ctrl->teardown_lock);
> +	nvme_rdma_stop_queue(queue);
> +	if (blk_mq_request_completed(rq))
> +		goto out;
> +	nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +	blk_mq_complete_request(rq);
> +out:

Nit: I'd probably avoid the goto here for a slightly simpler flow.

>  {
> @@ -1961,29 +1979,43 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
>  	dev_warn(ctrl->ctrl.device, "I/O %d QID %d timeout\n",
>  		 rq->tag, nvme_rdma_queue_idx(queue));
>  
> +	switch (ctrl->ctrl.state) {
> +	case NVME_CTRL_RESETTING:
> +		if (!nvme_rdma_queue_idx(queue)) {
> +			/*
> +			 * if we are in teardown we must complete immediately
> +			 * because we may block the teardown sequence (e.g.
> +			 * nvme_disable_ctrl timed out).
> +			 */

Please start the setence with an upper case character.

> +			nvme_rdma_complete_timed_out(rq);
> +			return BLK_EH_DONE;
> +		}
> +		/*
> +		 * Restart the timer if a controller reset is already scheduled.
> +		 * Any timed out commands would be handled before entering the
> +		 * connecting state.
> +		 */
>  		return BLK_EH_RESET_TIMER;
> +	case NVME_CTRL_CONNECTING:
> +		if (reserved || !nvme_rdma_queue_idx(queue)) {
> +			/*
> +			 * if we are connecting we must complete immediately
> +			 * connect (reserved) or admin requests because we may
> +			 * block controller setup sequence.
> +			 */
> +			nvme_rdma_complete_timed_out(rq);
> +			return BLK_EH_DONE;

A goto to share the immediate completion branch would be nice.  I wonder
if we should also do it for the reserved case during shutdown even if
that should never happen and entirely share the code, though:

	switch (ctrl->ctrl.state) {
	case NVME_CTRL_RESETTING:
	case NVME_CTRL_CONNECTING:
		/*
		 * If we are connecting or connecting, we must complete
		 * connect (reserved) or admin requests immediately, because
		 * they may block the controller setup or teardown sequence.
		 */
		if (reserved || !nvme_rdma_queue_idx(queue)) {
			nvme_rdma_complete_timed_out(rq);
			return BLK_EH_DONE;
		}
		break;
	default:
		break;
	}

	nvme_rdma_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
