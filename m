Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1F0C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J2k9Op3oCvA0yw2O0z+wfdGUyypR9n8Swd2cAEAx4EM=; b=RHbMp0zU0fIdvkXQeKdZqTqMQZ
	es1k1G0OcmZynr9UBYfZEhnLTKc+5WEy+rE1rYHV2iU4e7fikxt5aDbwEwgYsyNevhXfKzni/eqMO
	N1jvjZcZI/WKTwJiuyg/mjwxjTDDXZB61G0E2bMbiXNG4BgAYgegciPALW2MImghZsKRg6DgDvRaX
	Rgbv2LZ2HRS7AUn7HgEtsxvL1T1PecA/TJYCR6d7mdwomo5tWCoK4GPGslxd2BLaJmHP2jERjmfQM
	ZW1F+SU6B08hJQM+aVi4EEnqmKDoyT1lN0wGUqgRkcZwMtbnk13u8keYJTpOLAR/KWmpDsRldFI7K
	JNN+K9FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk54P-007SzP-JR; Thu, 28 Apr 2022 14:24:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk544-007St0-Kc; Thu, 28 Apr 2022 14:24:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A118E68AFE; Thu, 28 Apr 2022 16:24:12 +0200 (CEST)
Date: Thu, 28 Apr 2022 16:24:12 +0200
From: "hch@lst.de" <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, Janne Grunau <j@jannau.net>,
 DTML <devicetree@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Apple M1 (Pro/Max) NVMe driver
Message-ID: <20220428142412.GA19708@lst.de>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <CAK8P3a1yJkegvgvzHemBd_dowvpyDmxtUnrpiHob8+hiNeO4sw@mail.gmail.com>
 <0f6ea2c3-586d-4f5a-9cee-688cd73b96b3@www.fastmail.com>
 <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3pPxpoOZ0hm9htBRyYc7L38F6egi-0=41tMtcLRGJ_jw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_072416_877953_7C9F213D 
X-CRM114-Status: GOOD (  14.18  )
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

On Wed, Apr 27, 2022 at 07:39:49PM +0200, Arnd Bergmann wrote:
> The usual trick is to have a branch with the shared patches and have
> that pulled into every other tree that needs these, but make sure you never
> rebase. In this case, you could have something like
> 
> a) rtkit driver in a shared branch (private only)
> b) thunderbolt driver based on branch a), merged through
>      thunderbolt/usb/pci tree (I don't know who is responsible here)
> c) sart driver based on branch a), merged through soc tree
> d) nvme driver based on branch c), merged through nvme tree
> 
> since the commit hashes are all identical, each patch only shows up in
> the git tree once, but you get a somewhat funny history.

Given that the nvme driver is just addition of new code I'm perfectly
fine with sending it through whatever tree is most convenient.

