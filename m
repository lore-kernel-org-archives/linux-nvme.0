Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A182CA5FA1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZRHw7RgDM0zXXk/3KIjBq2VdWFLOso3NRavH42G174=; b=LoFHfVdeHE4OjbLzvFDGyWTAl9
	oqh50NPuLjeXOx9dy0bDoq3XBBvPYgjM0ZDwvn0LcmAhygqoBYwxo87vcCoupShZn4mBDn1P3wuqX
	OKDCBjLN4QiCtjZGVvJJ3lbAF8LiZjIANZhr+8w30tLJEh4JCmTzMzA/5o0GPPFfufWi1yndGZSJX
	AleC8ak/ZnLyUN9RP+nTkxsHYZs5WtuJefLggWKi6wJza9kz6bZr7dj1lAH5paSmbn2Ray29TQnoS
	xXbBDNOZRtnPcdQWjBdQCXLDQYbBD4nYm9zrP8CAY8baINhuLYiSH1HaXq+FKaNYdFv1uYP+isSZ1
	5VLeFC5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT1d-00000002iEU-49Dl;
	Tue, 29 Sep 2026 08:17:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT1c-00000002iDm-4AZq;
	Tue, 29 Sep 2026 08:17:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2FF3B60210;
	Tue, 29 Sep 2026 08:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2EE1F000FF;
	Tue, 29 Sep 2026 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669839;
	bh=eZRHw7RgDM0zXXk/3KIjBq2VdWFLOso3NRavH42G174=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Smq4C7Ca+4ynJlgInChrfWL5g6vVLyXTAdOldVpbtYHYUKmXK4S1r2y0Ic81bSs4S
	 yaE/xL8/0yxVtokrrL7RKm7vf2hvYKhqcGriaEgb+v3Kmoi7rjQvL3XZOQxUMBUNuR
	 SpJzfo7htNlQXDmFwLG/oP+xUC/yWyQYjLkFNpIveYRQpQMz+MC6d98Fs/sRnOpFMN
	 fyjHVeLB+3HtMmT085eKJ+0qjuK/GuVA+1nz5nsA/FTcoBOq4ZcpRWKxGHw1557QJm
	 QjaMVVUvKWNsqqXz9LP2ute7BgRAEuekC+0yAeigOZurKZbHREeLBM4ne3JdiHZ01G
	 ziAFOvqHDZ6Jw==
Date: Tue, 29 Sep 2026 10:17:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 4/7] dt-bindings: nvme: apple,nvme-ans: Add Apple M3
 compatibles
Message-ID: <20260929-illegal-international-guillemot-1dbbab@quoll>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-4-5e832e2f4aa9@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-apple-m3-nvme-v1-4-5e832e2f4aa9@jannau.net>
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

On Fri, Sep 25, 2026 at 10:22:51AM +0200, Janne Grunau wrote:
> The ANS NVMe on Apple M3, M3 Pro and M3 Max/Ultra is compatible with
> with the NVMe on M1. Add their per-SoC compatibles
> "apple,t8122-nvme-ans2", "apple,t6030-nvme-ans2" and
> "apple,t6031-nvme-ans2" to its dt-bindings.
> The NVMe on M3 Max/Ultra uses 3 power-domains so add it to the
> power-domains conditional to change 'minItems'.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


