Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E8EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IptIfpBa+4bUOT4/pru7LRgHp29zyPj9qkSus/4eWe0=; b=AgnWZD8uzWxrOUbtqcGqBZGL0z
	FTmNWBfyWPHwEwFRmz8cJykt6YDoOI0ifYI7xwF+VVfWKB5pCCCgA/M9cofIJ29yvrY6okXXt72wc
	U/XXl2wWReqCleerYe0KetgdGVj4qKtYGIllhJjnN6s6f8URtPh2VfQQn5uCxpnqeaYYxGNojHOnz
	0zax6kVWlB2xI927a6M3metAXbhHj5gAaUAanIYL9CgEXB+I6ia6664copG0LBfZhxHqpq2xNwASV
	Zs0tRUH7vsbXaoHu2MB7v+qmGWu+ycGNjUPiXx9FgjesbCIOYF3okOZh3IihToBtSx0DLoMHF49+D
	8LTITw1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njTaJ-00GR7N-OV; Tue, 26 Apr 2022 22:23:03 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njTa5-00GR3C-TW; Tue, 26 Apr 2022 22:22:51 +0000
Received: from mail-oo1-f45.google.com ([209.85.161.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mkpj7-1o9iZs08dT-00mIkF; Wed, 27 Apr 2022 00:22:47 +0200
Received: by mail-oo1-f45.google.com with SMTP id
 bg34-20020a056820082200b0035e7cd94e46so56632oob.1; 
 Tue, 26 Apr 2022 15:22:46 -0700 (PDT)
X-Gm-Message-State: AOAM531/7fv7mMCo5g6+tes0K7CHEmRE/NlN15BVN3lcEfI52sONkdvc
 SLxyqgifxVVODPWS/6IbMDcnm8COrj1YxIVmvbg=
X-Google-Smtp-Source: ABdhPJzbAvI1S2GyRLREWapjSXfR+JqwT+LmqG09UCM4q8/CHei88Q5j9UOL+o3W1tRf1uMqf75Cr4X40ZB+iuMcOqE=
X-Received: by 2002:a81:1dd1:0:b0:2ea:c38b:65a8 with SMTP id
 d200-20020a811dd1000000b002eac38b65a8mr23947273ywd.135.1651007764178; Tue, 26
 Apr 2022 14:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220426201539.12829-1-sven@svenpeter.dev>
In-Reply-To: <20220426201539.12829-1-sven@svenpeter.dev>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 26 Apr 2022 23:15:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
Message-ID: <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 Janne Grunau <j@jannau.net>, DTML <devicetree@vger.kernel.org>, 
 Linux ARM <linux-arm-kernel@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:f7gNqzvKdAlrpEro18BZc4XqYaMNFNpK/7lCnsE8xQZHTQGLh/1
 KFEzLNeXIXgHpGEA1Y0LlSfNaJ8GO81QuYEngYXM1sa2rLKRfdkyI4JEPbajP0owoOL6hxs
 2zPAo9rY9NM0lO9Sqz+R83e1Yag0oktw4ZAk9/eJiEC8iVn1dw8C/BokeMISuWksnKAgZpA
 S9YVlzZt2zbDddt6ihDhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8w3cHa4v2a8=:cfmxANO7uyah4gxrA9NcVQ
 OtMP8FlJczWdV4940e5GCEJ88rkpWWYA+QO14JBQvp6QbQhnOyzNQmBDxJs6DM7N54IQBLIzJ
 p3sfWXQZtvj4Ag+CHyVbttL1MincYxPWj8nHrs4XZgiCCChwZxWCiymxlRs6C8Z4vwgWujJZi
 D3cGZlmR0tJgIrrIcn+9/0LGmq9KM8/E1MNOnFoZxHlvjvSPVSSO1MDjKLoFnBb4xgtD6IurF
 kBvbSuh07aUfKug6KZlBmHckQPIbHTx1gynag2v/phfYSh04BmhmCNhxDSfniGOdz16eTrcvP
 9hGGVF3JdSSJXcLkstd+N4puLaSkhoHKhfX0edyqv4JdH+H6srwUwjHt1WSDpmJaUCr2p2e0l
 dYMXr8sDXGC248qiVLWtJsDwaBphZXY6ucI8MNimcUTl7xb9/8DrJwTOPOy96jJUO5oQeU+M3
 5yELJOJpgjSJYMKcgrrQHDmPbGaft9BfNqw4k+Pp3LwjfI/jcOD/m/t4U8lhEghTZ2hWxpr7L
 FCcD4tr4PtY8jJdr4mbp6toGcPqXjxZBUoUEgmkCqT1qw3Db5NtLSKsvxSsntL2BtBZc6qns3
 H4W59XPTakK1w5K9mXry7POuMe1pkuXbU4BdPEXcSCZP95SiUuZCVc8SRNVka6mWRsGr9EhIi
 /b5oWmjmC/D5hLlKd+NR8K3K5YgsUZFhkSszqn366JfYIgedf8y9nCyd95t0iMfxAruG0paev
 qlzvT6DZrJGHOsIyiyoVmJ9DlfgOCVYQwDGT8AiarTianT/5Q51bIYdoDv4VsCGE2XyeqBUlb
 d2qbVeTm/5I6vpi0N8mpZwo2IKcvbNhunKZXuFHyswNwOIf8rw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_152250_285559_84864F47 
X-CRM114-Status: GOOD (  17.73  )
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

On Tue, Apr 26, 2022 at 10:15 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Hi,
>
> This series includes everything[*] required to get NVMe up and running on
> Apple's M1, M1 Pro and M1 Max SoCs.
>
> v1: https://lore.kernel.org/linux-nvme/20220321165049.35985-1-sven@svenpeter.dev/T/
> v2: https://lore.kernel.org/linux-nvme/20220415142055.30873-1-sven@svenpeter.dev/T/
>
> Thanks everyone for the reviews of v2 again! There are just some minor
> changes since v2 listed in the individual commits again.

Nice! I had not looked at v2 in much detail, but I'm perfectly happy
with this version,

I found a few things that could be improved if you do a respin, but
nothing important.

> [*] The only missing part in this series are the device tree updates
>     but since these will go through arm-soc anyway I haven't included
>     them here but will instead submit them once this series is in a shape
>     where it can be merged.

Just as a clarification: the drivers/soc/ portion should normally go through the
soc tree as well, but I'm happy for those to get merged along with the
nvme driver
if that helps get it all mainlined more quickly.

       Arnd

