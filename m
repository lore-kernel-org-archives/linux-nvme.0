Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F74C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 03:44:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C6F20721
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 03:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YKhqIOya";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWqg1F/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C6F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hSpQOLWCjQKoYoRldqsf0IhhcQ/lGfl1T7/3KQkLKOM=; b=YKhqIOyaSYZ9GR
	YRXS692xkfxejw8bTjpylxnIEU/3sjkGhfL9GoN1FvvAIIcCC3ERArjJyfMU6CYyLfQwj6EKDbPY6
	Jv+WF6fyh+AYZPZVtti064k7vOES5U7NpAqvGEN4RsybqeI4vhLP3BSjjy0AZAzMzEuo2oduartFx
	OQ1PkO3lvuMXsN+mvtiAbauU0hxT9mzbF79T1Mb0Evcrh3uo9DSArnY3obaXOZjvSJLD8DOaXLwr4
	nz9j0kdiFWvs4e03X8ZDAI9OIPmrzgsv25/P2LPkplYG9GksS6p9qySPgVbmLJ9qQhsGpZnv8xBfD
	UT+kolvtVhtlb15ao9Sg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeVx3-0002Ds-T1; Fri, 29 May 2020 03:44:57 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeVx0-0002Bm-Iu
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 03:44:55 +0000
Received: by mail-wm1-x344.google.com with SMTP id k26so1623407wmi.4
 for <linux-nvme@lists.infradead.org>; Thu, 28 May 2020 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+u6mMZSLimZl0GywaUQnKdRzfuv7lLKSy19l3gA5aXU=;
 b=kWqg1F/Ov75DwlTBnYhlLLQr9+8g20a/Z1UtG8VIPv7wOcmYunemTHdc7kqgsHcBD1
 8gvngbETYilY/8Fv/N6L6e9gOuDdNbxyxkPkWdFNmRSF3igjf9Ce/zF7QBsJouJluTVx
 hC/XQ1VVC9/482y2P3tYKEFzs7qq7V95O7C8tnb7vDxDzzKi+s/FeXoRd0uksXywhIoQ
 cQs9Q3UOfCwuZZ5AlY/V5VsvQaUEBlpLn7r+sr4857qmD7BrthkMwRlBLSvYBcsQsNRK
 w6++VW3aW9WTy0LDlbzkPXao0gyNILIAKCKiT/piN8pKnFc8tZIgxNxSw59dJbP4RdLI
 6ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+u6mMZSLimZl0GywaUQnKdRzfuv7lLKSy19l3gA5aXU=;
 b=i1LRm2jcbQ/0FDvI7BSPZcwz6Kg9Fk+rRl62JDUWPYc1G8SWcCkZuECBm/U7AaYc1D
 IOCQBvBiOFUO4fPtWSb5AmOff2NtwESoAihmvyXH3uYZ2thqE5Hp32pRvo54YogXlu+I
 /p9fa5klz37jE2vyKl0nz9VZgvlmBe5xHjr0qPjicJmk5KbfS4fzPR0JWMAIqg2jGpbQ
 NBWsWgMzGsSlqpOPSLOJBzeXls9YKSoO8jgk3rjyLLDgOsExVMv+vOVnTVRE9ZcFCcHZ
 i2CnizbKGuIbp2pf1FQpxVVZ8b/r2nzDPYv8qYAK8MEhrPi7CB4RSh3Kb2KqqVS1zs7L
 mfbA==
X-Gm-Message-State: AOAM533AZOmvnfmSR/mMiYbSpF7FU9dvzxAhQdtWUnJAVYWu6H9gtU7a
 CRNpuhc2Y2ob0WhoqqP9znRXuzszQ/WG4ZUz4ys=
X-Google-Smtp-Source: ABdhPJyxD6HpdHMYbOLK5MKbh2lMWfZML7uJP7IfC8iuNxn/mxHI9L6PlL1AnUz9n6/ABz1O05hb7dlUXQrUghmMCEg=
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr6070547wmg.115.1590723893290; 
 Thu, 28 May 2020 20:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200528151931.3501506-1-kbusch@kernel.org>
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 29 May 2020 11:44:42 +0800
Message-ID: <CACVXFVMosTsw5vD=y848umB4UkK3pgnNPjvULBHtp9C40XgYJA@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_204454_624660_8693D4D3 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 28, 2020 at 11:19 PM Keith Busch <kbusch@kernel.org> wrote:
>
> For when drivers have a need to bypass error injection.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq.c         | 3 ++-
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cac11945f602..3c61faf63e15 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -556,7 +556,7 @@ static void __blk_mq_complete_request_remote(void *data)
>         q->mq_ops->complete(rq);
>  }
>
> -static void __blk_mq_complete_request(struct request *rq)
> +void __blk_mq_complete_request(struct request *rq)
>  {
>         struct blk_mq_ctx *ctx = rq->mq_ctx;
>         struct request_queue *q = rq->q;
> @@ -602,6 +602,7 @@ static void __blk_mq_complete_request(struct request *rq)
>         }
>         put_cpu();
>  }
> +EXPORT_SYMBOL(__blk_mq_complete_request);
>
>  static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
>         __releases(hctx->srcu)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index d7307795439a..cfe7eac3764e 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -494,6 +494,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
>  void blk_mq_kick_requeue_list(struct request_queue *q);
>  void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
>  bool blk_mq_complete_request(struct request *rq);
> +void __blk_mq_complete_request(struct request *rq);
>  bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
>                            struct bio *bio, unsigned int nr_segs);
>  bool blk_mq_queue_stopped(struct request_queue *q);
> --

Looks fine:
Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
