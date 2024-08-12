Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F196C52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=73GvcgdSLrMZXGcYPjAJiYsspT+yFL38vgOcQSxgjFk=; b=CwEOmI7nsVUPi5aEJaRDDKrhlH
	5hH06TEP0dAln8FDykkiBx/w7j9Xlc1kF4PVtMEDqJdJ9JyyNwOJ89EzPe+qB9Ix7c6axNNjDWjO5
	gLsLsv+cEYVV3q7d056YtBAb54GmVpaZlPRacZtFikKgUKzGjvWIWiRT3FKS/YIsMp45D+RyoUHka
	lWLj+7+lmQE6Gfeu1yVeK1m3TFwEIFFCfmjhr3e02sQsPRsYoJERhFkyKybAVGRliRkvf+7Foy5Nd
	Lz0Sxap1YrfPIHo7bl7UK6dL7U+i0HlEQygdNVt7FATvZ8Xqi/nR6Fv1iG+kiC2GnTbdLuvd51/mp
	hHbXJyOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQkh-0000000HK7p-1uFK;
	Mon, 12 Aug 2024 08:50:07 +0000
Received: from relay7-d.mail.gandi.net ([2001:4b98:dc4:8::227])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQkd-0000000HK6t-20eU;
	Mon, 12 Aug 2024 08:50:04 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7AE420007;
	Mon, 12 Aug 2024 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723452599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73GvcgdSLrMZXGcYPjAJiYsspT+yFL38vgOcQSxgjFk=;
	b=hsUZH/C8PXrcNQJubX+GqA3kU3D3BCLoUqm0Nuwf/7zwdpBWAhom6I5lp+UeuskT4/kWmz
	ftrP1rxNG10SZ4ErGuXCdc33Wl9LPw6QSB++RRHH3gFDd/uYKExSJGihp9k5EO5DGpZRWS
	Vhug+ZdnbZCC7T/doh7pjomhBB0v6AthvjEYPTC1WEKTeV+zjEPFpeqqEOmZKcIVzCdP9N
	VckV7vn4nKMrx12x2qerZAXsz4COE8RZhfbTGbMmn5Dhhlo7SqFwIws17BKJcODEQDwM+P
	bJ4gepsVvcU/1x3lF6f4fU2YKzRk3W0mow+kBu19yQpGsDh6BtkWPN96iehkMw==
Date: Mon, 12 Aug 2024 10:49:54 +0200
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
Message-ID: <20240812104954.1e8d55f7@xps-13>
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_015003_689614_6009C28A 
X-CRM114-Status: GOOD (  22.84  )
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

ansuelsmth@gmail.com wrote on Fri,  9 Aug 2024 19:20:58 +0200:

> This small series handle 2 problems.
>=20
> It does try to ""standardize"" the usage of block2mtd module with
> MTD OF nodes.
>=20
> It is very easy to add support for MTD parser by just adding an
> OF node to the mtd created for block2mtd.
>=20
> This apply only if the root block is used for block2mtd to allow
> scenario where the full eMMC or an NVME is used for MTD and it doesn't
> have any partition table.
>=20
> To also support NVME, similar to how it's done with eMMC, we introduce
> a subnode to the NVME controller that needs to have the "nvme-card"
> compatible where a dev can define fixed-paritions for MTD parser usage.
>=20
> This series also add support for the Airoha partition table where
> the last partition is always ART and is placed at the end of the flash.
>=20
> This require dynamic calculation of the offset as some dedicated
> driver for bad block management might be used that reserve some space
> at the end of the flash for block accounting.

Who is reserving this space? And this is not reflected anywhere in the
partition table?

> New aarch64 Airoha SoC make use of this partition table and use block2mtd
> for eMMC to treat them as MTD with custom bad block management and block
> tracking.

I am sorry, I am not used to such use cases, and I really fail getting
why you would like to use mtd with an eMMC. Can you explain a little
bit more what is not available in the block world that you really need
from mtd?

Also, did you consider nvmem layouts instead to detect and define the
ART area? (just asking).

Thanks,
Miqu=C3=A8l

