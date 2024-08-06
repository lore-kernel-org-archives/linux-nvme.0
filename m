Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5237C52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Chn8ymlqazavJ1DZmXPdLBrye9DBk3cugxlezlxhvc=; b=vs/K8L9+W3dSd8nudhMA7uAuiF
	X2z4VLFHdZk7RQuUzFxX5qZRmiaTTizZGXCdCmE+SCiqUpd6XnD2J9i6bspOV06O/N91loEqXW2fV
	MBVT7VYXEl9LBe7jYdC9KHzj31w5qJBqVlMa5uFueNJFYL5ZmCjPfCM1Eb7LLEvhVFwiJ+E2OR2fV
	aXYlDV7x08zfbP4iR36Sms7Lr8BRsJxQVLg1wnY3HJn3qNzOG344/XdKJzp8UbWxide1K1XuOuHYP
	gKhiY8YGhlGzVbI3I7NemmjpiHqjq5yiZ5XrG6t8Sa8NMXx4mGybgPRaQpNuG7XrNFC0E+NlOsqi9
	i9+VdYLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbMHz-00000002CsU-2Omt;
	Tue, 06 Aug 2024 15:39:55 +0000
Received: from mail.manjaro.org ([2a01:4f8:c0c:51f3::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbMHi-00000002Cog-046m;
	Tue, 06 Aug 2024 15:39:40 +0000
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722958773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Chn8ymlqazavJ1DZmXPdLBrye9DBk3cugxlezlxhvc=;
	b=VfEMfp9veTf9vofJGHvARhjKJLQWxXoE6CZ4ZfPJBcyubeBt6RFYznvEmk0qhNLGaLcWIZ
	V4ZVilXZpCU9C/H3Fj/ysZ/XgET0TF1ZDcxMeq8V3CyxyQdsNk7NIj2fbogg2t01z7WsLv
	wvZqgRJCniv7XWLsHstRuSCgMls15R5RXpdkYXYEbuirc0/HNhXfXfbC+UTQp1+RTHuNyc
	HQCGgdhhrNGrjo/ZN4a8er9JdyzG+eHz0KiwhMuHq/wV0VtW6AozR7DoRbDrDnLY5G34gi
	SGgRl+hV/9eqi04hVkBzZk6CNzURj7hKvvnqvMopGb0w7ymNHesO9/LnmyrCtw==
Date: Tue, 06 Aug 2024 17:39:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg
 <sagi@grimberg.me>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
In-Reply-To: <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
 <20240806114118.17198-3-ansuelsmth@gmail.com>
 <20240806124312.GB10156@lst.de>
 <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
Message-ID: <ceab3813dad635387e9f216203292fbe@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_083938_701293_45C5F903 
X-CRM114-Status: GOOD (  24.73  )
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

Hello all,

On 2024-08-06 15:03, Christian Marangi wrote:
> On Tue, Aug 06, 2024 at 02:43:12PM +0200, Christoph Hellwig wrote:
>> On Tue, Aug 06, 2024 at 01:41:12PM +0200, Christian Marangi wrote:
>> > Introduce support for a dedicated node for a nvme card. This will be a
>> > subnode of the nvme controller node that will have the "nvme-card"
>> > compatible.
>> >
>> > This follow a similar implementation done for mmc where the specific mmc
>> > card have a dedicated of_node.
>> >
>> > This can be used for scenario where block2mtd module is used to declare
>> > partition in DT and block2mtd is called on the root block of the nvme
>> > card, permitting the usage of fixed-partition parser or alternative
>> > ones.
>> 
>> Err, hell no.  Why would you wire up a purely PCIe device to OF?
>> PCIe is self-discovering.
>> 
> 
> Well on embedded pure PCIe card most of the time are not a thing...
> Unless it's an enterprise product, everything is integrated in the pcb
> and not detachable for cost saving measure or also if the thing use 
> PCIe
> protocol but it tighlty coupled with the SoC.
> 
> This implementation is already very common for all kind of pcie devices
> like wireless card, gpio expander that are integrated in the PCB and
> require property in DT like calibration data, quirks or GPIO pin
> definitions, i2c...
> 
> In modern SoC we are seeing an influx of using cheap flash storage
> option instead of NAND or NOR as modern hw require more space and price
> increase is not that high... Almost any high tier device is switching 
> to
> using emmc and even attached NVME and simulating MTD with them for easy
> usage.
> 
> Please consider this well used scenario in emebedded where PCIe is just
> a comunication way and the concept of detachable doesn't exist at all
> and things can be described in DT as static. Also these storage are 
> used
> for rootfs mount so userspace is not so viable.

As a note, perhaps this is another good example of a "fixed layout"
PCIe device found on an SBC:

https://lore.kernel.org/linux-rockchip/20240805073425.3492078-1-jacobe.zang@wesion.com/T/#u

