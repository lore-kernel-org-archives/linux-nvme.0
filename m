Return-Path: <SRS0=tL+/=A3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01248C433FB
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 17:22:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14BD20657
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2020 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GX5A8CRI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZeRoY0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14BD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ohc1plEHX3i3qMdpMcIUldB8P7CEfR4sY91ffclF1yo=; b=GX5A8CRIo+jAtjPrYO+lYFD3Q
	I6c0ASvBmKxT79W3YeAsh9eqjPkEqSJFgWDFM0qpCSfwFEXA/HlLRthSwYL7MsoxWy0+LenQlyLbG
	Uk+x9K1out8dbhNKx/i2cgfI87Jc0RFY10/IIgzuHDtg0Gq64DT5zZT6geo75r2AH+SyEwr5y9d7O
	lbeTIS0UDCyR3FgE/nTTlhZ5pfRhqw+zfv/bQVollmMJGrkWcEl7mJr424TiIfs6tev+ACXR+riQY
	oQgzI7S7i73nlSIG6Y0Xr0NDWHYMrGrGPjz75CCL5UlV7T1I7LgcdZrPFjDw/P9Bi5RwR4/To4w6b
	cmm2l2XnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jw7Zy-0008Aq-0y; Thu, 16 Jul 2020 17:21:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jw7Zv-00088X-2s
 for linux-nvme@lists.infradead.org; Thu, 16 Jul 2020 17:21:52 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8BD3420657;
 Thu, 16 Jul 2020 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594920109;
 bh=ctSOUR51zUNLOTRs5i7BKOjlKSkDjPbwBTLa6Z1gzwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HZeRoY0aGb1fLAHBnoI42rOigziBskvvTO+Qpo3p4wN2ZLO0Kznsn3NuJbyxLybz9
 T8CKkfj/YzPBQOEGbP5r/Dc+icJ5pS81q30niNjoEEPrvX6eGBssXZTZrUNgUjLRu1
 0Z7GOjq7tVQf+Jik+vu/bTZiBvZqmCLNVU52/3L8=
Date: Thu, 16 Jul 2020 19:21:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
Message-ID: <20200716172141.GA3143216@kroah.com>
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <20200716161358.GA3135454@kroah.com>
 <CAPDyKFr6eSZr2V-=YvAEZH9SmsE2SZ9j5ZS5zZEFHBqwyWRfpw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPDyKFr6eSZr2V-=YvAEZH9SmsE2SZ9j5ZS5zZEFHBqwyWRfpw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_132151_272243_68F18269 
X-CRM114-Status: GOOD (  22.32  )
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

On Thu, Jul 16, 2020 at 07:04:21PM +0200, Ulf Hansson wrote:
> On Thu, 16 Jul 2020 at 18:14, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 16, 2020 at 04:15:34PM +0200, Ulf Hansson wrote:
> > > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr)
> > > +{
> > > +     u32 resp = 0;
> > > +     u8 pcie_bits = 0;
> > > +     int ret;
> > > +
> > > +     if (host->caps2 & MMC_CAP2_SD_EXP) {
> > > +             /* Probe card for SD express support via PCIe. */
> > > +             pcie_bits = 0x10;
> > > +             if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> > > +                     /* Probe also for 1.2V support. */
> > > +                     pcie_bits = 0x30;
> > > +     }
> > > +
> > > +     ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> > > +     if (ret)
> > > +             return 0;
> > > +
> > > +     /* Continue with the SD express init, if the card supports it. */
> > > +     resp &= 0x3000;
> > > +     if (pcie_bits && resp) {
> > > +             if (resp == 0x3000)
> >
> > 0x3000 should be some defined value, right?  Otherwise it just looks
> > like magic bits :)
> 
> Yeah, I was considering that, but there are already lots of magic bits
> around here in this code. On top of that, the bits are shifted,
> depending on how they are used.
> 
> We should probably look into doing a cleanup, so this gets clearer overall.
> 
> >
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -60,6 +60,8 @@ struct mmc_ios {
> > >  #define MMC_TIMING_MMC_DDR52 8
> > >  #define MMC_TIMING_MMC_HS200 9
> > >  #define MMC_TIMING_MMC_HS400 10
> > > +#define MMC_TIMING_SD_EXP    11
> > > +#define MMC_TIMING_SD_EXP_1_2V       12
> > >
> > >       unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
> > >
> > > @@ -172,6 +174,9 @@ struct mmc_host_ops {
> > >        */
> > >       int     (*multi_io_quirk)(struct mmc_card *card,
> > >                                 unsigned int direction, int blk_size);
> > > +
> > > +     /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
> > > +     int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> > >  };
> > >
> > >  struct mmc_cqe_ops {
> > > @@ -357,6 +362,8 @@ struct mmc_host {
> > >  #define MMC_CAP2_HS200_1_2V_SDR      (1 << 6)        /* can support */
> > >  #define MMC_CAP2_HS200               (MMC_CAP2_HS200_1_8V_SDR | \
> > >                                MMC_CAP2_HS200_1_2V_SDR)
> > > +#define MMC_CAP2_SD_EXP              (1 << 7)        /* SD express via PCIe */
> >
> > BIT(7)?
> >
> > > +#define MMC_CAP2_SD_EXP_1_2V (1 << 8)        /* SD express 1.2V */
> >
> > BIT(8)?
> 
> I can change to that, but it wouldn't be consistent with existing
> code. Again, probably better targeted as a separate bigger cleanup on
> top.

Ah, good point.

Ok, no objection from me!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
