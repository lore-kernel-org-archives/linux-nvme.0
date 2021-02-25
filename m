Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10567C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:32:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE3D64F1C
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE3D64F1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YqyYJAWt12Fnxv34LVj/0tArCR9SMCGbHMHDr81AtNU=; b=apmEYL564Yt6bSEAq8OTcRBZz
	QagdygPsVGcnbri/rufMNL53h4RBoTlWD9Xdk93lPNp4HKMZkHDLoHJVVnKhith1gttVrJGqe5h5t
	JZzYZ3970fzHafnMsqLnujjmJEHJJgSCwQZoe6e9wYNfVA9d75aSl6rE7xNDFCxqQPoTpn7M6Gjwx
	cF6MoW9qLuyvgJWliP374gf1ppmDszx517caToRjHjs9GDW/9gfzvjItZwqYOiERV0Qtik7ZJW/6k
	LmuIUU9Ul25LjT1/Ee/q0vYiby98ybZVDB0to3eSc6bfB8m5e4D9VeAjsDEOV3wBsIy0Y/QuVeg98
	fcRzvr34Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFJYN-0005V9-1l; Thu, 25 Feb 2021 16:31:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFJYK-0005UR-Dm
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 16:31:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B15B364F19;
 Thu, 25 Feb 2021 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614270707;
 bh=Kr6gr//Q33H82QxvBxKL69jjL5dx5QVK7eMZab/hMqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sp1A0DO+oCcrd39+18+4NonwC/C619PloYBeLNuPzVnzHTt5hdN6FzrJl4TWAMjHb
 zvZP1PkQ6t8tSreIh6B94X/Kk/mDrCy++1SgYaajgfCZHAlC6foo42InPMP0WiUCXZ
 YaRf4Ysz7yG0otPw9iYuL2RpfIS3+89pEeGIFVcShNSwccVpqEF1O18vXyRTOck9mM
 03hVMWVNQJHWGYu21XAQRHyhsahT9A4rKK43ddGRmK+HFzJ1jGeSGdnJ1ImquQUi66
 IGfZJ3APbnbzoMVq4DFouJs0x0l7muLO3Vb4dkDpKr0L4QXHV8c6bEh3FxMfYxu+5w
 1crHswiueAytw==
Date: Fri, 26 Feb 2021 01:31:40 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 6/6] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
Message-ID: <20210225163140.GB31593@redsun51.ssa.fujisawa.hgst.com>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-7-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225105527.75277-7-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_113148_685178_480128B8 
X-CRM114-Status: GOOD (  20.03  )
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

On Thu, Feb 25, 2021 at 11:55:27AM +0100, Hannes Reinecke wrote:
> When a command times out we should be returning -ETIMEDOUT in
> nvme_submit_sync_cmd(), and not requiring the caller to guess whether
> a specific NVMe status should be interpreted as a timeout.

This driver has been using -EINTR for this condition since the
beginning, though. Is there a reason I'm not seeing why these use cases
can't use the existing command cancelled flag?
 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 2 ++
>  drivers/nvme/host/fc.c   | 1 +
>  drivers/nvme/host/nvme.h | 1 +
>  drivers/nvme/host/rdma.c | 1 +
>  drivers/nvme/host/tcp.c  | 1 +
>  5 files changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 624531a6b7c6..5c1ec3bfb9d3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1004,6 +1004,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		*result = nvme_req(req)->result;
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>  		ret = -EINTR;
> +	else if (nvme_req(req)->flags & NVME_REQ_TIMEOUT)
> +		ret = -ETIMEDOUT;
>  	else
>  		ret = nvme_req(req)->status;
>   out:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 86395b66310d..bcc086fcbe61 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2551,6 +2551,7 @@ nvme_fc_timeout(struct request *rq, bool reserved)
>  		"x%08x/x%08x\n",
>  		ctrl->cnum, op->queue->qnum, sqe->common.opcode,
>  		sqe->connect.fctype, sqe->common.cdw10, sqe->common.cdw11);
> +	op->nreq.flags |= NVME_REQ_TIMEOUT;
>  	if (__nvme_fc_abort_op(ctrl, op))
>  		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 07b34175c6ce..02aa4ba665c0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -173,6 +173,7 @@ struct nvme_request {
>  enum {
>  	NVME_REQ_CANCELLED		= (1 << 0),
>  	NVME_REQ_USERCMD		= (1 << 1),
> +	NVME_REQ_TIMEOUT		= (1 << 2),
>  };
>  
>  static inline struct nvme_request *nvme_req(struct request *req)
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 53ac4d7442ba..99ad2e10b295 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1990,6 +1990,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
>  	nvme_rdma_stop_queue(queue);
>  	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>  		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
>  		blk_mq_complete_request(rq);
>  	}
>  }
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 69f59d2c5799..64aab742c84d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2189,6 +2189,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>  	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>  	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
>  		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> +		nvme_req(rq)->flags |= NVME_REQ_TIMEOUT;
>  		blk_mq_complete_request(rq);
>  	}
>  }
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
