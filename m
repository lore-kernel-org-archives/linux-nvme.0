Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 17:05:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72AC2070E
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 17:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hO5IqrzD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMAZ17R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72AC2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=no5St12yAZSkXAQcucczuo8BqiSYIcWShrndj3sAipU=; b=hO5IqrzDccEJn5mwLhA9WK7Y2
	/C+SLoR1NVzGK1NMpkg6chd3UhrIslu5Dwz+Qog9oVr06C1WtrTR8T2HEYZapCYlB/UgKdL+Qg1W6
	zKnaBrqJ30Jnyzx5F/WJ2cddDGnCoAgrDVeJvTLsgYtpgVR6/gBGfGPOIugTm79cJsH3w8tND0CvM
	DUqiIjkEc2Gbg7J8Ijer+PuMiYHtt1G6ssZkGYuJdCshyPXYY8NSORDn7rb6anbn8nJODnB3XZlTu
	yx2Bt/9quu5l+mijg287sVlaxegpGwVQUlw+9fN/M2djGgyGtMOVzeG99NEkCAuciuyZIQoESVSJc
	nfc+2piWA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw7Jf-0005OA-Bu; Thu, 16 Jul 2020 17:05:03 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw7Jd-0005Mp-8H
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 17:05:02 +0000
Received: by mail-vs1-xe44.google.com with SMTP id b77so3384456vsd.8
 for <linux-nvme@lists.infradead.org>; Thu, 16 Jul 2020 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yXCXHIokDzodhKUObyVjOxa03jfGTBYMvv8WAppwfWw=;
 b=OMAZ17R5F4R2ot+nESDlRmF/PsTGBo0nI3RT7xp1G/cqE2oqUY3bc9Fb+ugMS80xrb
 znXaX4PAarGdFPR4LBReIhms/8bt9bKPhyvwhSRlY7CU0GUd57x4rIKKEuvgWWBKz69x
 i4xQ0ZoPWC36Gw/dqdOsafiQp1tUyNns5fk/cRljFa68IvfNSHwcTnQ9lYZzLLPNsfPk
 PWK9Mi4QjWU6/kksGKdQKviiSIGSdka8ufAadG90A+Y7rITCQ8IDj/3BXZUBVKib3mkE
 LA2ISGCmf/Id/n0XHdIlXCmmGZ/EntO1PICDf4G+PB6Vr1opRAuVYeK7+34wA+8GrRfo
 rWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yXCXHIokDzodhKUObyVjOxa03jfGTBYMvv8WAppwfWw=;
 b=FxOOMxdjwU7gBcx9To8Cbg0UPlL25cfug8TuGpn8XwlC/tF7kSoqoeanHSohiKpb2Y
 cq7mxA5+T9uIAFN1h0dAksKiGBsPwOaujJ28KQabRdt6SEFpiKR+WncThAlw38IgpDZG
 bR7JcPOE2CDDG+oWz4VT7rBocuv+Qq6R+BR67Hbq5iKBUOrCgQzYqAmY/5lGuYQV7Ors
 PW4hu6YzSmHh2m+Fybv1iSPqY3YDw3Ts8/YcWSOZq9OWg3tGyib2U+x6GMxBvnasgL7J
 wj7viHPCMKrM8go8kgV/zdJW27K0uIXsnMCJEzZknC/eqgUvXVanryDzLunqULeXvGbt
 FHbg==
X-Gm-Message-State: AOAM530fPcRAYHQvVbY4OtdBNYRp8WgdKJd99uhUp/DJuD22Gzh8LuKe
 RWVZFwv5N6Yz9zb4UMbE64LT0E1l8q73qM/5Tft1Xw==
X-Google-Smtp-Source: ABdhPJy+joudz+/azfNGzNGeAboNVq0ccJyFmfsvE4PWZBNI06UJy8K3PCy86RDOtundUZK2A9jXmpiX35sAbL82qYw=
X-Received: by 2002:a67:d01a:: with SMTP id r26mr4172278vsi.200.1594919098955; 
 Thu, 16 Jul 2020 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <20200716161358.GA3135454@kroah.com>
In-Reply-To: <20200716161358.GA3135454@kroah.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Jul 2020 19:04:21 +0200
Message-ID: <CAPDyKFr6eSZr2V-=YvAEZH9SmsE2SZ9j5ZS5zZEFHBqwyWRfpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_130501_349726_86AEB29C 
X-CRM114-Status: GOOD (  19.58  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Rui Feng <rui_feng@realsil.com.cn>,
 Linux PCI <linux-pci@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Adrian Hunter <adrian.hunter@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 16 Jul 2020 at 18:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 04:15:34PM +0200, Ulf Hansson wrote:
> > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr)
> > +{
> > +     u32 resp = 0;
> > +     u8 pcie_bits = 0;
> > +     int ret;
> > +
> > +     if (host->caps2 & MMC_CAP2_SD_EXP) {
> > +             /* Probe card for SD express support via PCIe. */
> > +             pcie_bits = 0x10;
> > +             if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> > +                     /* Probe also for 1.2V support. */
> > +                     pcie_bits = 0x30;
> > +     }
> > +
> > +     ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> > +     if (ret)
> > +             return 0;
> > +
> > +     /* Continue with the SD express init, if the card supports it. */
> > +     resp &= 0x3000;
> > +     if (pcie_bits && resp) {
> > +             if (resp == 0x3000)
>
> 0x3000 should be some defined value, right?  Otherwise it just looks
> like magic bits :)

Yeah, I was considering that, but there are already lots of magic bits
around here in this code. On top of that, the bits are shifted,
depending on how they are used.

We should probably look into doing a cleanup, so this gets clearer overall.

>
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -60,6 +60,8 @@ struct mmc_ios {
> >  #define MMC_TIMING_MMC_DDR52 8
> >  #define MMC_TIMING_MMC_HS200 9
> >  #define MMC_TIMING_MMC_HS400 10
> > +#define MMC_TIMING_SD_EXP    11
> > +#define MMC_TIMING_SD_EXP_1_2V       12
> >
> >       unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
> >
> > @@ -172,6 +174,9 @@ struct mmc_host_ops {
> >        */
> >       int     (*multi_io_quirk)(struct mmc_card *card,
> >                                 unsigned int direction, int blk_size);
> > +
> > +     /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
> > +     int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> >  };
> >
> >  struct mmc_cqe_ops {
> > @@ -357,6 +362,8 @@ struct mmc_host {
> >  #define MMC_CAP2_HS200_1_2V_SDR      (1 << 6)        /* can support */
> >  #define MMC_CAP2_HS200               (MMC_CAP2_HS200_1_8V_SDR | \
> >                                MMC_CAP2_HS200_1_2V_SDR)
> > +#define MMC_CAP2_SD_EXP              (1 << 7)        /* SD express via PCIe */
>
> BIT(7)?
>
> > +#define MMC_CAP2_SD_EXP_1_2V (1 << 8)        /* SD express 1.2V */
>
> BIT(8)?

I can change to that, but it wouldn't be consistent with existing
code. Again, probably better targeted as a separate bigger cleanup on
top.

>
> thanks,
>
> greg k-h

Thanks for reviewing!

Kind regards
Uffe

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
