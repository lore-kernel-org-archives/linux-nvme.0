Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE75C52D6F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Message-Id:
	References:In-Reply-To:Cc:To:From:MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZRhJK2rJQwZOpgXKPeN4cMC1BqwmxPQ/SGece0HQV1w=; b=IDfr9sxQq1m5sLoxPIRK65qxyH
	CCiuOcpMytrdSzM2IlKcTAnw6hvwE3RPvZubuMr1MrMkmP7/AZBQgVwukHqnhdlZZZ5YusiOk59iK
	ZtLyVUss9N9aJQ6sjVCWgfL2T6pTtfoE+0KNeNlppR3K4S/CxcrALxErxEuTc+t6vo446u3BbRjoF
	QjGGbbdbH9tS6Ifx2THLUXogr4SEGuqrCokFIqI79QzmERV9qjmH1cE0B1iBlQPR73xtJr+eM+QH/
	p+ZhJvAGKos1Jn7AoHuD7charWiqVykyu19aUfgNY2yl2CvD+X4ykPLS0jKDFWomhIJIAZmCx0vHY
	bqshxlZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saaID-0000000DEFP-2FVS;
	Sun, 04 Aug 2024 12:24:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saaIA-0000000DEEN-31Yf;
	Sun, 04 Aug 2024 12:24:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 22BE46068B;
	Sun,  4 Aug 2024 12:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE18C32786;
	Sun,  4 Aug 2024 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722774292;
	bh=L0HvgUcTzvuY++NgzjIc33b0gY8p82E/q9HfyXR7HMM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vPfBku7BbNkqVihw9JIw5JHXxeOgSqm9YubloUJMMoi3z/QBjenmzfVpAfAzOQ1KD
	 FH+oBT6KI7xstHlNmtfJgVvo2JFkberlKbI/apvOYqK9IYf0eYDmGXtTrbdAyiosbm
	 rLSLWoHJZNDxmJho4JKrAz20LiP5OQWwUS4fvoJ9BT6OouyVcU3N/UfsPVoAkzCJyz
	 HSf+hpItAPY9RfLx3TsWwmtgVMmrlISMP0tWfvN8H944+YEtFLdvCnxlkcPe0zDji3
	 TbODPpHp1L3Vh5ok6xIznfQ1iWq08a2RBnjMOLE9tIj5rnxgf5BaD8PfRPOp88sYRi
	 jXsLRTZiZvFPg==
Date: Sun, 04 Aug 2024 06:24:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Joern Engel <joern@lazybastard.org>, linux-nvme@lists.infradead.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mtd@lists.infradead.org, 
 linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>, devicetree@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Christoph Hellwig <hch@lst.de>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, 
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20240804114108.1893-6-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
 <20240804114108.1893-6-ansuelsmth@gmail.com>
Message-Id: <172277429149.3783478.13649526225862642200.robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: mtd: Add Documentation for Airoha
 fixed-partitions
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_052454_825878_5C6F9E23 
X-CRM114-Status: GOOD (  15.97  )
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


On Sun, 04 Aug 2024 13:41:05 +0200, Christian Marangi wrote:
> Add Documentation for Airoha fixed-partitions compatibles.
> 
> Airoha based SoC declare a dedicated partition at the end of the flash to
> store calibration and device specific data, in addition to fixed
> partitions.
> The offset of this special partition is not well defined as it depends on
> flash bad block management that might require reserving additional space
> at the end of the flash.
> 
> This binding allows defining all fixed partitions and marking the last one
> to detect the correct offset.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.example.dtb: /example-0/partitions: failed to match any schema with compatible: ['airoha,fixed-partitions']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240804114108.1893-6-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


