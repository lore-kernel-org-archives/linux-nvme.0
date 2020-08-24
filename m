Return-Path: <SRS0=kA5W=CC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD6C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 01:05:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A55206C0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2020 01:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZqLhWRL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A55206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PmCZujvE/L31Jv5gHKr1MYdc60nCEKWpQLXqh1MP4Ms=; b=ZqLhWRL3kI+JaSi0OVxN4oVwn
	1P8NPfF9Lmos7LhJMrgqI3N8xLmnVcFz8te6vfZJKvyLELYX1Q8WBYrhJXrI1NUkTL3nXGaNF2pZf
	ecXlC41j5mxfZ6C2Q/3WClyho352FDIjY7E1sApkv8oSNf8Ve+11G/qtYPktCLTFVtb4B3KOgw2ys
	QtC6YODQTraJFmBF0rU/yE5HC6irYogJY6soWvorTR/C8k/TelpsEEOy1uBDmnH+8hM9lZYC/xYl9
	ANHe5TgUDDUsIqXAHxrLvenQgqrt7iC1iUg9YvgNnQrBuLVqvMY0jaBFhoLo4b5d+3rnuLnvokX4h
	/eKF8nHxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kA0v7-0001CR-Hn; Mon, 24 Aug 2020 01:05:09 +0000
Received: from rtits2.realtek.com ([211.75.126.72] helo=rtits2.realtek.com.tw)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kA0uy-0001Ao-Qa
 for linux-nvme@lists.infradead.org; Mon, 24 Aug 2020 01:05:02 +0000
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07O14Qe34013243,
 This message is accepted by code: ctloc85258
Received: from RSEXMBS02.realsil.com.cn ([172.29.17.196])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07O14Qe34013243
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 24 Aug 2020 09:04:26 +0800
Received: from RSEXDAG01.realsil.com.cn (172.29.17.199) by
 RSEXMBS02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 09:04:26 +0800
Received: from RSEXDAG01.realsil.com.cn ([::1]) by RSEXDAG01.realsil.com.cn
 ([fe80::505f:54c3:1aa:5c19%11]) with mapi id 15.01.1979.003; Mon, 24 Aug 2020
 09:04:26 +0800
From: =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tYzogY29yZTogSW5pdGlhbCBzdXBwb3J0IGZv?=
 =?utf-8?Q?r_SD_express_card/host?=
Thread-Topic: [PATCH] mmc: core: Initial support for SD express card/host
Thread-Index: AQHWW3uU3AH2v5B+mk6tKPAAmzd6U6lCM2GAgAR5zwA=
Date: Mon, 24 Aug 2020 01:04:25 +0000
Message-ID: <f4d74498a8c246a595e56b8daa09ece8@realsil.com.cn>
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <CAPDyKFr5WQ1kpFguDe2e8G7t7p_99CFbqwRQFZPCSuMV2eYsMQ@mail.gmail.com>
In-Reply-To: <CAPDyKFr5WQ1kpFguDe2e8G7t7p_99CFbqwRQFZPCSuMV2eYsMQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200823_210501_348297_6473E460 
X-CRM114-Status: GOOD (  46.33  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Linux PCI <linux-pci@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hansson:

If this patch will not be changed, I will post a patch for rtsx driver according your patch.

> 
> Rui,
> 
> On Thu, 16 Jul 2020 at 16:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > In the SD specification v7.10 the SD express card has been added. This
> > new type of removable SD card, can be managed via a PCIe/NVMe based
> > interface, while also allowing backwards compatibility towards the
> > legacy SD interface.
> >
> > To keep the backwards compatibility, it's required to start the
> > initialization through the legacy SD interface. If it turns out that
> > the mmc host and the SD card, both supports the PCIe/NVMe interface,
> > then a switch should be allowed.
> >
> > Therefore, let's introduce some basic support for this type of SD
> > cards to the mmc core. The mmc host, should set MMC_CAP2_SD_EXP if it
> > supports this interface and MMC_CAP2_SD_EXP_1_2V, if also 1.2V is
> > supported, as to inform the core about it.
> >
> > To deal with the switch to the PCIe/NVMe interface, the mmc host is
> > required to implement a new host ops, ->init_sd_express(). Based on
> > the initial communication between the host and the card,
> > host->ios.timing is set to either MMC_TIMING_SD_EXP or
> > MMC_TIMING_SD_EXP_1_2V, depending on if 1.2V is supported or not. In
> > this way, the mmc host can check these values in its ->init_sd_express() ops,
> to know how to proceed with the handover.
> >
> > Note that, to manage card insert/removal, the mmc core sticks with
> > using the ->get_cd() callback, which means it's the host's
> > responsibility to make sure it provides valid data, even if the card
> > may be managed by PCIe/NVMe at the moment. As long as the card seems
> > to be present, the mmc core keeps the card powered on.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Rui Feng <rui_feng@realsil.com.cn>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Rui, did you manage to get some time to look at $subject patch?
> 
> If you need some help to understand what's needed to implement the
> corresponding support in drivers/mmc/host/rtsx_pci_sdmmc.c, then please
> just ask.
> 
> I think it would make sense to queue changes for rtsx_pci at the same point as
> the mmc core changes. That's because I don't want to maintain code in the
> mmc core that's left unused.
> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/core/core.c   | 15 ++++++++++--
> >  drivers/mmc/core/host.h   |  6 +++++
> >  drivers/mmc/core/sd_ops.c | 49
> > +++++++++++++++++++++++++++++++++++++--
> >  drivers/mmc/core/sd_ops.h |  1 +
> >  include/linux/mmc/host.h  |  7 ++++++
> >  5 files changed, 74 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > 8ccae6452b9c..6673c0f33cc7 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2137,8 +2137,12 @@ static int mmc_rescan_try_freq(struct
> mmc_host
> > *host, unsigned freq)
> >
> >         mmc_go_idle(host);
> >
> > -       if (!(host->caps2 & MMC_CAP2_NO_SD))
> > -               mmc_send_if_cond(host, host->ocr_avail);
> > +       if (!(host->caps2 & MMC_CAP2_NO_SD)) {
> > +               if (mmc_send_if_cond_pcie(host, host->ocr_avail))
> > +                       goto out;
> > +               if (mmc_card_sd_express(host))
> > +                       return 0;
> > +       }
> >
> >         /* Order's important: probe SDIO, then SD, then MMC */
> >         if (!(host->caps2 & MMC_CAP2_NO_SDIO)) @@ -2153,6 +2157,7
> @@
> > static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> >                 if (!mmc_attach_mmc(host))
> >                         return 0;
> >
> > +out:
> >         mmc_power_off(host);
> >         return -EIO;
> >  }
> > @@ -2280,6 +2285,12 @@ void mmc_rescan(struct work_struct *work)
> >                 goto out;
> >         }
> >
> > +       /* If an SD express card is present, then leave it as is. */
> > +       if (mmc_card_sd_express(host)) {
> > +               mmc_release_host(host);
> > +               goto out;
> > +       }
> > +
> >         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> >                 unsigned int freq = freqs[i];
> >                 if (freq > host->f_max) { diff --git
> > a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h index
> > 5e3b9534ffb2..ba407617ed23 100644
> > --- a/drivers/mmc/core/host.h
> > +++ b/drivers/mmc/core/host.h
> > @@ -77,5 +77,11 @@ static inline bool mmc_card_hs400es(struct
> mmc_card *card)
> >         return card->host->ios.enhanced_strobe;  }
> >
> > +static inline bool mmc_card_sd_express(struct mmc_host *host) {
> > +       return host->ios.timing == MMC_TIMING_SD_EXP ||
> > +               host->ios.timing == MMC_TIMING_SD_EXP_1_2V; }
> > +
> >  #endif
> >
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index 22bf528294b9..d61ff811218c 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -158,7 +158,8 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> u32 ocr, u32 *rocr)
> >         return err;
> >  }
> >
> > -int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
> > +static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8
> pcie_bits,
> > +                             u32 *resp)
> >  {
> >         struct mmc_command cmd = {};
> >         int err;
> > @@ -171,7 +172,7 @@ int mmc_send_if_cond(struct mmc_host *host, u32
> ocr)
> >          * SD 1.0 cards.
> >          */
> >         cmd.opcode = SD_SEND_IF_COND;
> > -       cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
> > +       cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | pcie_bits << 8 |
> > + test_pattern;
> >         cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 |
> MMC_CMD_BCR;
> >
> >         err = mmc_wait_for_cmd(host, &cmd, 0); @@ -186,6 +187,50
> @@
> > int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
> >         if (result_pattern != test_pattern)
> >                 return -EIO;
> >
> > +       if (resp)
> > +               *resp = cmd.resp[0];
> > +
> > +       return 0;
> > +}
> > +
> > +int mmc_send_if_cond(struct mmc_host *host, u32 ocr) {
> > +       return __mmc_send_if_cond(host, ocr, 0, NULL); }
> > +
> > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr) {
> > +       u32 resp = 0;
> > +       u8 pcie_bits = 0;
> > +       int ret;
> > +
> > +       if (host->caps2 & MMC_CAP2_SD_EXP) {
> > +               /* Probe card for SD express support via PCIe. */
> > +               pcie_bits = 0x10;
> > +               if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> > +                       /* Probe also for 1.2V support. */
> > +                       pcie_bits = 0x30;
> > +       }
> > +
> > +       ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> > +       if (ret)
> > +               return 0;
> > +
> > +       /* Continue with the SD express init, if the card supports it. */
> > +       resp &= 0x3000;
> > +       if (pcie_bits && resp) {
> > +               if (resp == 0x3000)
> > +                       host->ios.timing =
> MMC_TIMING_SD_EXP_1_2V;
> > +               else
> > +                       host->ios.timing = MMC_TIMING_SD_EXP;
> > +
> > +               /*
> > +                * According to the spec the clock shall also be gated, but
> > +                * let's leave this to the host driver for more flexibility.
> > +                */
> > +               return host->ops->init_sd_express(host, &host->ios);
> > +       }
> > +
> >         return 0;
> >  }
> >
> > diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> > index 2194cabfcfc5..3ba7b3cf4652 100644
> > --- a/drivers/mmc/core/sd_ops.h
> > +++ b/drivers/mmc/core/sd_ops.h
> > @@ -16,6 +16,7 @@ struct mmc_host;
> >  int mmc_app_set_bus_width(struct mmc_card *card, int width);  int
> > mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);  int
> > mmc_send_if_cond(struct mmc_host *host, u32 ocr);
> > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
> >  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
> > int mmc_app_send_scr(struct mmc_card *card);  int mmc_sd_switch(struct
> > mmc_card *card, int mode, int group, diff --git
> > a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> > c5b6e97cb21a..905cddc5e6f3 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -60,6 +60,8 @@ struct mmc_ios {
> >  #define MMC_TIMING_MMC_DDR52   8
> >  #define MMC_TIMING_MMC_HS200   9
> >  #define MMC_TIMING_MMC_HS400   10
> > +#define MMC_TIMING_SD_EXP      11
> > +#define MMC_TIMING_SD_EXP_1_2V 12
> >
> >         unsigned char   signal_voltage;         /* signalling voltage
> (1.8V or 3.3V) */
> >
> > @@ -172,6 +174,9 @@ struct mmc_host_ops {
> >          */
> >         int     (*multi_io_quirk)(struct mmc_card *card,
> >                                   unsigned int direction, int
> > blk_size);
> > +
> > +       /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP.
> */
> > +       int     (*init_sd_express)(struct mmc_host *host, struct
> mmc_ios *ios);
> >  };
> >
> >  struct mmc_cqe_ops {
> > @@ -357,6 +362,8 @@ struct mmc_host {
> >  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can
> support */
> >  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
> >                                  MMC_CAP2_HS200_1_2V_SDR)
> > +#define MMC_CAP2_SD_EXP                (1 << 7)        /* SD
> express via PCIe */
> > +#define MMC_CAP2_SD_EXP_1_2V   (1 << 8)        /* SD express 1.2V
> */
> >  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /*
> Card-detect signal active high */
> >  #define MMC_CAP2_RO_ACTIVE_HIGH        (1 << 11)       /*
> Write-protect signal active high */
> >  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power
> up
> > before scan */
> > --
> > 2.20.1
> >
> 
> ------Please consider the environment before printing this e-mail.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
