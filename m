Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B90C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:44:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA53661059
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 16:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA53661059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DPumwl9keGCITdXPi7DDNpqQqDLENpJ9+yB5yAv4jHE=; b=SkF4G3VlWwAqVsXe0L6KhSggg
	TSY3QLVabG1dJd2tjQECZw8g5EIQ3iV3NfrxVcSvMs1766McWwrfVo6DOeuDvab9jyQ+zzhqXGx68
	XmyfCRThj1802wY0qwfg7rmJMhltP40AmsvziFgrP4hwg6vhfJVraCEe7ZB9I/m3iMLEjrRZvJgJc
	uRoRwAARUxOSwVwf630Qry1oy48VSGzyxO/3BAPt1BT46xj4bExWLtGsnOh3mhG3d6ZmL9q08orvU
	t6DPDrwl0ukmDbNEep+nAFVFZSiOhjM2L0UHJL1td6wlWSvcrRMnH1Hq8e5/05Asapev4aUKun/Q5
	N4+CdxQvw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ligLx-00FYfO-1z; Mon, 17 May 2021 16:44:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligLu-00FYeh-Gp
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 16:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+VtV8nX+Uzjp9W9nmFCJu2nrfmzR8I0bnxqoUhqRYCQ=; b=YNlhaPq44hId731jipmsLN4gtD
 v2aX2/jhep/CgLMSw5SJoy8xbtlkRqKLCIta03T8Y053vzpZIGYDPq6GCicD+vnzRhemKbn9ibY5F
 cLgM8/gx/nLmslWcj9tNWoC8DKv1vXyJFtQ0DTW21IbYlsxn4qsCUWZDM310pGpJBZODRLMV0CpRz
 7JZWugyxR0jMLbpXkdq1Dgj76KrMLr+YEm1qBYZoBuOY+sdVRbMvkcuge9G+7YCKDI53pESScDrwt
 ffNSRJQhyokNhpB9mplRjL0JJ+YP0g2F90NzHDRjFAe7o4tICcd/pVvy7sDomsB/plHaT8vFa39XW
 9MlkIJgA==;
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ligLs-00DzUg-2R
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 16:44:21 +0000
Received: by mail-wr1-x42a.google.com with SMTP id r12so7146649wrp.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+VtV8nX+Uzjp9W9nmFCJu2nrfmzR8I0bnxqoUhqRYCQ=;
 b=XCDef7VXfeqXqKqRbwsg7GLiUQSoUtfM70wDpmSftyUGC5VZLlm+DTZn6cjRNVLPZQ
 G3jsMNHRUNtGB1J1naBe93gwijRQ2i5Kcp0kGtiFj8X2cAgDohcD591gEWVPyc2k+Qkm
 1oLPAJU6DpHgqQMdLOsYjRMbKF76Kvhle182Wsy+SDTAvrb0DGZmsfOzhE3M+DvE6Hrl
 ClML2Ycta174wRcocZyE9py6Ngs4uuFWWQGYScTIBsqN0xQYnUC2Ie9fPs6sVf/FZBuI
 hUeBJRj76vT6cLqNxPv1Y9zISHi6dH5INjV3SGLCU0UH6f/VsFY19KQPqUCxBVfJWehU
 DCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+VtV8nX+Uzjp9W9nmFCJu2nrfmzR8I0bnxqoUhqRYCQ=;
 b=fBqOM+TUZMBJljxSm20PxSc13ISwo5tFer4UZfTcvijhcdWbYdFi8eoLvvJdDGdCaL
 VsXhvlySuB6pYMiF29k5HS/DQzJJS4Beh2KgxllC4Z1SS+53ryHaX2mk7Vnsp0jjFfkl
 AhWLBAROErMzAXjK2rE+0iqlU34PEWpVOHOb9opGIxq/repGaaUx3yC9sTrb6aG4LOhN
 oOLHiQm8D8/qB1wMx5T1CVS7kRxBIf9Lul/Oy2+B1bDtGkX2tNjQOb4uHy0GAe2KLEaG
 oKfbnTbi46ksFZuc+GwsGVd1ki/OO19Y+mjF9AMzGNGNPTZjHz5c4NBb6FeB4rzS6ArH
 uubA==
X-Gm-Message-State: AOAM532o4dsanWtShS+QaKCcuke/zYD2kGR+xSrcDT66FIujOurBp1yy
 /JLTxNrz4qaMQGHRqx937QSKk+0O47lqeNd1IAQ=
X-Google-Smtp-Source: ABdhPJyDb61mqECC+gWc/B1MpMTWknlMBd7wXO1WQfHD5X73NOFTBrqoZSArpY6r+YDZ0TO3HXMxu+IYMPYs7fLn058=
X-Received: by 2002:a5d:5508:: with SMTP id b8mr693279wrv.278.1621269858262;
 Mon, 17 May 2021 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-2-kbusch@kernel.org>
In-Reply-To: <20210423220558.40764-2-kbusch@kernel.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 17 May 2021 22:13:50 +0530
Message-ID: <CA+1E3r+3dDW0Hbc8MCsxAnwcpY=kWAqDLh0h9+j501VnKvgwqA@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] block: support polling through blk_execute_rq
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, 
 Yuanyuan Zhong <yzhong@purestorage.com>, Casey Chen <cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_094420_138326_294FD407 
X-CRM114-Status: GOOD (  19.30  )
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

On Sat, Apr 24, 2021 at 3:37 AM Keith Busch <kbusch@kernel.org> wrote:
>
> Poll for completions if the request's hctx is a polling type.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..b960ad187ba5 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>
> +static bool blk_rq_is_poll(struct request *rq)
> +{
> +       return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +}
> +
>  /**
>   * blk_execute_rq - insert a request into queue for execution
>   * @bd_disk:   matching gendisk
> @@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>
>         /* Prevent hang_check timer from firing at us during very long I/O */
>         hang_check = sysctl_hung_task_timeout_secs;
> -       if (hang_check)
> +       if (blk_rq_is_poll(rq)) {
> +               do {
> +                       blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
> +                       cond_resched();
> +               } while (!completion_done(&wait));
> +       } else if (hang_check)
>                 while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
>         else
>                 wait_for_completion_io(&wait);
> --

Looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

--
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
