Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5939BCD8C8E
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xGwj67mAdvjyet/J2nHlIYGQH//k5ItlM0+5UXPSkLM=; b=0Ex36hrFirAN6kWpgGn9E4cw73
	VW/0jva60FlJQdExrDV6BwEihnpGsUnfZ/+LrJmm1ewMnbxhxTZnsl+qlWzZnzS8oZ8AvDH601uFD
	zM0WDvoMMPtRe8mrUCAbArNOAMEQWYrYR1CVqo4Gf+1SS5VjHYZNPaOsZ2aItDsAu2Ro4mS4dG6vb
	CXEjAk2dHKQ1RTOm4mRFscOo2VXH/lqPrN3XOA5aoB2xgWuqqC+wFXTsHhccPWxXb4BGj7CgDVaP/
	phylbiD4irpUaJ4wuZBrFzQcEmJbIJBMn0kP3x/+weyK1imjhHThpWP8LZuDM5RsYLl44Cu/RehlY
	ecce9EFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVs1q-00000001dxl-1psv;
	Sat, 06 Jun 2026 14:29:38 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVs1m-00000001dwy-3piW
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 14:29:36 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so31043645e9.0
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780756172; x=1781360972; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGwj67mAdvjyet/J2nHlIYGQH//k5ItlM0+5UXPSkLM=;
        b=KZ16gS5NThNPk9g+4YL1pEXjOD2uEMNWu/MMhrf1UeYsVj3nbxrXX4ltTqq2XoTDPN
         c5XmEnHil1OfT3pdE0AWpe0b5G1dMZUeWNxsAkl46hei/0X1GP9ELb7EGryQaG5p0yZT
         vAvvu5IOCZB3CUUdzc7/4fs4kSQWqS2w6aPdq0Gdlc4gjwsacX+nIKZyEjd085u9owU6
         5nmVGOAWovCjnOG1byHiLK9/Se6sPni8ss1bYB8GTnCISIPLrJDyxRkP48qzs0Ufy1sX
         tOObEa13tpndXjWsoHmyLCVD2PIcleNDbB+9Ib67mKYfQBlw04gl/Oh3SBy6KLpQJqR5
         OhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780756172; x=1781360972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGwj67mAdvjyet/J2nHlIYGQH//k5ItlM0+5UXPSkLM=;
        b=iF9CIayShHLxrYbN7NvebVO6WjoOhopARmldvmZI/MYaXm8ftqT9sObIzP/PWawxhi
         9D2tZiTHwuFdZmpRKhrGqEsw1Y5Logol00TrLR2oc0YWa96B96HqJisLddfEpZ3SUMG4
         4YNH/oGhfPP2UdXnEQnF0oHcisRu8fRWicpIMI0MxpSkQ9zN1Z//ArQnRkP1ojXLZ/b0
         +gCuBv7oo7lzvcg+Myu8zKOxRFElpQv7RHbBDbXqr582IupH2Js51VBw63aptlxSr5Nx
         O19+Oxan+QcD+WWEjndIvnGnkDEvC8vZIhJ3BhATLgqy2izM09AmATKcCeQ+9li3CEyl
         Rn7A==
X-Forwarded-Encrypted: i=1; AFNElJ+jGC0m3Gz60SgiCtSv1SY+Kc7auhxLPKMq8sWj+0H1LTI+mcKgGKnRwJ47Igj1DoHD8b1shAuPKvTs@lists.infradead.org
X-Gm-Message-State: AOJu0YxF+DnrlIhwcTvR6HXtehgNsbgCtY+qAMjUhPiKGobysnBnyr+g
	4jFxikFCH5o5Ln+GGPvhxpDjmPQS2rXFGYvg0h3MBOvJ1q880r5t464K
X-Gm-Gg: Acq92OFB1ShR5kMTPmZ87OkHZ1Z1kHDjSDREv24+b8T+j/Dle4fADtaW6TcdvnGX+6P
	zSbzdBFQx/ldpghoCl7YrDBuYsEMTlYGxnmsla1LVN1/v3fdPCYcGzdxgCTfVyslAfbcjOk/ehh
	D30e0ZCKJYOb2HP3LzRtcO1tPD7jNXANhr95yVjQcbzs7ZhzNNB+FPGeWvtKWLMH+ablutIvqAX
	CIWpCQTDKSFAS3sK5rPxMVxy+gZzkdJ+8qzPmQT2PPA16QFUsol9ccVjbhxGx1iFo6qpqlW98A4
	O5eXwyZ2bRT3AkbsLITPIQYo+Sbol0R1dfLzJhlPBXmvEFwG+bQCx2yHPvKTatZu6Kxaxpa2u3m
	44yIb1JOMu/c6idOF4+rBIcvOXySAHn28sGhewaVsp+FL975zKk9zsUCaB3q5uVPmPeN6jGMfFn
	iTQItYs/r746szq23JXnG+VtpuHDtyMVOo+s5TjZTD8KOotmI34A6hhAJQk5ClnECeSwp5thQ=
X-Received: by 2002:a05:600c:3153:b0:490:b8c0:d46a with SMTP id 5b1f17b1804b1-490c2604790mr138043675e9.22.1780756172286;
        Sat, 06 Jun 2026 07:29:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm36003622f8f.13.2026.06.06.07.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:29:32 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:29:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa
 <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yuriy Havrylyuk
 <yhavry@gmail.com>
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues
 even if tag space is shared
Message-ID: <20260606152930.6f2bf4ed@pumpkin>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
	<20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_072934_990293_F27C10BB 
X-CRM114-Status: GOOD (  29.21  )
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

On Sat, 06 Jun 2026 21:25:26 +0800
Nick Chan <towinchenmi@gmail.com> wrote:

> From: Yuriy Havrylyuk <yhavry@gmail.com>
> 
> Apple NVMe controllers require tags of pending commands to not be shared
> across admin and IO queues. However, on Apple A11 without linear SQ, it is
> not possible for either queue to skip over some tags and must go from 0 to
> the configured maximum before wrapping around.
> 
> If a pending command tag is duplicated across queues, the firmware
> crashes with: "duplicate tag error for tag N", with N being the tag.
> 
> Instead of partitioning the tag space, which is not possible without
> linear SQ, prevent tag collisions by keeping track of which tags are
> currently in-flight across either queues, and return BLK_STS_RESOURCE to
> temporaily block command submission when a collision would have occurred.

I look at using the atomic64_xxx() functions rather than the bitmask ones.
The for_each_bit_set() loop is then an atmomic64_andnot() call.

-- David


> 
> Cc: stable@vger.kernel.org
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Signed-off-by: Yuriy Havrylyuk <yhavry@gmail.com>
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/nvme/host/apple.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index c1115e27a0d6..6354edf27225 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -203,6 +203,20 @@ struct apple_nvme {
>  
>  	int irq;
>  	spinlock_t lock;
> +
> +	/*
> +	 * Tags of pending commands must be unique across both Admin and IO
> +	 * queue. However, on T8015, unlike T8103, without linear submission
> +	 * queues, it is not possible for the either queue to skip some tags,
> +	 * and both queues must go from 0 to their respective configured
> +	 * maximum.
> +	 *
> +	 * Instead of reserving some tags for the admin queue, use a bitfield
> +	 * to keep track of pending commands on either queue, and temporaily
> +	 * block command submission by returning BLK_STS_RESOURCE until the
> +	 * tag is freed on the other queue.
> +	 */
> +	unsigned long t8015_active_tags;
>  };
>  
>  static_assert(sizeof(struct nvme_command) == 64);
> @@ -290,6 +304,28 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
>  				     "NVMMU TCB invalidation failed\n");
>  }
>  
> +static bool apple_nvme_reserve_tag_t8015(struct apple_nvme *anv,
> +					 struct nvme_command *cmd)
> +{
> +	u16 tag = nvme_tag_from_cid(cmd->common.command_id);
> +
> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
> +		return false;
> +
> +	return !test_and_set_bit(tag, &anv->t8015_active_tags);
> +}
> +
> +static void apple_nvme_release_tag_t8015(struct apple_nvme *anv,
> +					 __u16 command_id)
> +{
> +	u16 tag = nvme_tag_from_cid(command_id);
> +
> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
> +		return;
> +
> +	clear_bit(tag, &anv->t8015_active_tags);
> +}
> +
>  static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
>  				  struct nvme_command *cmd)
>  {
> @@ -652,6 +688,8 @@ static inline void apple_nvme_update_cq_head(struct apple_nvme_queue *q)
>  static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>  			       struct io_comp_batch *iob)
>  {
> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
> +	unsigned long completed_tags = 0;
>  	bool found = false;
>  
>  	while (apple_nvme_cqe_pending(q)) {
> @@ -664,11 +702,26 @@ static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>  		dma_rmb();
>  		apple_nvme_handle_cqe(q, iob, q->cq_head);
>  		apple_nvme_update_cq_head(q);
> +
> +		if (!anv->hw->has_lsq_nvmmu) {
> +			struct nvme_completion *cqe = &q->cqes[q->cq_head];
> +			u16 tag = nvme_tag_from_cid(READ_ONCE(cqe->command_id));
> +
> +			if (!WARN_ON_ONCE(tag >= BITS_PER_LONG))
> +				__set_bit(tag, &completed_tags);
> +		}
>  	}
>  
>  	if (found)
>  		writel(q->cq_head, q->cq_db);
>  
> +	if (!anv->hw->has_lsq_nvmmu && completed_tags) {
> +		unsigned long tag_bit;
> +
> +		for_each_set_bit(tag_bit, &completed_tags, BITS_PER_LONG)
> +			clear_bit(tag_bit, &anv->t8015_active_tags);
> +	}
> +
>  	return found;
>  }
>  
> @@ -790,6 +843,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (ret)
>  		return ret;
>  
> +	if (!anv->hw->has_lsq_nvmmu &&
> +	    !apple_nvme_reserve_tag_t8015(anv, cmnd)) {
> +		ret = BLK_STS_RESOURCE;
> +		goto out_free_cmd;
> +	}
> +
>  	if (blk_rq_nr_phys_segments(req)) {
>  		ret = apple_nvme_map_data(anv, req, cmnd);
>  		if (ret)
> @@ -806,6 +865,9 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return BLK_STS_OK;
>  
>  out_free_cmd:
> +	if (!anv->hw->has_lsq_nvmmu)
> +		apple_nvme_release_tag_t8015(anv, cmnd->common.command_id);
> +
>  	nvme_cleanup_cmd(req);
>  	return ret;
>  }
> @@ -1165,6 +1227,9 @@ static void apple_nvme_reset_work(struct work_struct *work)
>  	if (ret)
>  		goto out;
>  
> +	if (!anv->hw->has_lsq_nvmmu)
> +		WRITE_ONCE(anv->t8015_active_tags, 0);
> +
>  	dev_dbg(anv->dev, "Starting admin queue");
>  	apple_nvme_init_queue(&anv->adminq);
>  	nvme_unquiesce_admin_queue(&anv->ctrl);
> 


