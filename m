Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CCDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYliOwUP968U5w7lzFTh5fjWjw7RivzcHMVdJepys6c=; b=c3NjuTeCz4KNb7ZvECdiDog2mQ
	kU0GJ3IY6346GdbMg25NaywWe4OFdwW+1/qgI4Mzj0jx1+CnV7vd2Bvn3ynqOcA3MzQJ6tSeGZT0C
	9cMLnK9ZQDggJIst+CAojl6LBIxsX/LpZL+/gWimUAx6szSmM1dP1Lt+dCmECBJ3c50HTr1bk9Yqj
	bpMwoHNi6mwaZgG/Mp+8WNyalAu709nuSJnTMNIsxiZX9zVmqppu+HuMKisbu1nnazeAseDBu/D7U
	83yJPM1KnZjieWhk9iQgNdUMJBb0sfckm8OjIFlVI+NTUdd5ft11F8LHZDwjwv1R/2rqnQMQ5svVq
	7SB2jHYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngkZr-002ea6-6j; Tue, 19 Apr 2022 09:55:19 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngkXG-002d2L-Bf; Tue, 19 Apr 2022 09:52:41 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MScDh-1nW8bm2YWn-00SunE; Tue, 19 Apr 2022 11:52:31 +0200
Received: by mail-wr1-f43.google.com with SMTP id p18so20839322wru.5;
 Tue, 19 Apr 2022 02:52:31 -0700 (PDT)
X-Gm-Message-State: AOAM532afHRn2JAoSXF9N5ZBoUQdCNuLkalEtlkHaDDPbQaGrPd0WPmv
 CPyE6gnlfuHLipo8fN3rro4tqIgRw7r5CpY3aJ4=
X-Google-Smtp-Source: ABdhPJzCXBI+RcttLx9ypMCYJp26DkP98+kkPTFl+n5n/hcn08b2tUYxS4vgAQ33NEwseKjHf7Qbovh8TXElWM6kX8E=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr11097055wru.192.1650361951213; Tue, 19
 Apr 2022 02:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev>
 <20220419053157.GA31530@lst.de>
 <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
In-Reply-To: <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 Apr 2022 11:52:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
Message-ID: <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, 
 "sagi@grimberg.me" <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eDJH8G9FAClybImg2taUQyjYx3XbDTjH+n5WcH2YNBvHRO0Cpc3
 aRAC/+YrCQ6nx6hqjiGzDYw7CHRxWzI45Wy6wXoT40IPsOW7dPlu/v61HN1SsmJBst9Y52N
 C7EmkDNug2Mkgr1GP/zxHc3Ac6QZmKZ1JkZvVzIkMLO5YrS1K4JAutd9EMljHssElDuIeiB
 xFZJFp7DihlKfW7V5c/9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:loZTIvndwxc=:aaUvAk2moLwrKOJIblHPv2
 qqvYEHggotGKCjMG23KvV9YaUiW5eWLUCfeopcgKaOC5twJFYwuKXFfND8BsPIOXXjzAPL/t5
 +b2ANWkZxBQhCFBUPmc6n1J0SzCJWkt7yJjCjtPL/cKkXebZ2zqucms0EnkZEqe8zwDkZ1woC
 I7QXerIUXgenLTuEWdTrZzRt6XFp1X9Aw+uNBUZfiVt4oBOqq9Z9ebX9ptf13O64geROpROq6
 cxY+hj+JbqUsOpdT/jtTdZ2WJCgCjb9GHcqlN1S8w0UTlKvjkNNE4tP1IhMlwcUWUhhcVv0KQ
 LiK5CCTA5k92JhBcn8eugV2l1vvpngzcLedKh98MULsM6YZtfyTJ3mouChKrJwdnQLN3yeGHF
 S+CT54aBj5PzIqgFK09kkn4HN+NQUW4blEmsRph8vONv/Bm7EpeZABs7l+PUD94FPi23u5KQr
 LM28XXAM5Vvu79fOD8x36WHn8EhTCdy1L0hM8dJSsk2avZ1Z1dv3JNfK/ik/G03QCYkVu0HYS
 K7qLazlGPBmkTElpE7WMwqF7lzp173MqIKdtveYGEmVyfaYZcy+RHmnPGxoWyDpvovZ+eR17O
 9pwmn/IcKPuZn501UGWqO1+/uNezrOvW21kqP3Kaf3lRecnipOpJGyfsFetfFFY4H3D+qdv5k
 xDljNaEDRPNF0rs6S57tNkPc0W5QcG8ZRgw2J3TaP8m9rzk4DNBZ7qHyIFZalAaiKFYA=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_025238_742966_286FC7EB 
X-CRM114-Status: GOOD (  21.27  )
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

On Tue, Apr 19, 2022 at 11:47 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Apr 19, 2022, at 07:31, Christoph Hellwig wrote:
> > On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
> >> +++ b/drivers/nvme/host/apple.c
> >> @@ -0,0 +1,1597 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Apple ANS NVM Express device driver
> >> + * Copyright The Asahi Linux Contributors
> >
> > Is that actually a valid legal entity?
> >
> >> +#include <linux/io-64-nonatomic-lo-hi.h>
> >
> > Does this controller still not support 64-bit MMIO accesses like
> > the old Apple PCIe controllers or is this just a leftover?
>
> I just checked again and 64-bit accesses seem to work fine.
> I'll remove the lo_hi_* calls and this include.

If you remove the #include, it is no longer possible to compile-test
this on all 32-bit architectures, though that is probably fine as long
as the Kconfig file has the right dependencies, like

      depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)

I'd prefer to keep the #include here, but I don't mind the dependency
if Christoph prefers it that way.

       Arnd

