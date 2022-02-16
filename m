Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444ACC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMEC9up1pdSgVmN96DpXU82nWhWLDUUDZ0jRF4j3ubI=; b=0TkyX3KKnsji7EPjTzK7HNlOWn
	wGQmhRd50KKWSwLnb+nElwLolBHb0v6XcMIDDUUNg2478vMB6BHCphGqb792JQqHlUTYXdrhfuHHf
	UJbY9xFvDndVMBRnYBPStr4pEBGU6izSKC7tSmAnRmCLybxz692PahA8U/0cS7655w+VXgX2pBVvK
	U22ZDuyGlAoowcP/ADIyz0B2F2qjE9Qxuz9hFBixJxqAX4ivzLJ8UFuosyB1qLvvdBVqF9x/1YJN+
	cEntdARD3k1GvJkyxTQYOQlnz9QKkvp/CHcNubaRj6KZjPFPxVFrP6cmDnwnvMTPUBQKWPT2fErjc
	lAouD5LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKKuV-007IEv-FM; Wed, 16 Feb 2022 14:03:59 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKKuL-007IEG-Fr
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 14:03:54 +0000
Received: by mail-pg1-x52f.google.com with SMTP id z4so2216861pgh.12
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 06:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WMEC9up1pdSgVmN96DpXU82nWhWLDUUDZ0jRF4j3ubI=;
 b=aqnwqX5OGX53yCw3v5VIeAFDRQdA9y/6hmRfAWyNc2cfpAzSzfNpzFK4JWGajaAVQL
 bsTdC3EwCErJHGFBd3jp7jG4n3Mem/xm3HjU7hNsNztkT2rTH/CqWApEEx684cG1oTu8
 drMTuQVJSFcjzfaNkzY2k/5j4V759xZ0M4FEStzur8BDH0e+LSkHGd/u8VHTITgC7uBi
 nCCvBC/nXkfQbgtYLEM+1h6MdwXViOI9gCTsEHRs5Z6GH/mycIgG5R5lJ2umSphCoQYY
 d42AyaFH7eoZrXhWCaLLpr5OS2zb5iLuzZbbLI9sN+/qFQAMOWGcZcqXYVk6zpE16srv
 Ve9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WMEC9up1pdSgVmN96DpXU82nWhWLDUUDZ0jRF4j3ubI=;
 b=a+h6VurCuMuKB65cpMiZCYuMB4ZdJjWt8DSogzKZ8x/W7zcrOi+vsYQ3oQQrKJc/uP
 2yqewXBcwnJA2jpXXk/IV4Za2reZwCRnimm52tpTR5ia2Uxl71W783yofX4nwmqdoOEB
 ie7ljCOdjqozyH9aH2ePQl+cGBQV0LJf8+crKiGLB+3u/bz11ZHFW0TRYIBFoyCckVzQ
 IDK5lg8U/HA1NEbAk+ohgdvTaPnrAZJ+w18rp+pUTknFB1E0AXCDa9LoTEC+GUS/aTAd
 386V7wpRpEyyEiq++aFH99xp9+quqFvdsYVJohV8P1k0oMm1Sk+8y5jIYp5Xopx4VwG6
 HKGw==
X-Gm-Message-State: AOAM532dalfFYFZZf/YugK5srEZI+P1B4ast1n7cgs7dl6ZVeVjzp/pB
 n26J8rx6SyMeYF4CzMGPdu4R1vF02oZfdnKZiBM=
X-Google-Smtp-Source: ABdhPJyjJGz+efLP9+ky1xac0SP8AV4nTxMoEPCXhVkOi+QAIFKiXyoRT7U8Dl9sTcZlVuhx1D5iA4Kn6pPWVaCD1Q0=
X-Received: by 2002:a63:91c9:0:b0:34d:f43b:61e9 with SMTP id
 l192-20020a6391c9000000b0034df43b61e9mr2474254pge.155.1645020226293; Wed, 16
 Feb 2022 06:03:46 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220216061807epcas5p1a349815c50db8f3539c30e2dd569232f@epcas5p1.samsung.com>
 <20220216061305.45360-1-joshi.k@samsung.com> <20220216081148.GA10851@lst.de>
 <CA+1E3r+3ra2sr3hHx4b2QEq-tsQ6sfLp+hVvPz0a+Q_8G84QKg@mail.gmail.com>
 <20220216125731.6juezl4kshv7ovbp@carbon.lan> <20220216132056.GA15649@lst.de>
In-Reply-To: <20220216132056.GA15649@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 16 Feb 2022 19:33:20 +0530
Message-ID: <CA+1E3rJbE8+T4SWQcwZZyXmEDUm88dFWudSJtcvE3vOtrkOU9w@mail.gmail.com>
Subject: Re: [PATCH] nvme-multipath: fix multipath path scan
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, Kanchan Joshi <joshi.k@samsung.com>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, Adam Manzanares <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_060349_571463_986C4298 
X-CRM114-Status: GOOD (  14.68  )
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

On Wed, Feb 16, 2022 at 6:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 16, 2022 at 01:57:31PM +0100, Daniel Wagner wrote:
> > > In nvme_update_zone_info, but nvme_configure_metadata is also possible.
> > > Moved setting the flag before both these.
> >
> > But the NS is not ready at this point. nvme_update_disk_info() needs run
> > before the NS can be marked as ready. Commit message e7d65803e2bb
> > ("nvme-multipath: revalidate paths during rescan") explains why.
>
> Yeah.  So the only error return from nvme_configure_metadata is a can not
> happen case which doesn't really need the error return.  So we only
> need to check nvme_update_zone_info and can set the ns life for the
> -ENODEV case there.  Something like the patch below:

It looks good to me. Can add a tested-by too if you are planning to send it?

Thanks,
-- 
Kanchan

