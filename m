Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B09C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 13:36:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529A32067D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 13:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zuNJxWAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529A32067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HevbPlbxW3S0Qcet8PV4MYLEUfWdNs24vxHrozcp73M=; b=zuNJxWABe7wNuMLtisHSMLw9a
	ItA2NXsUI/dDfKcetS+ZS6pVuhibTOA9+KLMWhyrARC+1i5pIWRyBB09GFdlBcpEPogEsPyTh6tgV
	jagxcpAmKEvP7DimEXQrpChhblFJiTwFx2J8we4c4tbvlXh1sO4X0aHzUuH2JHbx0Lrcm9CzWDt3+
	iX+keVxZ9oG3GGOh/5dLMFkd56v1ajqDIuIwUfJce1U5r5S4sfkSGr1CShPJT4ZupgGhcNSZlG5Ga
	3WrHxF0pzHifI3QpUu83QzWQEH9ZeUkE0MGpQwx5l9RMumyzX+nyFrAcp9kWrR8rpmeLNg+91Zqq7
	+sBzb6Ifw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyxrv-0004Aa-SH; Fri, 24 Jul 2020 13:36:11 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyxrt-00049R-2W
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 13:36:10 +0000
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mgvev-1kSpRZ3IIH-00hLzG for <linux-nvme@lists.infradead.org>; Fri, 24 Jul
 2020 15:36:04 +0200
Received: by mail-qk1-f169.google.com with SMTP id 11so8623243qkn.2
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 06:36:04 -0700 (PDT)
X-Gm-Message-State: AOAM531Hxbv/gTxFfWxU/UOKA9wI/QFVZaI7eaRuN/hR3nzwJkYfxy8e
 sWCbrXZ9wMxlBHZOiW0hnXgggxzwIUWYgRx8vUA=
X-Google-Smtp-Source: ABdhPJw8PDUAcsa19D0JsA1UiJ+7gWd1V/OX8unaG7ilwuCw9y8HfDDcLAZ6+8VBtnlLCvi1Km+wsSFZgRokoxK9dkY=
X-Received: by 2002:a37:9004:: with SMTP id s4mr10380921qkd.286.1595597763603; 
 Fri, 24 Jul 2020 06:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
 <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
In-Reply-To: <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Jul 2020 15:35:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
Message-ID: <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To: Ulf Hansson <ulf.hansson@linaro.org>
X-Provags-ID: V03:K1:t7FzyOoCXOOxH617dlZKI9SO9lD3vYW5cFL8+KNiEP493gw8jtr
 bKEGSFwmgSX9vJMKgJhiRPM0AteFB8d1BP6+6YFjPxICTwEvethHiQ5VOcGJM4wTUMxN0qr
 OvEGcne7qdjn8USBPFH73FHi3KEHCYB9zcJNnPe/ve7BHbx/NKSSyM1EBUAtAx0SM8myxuQ
 G6yftikQIEmnCbElSWXJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3wapdOe4xCo=:TYCUcqJT0+dU9ZQ2+859KF
 aPElGvKA3nuIpANJWH1zSt9z7lbhOM57zeeXstMODpo2i4jZPC3Evxhn5s4iFGYc4Xe4TTgnb
 cUus9I6uHwEzDtDj1CV6Z3iqrpdUsrKQcwobkkmaEdN+8FVEGtlYzMOQmQ0KKp19FD2XiS9zT
 eExZw5CTbq/2aZy486iPoXBM255BdQq8/HCiKyhiHP6JiA1GPynE+KAKUKCObo5nDmcSjI+cm
 aQ2uoCkvrwpWQEjrKo7oImqarEHSMaK/JiY0HsLj8PM9WPts9SHEhLCZ6oONruzFAXgSU/Rj8
 EBBL3gQJtvMneh3wBqbz8R9+iNwJEgDtzziA8BruH2wwN/hIIZlpUtk8rKJj81tuW6lLdv4Xq
 /jjmOqsiPDJtYcQlPO/yaS7/RiC3l9OnVyW4GfmAFiuC1iDIxk+ppGRjs9DJEUrNHtWEoH/jF
 zf1/BFhT7wsJ6ZO0e1foMU4Us2bH10x1eP3Qz98rQtokfj8IhXNh0rp0f4GJc5m8S87pDI7VP
 Bj8WsLFhEJ8W9ZvNYR/mK4GfLfrkGKq36Z2EDNFskf26bF7rR7XwIRuYzgvHaCPVxct8qM2T3
 qdBCjYlfp5D/NP8EcfUF4JFWjknZs9tWVSXqo8xBD4sdZpMs7cuuKevD8EYQ7mu4QJ7g0r5Js
 +TPHfePG7gjYpqm25dO+CZZrlNywE7OzSr80nLYw1jGlmp0frds5hnV+qUvf6EOcMSPo6lD2O
 f/R9VCcrn4lz8FaskOFQBNGs/0owIV6bNdVMwFPO27ZHm/3SYoMAwCnBqnMkRB57FEKtaC5OM
 /fKq2lSQwmjCTIjtqTTaNojuUjkhexcFVz+beRjvOpfNTX++4Z1zJSOxQ1vqjHDumNibe9S
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_093609_324754_D275511C 
X-CRM114-Status: GOOD (  25.11  )
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
Cc: Rui Feng <rui_feng@realsil.com.cn>, linux-pci <linux-pci@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Adrian Hunter <adrian.hunter@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 12:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 16 Jul 2020 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jul 16, 2020 at 4:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > > +       /* Continue with the SD express init, if the card supports it. */
> > > +       resp &= 0x3000;
> > > +       if (pcie_bits && resp) {
> > > +               if (resp == 0x3000)
> > > +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> > > +               else
> > > +                       host->ios.timing = MMC_TIMING_SD_EXP;
> > > +
> > > +               /*
> > > +                * According to the spec the clock shall also be gated, but
> > > +                * let's leave this to the host driver for more flexibility.
> > > +                */
> > > +               return host->ops->init_sd_express(host, &host->ios);
> > > +       }
> > > +
> > >         return 0;
> > >  }
> >
> > Does this need an additional handshake or timeout to see if the
> > device was successfully probed by the nvme driver?
> >
> > It looks like the card would just disappear here if e.g. the nvme driver
> > is not loaded or runs into a runtime error.
>
> You are correct! In principle, the card would not be detected (it
> doesn't disappear as it never gets registered). Instead, it's left in
> "half-initialized" state, waiting for the nvme driver to take over.
>
> I simply didn't want to go that far, to introduce synchronizations
> steps between the nvme driver and mmc driver, but rather started
> simple. Perhaps we can discuss these things as improvements on top
> instead?
>
> What do you think?

Starting simple is generally a good idea, yes.

It would be good to have feedback from the nvme driver maintainers.

One way I can see the handshake working would be to have
an sdexpress class_driver that provides interfaces for both mmc
and nvme to link against. The mmc core can then create a
class device when it finds an sd-express device and that
class device contains a simple state machine that keeps track of
what either side think is going on, possibly also providing
a way to perform callbacks between the two sides.

      Arnd

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
