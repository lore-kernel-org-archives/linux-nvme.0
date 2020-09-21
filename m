Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D47C43465
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:08:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8FA2076E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zIvea2ux";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zSZlx7OJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8FA2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rJf7JiEwXKMP4Bff1fW3fSvC1/MWA07mTNXXDjUm5/A=; b=zIvea2uxmuXZoTECD/Y1gZysq
	830jxsUyIbNMm5pXkvNxHQ98e6qFJIuuLfwLnyReLOB0AuIznIMaLn8q7U7nUGUTuF0tkVs3Lqb7f
	qDASOHwWyFsdlYxblRiN8sLBP5NbCde+XAploIv5VoSZs+JceLctvNBZN/7j5LMWHHvL6ehtZVW2W
	RkVU+U7CyE13dQLMcsmPTh6t5q0y6VsDz3RXA4LM+sFPcZCDoHk4DshTSEClUhRx5y20eMj7ZKP/2
	AjVfq4V2BKnc63kQsB8/qyzLP/6gtYQzK6NPyL5ENzD7y6tk7AJrXMRi7GB2W+LuLiC3QWEpBTINH
	jz5YbQcqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKNQm-0005Qw-IT; Mon, 21 Sep 2020 15:08:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKNQl-0005Q9-1n
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 15:08:39 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC00C2075E;
 Mon, 21 Sep 2020 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600700917;
 bh=GEfKBDsAq9Cn4LzuqJLcIihd6H6TDcY0ig26pwzvOu0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zSZlx7OJA7OyfF9J5l44+k6f8IVBUKDnylqW7KkV1ZVRwCJx+zSfr8oDEiJKtP1IK
 g5aP48XSvXBMN4bXc9ytiUWSn2M9Gj/INQbLERiHnXiLcxRXJ/49vYo3U79ZocFNKe
 Z5Ip7591VPGM63DBJNo9GMxUMZXQ034BW21evelY=
Date: Mon, 21 Sep 2020 08:08:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Xianting Tian <tian.xianting@h3c.com>
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Message-ID: <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921021052.10462-1-tian.xianting@h3c.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_110839_162692_6309D58E 
X-CRM114-Status: GOOD (  17.38  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 21, 2020 at 10:10:52AM +0800, Xianting Tian wrote:
> @@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
>  	struct request *req;
>  
> -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> -		dev_warn(nvmeq->dev->ctrl.device,
> -			"invalid id %d completed on queue %d\n",
> -			cqe->command_id, le16_to_cpu(cqe->sq_id));
> -		return;
> -	}
> -
>  	/*
>  	 * AEN requests are special as they don't time out and can
>  	 * survive any kind of queue freeze and often don't respond to
> @@ -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
>  	}
>  
>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (unlikely(!req)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"req is null for tag %d completed on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}

This is making sense now, though I think we should retain the existing
dev_warn() since it's still accurate and provides continuity for people
who are used to looking for these sorts of messages.

Your changelog is a bit much though. I think we can say it a bit more
succinctly. This is what I'm thinking:

  The driver registers interrupts for queues before initializing the
  tagset because it uses the number of successful request_irq() calls
  to configure the tagset parameters. This allows a race condition with
  the current tag validity check if the controller happens to produce
  an interrupt with a corrupted CQE before the tagset is initialized.

  Replace the driver's indirect tag check with the one already provided
  by the block layer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
