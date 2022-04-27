Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybW0OIDsWEcMn3VwmmEhbJWTWhP0KU3qwOvRVelJVIY=; b=XvMJRzEt4f/LCWx822vRUqI7lp
	xrdXGXyfUOeZ219zm9fldxhyCdxzZ85AwlUccYqmAnQYQBVHPQ7ZDGyagE0lTiF88kd6VcUzC37f1
	ekgZFIszlnw6edOV6bzISJwrHIRip11pgU1ZplgQ8uadEOIjICJPSI/PjX7UYE3fKSidY6U7EUx9c
	ABoIz/jy30l0ns85vs3KxYGrIAt3/Cq06U9h3ftMZv17ENTzDGPmCwFCAMG+tmE18nRX2/kD+fGQi
	b3yy4u9C/9otzAe34PVzPFiqQol93ZBkeZ6IUW2GWbQycwbgstgo1el7aK73D/TVd1YzOsZXY70Ay
	2quZ8RrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njlqR-002oj7-0d; Wed, 27 Apr 2022 17:52:55 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njle8-002jUl-5j; Wed, 27 Apr 2022 17:40:13 +0000
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MV5G4-1nKuQL04UI-00S9UM; Wed, 27 Apr 2022 19:40:07 +0200
Received: by mail-yb1-f179.google.com with SMTP id s30so4701340ybi.8;
 Wed, 27 Apr 2022 10:40:06 -0700 (PDT)
X-Gm-Message-State: AOAM531F5iagjsi2DApriycOAjFmrliw5bYMJbIXmAUPseihN1eSa1SL
 0H9i/rb2RgTZTQkVfW0MNImcDR2AC2N4f2ah6IY=
X-Google-Smtp-Source: ABdhPJzGG7dXTjLV/N930H2jECBxmcHfIENpJEZwy84Jm+PgNFN5BfeM0y2kC82NWH0UZJvpag8dzGlkFmBl+oiknr0=
X-Received: by 2002:a25:c50a:0:b0:647:b840:df2c with SMTP id
 v10-20020a25c50a000000b00647b840df2cmr20714873ybe.106.1651081205687; Wed, 27
 Apr 2022 10:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
 <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
In-Reply-To: <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Apr 2022 19:39:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
Message-ID: <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, 
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, 
 Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6EEjNtoXbrsH7rxifzts9rSubBIBtZ5eYKI11CmPSu9EACobzzd
 ypRGLjJ25j6bW/AThPa/uPSd3zbqpIjy1X5XsM6UB94edw/hZVslXvjK0j8nashVOSe/HvC
 IQkZcTawHMYh4vF2KXv1j6/0TnvYL6Jo/21Cxmh89TfhnMH7j/7flPYJiWsEOXjGYd8Pigi
 Re3ACTcj/rRlD2ygMwnnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tLp5TneXNeM=:SXhpAirue0mvBS4EXgb9S9
 Zz+4MV8Q9cg35MV0s5t8LaLXHPysFz/Yt/hjqSmMNtLap1F/Mi8GokXCXNCSCvLd+AezPoLrg
 MH4QUkddx37xCCjFx1LamQ0COV7ElRanzoVC02GtRkSFfDu8pLCs0E74oGx7N3UicNiu1yfM/
 qDu0e6/yZh4NRkiXQiT+vkVMxb7C2zT1uJi7ePbHlt8aJZSK5sCaUS5EvFoX+y9O0u26z+DxQ
 qaUemn66iIQ988aya04vV3GA6HdUivEG8PRo1u6zr3Fyv8vnYt2yKLCaa+JTVcvOaVRfI1pqE
 xrPJcTOTO8QPMxaS8/ks7h79MHyBY4Ei6uM0KVw1v1jAN4XZ7/m2Fe0PMm4BydJtz0zmoOR8V
 KvhnEW81sGOU2fnOQ+LYj7uMUNMnlwHnKuZUkKdU9tWixLxD28lLR3aauk0MFMRl4u9q9Rehx
 sPbIQfrTGgnP3SCA2XkgmdKyhZZ7Q3QqmlWB3MEw4TPFz3puzeK8LhgPcAfPnMIqGvykO1HMx
 wOvsnrNojcWrwxNsTlrZV1RxeyreFkKVStzQNiAFLEOD+zivFx89s73VQtzSpcg5p4rYEUUGQ
 mqOSyIj+plI72IMw8m4bfItSyqqN3U2HDI9oYKZYLvkTb5HWibSKTPLQyc1ue3HcHStOebdTR
 kdl3RcQEJKlcGEEF2yMpitafwiC89ahuAxEZpv+bagj0JFoNJQWkjtBZdPAiYDuw6OcHX07lJ
 7zN1JUfQ+kG+Tz+OdWYtHdnZ3BVoTh25iSOPeeK5qlGqsu+SW7TODj+rS9imgzUjghkfhEK5u
 L/BBhPGZpbIWsUFiiQl8eHZWXrp4hnfQLoLMOyvR1LEuFQ6uKM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_104012_566981_5896EC14 
X-CRM114-Status: GOOD (  16.87  )
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

On Wed, Apr 27, 2022 at 5:33 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Apr 26, 2022, at 23:15, Arnd Bergmann wrote:
> > On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Makes sense!
> I don't think I'll be ready to submit USB3/USB4/Thunderbolt (which also needs
> RTKit) during this cycle but I think there's a decent chance marcan will submit
> SMC which also depends on RTKit and will go through a different subsystem.
> What's the best way to handle the RTKit commits in that case?
> It would be great if we could get both into 5.19.

The usual trick is to have a branch with the shared patches and have
that pulled into every other tree that needs these, but make sure you never
rebase. In this case, you could have something like

a) rtkit driver in a shared branch (private only)
b) thunderbolt driver based on branch a), merged through
     thunderbolt/usb/pci tree (I don't know who is responsible here)
c) sart driver based on branch a), merged through soc tree
d) nvme driver based on branch c), merged through nvme tree

since the commit hashes are all identical, each patch only shows up in
the git tree once, but you get a somewhat funny history.

        Arnd

