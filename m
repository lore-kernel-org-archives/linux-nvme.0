Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA56C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rUNzNTA7KiGKI5Gr3YCJNZKZM2l+gczyHinoEn3uWM0=; b=KAg8XLv2oWYg+FFb1qEWQNFgex
	J61xgWJAy848klU7YhBhM1WUishwdvDGS+S8UorFx6dwbH+w2DNF5Cqxt/3akICZXb/S2rWl/fD88
	V/9jqLF17I2oMlq2eOr9FDyIG2mD9HwIko8Srx/vj4yCenNGJ3G+F+ILjnNkW/VrTX9uOiFPAipWx
	U4Dz9MU5Lv9PfbbpCFQvodZFCz7dTVTS33n+2eoTtKNWQ/DNiMIE8Q704ZX0YQw2r/xtKuCUqO6JU
	5aJ+yOcu//ySz+dzmt/Jdx1tOOX0ZUAXZnxfbLd7hoFPuCyMyTlZmb1jZLg7CnvvYbUSjwMOSox5g
	59AwezIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh23N-007JT4-8l; Wed, 20 Apr 2022 04:34:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh23B-007JOR-MZ; Wed, 20 Apr 2022 04:34:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E88F67373; Wed, 20 Apr 2022 06:34:38 +0200 (CEST)
Date: Wed, 20 Apr 2022 06:34:37 +0200
From: "hch@lst.de" <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sven Peter <sven@svenpeter.dev>, "hch@lst.de" <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-spdx@vger.kernel.org
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220420043437.GA1123@lst.de>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev> <20220419053157.GA31530@lst.de>
 <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
 <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_213445_912174_F4120D32 
X-CRM114-Status: GOOD (  18.54  )
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

On Tue, Apr 19, 2022 at 11:52:15AM +0200, Arnd Bergmann wrote:
> > I just checked again and 64-bit accesses seem to work fine.
> > I'll remove the lo_hi_* calls and this include.
> 
> If you remove the #include, it is no longer possible to compile-test
> this on all 32-bit architectures, though that is probably fine as long
> as the Kconfig file has the right dependencies, like
> 
>       depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
> 
> I'd prefer to keep the #include here, but I don't mind the dependency
> if Christoph prefers it that way.

So thre's really two steps here:

 1) stop uing lo_hi_readq diretly which forces 32-bit access even on
    64-bit platforms
 2) stop using the io-64-nonatomic headers entirely

I definitively want 1) done if the hardware does not require it.  Trying
to cater to 32-bit build tests on hardware that has no chance of ever
being used there by including the header seems a bit silly, but if
it makes folks happy I can live with it.

> 
>        Arnd
---end quoted text---

