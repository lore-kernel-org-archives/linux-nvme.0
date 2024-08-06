Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520D0C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJZALk2TlqMRe4kETaGtjGmHrz2PcQZI1F2rCm484H8=; b=pQhXAuBFxb4vPEwVBohyM3P3SV
	SvR4TXElWb4b1C1BVPWponXY0weiwayQPpa4jj+zVJpY6nHC7CxMKRBeCbk7NrFjTR8agdummnuF+
	AHjySTJLlY7AEYqZrjAHpeiNRhdL3rsWpSwRoIttM3SHiQ0HPEhelaqo8UWXY5FgIDghtWFFuYxkS
	MMAZ2fYT4XQa7E1Q6PRS7KGfjKWfjZW7EN5An//nZylUk/Q/qtbZKlmnTygmdaMOj7R2dFDimazNk
	YbQhOgDOLBMyDXl1ofp0LYtosCtB07rziky2S8dWygCaff9uQnu1QIYtf6w6Zh+fduX43jjkGI7sd
	ND9IuniQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJZ0-00000001Xn6-3WTq;
	Tue, 06 Aug 2024 12:45:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJX1-00000001XWQ-3ys0;
	Tue, 06 Aug 2024 12:45:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8173668D09; Tue,  6 Aug 2024 14:43:12 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:43:12 +0200
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
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
Message-ID: <20240806124312.GB10156@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806114118.17198-3-ansuelsmth@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_054316_149673_F65EE9F4 
X-CRM114-Status: GOOD (  16.62  )
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

On Tue, Aug 06, 2024 at 01:41:12PM +0200, Christian Marangi wrote:
> Introduce support for a dedicated node for a nvme card. This will be a
> subnode of the nvme controller node that will have the "nvme-card"
> compatible.
> 
> This follow a similar implementation done for mmc where the specific mmc
> card have a dedicated of_node.
> 
> This can be used for scenario where block2mtd module is used to declare
> partition in DT and block2mtd is called on the root block of the nvme
> card, permitting the usage of fixed-partition parser or alternative
> ones.

Err, hell no.  Why would you wire up a purely PCIe device to OF?
PCIe is self-discovering.


