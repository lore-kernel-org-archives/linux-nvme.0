Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14513C52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qCYK2yliQfD9d+TBPAwEJ5g93MWqlBUOfKZB7GnEG0=; b=G+ertdvHFb4Umqh2USTToP+3uj
	1ctdHhw/hVe+3nds05AMSJ5CE3QJQy2g1/aTgHR2RkZOLsD6oGwgIbvyaUyKG1QdbkX3Ijvc5vlIF
	aIbA+r1gOEmKPpXLB1cbPuza11WZHKdLxlLUrw7yf4PvcZeQwwDfR95hNaOn+i+frcZ/OFif12a+I
	nB616hUAXZCOyNuTfsVsz47UjJj0liMA9YsN/DNr40bTcEd6S6brbPa4z0tvTFaoPPHjyNSttB9QA
	qgUE1OWpa4JhemA2zAf1PAz//pQeVpD1KyojI1klxze9/te6SCjXeGshqld68IG5VBNQluaguwJTh
	YAZwbJvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdV3G-00000000P9P-0ZyP;
	Mon, 12 Aug 2024 13:25:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdV3D-00000000P8P-1osY;
	Mon, 12 Aug 2024 13:25:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5AA6268AA6; Mon, 12 Aug 2024 15:25:27 +0200 (CEST)
Date: Mon, 12 Aug 2024 15:25:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Message-ID: <20240812132527.GB23655@lst.de>
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240812104954.1e8d55f7@xps-13> <66b9df7c.050a0220.3574aa.d5bb@mx.google.com> <20240812151755.0feab4b2@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812151755.0feab4b2@xps-13>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_062531_641559_AF8FD531 
X-CRM114-Status: GOOD (  17.69  )
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

On Mon, Aug 12, 2024 at 03:17:55PM +0200, Miquel Raynal wrote:
> Is this supported in mainline Linux? MTD handles the bad blocks and the
> bad block tables, so I don't understand how this hardware feature can
> live together with MTD.
> 
> Anyway, you are talking about MMCs, I don't understand why there are
> bad blocks, nor what is checking them and when. This is all still very
> fuzzy to me, I'm sorry.

Yes.  The idea of using block2mtd for anything but development seems
a bit odd to say it politely.  Using it to reinvent bad block management
on top of a block device that needs to do that as one of it's fundamental
functions seems extremely odd.


