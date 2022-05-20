Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B5CC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhZYflED6/DiNr1feOC9OhkU49iweDam4jS4WznrIsk=; b=NHQ5OjMc0Dx3UtKJg6sjwCB79Q
	hcJpwdUaAMJEX/A7BBqhW6l1JPY4IJPsw6FBrQa7climRBomF/31IqXzUNDxX4agXhr2SmXMbqpRu
	hHMsKG5Ly3JjszEI9PLMSWhSaYm6AaDA73ZFU+gznRcPJaipOfssb9zZEufotJKlfjT32GxHIeRwl
	7aY2jSPpgyZPD4/SIfhSsD3QcUoAV92AlaTo5xeYUbHKwCVqKivB1v0lqmmbhjstSvQ+nicCnDl8Y
	C8CNcsY0BmjWAor2MeMbYY4mmymNZRrn2uJIIjMQpgqmG7QDp8eCIYiTpHURpX22BvEr2OUZAINRQ
	JMZ73Kpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns22e-00CRmI-MT; Fri, 20 May 2022 12:47:40 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns21d-00CRIs-BE
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 12:46:41 +0000
Received: by mail-qt1-f174.google.com with SMTP id g3so6797161qtb.7
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UhZYflED6/DiNr1feOC9OhkU49iweDam4jS4WznrIsk=;
 b=t2ZMHqw3TfT9Vn0Xr7c1iewLs6jlUd2ucE+iR7w/72qMRcZZBm7EZQIgu+5/QMc2mo
 v1/FgBb/7KaA6hhsQr64jByXb4seA4NbVJx/wg0GyA9JBiZmVSCyapS8Sx/cw81CtcId
 Uk6xAuzTvUkVtaV2zHkI+ybAKoJ+307EntnQouNGFBgzhNpAuFwIqYYNXB2FvczJ8jN5
 bhxAktNqeoH+uabW1Vxczs2gmOE0SPGon6fOCSe/POCZPeTcXxbZxecBcCvaqv1l+YOc
 GmWC+cjyQ9kXrPZFJzPl9159yGde2E6a4iL0FyEpiVFyw0a9mJ9PuXuksM8T8fU9rZFr
 zz4A==
X-Gm-Message-State: AOAM5303bL3cQsQYsQjPZZmBvWFMPLsJve9V3Rn97yBbDVJf7KwIRd//
 foVn+YBdtYTLepy8uaMv1+2nJ8gl+GY5yQ==
X-Google-Smtp-Source: ABdhPJyarreNWPKhqaPlSLii/HD1smXrSly3Be2T7THTuCNNYVapXb2Y+uSPVVZaRNyden+GvZ4DVg==
X-Received: by 2002:a05:622a:3c8:b0:2f3:ef89:fa28 with SMTP id
 k8-20020a05622a03c800b002f3ef89fa28mr7613736qtx.136.1653050794146; 
 Fri, 20 May 2022 05:46:34 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com.
 [209.85.219.178]) by smtp.gmail.com with ESMTPSA id
 a7-20020a379807000000b0069fc13ce21csm2995381qke.77.2022.05.20.05.46.32
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 05:46:33 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id b124so2010974ybg.12
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 05:46:32 -0700 (PDT)
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr9068692ybs.543.1653050792549; Fri, 20
 May 2022 05:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
 <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
In-Reply-To: <CAMuHMdU3SYOwE5ftDwymQpVwWmpbC=1Ytyp0Y9GaeUS2i1cP+A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 May 2022 14:46:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVx7r-4TVV9uVJppT-7ZAriov01BUNk4ghU9Bs4uY28vQ@mail.gmail.com>
Message-ID: <CAMuHMdVx7r-4TVV9uVJppT-7ZAriov01BUNk4ghU9Bs4uY28vQ@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
To: Guenter Roeck <linux@roeck-us.net>
Cc: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-staging@lists.linux.dev, 
 "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>, 
 DRI Development <dri-devel@lists.freedesktop.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux Memory Management List <linux-mm@kvack.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
 linux-sparse@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_054637_438167_B2CDCCE6 
X-CRM114-Status: GOOD (  25.65  )
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

On Fri, May 20, 2022 at 2:40 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, May 19, 2022 at 8:48 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On 5/18/22 17:55, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > > branch HEAD: 736ee37e2e8eed7fe48d0a37ee5a709514d478b3  Add linux-next specific files for 20220518
> > >
> > > Error/Warning reports:
> > >
> > > https://lore.kernel.org/linux-mm/202204291924.vTGZmerI-lkp@intel.com
> > > https://lore.kernel.org/linux-mm/202205041248.WgCwPcEV-lkp@intel.com
> > > https://lore.kernel.org/linux-mm/202205122113.uLKzd3SZ-lkp@intel.com
> > > https://lore.kernel.org/linux-mm/202205172344.3GFeaum1-lkp@intel.com
> > > https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com
> > >
> > > Error/Warning: (recently discovered and may have been fixed)
> > >
> > [ .. ]
> > > drivers/hwmon/nct6775-platform.c:199:9: sparse:    unsigned char
> > > drivers/hwmon/nct6775-platform.c:199:9: sparse:    void
> >
> > This is getting tiresome. Every driver using outb() on m68k will
> > experience that "problem". As far as I can see, it is caused by
> >
> > #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))
> >
> > in arch/m68k/include/asm/raw_io.h. I have no idea what the
> > "(void)" is for,
>
> The "(void)" makes sure there is no return value.
> Which matters if the result of a function returning void is propagated
> to another function returning void.

Which, FTR, sparse also doesn't like:

    error: return expression in void function

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

