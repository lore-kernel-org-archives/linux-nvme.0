Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D875C5AC67
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a1Qc4t1sKMfE9AWA3aPgD1xYl+DO2MyYkWPuNL/ZCng=; b=u3ME3n4taa3RR4w1I7Wshz/g9w
	7YeVWdI7oCjj8dBJFylszuitzFOHsuxNtOTypU/5aE3HqmXsOQt6nycyJsbch7mE97QbUIsdm5QHO
	RaO4vq9ldjbcRSn6dt7Me3M+yqsldFt2npMo4oKf2Yy22AWKG+uViYkehwtvrhJg/qRZdD8MXvgjr
	yh524XpRyezA/xe86Mite0lduPDi4iFYuoxOJVuwnL+LmAc1NPIpCB6nA/FXcOp0ClvPW+DLe4X9E
	b71ebpmLXk5wwSg7CpNvjtxXpXLrK+ii52AkhUKAi4a9sIA+zIp9mpqVY3lsyFyCM9qoQ6vw12Rw6
	yxfJxK9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtvcx-0000000F4CL-1YIq;
	Tue, 11 Aug 2026 23:11:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtvcw-0000000F4Bt-1WUg;
	Tue, 11 Aug 2026 23:11:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BFB5642BB1;
	Tue, 11 Aug 2026 23:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856C31F000E9;
	Tue, 11 Aug 2026 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786489881;
	bh=a1Qc4t1sKMfE9AWA3aPgD1xYl+DO2MyYkWPuNL/ZCng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ghr9OGG05qlPjUggALEtkyE5b+GM7qpO4c51ZCG0KTcJ5XtJCjYOKuo+J7TdCzw3Q
	 9oH4pUlnU326LvYyYlS25XM4e8g3JWhtyAXJLVDnS2+3D7fJA7vQm2EhNs29BJ2hzG
	 5igv69JDygLHU7MZpp46rJeVYVa21NNl/znFRLqOTC1nSIzD/CFG8vUSdWUNX6PPyl
	 QzxfPAoEwR+AHgW5PFf3Z0WSHYyzpSGTt4hDLZaPlRJf5uyLJTQG9137Ob3dk++wd8
	 34V6mAEINb4a1+MGZRl78UP1jzE1f8LCnPa+FIaOhRQUOv2bF4bADCU6e7MHj680Lx
	 OnwxxB4v6xv2Q==
Date: Tue, 11 Aug 2026 18:11:21 -0500
From: Rob Herring <robh@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: nvme: Add apple,t8132-nvme-ans2
 compatible
Message-ID: <20260811231121.GA271810-robh@kernel.org>
References: <20260811-apple-nvme-t8132-v1-0-865be32e42c3@cyberchaos.dev>
 <20260811-apple-nvme-t8132-v1-1-865be32e42c3@cyberchaos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-apple-nvme-t8132-v1-1-865be32e42c3@cyberchaos.dev>
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

On Tue, Aug 11, 2026 at 10:49:47PM +0200, Yureka Lilian wrote:
> Add a new base compatible for the ANS2 NVMe on the Apple t8132 (M4) SoC,
> which uses a separate MMIO base for its NVMMU.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml   | 77 ++++++++++++++--------
>  1 file changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> index 4c0b1f90aff8..c8a41b268b9c 100644
> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> @@ -16,6 +16,7 @@ properties:
>        - items:
>            - const: apple,t6020-nvme-ans2
>            - const: apple,t8103-nvme-ans2
> +      - const: apple,t8132-nvme-ans2
>        - items:
>            - enum:
>                # Do not add additional SoC to this list.
> @@ -24,16 +25,6 @@ properties:
>                - apple,t6000-nvme-ans2
>            - const: apple,nvme-ans2
>  
> -  reg:
> -    items:
> -      - description: NVMe and NVMMU registers
> -      - description: ANS2 co-processor control registers
> -
> -  reg-names:
> -    items:
> -      - const: nvme
> -      - const: ans
> -

Keep properties defined at the top level. More below.

>    resets:
>      maxItems: 1
>  
> @@ -68,25 +59,53 @@ properties:
>  
>        The SART address filter is documented in iommu/apple,sart.yaml.
>  
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - apple,t6000-nvme-ans2
> -          - apple,t6020-nvme-ans2
> -then:
> -  properties:
> -    power-domains:
> -      minItems: 3
> -    power-domain-names:
> -      minItems: 3
> -else:
> -  properties:
> -    power-domains:
> -      maxItems: 2
> -    power-domain-names:
> -      maxItems: 2
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: apple,t8132-nvme-ans2
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: NVMMU registers
> +            - description: NVMe registers
> +            - description: ANS2 co-processor control registers
> +        reg-names:
> +          items:
> +            - const: nvmmu
> +            - const: nvme
> +            - const: ans

New entries go on the end. So nvmmu last and defined at the top level. 
Then this is just 'minItems: 3'

> +    else:
> +      properties:
> +        reg:
> +          items:
> +            - description: NVMe and NVMMU registers
> +            - description: ANS2 co-processor control registers
> +        reg-names:
> +          items:
> +            - const: nvme
> +            - const: ans

And 'maxItems: 2' on these 2.

Rob

