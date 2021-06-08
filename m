Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BEFC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 13:38:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F63161285
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 13:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F63161285
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zlaDUAO6wV35GQswhu12thqCMi2Nkam+xlDnfX/YqNY=; b=p8UiM1mFdPW7F2
	d73TXcgbzMy9OR8ZVVuCgGMczsHlvaiHYlU3S8g/Gopog4CrhIxunAmolF0NH/r2s/yEkAXj+8lBd
	TsaJ3USnRZFc3jV510/cOhHAEgrJ2ovxo6sFeTuUHtGyL6BhWVXP1h4zPWbbiLIuU7B/S6hlMF3lt
	1T5AR2V195xqOq/lR5AwLR35vh3NA3FtRckwB9+yWwDoJnVanUDEOIJCHtPWPY6GJgRivXI35D66/
	xtXVUfLl5XWiQxNEBX2IL5lXDcMXPvpeLg4DYkJ5Va7P08kqbkyAkBEuZaTyaDXKEdByrXiKIDJsA
	iDrg59uRjHp26F/snz5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqbvf-008eyX-5t; Tue, 08 Jun 2021 13:38:03 +0000
Received: from mail-vk1-f178.google.com ([209.85.221.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqbvb-008exp-Ay
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 13:38:00 +0000
Received: by mail-vk1-f178.google.com with SMTP id h19so163214vkh.9
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 06:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sFBGRyF0SVyL5gp+laaTF2trM1KaVtWovTdNQuQCpaI=;
 b=j3A79wn2/xwL3SAvBLczo15vuJCeN12nFmKyHFrUKydj2E8s7eUIzxv1cpX58kj1HS
 +ZEEbYcnxNqKo6mjjSdHW9QDZVwUmSuXcmJGdISlRtBw8lP2Jz/3QFWY/TWofElSzK/g
 CUwHqyUjx9SAjsiV643LTyh72eR8QREdh9WdPx97Ut5iBp9KvmBBossNdOOW2YGCRl23
 R0EQ3ZuaeBOhaSgKieoMFEsiTbKg5rx2ZQ1vZrEFfrNMrOGmh1Kyz+oPfUngSm9YYPIX
 3yluebE+FIEoPphMdTq9fgurr4huFRn7izLDRO2C8dNIJ63Re5R9hDG5uJNtog15gFu1
 do+A==
X-Gm-Message-State: AOAM532Bqr5QL0rzln9OJeT/WkPOMT6e2atsAtBw2TLc2zqVtQOr6Ltn
 zhDxSPbmdjjsxDm657LwWW3M2fKL6XNeJfPnC7w=
X-Google-Smtp-Source: ABdhPJzZpyfnwLGoBlfNX9l9wAC4rUovi8VQg3eXsLNLgoL0OHDkqdxJ2vRdBZLHTWRUeXJBZZqNSzFEalIOgTNWy2E=
X-Received: by 2002:a1f:ac45:: with SMTP id v66mr10780808vke.1.1623159478179; 
 Tue, 08 Jun 2021 06:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
 <20210608121925.GA24201@lst.de>
In-Reply-To: <20210608121925.GA24201@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jun 2021 15:37:47 +0200
Message-ID: <CAMuHMdWgLf8GJfOaRUyx=AvOTnuOs8FS-2=C+OCk02OLDCyrDg@mail.gmail.com>
Subject: Re: [PATCH] nvme: NVME_TCP_OFFLOAD should not default to m
To: Christoph Hellwig <hch@lst.de>
Cc: "David S . Miller" <davem@davemloft.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, 
 Sagi Grimberg <sagi@grimberg.me>, Omkar Kulkarni <okulkarni@marvell.com>,
 Hannes Reinecke <hare@suse.de>, Dean Balandin <dbalandin@marvell.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, 
 Shai Malin <smalin@marvell.com>, Petr Mladek <pmladek@suse.com>,
 linux-nvme@lists.infradead.org, netdev <netdev@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_063759_402525_984A4C7B 
X-CRM114-Status: GOOD (  24.74  )
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

Hi Christoph,

On Tue, Jun 8, 2021 at 2:19 PM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 08, 2021 at 12:56:09PM +0200, Geert Uytterhoeven wrote:
> > The help text for the symbol controlling support for the NVM Express
> > over Fabrics TCP offload common layer suggests to not enable this
> > support when unsure.
> >
> > Hence drop the "default m", which actually means "default y" if
> > CONFIG_MODULES is not enabled.
> >
> > Fixes: f0e8cb6106da2703 ("nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Err, where did this appear from?  This code has not been accepted into
> the NVMe tree and is indeed not acceptable in this form.

It was applied to net-next.

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
