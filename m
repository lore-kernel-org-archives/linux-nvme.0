Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401DBCA0EDC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s9iCFnjYW4jLbwup/nHxIsGYXdhs4iG9bGbYr2l/CEc=; b=rMdxYkbb8n8vU2TU9HTt7i3kmp
	ybxR7fFfbZ7eGf74KUYxEFQLiFOP1OoSSEKAHMNvBDpJe3tctnZKiIYYjbe5earubS/J3hg74cm9u
	ceMDRR6Er/Rk9mPD1M6+8DR39KiBHQBMvh5x1Y89GYVqZonkDBerJ4w+RGYOJ2+j8jCf/NPQx+GkJ
	6+iugKA2w8Lthtqj1b71iGok3JWBiKsoB7Kd00fA4FqGx8JsBoJbuxDMWo4w1f8cVnvXuWTVkGt7A
	3sTjY4H5cPO3OMuVyjRAy/+xWyWj6tkzTWnpZK9bvdYqbw+4MRMGwCpAVEQWQ5cQmaD+FDwtYJCKJ
	LNWZH7Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uouEd-0000000FSwo-2WnQ;
	Thu, 21 Aug 2025 01:36:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uor92-0000000F4jb-0uut;
	Wed, 20 Aug 2025 22:19:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1E0AE5C63E4;
	Wed, 20 Aug 2025 22:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3731C4CEE7;
	Wed, 20 Aug 2025 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728338;
	bh=R/BkZNm9tZiYfcxpkJb8o6x4WQt+nKkmKkM9VRJvV2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAKdvASJOeFeY9PqNztR9l2AspAmbogSBjNYC9IwiujKsl2h4QI5YrO+k9Ni1bdlx
	 whq/tit9TJ7FnI6orG+bJ5mUauaQ3DTdQ0dk1R4nejV55iXxm9JjLbh5YM//to3JDi
	 jRhUrPNszpezhwm14NJP9g0hc6dhAyk4aZS9H468sbn93nAFmSO/qGg6Ywg9ygGDkk
	 Ms9skBLOvqHmkn18wTUGmeywK15ygj3abA4zgdSM2hH6gTSQTMUxiEJ8khRZXuaZch
	 4IiWY51pHl5rhaIQA5gjMkTfRHk01sZ+1K7OCnKXFk6V1S/HI1Zt+R9obiQlWXLsaA
	 Q08EUD39d/YmA==
Date: Wed, 20 Aug 2025 17:18:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Sven Peter <sven@kernel.org>,
	linux-nvme@lists.infradead.org, Hector Martin <marcan@marcan.st>,
	Keith Busch <kbusch@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
	Will Deacon <will@kernel.org>, Janne Grunau <j@jannau.net>,
	iommu@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Message-ID: <175572833738.1513431.970706958062669952.robh@kernel.org>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_151900_299095_D3BAA32B 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
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


On Mon, 18 Aug 2025 16:42:56 +0800, Nick Chan wrote:
> Add bindings for SARTv0 as found on Apple A11 SoC.
> 
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


