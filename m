Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4553EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:43:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D8464E83
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D8464E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2ZGTRQ6IvN/COaHOqP/5NxEin6yKYT1rswGZdjz/Hvo=; b=v+S8WK6eLqHj8FlSeUnQNJhp+
	94Z7m2DZxGWunO+Q+Y44ItJcyXeLV2jfdkxHRkPfY59jWmQWL1XGNhkdvyK0pZJEGgdnxUG9o3Woo
	3pdxG1uu7AUgDQYMbVaGRLxEAuuWufkqpG2bnNryMTSioYqPbIN7aNJz+huXHYJxVDueb9Bu2cwDr
	P5PBxYZizShbPcSMQSJYwFxzagc0Ig4PZuXp0OXWD+ECIeDOR5+I8K0cVMKO0YFJWJLxV6/XNF8CI
	b9BqqoN/WFHG9eOYGt04dV05qDQSUoHyr++kXCmG4bDLjymInMmnyHU4r9zLWYSDp+IGNjFfzYf5h
	wLvr43bxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFJjQ-0006uR-6d; Thu, 25 Feb 2021 16:43:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFJjM-0006u2-Om
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 16:43:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C07CF64E83;
 Thu, 25 Feb 2021 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614271391;
 bh=kGeOkAWDGDckcYnVCbWjhVKFbi9Dlf6RUJczrfGWTfc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FXxnjP6Qur4aqfdqpq6NSMX291Z+HjqNJZoXJzHfOIkNx8W7Bln3Woq9w9IaqDy8p
 kZXu3mythYLzH63ps+FIcKQIsSOpczw7M5n/x5pki41S8jxNpOB07eeMDHtqNnit7a
 cxnZYsqrdw6fvLhLvfq7mH0U/4twSAUKd5geC90n6pd+gBpctblIpmzukAE53OPhLA
 Er8r8vFy6H0Zm2VqIccB16KHS+YamBt29+ZG1Lc5f5vKXTA69CELP5Y8pKVTNIgWWJ
 phJlnM7fEq3Y4JkPVCtNKVfMXlGfW/jDXEnVyibw/lrOCxfR40nN2JPfMcGQFd9Y+S
 lwdUzrPOPgv6g==
Date: Fri, 26 Feb 2021 01:43:08 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/6] nvme: return NVME_SC_ABORT_QUEUE for cancelled
 commands
Message-ID: <20210225164308.GE31593@redsun51.ssa.fujisawa.hgst.com>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-6-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225105527.75277-6-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_114312_894259_DF4DAEB4 
X-CRM114-Status: GOOD (  18.48  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 25, 2021 at 11:55:26AM +0100, Hannes Reinecke wrote:
> A request will be cancelled when a queue is deleted, so we should
> be returning a status of NVME_SC_ABORT_QUEUE.

I'm not sure if this makes sense. The controller didn't return a status
in this case, so the host is reclaiming the command absent a status from
the controller. Is there a particular situation where this patch
matters?
 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  drivers/nvme/host/fc.c   | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 04dc85e0810c..624531a6b7c6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -379,7 +379,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>  	if (blk_mq_request_completed(req))
>  		return true;
>  
> -	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> +	nvme_req(req)->status = NVME_SC_ABORT_QUEUE;
>  	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>  	blk_mq_complete_request(req);
>  	return true;
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 97e3424c7b03..86395b66310d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1955,9 +1955,12 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
>  				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
>  
> -	if (opstate == FCPOP_STATE_ABORTED)
> -		status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
> -	else if (freq->status) {
> +	if (opstate == FCPOP_STATE_ABORTED) {
> +		if (op->nreq.flags & NVME_REQ_CANCELLED)
> +			status = cpu_to_le16(NVME_SC_ABORT_QUEUE << 1);
> +		else
> +			status = cpu_to_le16(NVME_SC_HOST_ABORTED_CMD << 1);
> +	} else if (freq->status) {
>  		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
>  		dev_info(ctrl->ctrl.device,
>  			"NVME-FC{%d}: io failed due to lldd error %d\n",
> -- 
> 2.29.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
