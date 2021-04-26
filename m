Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE3C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:46:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D132460E0C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 14:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D132460E0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tOYh/qPyHyW7wpui4jKN0fpfEA724bpDxtBuFnB/KLE=; b=YCftqSX8aF3+GhXU7GizwZNdv
	xTuzfnMrpIa2IosgK+2DixjFdPEUtOnwW8XaUeG2Iuhu5onB2LRgnpMFAm1w3q76bhimWeo0CRc4m
	SUKz8JULpcsk+4mC/rRi3fQYgqjIm0wNMmIsVcVOO2SIaxb8QI7WQIQaLE81Nj8IYkfWUjxID9/kg
	1PMeV+5LTWCes/raohrzw2+4xixda1okdhBlXAf+sQ0EWg0GLK2L4AuZm/RDPPgHsiZICPDyosFA9
	0kfOTngeAnPoVX2tksAH4r9UovSAw8Em6alEJWWMjnDDYMV9P7g06aX5J5lvvB5ZvdDBdcYQVSEz2
	wgHHGCP2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2VQ-007sji-0r; Mon, 26 Apr 2021 14:46:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2RO-007rxW-SS
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 14:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rqukxRmjq3kil5H6O5NkttRRk5qSG6OkDNGS0RtXlSA=; b=RJG+XPuyOfmsfgHQJ4ImeD+8dL
 ENNJFtZ6LJXWC45/fRHED/cxCWurgaoYldU8yR6S7wZ498ytir6zwundbv3M3e7+tYD1UkAi5ZT/U
 vlhkkxDrnwisWsIpxvQFlRfMnhtZL7t1zi0V8+FwF27w4TeGoDNYM1X+dDMCzr9rrHDDisqs/cbYe
 X8sh+690pYmqS3K3p6bqHtUYPxMszEnFm1kbKNdvJu3qU7UqWHuu1uOUyAQNJxWQBk8N7jSwNkpzf
 O5ObfdwsFVi4qeuvb3/z5S3pR+Gvka0klcqknMU7syGbH2JG4RD69/29GBrN49JVq3PsiLvR7b6+a
 4ybsFz4w==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2RL-00G1M4-7Q
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 14:42:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D24C068C4E; Mon, 26 Apr 2021 16:42:17 +0200 (CEST)
Date: Mon, 26 Apr 2021 16:42:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org,
 Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
Message-ID: <20210426144216.GD20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_074223_434855_8E5633CC 
X-CRM114-Status: GOOD (  24.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 23, 2021 at 03:05:57PM -0700, Keith Busch wrote:
> We don't have an nvme status to report if the driver's .queue_rq()
> returns an error without dispatching the requested nvme command. Use the
> return value from blk_execute_rq() for all passthrough commands so the
> caller may know their command was not successful.
> 
> If the command is from the target passthrough interface and fails to
> dispatch, synthesize the response back to the host as a internal target
> error.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c       | 16 ++++++++++++----
>  drivers/nvme/host/ioctl.c      |  6 +-----
>  drivers/nvme/host/nvme.h       |  2 +-
>  drivers/nvme/target/passthru.c |  8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 10bb8406e067..62af5fe7a0ce 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  			goto out;
>  	}
>  
> -	blk_execute_rq(NULL, req, at_head);
> +	ret = blk_execute_rq(NULL, req, at_head);
>  	if (result)
>  		*result = nvme_req(req)->result;
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>  		ret = -EINTR;
> -	else
> +	else if (nvme_req(req)->status)
>  		ret = nvme_req(req)->status;

Just cosmetic, and already in the existing code, but I'd prefer if we
could keep the ret assignments together, something like:

	status = blk_execute_rq(NULL, req, at_head);
  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
	else if (nvme_req(req)->status)
		ret = nvme_req(req)->status;
	else
		ret = blk_status_to_errno(status);

 	if (result)
 		*result = nvme_req(req)->result;

> +	ret = blk_execute_rq(disk, rq, 0);
>  	if (effects) /* nothing to be done for zero cmd effects */
>  		nvme_passthru_end(ctrl, effects);
> +
> +	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
> +		ret = -EINTR;
> +	else if (nvme_req(rq)->status)
> +		ret = nvme_req(rq)->status;
> +

I think we want a helper for all this return value magic instead of
duplicating it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
