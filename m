Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCC4C52D7C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rSZ7+gjOYwZkpB9xQOsLDFLwFaoUgt8DAL0cqVAkKuA=; b=4sfRoHEbUHql+lQk67MYYTDWwk
	ePWURA6/FYfqUnnv4nYuFw4tb2gBoopPcuEdgPs3RU/IDdmlNyK94daZKTjoBdzdUp6y5KjKD0T2e
	ZmeLyrsQlEk8u6UM40VF8iZiI7rZBFZaHbFFru538p7M84DKB8H66r3og0+W9pdGdclo2I7EcCro9
	dyhVC2cUgEjVr0Vt0mVnVq8UYrKTuy0nLqTG8s+IMCJHCO1qVy+BJ0AHFqktjIuAp+uRA5p3HqZUA
	qSr8fPGRgg4HHzC1C1jhvEkl5hDkdAljpsqtG9nAwfI0fOVSxn2rKEHVah3sudndT8r5T7TU03IyQ
	y1vtJFpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxnw-00000004q4l-2cf9;
	Tue, 13 Aug 2024 20:07:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxnt-00000004q3t-0SFm;
	Tue, 13 Aug 2024 20:07:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33DF461873;
	Tue, 13 Aug 2024 20:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ACDC4AF10;
	Tue, 13 Aug 2024 20:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723579655;
	bh=pcU0DlQ+ID/ze4Ee6AQQElRUnHpjqLCr6VqHuIdU5FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+a9BFGu5rXoC2VXF6YVaCHXPLBvjQuCO8q/YvNGn+2s8sNyKgBQOKR/h+Ir4j/no
	 olrDkMK2uBr05dFbfSDhtvK0drNBkgcfwHf0f4I4yBTsilX/69neoR+L9aMLsl97ot
	 v2XrSh2CgqXEZlReERf1DOAfXBEFIiSX49Run3f1H/eIYLw5Fp3Q8RcdUyKdNAEu9N
	 Q1kzD3q88FLCEQb5JTURDmmAikCCifDm+nDix/zedHtEqRj6rmIzIEeApdN5iT2uf7
	 0B/2krLSkbGHqqWiM1VXpoV6E/5RJRBy9TpuHYIfHQ40KAr4ZG5gfWjAt7dzQPBQlg
	 1hhTdmNsn2RCA==
Date: Tue, 13 Aug 2024 14:07:34 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions
 node in mmc-card node
Message-ID: <20240813200734.GA1659224-robh@kernel.org>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
 <20240809172106.25892-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172106.25892-4-ansuelsmth@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_130737_235727_4729CBD0 
X-CRM114-Status: GOOD (  12.07  )
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

On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> Add property for defining partitions node in mmc-card node to define
> partitions in DT by the use of the block2mtd module to use block
> devices as MTD.

You justified patch 1 saying eMMC already supported this, but then here 
you add support.

Both are a NAK for me as both already have a way to describe partitions 
with GPT.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)

