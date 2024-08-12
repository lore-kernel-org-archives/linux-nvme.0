Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180A5C52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JdcV2kRk9M7GFAK/D+USec3altBfiWngrF1bMZJR0h0=; b=3+bidp92iuh/raFnMDImILFHyU
	fjCJYz5kqjz/hBIKDgv5o9XfhDox+sKW77lLhiyLI1co0aOjxAgzmEziE8X/SH2zhb0id+hErPxwU
	qWEuucMVU/JXqrpiS4eieZwb/s0Cunp9VtH4BXQoBwlg89HhnVIHv9GzfTIrx9djnMGbX9OGrtxoo
	/4u79caOqu/jvZdPbB0j0iOGsm7g1cZ+/0gbNzV7AUEQq7K5NYqedOQSh3guaz6PiZvrveDa0bMbW
	T0Tm6WL1RZQwcVp4YSYAryh7ihQG8mV9HSmOls12qp9O3zaGVTUPUExCjSF1dJfn87RaqRazC1V24
	RTlUO9Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdUw1-00000000Nj1-0A0p;
	Mon, 12 Aug 2024 13:18:05 +0000
Received: from relay7-d.mail.gandi.net ([2001:4b98:dc4:8::227])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdUvw-00000000NiA-24n8;
	Mon, 12 Aug 2024 13:18:02 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41E7620002;
	Mon, 12 Aug 2024 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723468677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JdcV2kRk9M7GFAK/D+USec3altBfiWngrF1bMZJR0h0=;
	b=T1DGM4+ftpehFe4HTk9kRVwPAVKw3AXm0nD1T1JMZhEdelkbXoOfgy4NgYAKj95rVaLvIp
	nZnomFB1XkmKUg7BHzwy2Zpp7FfDaMYjbRXKCK5jVbxGkA4HSJ1kb6ERXFei+u8THVVKQK
	AB7ydR869hd6hCgePz3L2ncJBB48RgAJbw3nqvRXWZ2bnwmJrOyzsbOyD1LgGLVygbOXe1
	h2sXickvc/8OCgBUceYdm1WA7UmkQX6+A8msWci8Mu3YNPv7JKtz5mpXi+/Z91kCss8Pbp
	noYDmTyhdrsEflAz5id8Ax4oD5XfbGH/ORmkMLDhKex9GquwQMFbGoeyrW6ljA==
Date: Mon, 12 Aug 2024 15:17:55 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan
 <saravanak@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Message-ID: <20240812151755.0feab4b2@xps-13>
In-Reply-To: <66b9df7c.050a0220.3574aa.d5bb@mx.google.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
	<20240812104954.1e8d55f7@xps-13>
	<66b9df7c.050a0220.3574aa.d5bb@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_061801_340107_76D26B03 
X-CRM114-Status: GOOD (  45.70  )
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

Hi Christian,

ansuelsmth@gmail.com wrote on Mon, 12 Aug 2024 12:10:03 +0200:

> On Mon, Aug 12, 2024 at 10:49:54AM +0200, Miquel Raynal wrote:
> > Hi Christian,
> >=20
> > ansuelsmth@gmail.com wrote on Fri,  9 Aug 2024 19:20:58 +0200:
> >  =20
> > > This small series handle 2 problems.
> > >=20
> > > It does try to ""standardize"" the usage of block2mtd module with
> > > MTD OF nodes.
> > >=20
> > > It is very easy to add support for MTD parser by just adding an
> > > OF node to the mtd created for block2mtd.
> > >=20
> > > This apply only if the root block is used for block2mtd to allow
> > > scenario where the full eMMC or an NVME is used for MTD and it doesn't
> > > have any partition table.
> > >=20
> > > To also support NVME, similar to how it's done with eMMC, we introduce
> > > a subnode to the NVME controller that needs to have the "nvme-card"
> > > compatible where a dev can define fixed-paritions for MTD parser usag=
e.
> > >=20
> > > This series also add support for the Airoha partition table where
> > > the last partition is always ART and is placed at the end of the flas=
h.
> > >=20
> > > This require dynamic calculation of the offset as some dedicated
> > > driver for bad block management might be used that reserve some space
> > > at the end of the flash for block accounting. =20
> >=20
> > Who is reserving this space? And this is not reflected anywhere in the
> > partition table?
> > =20
>=20
> To be more precise Mediatek use a custom way to handle bad blocks called
> BMT where they reserve and store data at the end of the nand. This is
> loaded before the flash driver controller so when MTD is init, the size
> is already reduced. The reserved space can change and it really depends
> on the tuned values hence it may change.

Is this supported in mainline Linux? MTD handles the bad blocks and the
bad block tables, so I don't understand how this hardware feature can
live together with MTD.

Anyway, you are talking about MMCs, I don't understand why there are
bad blocks, nor what is checking them and when. This is all still very
fuzzy to me, I'm sorry.

> > > New aarch64 Airoha SoC make use of this partition table and use block=
2mtd
> > > for eMMC to treat them as MTD with custom bad block management and bl=
ock
> > > tracking. =20
> >=20
> > I am sorry, I am not used to such use cases, and I really fail getting
> > why you would like to use mtd with an eMMC. Can you explain a little
> > bit more what is not available in the block world that you really need
> > from mtd? =20
>=20
> Since vendor needs more space and doesn't want to adapt to block world,
> they are starting to use eMMC or block devices in general unpartitioned
> and raw=20

Okay, why not, it's easier for ROMs to access it I guess.

> and using block2mtd to simulate it.

This is what I don't understand. You can very well access your block
device by offset, why do you need the mtd interface at all?

> They don't care about the
> performance penalities as it's something read at boot time and only new
> firmware or some config files are written.
>=20
> Is it more clear now?

I still don't understand the need for going through MTD tbh.

> > Also, did you consider nvmem layouts instead to detect and define the
> > ART area? (just asking).
> >  =20
>=20
> They still need a MTD partition

Why?

> and most of the time userspace tool are
> used on the ART partition. Using block2mtd and DT support will permit
> the use of nvmem cell as a side effect (and that is a missive bonus
> point of this honestly)

MTD also registers into NVMEM, so this is nice if you need both, but if
what you need is some NVMEM area derived dynamically and you register
into MTD for that, then no, I'm sorry, that's not the correct approach.

Thanks,
Miqu=C3=A8l

