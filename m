Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D6C9832A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXGaiD0t1LmHxEN66KA1O49FI312SmoXeAH9OHpamW4=; b=eQLbuPurG4c2QxfSrLT52Je6kQ
	4RItCIScEQmfkAzxWLDwIvfPeGq5WJtYDJ7384oO+BCX/dzKlvJRCN5mSQk4C4oDa44tZnqWPOJZR
	1sJxDQhkd3742gvbYY5XKukkCYhMc4bYa+RHP4T8jGSFQogNU3f5qbw/XruY9zL7g9Q3HhDlwaC8m
	ykLGXtaMohCO69sO4lsdBL9fTk7if/dbJ7W+Ko5pTDJPRyAVBqZ0j74SgTRE9tXYJDiEwm2gBM8rn
	KtJIGSrxHgLAOcy+QjvYKAZj3djAsNfSOH9t6Fl1bTigJ1nOiPQh/UIPYPEqAoteLaCJNpYJnAWyM
	9ksqkSig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT15-00000002i3h-2sD0;
	Tue, 29 Sep 2026 08:16:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT13-00000002i2s-2GjD;
	Tue, 29 Sep 2026 08:16:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC01440D9D;
	Tue, 29 Sep 2026 08:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A7D1F000FF;
	Tue, 29 Sep 2026 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669804;
	bh=FXGaiD0t1LmHxEN66KA1O49FI312SmoXeAH9OHpamW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3CPe98NVW/8EygC813eAT88KGlltDJPKBv6AU3tOdukWJdV/IP6/5l0Su1PQV5dn
	 C0/RI8sHigLqw4oXC/lv0mLPGBtYurFgbEiTn5yxbkh9U5oegoe9TGD97aeNvxvNSc
	 7p1DuWayxD8xPfwMoDMvnFlyBIZBhrwSLWYoKxCkfB/DUopjaCFtUhymQZSiix2V1m
	 Z/aBb+AvjsocSWNBYP9prkhhmRWynH/aF4FG4XeCc+WSj+QX1AT0KvIEZ0FJOhJJ1c
	 Gq64LPqK1RGgr8kd+TNUIGNvEUdfxV7pm/WghsA599xnx1gvWpLViiinK9sSEf+j8f
	 naIUsr+kC4JrA==
Date: Tue, 29 Sep 2026 10:16:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	Michael Reeves <michael.reeves077@gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: iommu: apple,sart: Add Apple M3
 compatibles
Message-ID: <20260929-basilisk-of-marvelous-fame-a0d58f@quoll>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-3-5e832e2f4aa9@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-apple-m3-nvme-v1-3-5e832e2f4aa9@jannau.net>
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

On Fri, Sep 25, 2026 at 10:22:50AM +0200, Janne Grunau wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
> 
> SART on M3, M3 Pro and M3 Max/Ultra is compatible to SART on M1
> Pro/Max/Ultra. Add their per-SoC compatibles "apple,t8122-sart",
> "apple,t6030-sart" and "apple,t6031-sart" to its dt-bindings.
> 
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


