Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18687C52D73
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/+yfebmcCt+GYD9DilF4pN8420I0xcAx5yduelZnns=; b=hNzMeU/FO2wbRDl/IcMXo1xq9K
	zgDnbOULxJA0tTnXynyrpPWYrdk9KKgUJoWiUf5pOKWIzL3A8W6CjcIcPV90FMIWUtFkklzFBrQy6
	pUFTOFl8k8DsoKqZzCVYnTr5VKGwXO008az4l03gRRxdQkAXNccfT1wVdm6NvZ6XU0u1uvCZIOVTK
	njqjS3Pfx+UVrF3pFVuAYuCf4f5rElO7ERi37Owy1s9QgkIIQopWo6WpBXiHdwyb90JbImm3bCKd8
	o/n9S+E2y/LnvqXsDkvjSyVlKhJcDmfWIv8ZckJLmQ4rnI8yEk9oxxvDeaOuoTkyhWJLhk4qspBW6
	GYCueqCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJwg-00000001eCP-1Mj6;
	Tue, 06 Aug 2024 13:09:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJwc-00000001eB6-3vee;
	Tue, 06 Aug 2024 13:09:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D203E68CFE; Tue,  6 Aug 2024 15:09:38 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:09:38 +0200
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] nvme: assign of_node to nvme device
Message-ID: <20240806130938.GA12231@lst.de>
References: <20240806114118.17198-1-ansuelsmth@gmail.com> <20240806114118.17198-3-ansuelsmth@gmail.com> <20240806124312.GB10156@lst.de> <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b21f20.5d0a0220.200175.4b9b@mx.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_060943_137609_8DF2B4AE 
X-CRM114-Status: GOOD (  15.07  )
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

On Tue, Aug 06, 2024 at 03:03:24PM +0200, Christian Marangi wrote:
> Well on embedded pure PCIe card most of the time are not a thing...
> Unless it's an enterprise product, everything is integrated in the pcb
> and not detachable for cost saving measure or also if the thing use PCIe
> protocol but it tighlty coupled with the SoC.

Yes, PCIe has a bunch of form factors, including just soldered on BGA
devices, but none of that matters at all for the logical protocol.

> This implementation is already very common for all kind of pcie devices
> like wireless card, gpio expander that are integrated in the PCB and
> require property in DT like calibration data, quirks or GPIO pin
> definitions, i2c...

Do you have a document on that/


