Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D3AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dai30hWVE73XS1BdDg5fYlvRV1WNpo0cUCaApTip4lo=; b=h0U4cRmxd7JSNgRWl5ywhabr9T
	xDyM3K3HVeCbWcK3nX888Irjc8h6oCNZhtNsCj8NckmK9Zwubsfa8vHYOiObjtNNKeR1a4aBGT6LF
	jFd3mB5hkchXbMumqoE1FGw6RAtMRsDmG3slY0UUnPryfOmqa0ZJugYaL0+iKw2g67+fIl31lfcUZ
	4NyTTbBl36nSyMxFJRr4jcCmJYzpUgjT3qCgKncHY9sRR053DUKXBr5UZl/VEkqS/sOntPA7i0wqx
	+IIbI4PXR613MFa/ybwQtGV88ldC0QyJPaEy6PFKJL3k1unB/zKMxd+85uxpcCDD0QCpOA4o1ndO5
	DHcWuk2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWyx1-00DQRi-0A; Wed, 23 Mar 2022 11:14:51 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWywp-00DQPW-CH; Wed, 23 Mar 2022 11:14:40 +0000
Received: by mail-ej1-f41.google.com with SMTP id dr20so2116780ejc.6;
 Wed, 23 Mar 2022 04:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dai30hWVE73XS1BdDg5fYlvRV1WNpo0cUCaApTip4lo=;
 b=JwrcUdx1fkFKfiK/+IE6pYakfXPzL5pp1C1c+gg0VlTahwB/vNg8llOAcQ7snEoJ8H
 F8jfyLHngyzEhtDImDFqHTP6FO7bhyNdcGFbjYCQ+Cg5qmYQM9RjfLG4m595h73wvsC/
 PupVAuvmtbc1UReZxqfoaui8dXdkLbPnyEjMlaGR5iBWtciQJRBSrXSSjKGh8N32H+AN
 OVhO7ZMyx9JT7cR7XR6piuPIS0iMBbMN7HokizrTPXt9ykzojaXkE4RAaqg0oifGgaAG
 fV4IFlFDi/kQcXtmcR+7PJVX+uuVpUJKjKchp8rn/QE10gKn2Cs/1yXtBp53SU1qR3jD
 WqJQ==
X-Gm-Message-State: AOAM5330mp3DG1lHWz0GVt+5wDBLT0zI7ngHxbyEKFNYXN+y5JH0kmNF
 lDRexAwchhIq3RLFFeGZjZM=
X-Google-Smtp-Source: ABdhPJxXt39QU/wVHju86BXrVhJch0OjFKWervPZkOxBPGRh1bfIYFtS/HVxO2OkprLAJEoFjwvxeA==
X-Received: by 2002:a17:907:970e:b0:6df:9b6f:8a52 with SMTP id
 jg14-20020a170907970e00b006df9b6f8a52mr28325822ejc.761.1648034074980; 
 Wed, 23 Mar 2022 04:14:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.googlemail.com with ESMTPSA id
 k19-20020a1709062a5300b006c75a94c587sm9544802eje.65.2022.03.23.04.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 04:14:33 -0700 (PDT)
Message-ID: <40f7c074-198a-5ce0-02b3-e6042975e228@kernel.org>
Date: Wed, 23 Mar 2022 12:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/9] dt-bindings: soc: apple: Add ANS NVMe
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-3-sven@svenpeter.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321165049.35985-3-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_041439_457961_A8A451FB 
X-CRM114-Status: GOOD (  16.44  )
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

On 21/03/2022 17:50, Sven Peter wrote:
> Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
> ANS2.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/soc/apple/apple,nvme-ans.yaml    | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
> new file mode 100644
> index 000000000000..e1f4c1c572aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/apple/apple,nvme-ans.yaml#

Do not drop all code in soc/apple, but please use respective subsystems.
Apple is not a subsystem, is not special.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple ANS NVM Express host controller
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-nvme-ans2
> +          - apple,t6000-nvme-ans2
> +      - const: apple,nvme-ans2
> +
> +  reg:
> +    items:
> +      - description: NVMe and NVMMU registers
> +      - description: ANS2 co-processor control registers
> +
> +  reg-names:
> +    items:
> +      - const: nvme
> +      - const: ans
> +
> +  resets:
> +    maxItems: 1
> +
> +  power-domains: true

maxItems



Best regards,
Krzysztof

