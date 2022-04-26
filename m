Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21C3C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 00:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/mTnYUQ6pZqCz9Eu3IYpCeJl6Jh6nhN/yx/cgzIAyc=; b=VBLNccVqcT3RYb9TXjTLqeLFac
	aPFARwIFWSQYd3a1Ry3y24zNaZxs5jdgMBR5JZAG8S5DolnxadwK/miu0nzZShMlZYZz7TvKPFFtT
	RroNF+NkljNmgq9ycUBKKqx8cbh/LUhY+VGRRiaaSnxKJay08PU2nTTAB25btPv1QtQaMbMDXSsBk
	ZPLpbGQk74SDnNGZxCHI/ko8/nLC+XKXGNdUniDMkVII0HT1QjVkJEsPm6Z2zR0275GfdBXYsPl9B
	cbvCSZU/vBhMJdEz3RCk1GLyYV9DVe4uygNjqlTjzmpuUFvMDD5weZh8x1fJl4Y3w8oXOthLpHwQ8
	9rxZP2fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj9VU-00C05W-0t; Tue, 26 Apr 2022 00:56:44 +0000
Received: from mail-oa1-f53.google.com ([209.85.160.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj9VE-00C02y-1h; Tue, 26 Apr 2022 00:56:29 +0000
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-e922e68b0fso6804884fac.1; 
 Mon, 25 Apr 2022 17:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U/mTnYUQ6pZqCz9Eu3IYpCeJl6Jh6nhN/yx/cgzIAyc=;
 b=eIiVUTRz/wl3HbvvAqpWkrPlXzDlhMkTogQK09jS2hIwdBoXBXpWnP137aoq4FDzWO
 Paz+HmqbNzAoVEwl3eTJWyrNzeDMHFiATQqtZbEWNEAXK01gV8wX4IjkjovJSzm2dosG
 SOY6jE3YzlPLOOl3EpINH6wJFF4C24JzW+nyPUT5f6uAx/QwlJMLVgMCjtTgSY0x0nmo
 Drgc95HVSAEqraG1ldf9bNxrSfU55YUMk1IoCjc+gpH6lw3nvOIO2MO+HuB5PQ5yAlZV
 +iVIg6q6VcgNKvjRjPgBPTAMOwoEMHI5nhIXQZFr8hANaiG0GPu5uHJJGEK1iyf3AOUu
 0/LQ==
X-Gm-Message-State: AOAM533vzA9Lp4rC/X7AKXT/szk1e4a30iQ69LXjJhmbbZvI8wewCSBE
 tzgD2IJcx7YeEGFmQNC8bOZtglSwJA==
X-Google-Smtp-Source: ABdhPJxyx3J68XofDMvRr2IMaFZEVqAi9bkYtA1l1FETzILj3JsvgXUd1OQnFJY5HJlTknU0eJHU+w==
X-Received: by 2002:a05:6870:15cf:b0:e2:6c7a:69fe with SMTP id
 k15-20020a05687015cf00b000e26c7a69femr8088818oad.257.1650934586697; 
 Mon, 25 Apr 2022 17:56:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 g8-20020a056830160800b0060548e5f69csm4344925otr.2.2022.04.25.17.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 17:56:26 -0700 (PDT)
Received: (nullmailer pid 659909 invoked by uid 1000);
 Tue, 26 Apr 2022 00:56:25 -0000
Date: Mon, 25 Apr 2022 19:56:25 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: Add Apple SART DMA address
 filter
Message-ID: <YmdDOeD31VZkMvv4@robh.at.kernel.org>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415142055.30873-2-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_175628_129791_FFBAFB26 
X-CRM114-Status: GOOD (  13.62  )
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

On Fri, 15 Apr 2022 16:20:50 +0200, Sven Peter wrote:
> Apple SoCs such as the M1 come with a simple DMA address filter called
> SART. Unlike a real IOMMU no pagetables can be configured but instead
> DMA transactions can be allowed for up to 16 paddr regions. The consumer
> also needs special support since not all DMA allocations have to be
> added to this filter.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>   - Moved to bindings/iommu since it is "Close enough to an IOMMU in
>     terms of its purpose" (Rob Herring)
> 
>  .../devicetree/bindings/iommu/apple,sart.yaml | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

