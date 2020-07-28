Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CF3C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:55:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB14207F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IfIQWgtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB14207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IJrT9BxBd4HkHIbT3+sFfL94JAA/lhJblR10FwanBTQ=; b=IfIQWgtHXNpHT6PCKWRNgo2JZ
	8zumRZmts8YD+1vbQXskim1OpSBWC9hhYSL+q2Crz1F9WWEJZaVLKtpWnxKNPkM2VJF9R55DLr/E6
	KKPytkqYjB8369hc5T0SZ4skJ4C8BhEhNfreslbF3R3sZ+YMORT9S53PI4Anjdd4XLoVuYBKdJ3+t
	pgzs0CfWKy4//m8uFfMUG0zqz8GZprZah9yX1av6UNruLTdtOJChSrJuZU7F0BeNtQoxwe12eugXN
	rPZqIDUFFZfIHiQRhAITdY/ZIcPCm6lUY4ypMdcOqzQzJaI23XTAKaVScC43Y5gOwAuag3Cf4hkRY
	te7qMBMaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0JW7-0005Q8-TO; Tue, 28 Jul 2020 06:55:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0JW6-0005PY-CS
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 06:55:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 10CFA68BEB; Tue, 28 Jul 2020 08:55:12 +0200 (CEST)
Date: Tue, 28 Jul 2020 08:55:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2 v2] nvme-rdma: fix controller reset hang during traffic
Message-ID: <20200728065511.GA21572@lst.de>
References: <20200728003209.406197-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728003209.406197-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_025514_587986_2AB94F6D 
X-CRM114-Status: GOOD (  24.30  )
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
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Why is this a 2/2 v2, where is the 1/2?

On Mon, Jul 27, 2020 at 05:32:09PM -0700, Sagi Grimberg wrote:
> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
> exposed an issue where we may hang trying to wait for queue freeze
> during I/O. We call blk_mq_update_nr_hw_queues which in case of multiple
> queue maps (which we have now for default/read/poll) is attempting to
> freeze the queue. However we never started queue freeze when starting the
> reset, which means that we have inflight pending requests that entered the
> queue that we will not complete once the queue is quiesced.
> 
> So start a freeze before we quiesce the queue, and unfreeze the queue
> after we successfully connected the I/O queues (and make sure to call
> blk_mq_update_nr_hw_queues only after we are sure that the queue was
> already frozen).
> 
> This follows to how the pci driver handles resets.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - fix silly compilation errors
> 
>  drivers/nvme/host/rdma.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5c3848974ccb..44c76ffbb264 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -967,15 +967,20 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>  			ret = PTR_ERR(ctrl->ctrl.connect_q);
>  			goto out_free_tag_set;
>  		}
> -	} else {
> -		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
> -			ctrl->ctrl.queue_count - 1);
>  	}
>  
>  	ret = nvme_rdma_start_io_queues(ctrl);
>  	if (ret)
>  		goto out_cleanup_connect_q;
>  
> +	if (!new) {
> +		nvme_start_queues(&ctrl->ctrl);
> +		nvme_wait_freeze(&ctrl->ctrl);
> +		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
> +			ctrl->ctrl.queue_count - 1);
> +		nvme_unfreeze(&ctrl->ctrl);
> +	}
> +
>  	return 0;
>  
>  out_cleanup_connect_q:
> @@ -1008,6 +1013,7 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
>  		bool remove)
>  {
>  	if (ctrl->ctrl.queue_count > 1) {
> +		nvme_start_freeze(&ctrl->ctrl);
>  		nvme_stop_queues(&ctrl->ctrl);
>  		nvme_rdma_stop_io_queues(ctrl);
>  		if (ctrl->ctrl.tagset) {
> -- 
> 2.25.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
