Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C951CA0EED
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eHJctUpfpTssB6epxW4c6p0svCfopwkl5fhW/Zi8jbI=; b=RGHuZ2lmvIrvd+igqYrs2TO9lD
	5qA4VEaQ6yk4SQvqzGR6mIzD2O+aueNz5tc55x1ceKC8EQlBQXQ0y0alDJMGi5DDxgBVFL2aExKA3
	Ua0n9FT7IBuzdR1ofOQC+Oklc7WKTXMSIWECZITb4/117KdTBqPnNX3/zgJH03TIYbD9La1N1vggC
	XoZAXX9QIGMJHU9HuRp6ybpg8I9HooywlmSzjmEDtEZCFa8LSTx1fD8jxCp0xlGeGBuJQ2vgsUdOM
	oUFhC4ReW+EDnuV75ZDBNtapHAwDqkvAbAG3GguVwPZtL1VRKVXgLRw0SwQRDmKgrz3SoaSBlM9wx
	w1UeDbRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoK8B-0000000ADNK-0hoT;
	Tue, 19 Aug 2025 11:03:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIUb-00000009vpu-0kJc;
	Tue, 19 Aug 2025 09:18:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DDE4D461DA;
	Tue, 19 Aug 2025 09:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0DCC113D0;
	Tue, 19 Aug 2025 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595136;
	bh=WE8xKTIRA1LGG0DwAxRK64uxUZcadJaYjOQ4rCBYnxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKwOCXjG4KIRJxgDlrsIKTTiaDCEjfwXzD7R6W9dL+Vj138hCKhIcivtdFEfrLWY+
	 zV3NXLqlASbFhj/k7b3YwRrDAl/WazGaFhUy3fV48/haFnBtqgMqbPbxqEcG7D5jDu
	 tkVlz0C2F218z8idseR3Op/HSEuNQy32gK8xC4vFeDqK58lacQeXMAarNZZmYaItws
	 qq2ff6loPEMNutxw7ju0TQaFMjfb8IpH44XlP+9goTQRaIYGTxqI8wTwHfmUjnQaUI
	 cpVNc1pLMovcTQXufxVFE+99vJLaZFWnfYEOueduj40Tnl+1lTDdyDGZUnVRrDYYr0
	 EueGu7VP4YK3g==
Date: Tue, 19 Aug 2025 11:18:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250819-polite-papaya-catfish-1a9d1a@kuoka>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_021857_237828_D2F709CF 
X-CRM114-Status: GOOD (  15.86  )
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

On Mon, Aug 18, 2025 at 04:42:59PM +0800, Nick Chan wrote:
> Add ANS2 NVMe bindings for Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> @@ -11,12 +11,14 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - apple,t8103-nvme-ans2
> -          - apple,t8112-nvme-ans2
> -          - apple,t6000-nvme-ans2
> -      - const: apple,nvme-ans2
> +    oneOf:
> +      - const: apple,t8015-nvme-ans2
> +      - items:
> +          - enum:
> +              - apple,t8103-nvme-ans2
> +              - apple,t8112-nvme-ans2
> +              - apple,t6000-nvme-ans2
> +          - const: apple,nvme-ans2

When some months ago this pattern of generic fallback appeared, I
believe I commented it is bad idea. So now months later we have a proof
- generic fallback is useless and you should have been using SoC
specific compatibles from the start.

Now it is just confusing and this broken pattern will be spreading more
and more, because you folks put generic compatibles everywhere.

Best regards,
Krzysztof


