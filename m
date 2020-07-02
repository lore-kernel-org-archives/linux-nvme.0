Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 15:53:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD8320771
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P5l7U3lZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwW+/U9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD8320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OOdxydO38UTQzoze03iElmpxV9ydjVQ3CdO+Wxbw04s=; b=P5l7U3lZesuE7s64vmSnjKLH4
	hk6TemExuOr1g56HOR1U84QHQttb4b67PiLZSeLp4ltzT2PzngZoTFStOLU569ySAzuLrHVr7jBOU
	b4P9YWvHzLoxvJYGg01qnIPO2fYlWuSaqDzx1CbDw1yLgEmpqYuxYZZwxoFJSVrrpEs7ED+RteBEr
	4y4hIzlNLJ0pxjqealJwwHYDUeWk0/Gqq66NkSnhwtchHx4XK3CkmpXad3PDJ/KcwcFxfYDW1BqXz
	YDe1Ncha9F+60Gan0ggBVt8NfRDtXxZLwmmYWM9zrBmCvJLG4bnkJrm53qVwcAa1w0WEw6gwfDoPC
	03+YUQX5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr1WL-0003qK-RV; Thu, 02 Jul 2020 15:53:05 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr1WF-0003n1-1x
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 15:53:00 +0000
Received: by mail-lj1-x243.google.com with SMTP id 9so32828295ljv.5
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X1hZZYHT2jx0soQwDY2Nw4ZNux9TK2TS4ou5sFWlySY=;
 b=KwW+/U9fkM+srFlFPvkKz4V3jEnKIKH8ygaroNt4YXgCxeue/VrdTKoJwmcn9oXIVs
 4DY0ZVk34mPlw7u4KLu6rGjhvnrQL6/lofTS76CSIpt1KUwe2M3VISdDz83TvG8iTXSI
 W47Pw8OTk/hC0zb2MZaQ1r596h7N8T5A23JSQkaU9RWiYgGd5Xav7JwLesO4IqMIFUZL
 2VuieIxaw/GaR9iMUF6CkG5lHBbOPJgWIfkSCxXHB48wkXOO7uuaIH8G93d6r33rKKeJ
 p2LG1w2EFwjJvNEP/726kUUAmMNBPXMl5+BvhQTxMO/S6XCBw/1QqIdNdExANIirUL/4
 +A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X1hZZYHT2jx0soQwDY2Nw4ZNux9TK2TS4ou5sFWlySY=;
 b=CkJkuRwRmayuh21mMruJlppiBIZPtCGfLRpJwUVeS9vWLHxXW0qeC9RUFhboSQYHY0
 JCX2Gl/8TmA26tMoU/+oMVZlmQ1xvWlOJn5t6Mf7tZxDblE18V+8CepN2xpjBWZu2EGz
 TWGcHSBD3wCM47OfDLCnWOUyzZUP3WyXZc2b2d4pP/dr6KopBX/NnOaAdMbgWNQnAJpZ
 FiKRuyfN+k6HusB3BbI2Z3IgINhvyeUlrlUKw7gJgZO/0fk/WS8piqyaS/EuQkRceWBf
 qiU65DzWNcgNqUeJWeplp4Ga7ArijyVjCSFmN8fLZ3DYCXq5Lncr3rT4eIGgiqN3CS84
 7lyQ==
X-Gm-Message-State: AOAM530ugxOznFBn76LDZowCTg/BkAUZtY0LnLC4jUOuCkkv8wjbGHSQ
 nphUTv20xx8/vSnl4E9WWfikpheFb1V8w3xQG+IH+w==
X-Google-Smtp-Source: ABdhPJz3ABkPWjkv8L0FIiK+Kjjg6BO4eaaimJnKQo1xzAYZPxzmmzDpXVUF4bLDPypwEcFJ8kmLmaUrHoL1B8Z52PM=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr16463205ljp.266.1593705177353; 
 Thu, 02 Jul 2020 08:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-19-hch@lst.de>
 <20200702141001.GA3834@lca.pw> <20200702151453.GA1799@lst.de>
In-Reply-To: <20200702151453.GA1799@lst.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 2 Jul 2020 21:22:46 +0530
Message-ID: <CA+G9fYv6DfJB=DeQFVptAuaVv1Ng-BK0fRHgFZ=DNzymu8LVvw@mail.gmail.com>
Subject: Re: [PATCH 18/20] block: refator submit_bio_noacct
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_115259_566269_59583A24 
X-CRM114-Status: GOOD (  18.38  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, linux-m68k@lists.linux-m68k.org,
 linux-nvme@lists.infradead.org, open list <linux-kernel@vger.kernel.org>,
 linux-raid@vger.kernel.org, dm-devel@redhat.com, Qian Cai <cai@lca.pw>,
 kasan-dev@googlegroups.com, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 linux-bcache@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Dmitry Vyukov <dvyukov@google.com>, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2 Jul 2020 at 20:45, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 02, 2020 at 10:10:10AM -0400, Qian Cai wrote:
> > On Mon, Jun 29, 2020 at 09:39:45PM +0200, Christoph Hellwig wrote:
> > > Split out a __submit_bio_noacct helper for the actual de-recursion
> > > algorithm, and simplify the loop by using a continue when we can't
> > > enter the queue for a bio.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reverting this commit and its dependencies,
> >
> > 5a6c35f9af41 block: remove direct_make_request
> > ff93ea0ce763 block: shortcut __submit_bio_noacct for blk-mq drivers
> >
> > fixed the stack-out-of-bounds during boot,
> >
> > https://lore.kernel.org/linux-block/000000000000bcdeaa05a97280e4@google.com/
>
> Yikes.  bio_alloc_bioset pokes into bio_list[1] in a totally
> undocumented way.  But even with that the problem should only show
> up with "block: shortcut __submit_bio_noacct for blk-mq drivers".
>
> Can you try this patch?

Applied your patch on top of linux-next 20200702 and tested on
arm64 and x86_64 devices and the reported BUG fixed.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bf882b8d84450c..9f1bf8658b611a 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1155,11 +1155,10 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
>  static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>  {
>         struct gendisk *disk = bio->bi_disk;
> -       struct bio_list bio_list;
> +       struct bio_list bio_list[2] = { };
>         blk_qc_t ret = BLK_QC_T_NONE;
>
> -       bio_list_init(&bio_list);
> -       current->bio_list = &bio_list;
> +       current->bio_list = bio_list;
>
>         do {
>                 WARN_ON_ONCE(bio->bi_disk != disk);
> @@ -1174,7 +1173,7 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
>                 }
>
>                 ret = blk_mq_submit_bio(bio);
> -       } while ((bio = bio_list_pop(&bio_list)));
> +       } while ((bio = bio_list_pop(&bio_list[0])));
>
>         current->bio_list = NULL;
>         return ret;

ref:
https://lkft.validation.linaro.org/scheduler/job/1538359#L288
https://lkft.validation.linaro.org/scheduler/job/1538360#L572


- Naresh

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
