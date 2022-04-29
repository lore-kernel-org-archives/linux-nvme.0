Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC77C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 05:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fYq61VHNyniGJSZy3+ryxBDaopZy7cNbHyKRfbZth/E=; b=BFrij3z1TAMulYf29vzTnw905f
	/AfnsWeBDaD+K8Qyb9s2rKeC3E4smTcIdbLVBlSYtzI1hbCHPpm1UxCrQM3BSlp32QfkBrEY//feS
	ZE8vpjb94teRfkcHQEp+FTZVzVbcexUpU2bvdXFQfIFk8/xcYJTlVO5ToXIya35bWLO2vQO2mFbra
	RkC6Ug41ymZR41vXwTzrSBstEOrZ6vjo2gZsZtjbWITqINJtmOmpNRSB1/S8U/XY42Sn9dyA2Vbd/
	a1uzKddtMdRlbs086EtoilG6aw458Vo17KECTgBQ1k9uyB+g1Ru0hHQMOfObZuAZ7TW9SLtTdd6pP
	LaHxrr6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkIl9-009Z4m-EX; Fri, 29 Apr 2022 05:01:39 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkIl6-009Z40-ES
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 05:01:37 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id m14so6524127vsp.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=fYq61VHNyniGJSZy3+ryxBDaopZy7cNbHyKRfbZth/E=;
 b=mh00xrfwyv2mfuEqvi2bjcMKv84sr4aJb+RGx1tNs5sqva+LcYf16WZeWF4HyGpmoI
 vfWmwpoOyixZH2GcNNmlUIMJk040TmTFDlgFxHuJxbqM2VFETCrjUaVTdyNYPNQTIkoV
 1H+qMYMZs+0BkrkWeLjWtxaYHxBZqEN8IyRdS1QJi/RdFJfIPDd/l+eDplwgSKAf55HO
 NlEajYsSOTdx7qHc9ScxvPmJafaMMpc0pZ/Mk+3HGu49kEgGYY5v/oOYr9Kb1d47M0bb
 HgoGrvg/XOnsaOOxiNuMDKE71ro1q9+jzeI7lr1CLciv5ClF3ofYcbyXYAcJGqSYNjWX
 bT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=fYq61VHNyniGJSZy3+ryxBDaopZy7cNbHyKRfbZth/E=;
 b=Pi/avVyJXlVDqjeHHCyP6o+c3kRwIPN8nUkpK40SA4mtLodzP7u/PoXc6KuYyS/OEN
 Ucs0VhfKTHUW8NLDcYSfq8fxORDWCXrrX8eLLCbLIpXEZIkFwj/94g9GOWHdx88kcJqp
 OqgjOKmltIpdwDPqjMNveB1Mgj3wzeYn3Jy1n1AEpFGSmS7+nk8guTmN81H8JwazuKbb
 trjA/Bh8faoH3uIOcBq51GrsVebiNrbzRT2REpUeNW3DMCgphRAZYWtWv7oBT45TIuIH
 0V7XBcWVmNBAwoxY+y1MaFwg+CowNQKLeskY1veessrfON6yjg6yMxcDlMhGmQoquQDh
 ItNA==
X-Gm-Message-State: AOAM533oUOt4g+mhm16gzNdcAiLkvo7gONbLUIbl90NIeFa/g3KK+mNR
 U67LPk27SUdsaRY/s0yhc1MKYfF7mqhPzzPh5bDvE4h+
X-Google-Smtp-Source: ABdhPJxW3uWFpWEI241LrDwxgGLQQYVjgpo+U3fKHHM0OpVfud1IV1aOezxda8OoL7qPhvtB3eF1lMao+nT8dh7d4HY=
X-Received: by 2002:a67:c40c:0:b0:32c:e5d2:8b50 with SMTP id
 c12-20020a67c40c000000b0032ce5d28b50mr5647796vsk.6.1651208492555; Thu, 28 Apr
 2022 22:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <YmrMSGDDn3UMnJ8t@kbusch-mbp.dhcp.thefacebook.com>
 <20220429045243.324403-1-tom.ty89@gmail.com>
In-Reply-To: <20220429045243.324403-1-tom.ty89@gmail.com>
From: Tom Yan <tom.ty89@gmail.com>
Date: Fri, 29 Apr 2022 13:01:21 +0800
Message-ID: <CAGnHSEkmxtnYoZ=sd39spYRrUNLUNtjyTowi8FXPFnm7w-1P-A@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix interpretation of dmrsl
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, 
 Christoph Hellwig <hch@infradead.org>, sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_220136_510543_B7FF2EB7 
X-CRM114-Status: GOOD (  20.28  )
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

Hi Keith,

IIRC I was once told that 0xffffffff should be set as the queue's max
discard sectors, regardless of logical block size, to signify that the
drive does not pose any limit. Besides I don't think it's a good idea
to put a value that is not a count of sectors into a variable which
expects that (as it would be confusing).

I also kept the overflow check. Let me know if there's a good reason not to.

Regards,
Tom

On Fri, 29 Apr 2022 at 12:53, Tom Yan <tom.ty89@gmail.com> wrote:
>
> dmrsl is in the unit of logical block, while max_discard_sectors is
> in the unit of "linux sector".
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> ---
> v2: ignore dmrsl if its sector-equivalent is larger than UINT_MAX
> v3: put the lts_shift declaration before code
> v4: make use of nvme_sect_to_lba() and nvme_lba_to_sect()
> ---
>  drivers/nvme/host/core.c | 6 ++++--
>  drivers/nvme/host/nvme.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index efb85c6d8e2d..8e06a6d675ef 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1622,6 +1622,9 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>         if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
>                 return;
>
> +       if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
> +               ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
> +
>         blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
>         blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>
> @@ -2881,8 +2884,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>
>         if (id->dmrl)
>                 ctrl->max_discard_segments = id->dmrl;
> -       if (id->dmrsl)
> -               ctrl->max_discard_sectors = le32_to_cpu(id->dmrsl);
> +       ctrl->dmrsl = le32_to_cpu(id->dmrsl);
>         if (id->wzsl)
>                 ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1393bbf82d71..1c85edcf7dbb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -279,6 +279,7 @@ struct nvme_ctrl {
>  #endif
>         u16 crdt[3];
>         u16 oncs;
> +       u32 dmrsl;
>         u16 oacs;
>         u16 sqsize;
>         u32 max_namespaces;
> --
> 2.36.0
>

