Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E56C3DA7F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tvBkiG4AA7FtHRwLk78lD5fI1TgDbAXwH1R4znJH1R0=; b=r/5kdzeNlMhSoKsZjVlyArCuxi
	vXBvCL7a2wNHbG25n6h18Tsom5lDk4QIA9FXT88d4GlWvw37TD4dLEvq3cdA+/x20ixCRZOiSLRnR
	Bx263VBySdJVpLS4oYoCq7WqnP9Q2diyHeJa2FAGBofUiKHu/5B9l5FC+z+uEHsosa6kb+W1Cps3C
	I6b4xtHhvELW1BS05cWvHK/NPxQRwnS6bCh+nvrXglgZUMHxP8xeMVDXRMMMoHT8PlD7gllAdj6Da
	KV+y7PV8MZlS3eoIhrEl4lBbYFs7wB7OlRMiruaME0/YeM+NWbNgwxEM8GTQu8zQ6sEsq7bf3Md/5
	bGT3KJwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdV98-00000000QQX-0cn8;
	Mon, 12 Aug 2024 13:31:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdV94-00000000QOW-1cWf;
	Mon, 12 Aug 2024 13:31:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F38168AA6; Mon, 12 Aug 2024 15:31:28 +0200 (CEST)
Date: Mon, 12 Aug 2024 15:31:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
Message-ID: <20240812133128.GA24058@lst.de>
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240809172106.25892-3-ansuelsmth@gmail.com> <20240812111205.GC14300@lst.de> <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b9fbb4.df0a0220.3bee6e.1e99@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_063134_595467_CD67F7F4 
X-CRM114-Status: GOOD (  20.77  )
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

On Mon, Aug 12, 2024 at 02:10:28PM +0200, Christian Marangi wrote:
> The chosen name was arbritrary just to follow eMMC ones. Can totally
> change if problematic.

NVMe namespaces are dynamic and can be created and deleted at will
at runtime.  I just don't see how they would even fit into OF
concepts.

There is a huge impedance mismatch here, to the point where I completely
fail to understand what you are trying to do.

> But support of OF for PCIe is already a thing for a long time. (it all
> works by setting the compatible of the PCIe ID card) and used in wifi
> card at assign MAC address, calibration data, disable frequency.

Please point to a document describing how, but more importantly why
this is done.  I've worked with and maintained Linux PCI(e) drivers for
about 20 years and never seen it.  And the concept simply doesn't make
sense in terms of a dynamically probed bus.

> Not having this well organized and consistent schema in DT will result
> in additional condition in the drivers...

NVMe Controllers are PCI functions (or virtual entities over the network).
Defining them in a static DT scheme does not make sense.  NVMe Namespaces
which are what contains the block data are dynamically discoverred and
can be created and deleted at runtime, so refering to them in DT is even
more broken.  I really don't see how any of this could remotely work.

> If these 2 patch are problematic I can totally drop from the series but
> it was really to add consistency in NVMe and eMMC. The real important
> part is eMMC that is becoming the de-facto replacement for NAND/NOR on
> high tier devices (mostly wifi6/7 consumer router)

If you aren't dealing with raw(ish) NAND don't use mtd.  MTD is designed
to deal with the nitty gritty details of NOR and NAND flash.  If you
already have an FTL running in the device there is absolutely no reason
to use it.

