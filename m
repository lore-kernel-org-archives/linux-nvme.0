Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D53CA0EED
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncpqx4j339hqWj+ozGFH+5vRN/crJz5rqcC6dDBTCmQ=; b=z+dT9B8lZUZE/WYrGZZcnqg9s3
	qm77yjiYfklROYzi642d2DhiPjHCSniDJzUmwJsTEvcxBEUYAQgyES8pTnT0fkKq618OyoEoxoxMA
	A9V+ZL682DO7c1e3yuiXDxNqE009GPuvamFFbwP2hIiPzkmLppYwyr1E06s629XnYsUMZW42Z7KvF
	I5tg4gGffHv03EP/A20RrqfCW/2QG9MSWTAfWK1nojvRVxpasx+ExISOGHVAyQJTvOvlaJs2UfWbz
	26cDD5nPveSJnGK1SXImIFD2OPHBJDvmuyTikBXmQxI0Vod8MhhQ8xOPO+Cr4tlsLu+nRrvSRWJ5j
	EfkF4B/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uouHE-0000000FTQd-0YN3;
	Thu, 21 Aug 2025 01:39:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uorAj-0000000F576-2QFW;
	Wed, 20 Aug 2025 22:20:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 03024451D8;
	Wed, 20 Aug 2025 22:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FA6C4CEE7;
	Wed, 20 Aug 2025 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728444;
	bh=wsUPldU04Nc0Tm1FqMCC1+DGwqczRsoyIsHWywBiPgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvsougiKOoa5TSf6WheDqGzlEMw00QFrCBKPtwUf2Tj9Nc4GtcSPwAfQpiNWBbMHc
	 E8qH/k7/hsk/RF3qbvoavwyuL17GbLlrCyU+7YzdQ61EHOGWKCtUybMhI0bsvL8o7m
	 T91q85AUiTZeiZmnEq7pMcS+5rSRcAWpFhJtqRXT/mYz/Bi7zGNGC/AuraNoQMnBTq
	 FyYxpl8DPOnWIemaxZnlpHuT/AhTETzjwLko+J71Bzr3wODLBVMkYOW5eRfZLOecGt
	 jlBK0S8hxOvvtj+JVF+fqiPZPbm97dPvagupwd9+f5tVqJ8iAGC5ffci5EJC8V27rT
	 vJlROA+aDptSA==
Date: Wed, 20 Aug 2025 17:20:44 -0500
From: Rob Herring <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Message-ID: <20250820222044.GA1513864-robh@kernel.org>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_152045_635934_F1E3ECC3 
X-CRM114-Status: GOOD (  15.04  )
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

On Mon, Aug 18, 2025 at 04:42:56PM +0800, Nick Chan wrote:
> Add bindings for SARTv0 as found on Apple A11 SoC.
> 
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> @@ -29,6 +29,7 @@ description:
>  properties:
>    compatible:
>      oneOf:
> +      - const: apple,t8015-sart

Actually I take back my ack, move this to the existing 'enum' down 
below. With that change, you can keep the ack.

>        - items:
>            - const: apple,t8112-sart
>            - const: apple,t6000-sart
> 
> -- 
> 2.50.1
> 

