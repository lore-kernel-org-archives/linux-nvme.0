Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAB2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Mar 2022 21:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vzLcBKO/XDK59tDp87Wl8eFLtQUNXGUQdW4J6/vdSnM=; b=arAdYL95r6hhXafUlqg6mjMgzr
	l33JKLAwgQTDVsOr/foN5/Zjg/NHElhnEjhvIdR+QME9vr2wJq+RaVOLV7TOjcweUsDdMDNf4+Qyt
	29Mjp9VL0tVPb+q6VFZ8KwdoUT6NNrDYp/WfDqeZgL8AhjEeOmx10AboBZHmyoEGn1zqKymTwiOmO
	InMg2xRceFDPZQ/B9YskxZoY/5AF/DbFPbcvBtJtcfdT14qMxQn8YFhUI7+Ng2ubbY6AQ6LKkSHQM
	rERccVuMkynvOevDtVHwZ0hLjN8nXC98Z0ZPXJT08m+gKF/aRwuRJhd2GG+Dvqal5d6il7fI9oa9q
	yf1N4WqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na2GL-003iWk-HG; Thu, 31 Mar 2022 21:23:25 +0000
Received: from mail-ot1-f54.google.com ([209.85.210.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na2G3-003iQ4-VR; Thu, 31 Mar 2022 21:23:09 +0000
Received: by mail-ot1-f54.google.com with SMTP id
 o20-20020a9d7194000000b005cb20cf4f1bso779422otj.7; 
 Thu, 31 Mar 2022 14:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vzLcBKO/XDK59tDp87Wl8eFLtQUNXGUQdW4J6/vdSnM=;
 b=ddEuspakIps3A8XbwmSP3ZfSlJn8Ub4PVQ3Z43/yX4T0WQ6CABljlDtm5f0nQjPLue
 XXnHG55vlNwq8hPUuDn/Y8goScY97lW3zd+03fKigzPlkV9+SLbLZ2EE/lrxmQDiWfy1
 RhbzhqHbOrsGIFoqDmEGXXtntFoZ5EqzvevxjdUCcqsPifw+yn5l3idtMR2fWQqiid67
 4HTDhWIpkb6Ny6Ocoz+/RIOx2ZLdJ6epJXQ8ksnGPTIBJA0M8bdbHY7+tWMIeMNVQM4y
 zPsoteLZXqbq7jCcZa80XVJ8Z7LJAJWgkR0yCtpJlMNHGy/kK2J70eoPxbGuYPrmALiW
 480g==
X-Gm-Message-State: AOAM5305sZxVQawPF/paP+NdN8pxh52sGOSqJlabqlJiACcmlYCIeLk/
 DsJqw4lql+NyJvz55GGx0w==
X-Google-Smtp-Source: ABdhPJwseFEEdKZk3qwsEVG8HRLBOBuwND9QrZ5NLEH5I03RtbXWF+Qpo07hT4Xv0inLxP4ssIR7fw==
X-Received: by 2002:a05:6830:2099:b0:5c9:4715:2c80 with SMTP id
 y25-20020a056830209900b005c947152c80mr6518629otq.244.1648761786754; 
 Thu, 31 Mar 2022 14:23:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 x18-20020a056830245200b005ce01c28c77sm333676otr.1.2022.03.31.14.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Mar 2022 14:23:06 -0700 (PDT)
Received: (nullmailer pid 1522501 invoked by uid 1000);
 Thu, 31 Mar 2022 21:23:05 -0000
Date: Thu, 31 Mar 2022 16:23:05 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: soc: apple: Add Apple SART
Message-ID: <YkYbubNBD+J2XUCg@robh.at.kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-2-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_142308_043218_9371D73C 
X-CRM114-Status: GOOD (  24.51  )
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

On Mon, Mar 21, 2022 at 05:50:41PM +0100, Sven Peter wrote:
> Apple SoCs such as the M1 come with a simple DMA address filter called
> SART. Unlike a real IOMMU no pagetables can be configured but instead
> DMA transactions can be allowed for up to 16 paddr regions.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/soc/apple/apple,sart.yaml        | 52 +++++++++++++++++++

Close enough to an IOMMU in terms of its purpose, so put in 
bindings/iommu/

>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml b/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
> new file mode 100644
> index 000000000000..d8177b3a3fba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/apple/apple,sart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SART DMA address filter
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description:
> +  Apple SART is a simple address filter for DMA transactions. Regions of
> +  physical memory must be added to the SART's allow list before any
> +  DMA can target these. Unlike a proper IOMMU no remapping can be done and
> +  special support in the consumer driver is required since not all DMA
> +  transactions of a single device are subject to SART filtering.
> +
> +  SART1 has first been used since at least the A11 (iPhone 8 and iPhone X)
> +  and allows 36 bit of physical address space and filter entries with sizes
> +  up to 24 bit.
> +
> +  SART2, first seen in A14 and M1, allows 36 bit of physical address space
> +  and filter entry size up to 36 bit.
> +
> +  SART3, first seen in M1 Pro/Max, extends both the address space and filter
> +  entry size to 42 bit.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - apple,t6000-sart
> +      - apple,t8103-sart
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sart@7bc50000 {
> +      compatible = "apple,t8103-sart";
> +      reg = <0x7bc50000 0x4000>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd0f68d4a34a..027c3b4ad61c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1774,6 +1774,7 @@ F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	Documentation/devicetree/bindings/power/apple*
> +F:	Documentation/devicetree/bindings/soc/apple/*
>  F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/i2c/busses/i2c-pasemi-core.c
> -- 
> 2.25.1
> 
> 

