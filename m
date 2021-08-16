Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B047C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 21:43:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530C860EB5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 21:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 530C860EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gubImP+VS4P67SAdLellL2lJEB8Gpb/7WIDg9ZkqZRg=; b=0mcdbw1icCr2ev
	8U08qC3grhAA64It62kb+u8TutN50/Qfu1gEZgS4vsZAJFvQ3EcfWmM5ctP890eUGXN9A9JoSMUbG
	7w9UvfKqwlx40PME7JPiRaExpP4FhXfafJ1LKXfMhIC1ufiY4BUMUxLpc8RAU5s10NP9QZ8+W7vJh
	h6koiq0Z2245cWlETkvNvmNzcMX0XBaNgUTN2llJ3dRMZ8p6SrBNL/5xAObKKaiKM7VThurISj1mB
	vcXVG3OBMaarAJEwreX6Wseyo7wpcV+MJVrCaZn9eWRjTPRwxOHop/5MhBCAIdgY6q96EsW+qu1zg
	ZGG1kh+uEIse5+dhSBTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFkO6-000Pw2-R8; Mon, 16 Aug 2021 21:43:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFkO4-000Pvh-H4
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 21:43:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9D2060E09;
 Mon, 16 Aug 2021 21:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629150196;
 bh=7giM+17w8T1P6G0lgvtj69T5bXMCOfNXj5H2gAA8ClY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GXr4YosCEkuR9dBbc0+r8cmnFrf0+tvtbSYSXZiFynsbBzDhguGxU4jm2pOx+bpro
 /d3r4Z+7UXc66gVLzblHrnHPUyaba9R8LypDk6AdB5yPuvQTGcWTaD8chXAbfGHXpv
 nhsgE2Y8M+n5+WK5nof33re959k6vfkT5KmTAvaeLi46kBxmCjyDkf5XTc2ayDvvLc
 Idk3Wi44N4eKh1CfgIeXuXOevnIiBJ3PPv7A2YcpgbT8wUHE4SCdGTwwoGUaMWZaRn
 yTLqsr0WV0RmbDbCg0tdrDZ3YHRndCT1qAcEYcNF95zvRfTw+QEUeIV0gGzad+H7NV
 0Fk03wlQ70D3A==
Date: Mon, 16 Aug 2021 14:43:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tom Yan <tom.ty89@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH 1/2] nvme: use UINT_MAX >> SECTOR_SHIFT for maximums in
 number of sectors
Message-ID: <20210816214313.GA223727@dhcp-10-100-145-180.wdc.com>
References: <20210816181102.4412-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816181102.4412-1-tom.ty89@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_144316_630048_0AFF7DEE 
X-CRM114-Status: GOOD (  17.49  )
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

On Tue, Aug 17, 2021 at 02:11:01AM +0800, Tom Yan wrote:
> The block layer uses UINT_MAX for maximums in bytes.

Nak, the code is correct as-is. A UINT_MAX number of sectors is
valid when the device doesn't have an upper limit.

> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> ---
>  drivers/nvme/host/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..3a1bfb45da2a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1640,7 +1640,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  
>  	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
> -		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
> +		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX >> SECTOR_SHIFT);
>  }
>  
>  static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
> @@ -2762,7 +2762,7 @@ static inline u32 nvme_mps_to_sectors(struct nvme_ctrl *ctrl, u32 units)
>  	u32 page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12, val;
>  
>  	if (check_shl_overflow(1U, units + page_shift - 9, &val))
> -		return UINT_MAX;
> +		return UINT_MAX >> SECTOR_SHIFT;
>  	return val;
>  }
>  
> @@ -2773,7 +2773,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>  	int ret;
>  
>  	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
> -		ctrl->max_discard_sectors = UINT_MAX;
> +		ctrl->max_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
>  		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
>  	} else {
>  		ctrl->max_discard_sectors = 0;
> @@ -2883,7 +2883,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	if (id->mdts)
>  		max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
>  	else
> -		max_hw_sectors = UINT_MAX;
> +		max_hw_sectors = UINT_MAX >> SECTOR_SHIFT;
>  	ctrl->max_hw_sectors =
>  		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
>  
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
