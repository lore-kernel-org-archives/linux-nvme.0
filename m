Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC6EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BH7vmV60pq07t1GAA5YZvFkzgwzKmGX6FaF8nF3TCVY=; b=d5NErvuYdkviNGbntpYOLxly81
	s9DQOmDg6YdUci6bLdRtP8wdyT+cXPxmbpLUZ5/KhSiWeL5HRCI9Yzc7BH6gx+Yj2Z4azobqfReyV
	kb+STMhKMzVDvCZ3V0gmP+zCl2868CE4Too3LT+SPB0236f6Oj5D8Na7ZJGmBGTt9p6QQ5WJHLReV
	NW51v7U05R0SZe9obFuMI54mo5K/6b14XKjDvB0UHYquvJIDRSZoYbQXy93McdEqXO6YHSHu0spfw
	M34OZrZd29QyW+hNv/TDE3dtzcmKr0e4N71hPQ/gfnkvjKn2Dz7RcfcR4unSFK4p9YJsQJjLqX+CU
	KCWGvnPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj9Yk-00C0wf-4s; Tue, 26 Apr 2022 01:00:06 +0000
Received: from mail-oo1-f51.google.com ([209.85.161.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj9YX-00C0sY-3I; Tue, 26 Apr 2022 00:59:54 +0000
Received: by mail-oo1-f51.google.com with SMTP id
 s203-20020a4a3bd4000000b003191c2dcbe8so3111050oos.9; 
 Mon, 25 Apr 2022 17:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BH7vmV60pq07t1GAA5YZvFkzgwzKmGX6FaF8nF3TCVY=;
 b=sJ3mC5MKj2gqtvnHTeR5fZrB4MpeiyHgSiRRuTtjmN1mV75SuUaalwCp7sNlUa9H5O
 mJM1FZW4ajNB4+5nJhs06vAfKPqGw+EhV1CWdUMeXpswX1Fv+m6lctN1Zz7uRB74U6f+
 a+hp6fJlXonlACo4zD/CaL+fpJ/2VKlcWbE89rNo4AbpBzjcmZ2LT6wUZaw5ckqrJYnb
 JY+Y1bdqFWhwkZrcZMN4KDT+FVBOwsZ3avpciI0VlVNrMUrl5aQTKfILK8LoJ1M0AGKq
 K2Ktq7dLZh0PR/BxnDwKOFCAUuwyghvg0AZEWZrW8oGvXZeG+IoMZQi9Wzk6RUxD2ecW
 xZbA==
X-Gm-Message-State: AOAM531dyfEFveKWpfJmEjNVy20KMYcZvzV4Oy4mmQPOSiWG06Gro4UP
 79ZcMFiK6qBBzLGxci8Fag==
X-Google-Smtp-Source: ABdhPJzWGYxJLnYY0ELBcT5LlXMJyLGiZQ9E8DZQVDqDcgdXUUm8igxTVXHcPgf2xbRJaVFiyccqpg==
X-Received: by 2002:a4a:c294:0:b0:329:2fed:ad3f with SMTP id
 b20-20020a4ac294000000b003292fedad3fmr7311432ooq.4.1650934791766; 
 Mon, 25 Apr 2022 17:59:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 30-20020a9d0ba1000000b005e95b29b95dsm4323883oth.5.2022.04.25.17.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 17:59:51 -0700 (PDT)
Received: (nullmailer pid 665368 invoked by uid 1000);
 Tue, 26 Apr 2022 00:59:50 -0000
Date: Mon, 25 Apr 2022 19:59:50 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Sagi Grimberg <sagi@grimberg.me>, devicetree@vger.kernel.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Jens Axboe <axboe@fb.com>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-nvme@lists.infradead.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/6] dt-bindings: nvme: Add Apple ANS NVMe
Message-ID: <YmdEBvMtO0PIfxCo@robh.at.kernel.org>
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415142055.30873-3-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_175953_174930_674F3F8F 
X-CRM114-Status: GOOD (  11.14  )
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

On Fri, 15 Apr 2022 16:20:51 +0200, Sven Peter wrote:
> Apple SoCs such as the M1 come with an embedded NVMe coprocessor called
> ANS2.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>   - Moved to bindings/nvme (Krzysztof Kozlowski)
>   - Added power-domains and power-domain-names min/maxItems
>     (Krzysztof Kozlowski)
> 
>  .../bindings/nvme/apple,nvme-ans.yaml         | 111 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

