Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C69C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 09:27:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8C920639
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 09:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o8Z/kpIc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiXoJqDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8C920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=557OV+L4sdDEb20O0GTA01qsIQEn5EsD6bZ9jh2hPQI=; b=o8Z/kpIcb/hBVbWqGHYyqUXM2
	oJ6KEUn5JIazanJn9e1OvwBi2yh6qJgkvMdMqy+rhqcgtHio0s+g0s5roUoDxI2NS3xKCAATCDCGW
	o32u93dinnGTDCFqbfr/ADu0hyiW6/Vd11HbPC3mwWDwCwSNpx0meqJggg7yexg6IzJ/DD6lmBwxG
	A1buD7C4afxXfax4ItQze9kwfjz0GRchdFBkrvJqA5fqMyewWpErq+FoRoPfXfte8F2DlbLXiYgrO
	iBqZc0oKMrqTgJBco6Jd6hyBqpzP/fcguxOq731dgr77s3wPtfUKwAqm7rUTGqhh/slb+sBKQf+GW
	tiYTulFig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8KN1-0005AP-45; Wed, 19 Aug 2020 09:26:59 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8KMz-00059f-Oz
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 09:26:58 +0000
Received: by mail-wm1-x341.google.com with SMTP id c80so1384805wme.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lVH13tdAzC6mW/dwhV6wM3c3cw0w+EwXAkE9fSxw6kk=;
 b=LiXoJqDEZa5lyE4ikb0YCl1GOpEyvF7YoJVZ3kOe+9PbwXYwTgsNunyBrTmnHpcwLS
 AycdLYrvYIpvnEsRb768v0N/KWszt83KWkhoZzXjI3eH1VMUG6mbDoqEFLy1K6QxIMOC
 1hVDWDu2nR1b+z89w6enM8EpzLNUN4QnBB2IY0SBnjvjtVM2P10D5cIoDVZgXGJh4GaL
 j5U8omvfmoAHsNIrqNSuho6gPySbtyWgNfmPBHhew2sO50S7vkaRhIOltkVWhPE00LHW
 0dxpLaSf4HgAo7voQQH0d2vcYfSwwFPXR98OGRdl9b6DxcDSL5Yt1dBGtfj1NMg51NKL
 49Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lVH13tdAzC6mW/dwhV6wM3c3cw0w+EwXAkE9fSxw6kk=;
 b=PcI3wvjc+PbTmID4sjP8w/z0J4s4VoaE73p4Uhj76V40s+473Rva7HWzz9QkiFWKzI
 SiFkfKjDR02P3aot4jt7raa1/UzeVgAYHBklp/XVKVcydcR7OFEBeRY7Nk+mt+JMFcb2
 IschNTF5z8X5BK/en61XRM+vapVV3ZybOOrJJga31H4syXtH72Ldxr2i5DJQ1Xt7kNIT
 xr0XD83Fx2TB/83tH/SBweOUK6FgujkFTEhf1JwXgxTmYOGlJGtgpH9qoTgWveksT6ke
 Q9U68VljtumVEyNfvrKNssyinSDEphVQH5LJfdXz0cEFTD/FQwFzK7yimyfILHnzgfdM
 f5yw==
X-Gm-Message-State: AOAM531VcMa4deicaMi6lkA8jxTLKJdBJAd66dTzNg9UEU5xsBGpAtwv
 7Ra1Ucc0NB1D+P613B4ZUHxRq51gbHWoQ83qbHtQLIMsrAM=
X-Google-Smtp-Source: ABdhPJw+vfNm6gcyC15QGjAi/+l7apLAwW4FOchrK0YZEt7izxf65sSx5B4ycnxIWcXGiEbZh+MIcEEgwnJLJgGiw2I=
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr3986004wmy.15.1597829216005; 
 Wed, 19 Aug 2020 02:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
In-Reply-To: <20200818071141.GA2544@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 19 Aug 2020 14:56:29 +0530
Message-ID: <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_052657_837152_92E30557 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 sagi@grimberg.me, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> > Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
>
> No, it is not.

Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
I see that null-block zoned and SCSI-ZBC both set this requirement. I
wonder how it became different for NVMe.

-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
