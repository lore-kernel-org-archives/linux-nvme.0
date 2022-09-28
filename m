Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E73C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G93x0tAkTk9UmC3wzfzA+7Kk2FVuT62V0cKnX0qkZ8I=; b=czAH9phw89gKHXcJmhq7AemR7H
	UvEdffm2ftNKsfMqwvj2btQRUSHENAKd8Ns7cdAPLDb6aGF0lwOz5Y5TwAeoGjzad7HZ+JbIXtmsR
	loC2Qomd4pgGXE/g/N29TPxcFOQ6u0ZTSLzm0RZ5I0oI9KX1EBGs1uNTXdeETs5JfENUav3SXN/Qq
	yxscHaZYPgkdL6/UiLabuBrggUUOMlNxH/h2swN7TFjbumaUtfBRs+qZMN+PRA38H9Y3EYD1aAh57
	o+EpniyPoRJkMqE9aJcG981ORbAbGYxZs/77sfUYYJgrSVkGTE5LBghlZnyxMBT8GCgu603G5x3CC
	/SdzTvcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXLH-00GXXX-SN; Wed, 28 Sep 2022 13:43:15 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXLF-00GXVh-9d
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 13:43:14 +0000
Received: by mail-vs1-xe29.google.com with SMTP id 63so12740150vse.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=G93x0tAkTk9UmC3wzfzA+7Kk2FVuT62V0cKnX0qkZ8I=;
        b=ZGdo+Vh9+L7/7qzQqSOlS8GtACFvttGfYOi1bLoJ8qdqMuw23y5JT6ZXQvIeA/Ez1d
         7chK/2pvkfxlrMa61hLQAZZDlZ/H/TlS6az3LOQHNzkJywPz1cOrCWHvCxF2oeik2npq
         9v7a13SkQjYP1npBrkvIRfacsgW6TQFeWHSPNnFGLteWhRPR1o4UfIR4W92Mp5q1fQdc
         adN6d8kxRwBlxd3uVWzI9zQ/EVgQyG/8mrL1Y1Y7d0wN0QL6A/ZL7msBZm/nVejXjM6Z
         tZ42E8GWGSny5i2qv1BpcOCpEaEXeb58e3v38G208yjDgkflU2F0vCJ74kNaQypJSk3a
         Vp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G93x0tAkTk9UmC3wzfzA+7Kk2FVuT62V0cKnX0qkZ8I=;
        b=zbnqptSe6wwNt/URkncOuMhiX/ifdT6/NOlQ+puuDPFZnFJKnqDKFu3q0yFVPpqTh2
         76U0eW1fC5VL+9wJl6vm0Cen3bJxMnsTAFOuSXC+XlSCu1/lHgO3ONrS9AVHLNzPka0t
         22+sf1zljlo3/pRepOASWdUQanJyCQTQ0CV+aMaAp3s6jYAsNSF0KGk7nCBnF04k/9/t
         VXWF3YGX5Qppkme4fWjPSrSxM+ZUPXxgduZIaWNCDd3mjCoUFDgw+hTMOvySt8C4lfFI
         YxvN7naHJ7qCXAvCbwuZPDijGDBGyAnardKFq8usq1V5gqb76clEOQ9ghmdKM8k3KrON
         OpmQ==
X-Gm-Message-State: ACrzQf0FMm5RyS7ALro4+/sD9Y8Na7GxzcFEO8+LQKCF1YAzL+hOtN3o
	SwjeX5JAcS3Eid30uQk5QbexkIpTULlzhJf80A==
X-Google-Smtp-Source: AMsMyM6VadrsjsdBNjWRG5SUiMTfBCh/45oowIS2fEdSsR6Y3RJ51jov5XiD9vSDYhLa4WCwuFshRYfsMZ5gLw79pkA=
X-Received: by 2002:a67:b74a:0:b0:399:4161:9f94 with SMTP id
 l10-20020a67b74a000000b0039941619f94mr14280163vsh.1.1664372590986; Wed, 28
 Sep 2022 06:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014420.71141-1-axboe@kernel.dk> <20220927014420.71141-4-axboe@kernel.dk>
In-Reply-To: <20220927014420.71141-4-axboe@kernel.dk>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 28 Sep 2022 19:12:34 +0530
Message-ID: <CACzX3AuMv8SZAnW66RcNHhksB1NBgKR3A5usnSwS1xDGTFzSzQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] block: allow end_io based requests in the completion
 batch handling
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_064313_377919_4BB8EB93 
X-CRM114-Status: GOOD (  19.86  )
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

On Tue, Sep 27, 2022 at 7:20 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> With end_io handlers now being able to potentially pass ownership of
> the request upon completion, we can allow requests with end_io handlers
> in the batch completion handling.
>
> Co-developed-by: Stefan Roesch <shr@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         | 13 +++++++++++--
>  include/linux/blk-mq.h |  3 ++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a4e018c82b7c..a7dfe7a898a4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -823,8 +823,10 @@ static void blk_complete_request(struct request *req)
>          * can find how many bytes remain in the request
>          * later.
>          */
> -       req->bio = NULL;
> -       req->__data_len = 0;
> +       if (!req->end_io) {
> +               req->bio = NULL;
> +               req->__data_len = 0;
> +       }
>  }
>
>  /**
> @@ -1055,6 +1057,13 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>
>                 rq_qos_done(rq->q, rq);
>
> +               /*
> +                * If end_io handler returns NONE, then it still has
> +                * ownership of the request.
> +                */
> +               if (rq->end_io && rq->end_io(rq, 0) == RQ_END_IO_NONE)
> +                       continue;
> +
>                 WRITE_ONCE(rq->state, MQ_RQ_IDLE);
>                 if (!req_ref_put_and_test(rq))
>                         continue;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index e6fa49dd6196..50811d0fb143 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -853,8 +853,9 @@ static inline bool blk_mq_add_to_batch(struct request *req,
>                                        struct io_comp_batch *iob, int ioerror,
>                                        void (*complete)(struct io_comp_batch *))
>  {
> -       if (!iob || (req->rq_flags & RQF_ELV) || req->end_io || ioerror)
> +       if (!iob || (req->rq_flags & RQF_ELV) || ioerror)
>                 return false;
> +
>         if (!iob->complete)
>                 iob->complete = complete;
>         else if (iob->complete != complete)
> --
> 2.35.1
>
Looks good.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

--
Anuj Gupta

