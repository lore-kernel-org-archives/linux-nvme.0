Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9847AC4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1zBOHCBv1XLnkA4Vtusr9GfOxRW+dO3nWPdFMF8Vsk=; b=WTPDgblQFWrqRwH7JSIVlQXk+1
	pvuWuJiGMHtVEHIFgh+j/n+2iP2nfoXGZQ4wJ7ne6kaDadO9SnYcjsPPYL6Qt919vL0XqcNsneqQU
	U+cL9HL7dUhIw8nXK2+6ZLsjICTiTO3mvlHBNdoj0DSpbZZ8BJMOJS3GUOf2CkLkpSGkcT85YzQUO
	ckaPkd7DGMtq1JuCH8rhEdZOKncZqN6VvTC/rV3aMqlpkTz01FYra0Kzbf4D0rv7pO8vxKZ3Rp627
	zdQuv2En7+iS02cbUXU2+qq1qwtyEnwDEmd/rm1AR/RNu5UUTHA0tRfzs6+3K6QFZ3WHguHrrWhL+
	pjzsrY4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEld-005qOX-1O;
	Mon, 01 Jan 2024 09:39:29 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKElb-005qO3-0V
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:39:28 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d855d0e40so2699305e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101965; x=1704706765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1zBOHCBv1XLnkA4Vtusr9GfOxRW+dO3nWPdFMF8Vsk=;
        b=JTS9oJdLvU7nNEFuE2S7G0y9fniV4laXdsv6UAmfmmg+DnUaC8KsZ+KoX5fgao2iKw
         JcmVvqhBpXfHhSd8vdbzuuk4ti/B0FwVRJ+Ca8qbIKGSjuqJJ4IV7LHBVDJ3WKbp9qXt
         vlHu/M/ZpxMesGjv+FGR7vHIsS2fYiCM0Yv31sG6mVvOQ/MCoxFcam8nbTB+PqgAebVW
         WIH33gQFLXO7xvXH2ZxHrdzNMCcGP4vW85V/Wkq2hekD+RhitdMmgBBFrXJpJrAqdF4t
         7hSkoXEzCxIee7W3lFq8dIlBVKHkjbtS2Ht12ePZmN16PbQwpJAupxrKAmPdudZ7WRXE
         /rEA==
X-Gm-Message-State: AOJu0YwmJvbY44RDelH4CxKkKJStg3a+PhTQ8gZaJNzyL8i6uG17tIYW
	eFUfgl2dHCSJAqHsxyfOINErD3pWAfs=
X-Google-Smtp-Source: AGHT+IGpAlc546fnlT2fQVk/MbJlGIkbpFNP6AZ0TWjGChsbY8qwYPV/XcbJTZgm0pt8ZPrggIuymQ==
X-Received: by 2002:a05:600c:3584:b0:40d:5329:96a3 with SMTP id p4-20020a05600c358400b0040d532996a3mr16193939wmq.0.1704101964605;
        Mon, 01 Jan 2024 01:39:24 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id je15-20020a05600c1f8f00b0040d62f89381sm15895281wmb.35.2024.01.01.01.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:39:24 -0800 (PST)
Message-ID: <1493ff9c-f9f5-4c54-96c5-92eddeb85516@grimberg.me>
Date: Mon, 1 Jan 2024 11:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] nvmet-rdma: set max_queue_size for RDMA transport
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-11-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-11-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_013927_190918_3B56DD43 
X-CRM114-Status: GOOD (  17.09  )
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


> A new port configuration was added to set max_queue_size. Clamp user
> configuration to RDMA transport limits.
> 
> Increase the maximal queue size of RDMA controllers from 128 to 256
> (the default size stays 128 same as before).
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/target/rdma.c | 8 ++++++++
>   include/linux/nvme-rdma.h  | 3 ++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index f298295c0b0f..3a3686efe008 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1943,6 +1943,14 @@ static int nvmet_rdma_add_port(struct nvmet_port *nport)
>   		nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
>   	}
>   
> +	if (nport->max_queue_size < 0) {
> +		nport->max_queue_size = NVME_RDMA_DEFAULT_QUEUE_SIZE;
> +	} else if (nport->max_queue_size > NVME_RDMA_MAX_QUEUE_SIZE) {
> +		pr_warn("max_queue_size %u is too large, reducing to %u\n",
> +			nport->max_queue_size, NVME_RDMA_MAX_QUEUE_SIZE);
> +		nport->max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
> +	}
> +

Not sure its a good idea to tie the host and nvmet default values
together.

