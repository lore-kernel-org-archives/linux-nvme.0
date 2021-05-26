Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC96C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CF961184
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 08:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CF961184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4PuPGY5C2FEJzySELyJs6O1qTwqXEkb9SPuEiyPsVWg=; b=mgElQLV3AHcG83
	dCmNc5aM//hMcvhSDDeaKOSZ+rqsYKo19U7j1rzB0mB8kae1oggLjjPO4TfQdQjqZyIOwQNRPFvIj
	Q+ALYPnvxBrhdBij955k6tA4eISXHsG5juAXDpscBJJWcZ4dz82b90BT8M+2+xz65B05ruHJOUcrd
	SpGG8BAZ+2WybFN22NTSXSKxL5FK7Mdqp2j9PY0Fl2dBG8+eWwke4MY7nQj2rV/qo8URjrCMvGeSZ
	NtUGlVhE7AHUq9gItd+h/I4f/F7LLjmrQwbYZbx5UzV/GWdbJw1sOeL3ZAFvnn6ZPeYVol9Q7NGh1
	8YVnu1eBcTLuG+DzmGnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llpDo-00Cbk9-QS; Wed, 26 May 2021 08:49:00 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llpCi-00CanI-IT
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 08:47:55 +0000
Received: by mail-wm1-x334.google.com with SMTP id
 u4-20020a05600c00c4b02901774b80945cso15026331wmm.3
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FCSkBSvzfP1tQL/xuysG7GaKjz/QYEyGy+/ZR44/MpI=;
 b=Kz25S1AjIss1JudYM2S4TtdSeANHutDr9XSb/t+lsyI4XF32T608KZIVw6rx0PeJHV
 bHQPAf6NPDfwahUDau+GYCaaSZM5jSBzdXZpZLmbdyqIpgojSb3Kxly382KYQxRo186g
 EtwsbXKVnUI+ZhQe1gZH/Uhl/YCLtjOntpYb8ZDiQv/Moj0VzfHaXbwCHKIwV3D9KoNs
 e9x8qQU9LD3FkAV7YU/ICS7g/0GRBKlfN8gME1C8ROjmrnPEiU61JTtn3PILhMCuUkDF
 cC/235xUWLWXaR7WPia81u7DTDkoQ26CqUYcDXKXXU0sjELiTkZLDkIxQw6o+8fmxLcg
 s9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FCSkBSvzfP1tQL/xuysG7GaKjz/QYEyGy+/ZR44/MpI=;
 b=uUDTwp2ItmGMvkQ4mZbb/0Oh9QMMqx8N6foAQDy0kC+Qd+pr93uP7f9uk4fa9ZNoFJ
 G7z6KHV/ChEVYipftXKPpptSLQBhb//2Qrxq3g3CoTJJkWbXMtA/zPEveyaGZYSc/dQf
 ngqqMVB2S6LoqVa0zHCZRtPQBB/43j4SZtxzBi+E/QKUgJClfgPsTRbnOC29VvXkBIz2
 ctlqm42q3zbPm1ZXEcC0hZDNHQwJWijjD/TkeSQ5Sr+wV4HwdsRk0OgQDR+3hvQf9O70
 oh62aVtQeuU3Pk6F0Cqb0Z6dMPk0emSpFxGKj6/40Upyq4NrgAFRrsgwcNO6HudO/f+M
 pV3w==
X-Gm-Message-State: AOAM5317fKHJ+g+QR2rzromSddq09VKsCYiMGNYugSrhG9tsVXK27SOK
 pjQOANOAr8ul+CxjHq7hHE9FA8bJn991mm5jRr8=
X-Google-Smtp-Source: ABdhPJzEaZz77g5pREKeKLYuDF6x5VBcjS4q7bhAOnDUvid+sQ13JtScj1DKIF1vmxJYosL3pFKwxD7rRl4qbDvvkgI=
X-Received: by 2002:a05:600c:b58:: with SMTP id
 k24mr2280461wmr.155.1622018869929; 
 Wed, 26 May 2021 01:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-3-kbusch@kernel.org>
In-Reply-To: <20210521202145.3674904-3-kbusch@kernel.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 26 May 2021 14:17:23 +0530
Message-ID: <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, 
 Yuanyuan Zhong <yzhong@purestorage.com>, Casey Chen <cachen@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_014752_669565_5F9D4B67 
X-CRM114-Status: GOOD (  15.48  )
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

On Sat, May 22, 2021 at 2:05 AM Keith Busch <kbusch@kernel.org> wrote:
>
> The generic blk_execute_rq() knows how to handle polled completions. Use
> that instead of implementing an nvme specific handler.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> No changes since v2
>
>  drivers/nvme/host/core.c    | 38 +++++--------------------------------
>  drivers/nvme/host/fabrics.c | 13 ++++++-------
>  drivers/nvme/host/fabrics.h |  2 +-
>  drivers/nvme/host/fc.c      |  2 +-
>  drivers/nvme/host/nvme.h    |  2 +-
>  drivers/nvme/host/rdma.c    |  3 +--
>  drivers/nvme/host/tcp.c     |  2 +-
>  drivers/nvme/target/loop.c  |  2 +-
>  8 files changed, 17 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 762125f2905f..1a73eed61eee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1012,31 +1012,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>  }
>  EXPORT_SYMBOL_GPL(nvme_setup_cmd);
>
> -static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
> -{
> -       struct completion *waiting = rq->end_io_data;
> -
> -       rq->end_io_data = NULL;
> -       complete(waiting);
> -}
> -
> -static void nvme_execute_rq_polled(struct request_queue *q,
> -               struct gendisk *bd_disk, struct request *rq, int at_head)
> -{
> -       DECLARE_COMPLETION_ONSTACK(wait);
> -
> -       WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> -
> -       rq->cmd_flags |= REQ_HIPRI;

The new code doesn't retain this flag.
Looks good otherwise.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>.


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
