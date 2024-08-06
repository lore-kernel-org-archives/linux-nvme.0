Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB60C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FH+PIjnN/rLQEpUK8oIcJ1uXGyA/a6HreCWjFq+oZc8=; b=qQnb51vQMarxT2RZ315lQASkDb
	HJxGTSRwcY01OyB8qiMLGrZP/aKEwrqS2fBXmeGkXP8wGkZ09bmz8VQLhwF966xU2mCFiovy3ND27
	pIRAt/eTzctzpksW89meoOXaEE/yhFXNsv0kJL1XaCjy3vTV+/rqzF3/cJOFHOsj7Ipj9hDX6vc1u
	ZMmz4lw6CM5UojAwO87VX1ViR8J4JsZxZRIm5M03M+0tiC703EeXNDC0PRv131ivOFYmIpQwFx7Vu
	auTf0MkMikEAEEC/I7LO2jJxPq+jLeVDWCbukogukU5XvsK/Toa1FcS7RbyXwg5TEHLS/MZr/wECR
	qV1AKNqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJYO-00000001Xfi-0lJ5;
	Tue, 06 Aug 2024 12:44:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJWP-00000001XR3-2zVh;
	Tue, 06 Aug 2024 12:44:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5887E68D05; Tue,  6 Aug 2024 14:42:25 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:42:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/6] dt-bindings: nvme: Document nvme-card compatible
Message-ID: <20240806124224.GA10156@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806114118.17198-2-ansuelsmth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_054237_915980_B43D2401 
X-CRM114-Status: GOOD (  12.50  )
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

On Tue, Aug 06, 2024 at 01:41:11PM +0200, Christian Marangi wrote:
> Document new nvme-card compatible to permit defining fixed-partition in
> DT by the use of the block2mtd module to use block devices as MTD.
 
What does nvme card mean?  Is this about nvmem or nvme?  If this is nvme,
are you talking about nvme-pci?  Why would that needs a device binding
when it is a PCI device?


