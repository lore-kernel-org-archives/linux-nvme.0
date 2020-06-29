Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD2C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF86020656
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q52Hica0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF86020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mq5f6VXqxHeX5QagRCWulu7vePQnaVy14IHuqyHf7Yc=; b=Q52Hica0CakMEjuiDMTJuVwwR
	cCGaRqMNGAAySdmlFeoj7qg97f4SA5ipdbcSOZWLugM4Oktk9Z/dNMK+XSy8VWzdg9Ik/zt7jpEEV
	kiA1C7ZwYXgs4w06h4hD3RZZohD/Kjtub3W/4q9gtlrPGirctwZdEjSuITtH45eeb9ZNfGNi9t2ok
	BvZC2TzOiSwSpgAOkslL8KzP3yYLA5ZwqWPi8wEVclfqa+Z1A6wR3JUiLcDp3lWn+2t3ocab/sctB
	S1TeSjl2N7U8kkWorO0F8ULM1X8Zxqm6S0XyfMm0CfEZGPsAT/NBeD5PBYbPxOKOILytyUQCFinkj
	sIJ8XI4zA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jq1d3-0003Cb-Vb; Mon, 29 Jun 2020 21:47:54 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jq1cz-0003By-Li
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 21:47:50 +0000
Received: by mail-ot1-f68.google.com with SMTP id k15so16801083otp.8
 for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2020 14:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bg/8+MNYJDDCvPfevV5MmVW6eomjiYjuKJdPS9BuKRc=;
 b=DRex5gj8NjsTjmvW1XM2Qx6tFv/wvUPbOAaTJUQjR/r5zDF8TuZ+y0BVqbOSTkrJr9
 F/anZiUYU5fi+18ptVB89vsHwjvGCRv0EDWXKru9q4c3NMpodQ2xh4ZnCyG/S45UDTRf
 uz2QeJFZILczXyE2EZvGXRtKcp9BKAFXrh0MCjk+t5cklJseBoZiA3MA4s2Xd2L3W7sg
 9/xASJS2bITuxSN8g2Rhe7bN6dVb0evfBe43jV9jGtQLf35GhidrGNm5OgU+GvrKVryE
 L4j4a4t6x0BXGbScPoPi58zYBaIsttxtLkgU3mOPtpdCvN1qiAU/aXc4r0iIw0CVYllh
 QpNg==
X-Gm-Message-State: AOAM530UJCv1rFqwF6PvvmGsrl+AeKoyvTJ2i0sJAUsDDXJcnONLZwQt
 9saDmOkUB6iDMk651RfEd1L8Gkvg6nbhy/k+YcE=
X-Google-Smtp-Source: ABdhPJyLaroA0htJgp6XAeP34onG9mo2tlAy+lOvoV/8lvJ36fwjwGDczPcQeW26SHMu76Ngn9P5yzkiLg9cpAETRvQ=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr14223999otb.107.1593467266175; 
 Mon, 29 Jun 2020 14:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-2-hch@lst.de>
In-Reply-To: <20200629193947.2705954-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2020 23:47:35 +0200
Message-ID: <CAMuHMdXXORM_yD4bqk+MQ1yEA1jmOjO9eyfnsjxY1a5E5isEcg@mail.gmail.com>
Subject: Re: [PATCH 01/20] nfblock: stop using ->queuedata
To: Christoph Hellwig <hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, "open list:TENSILICA XTENSA PORT \(xtensa\)"
 <linux-xtensa@linux-xtensa.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-raid@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Lars Ellenberg <drbd-dev@lists.linbit.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 29, 2020 at 9:40 PM Christoph Hellwig <hch@lst.de> wrote:
> Instead of setting up the queuedata as well just use one private data
> field.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
