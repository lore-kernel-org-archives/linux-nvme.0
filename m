Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E67E68946
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 01:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=; b=EsoXnoUbR9UWzullvPeKvFnKBr
	TD7pCi3iujV81GTjD3PGjiTEIpLu1iJHf37uwfNFlRPkmhrp1ub3dm1R7nsTOAZjTmUss7asmkcAL
	OdVdxlK0YR8HqT7CP2sbQXUwDocltWeyr2jrnazTSky8eTHscV3nbNZR46kdc8r9Zlxq4sgH1VVcG
	CA/eqQpePdcBWoIQBKsk/RtHsmXfc1RzaUHsQPsy+RnhQ0XDTdgVOM9zSc8aNvt5Tbxf6SNk7pn4+
	cHnF0CSpnvimAvwJ4GeL5lgTK7hJbufyuq7hUrY9fyrtD15ycYABHRNz2GaGQDCCBkWwXYYLAvJxy
	iimqTaTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6KEW-00000002HKQ-0MBC;
	Thu, 31 Oct 2024 01:44:20 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6KES-00000002HJm-3ggU
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 01:44:18 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso373680a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2024 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730339056; x=1730943856; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=;
        b=qniCZ+xqLod7w6Q8IKk3ftHvwRlRfOdMkF6lWXzJqyZJYdKQJfhQZzUhMncAjuxs3H
         qKcAzbVG6CxFfggGQao8LNk3YU83jcw2YqwKAVBpV4JZ9p3EGgIQ9NVSv1U8WPHYKHyg
         FP1gx+OLul1KMhq+V8oDyhgIXbETGq1FbJI87Ts/a3psypSwYy/skJg+hlWueIyVOFQ7
         p+chrDlrfTm/TYEg3N4mOjO+lVdbemdYgE+61Zf8J1sYi1GYmcfK+wDG73vjjzS2mDX+
         /E+NTYTiNpfCOqljBUrX8a58EQ06HizmFqAQbzR3vCTfRyS2jzn44oKtmlEMcW/52yJO
         CvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339056; x=1730943856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5HJbtUFcFXgZVBH0YtIsWB+OH8uOJ8D1+BabaE0bvE=;
        b=uoxOt1XveGYX21U0Xw0tbpzHnLA0c4AIwIZIFPcdvTwLVJkh4NhVwP/t0m9zUPJo6/
         1QvRt8SaieBycJNrZfBjzGMozNKJEPDYGVR5ul9DY7ZeUX6kgxMe87Wm1YzzlZAORXh/
         ioSDTb7cepbt/oz8qVEN0IqUeBMXgKWaLIjeauA5i0uk2dsuRa0MVH6FQb3uShNP39t/
         nQXVBJyELxsEphPZWvy96smo75G21sEqhm6mjao55iSEW+C0gk+ceH4z8ExZbx61GejH
         Fpb19kno89pGcG+0Q6cd1zuDPEMl/cFC1gJjFGyAVr+z+2zZOMikGg0p3Vh9y2+FgmoQ
         jlvg==
X-Forwarded-Encrypted: i=1; AJvYcCWK8At6v06RYByXjyXBrGY/ezccJkpjIwXirxPpD6gi9OTMTG5HpALs1pxXrmGtJ6KasjBqaJuFIlf0@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4+rpdCniaj/QT+U80W38+9W9vYVKlik52h/b5ZYTJTWI3LCZE
	zsiHZ/wU2K5r56COe710KOUV9Wa65qKt32DGpMrHdzEfdI4MZ5sQ6JBSC+VS5fQ=
X-Google-Smtp-Source: AGHT+IGsg2gMuDdd8QNd8tlE79QeVlOXl87E5sZsK92hB7UM4f0gqnlbEouiOfBHyppk70cC1W17JQ==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:b78:2dd3 with SMTP id adf61e73a8af0-1d9a840aaf4mr23384613637.26.1730339055795;
        Wed, 30 Oct 2024 18:44:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daac966sm332679a91.17.2024.10.30.18.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 18:44:15 -0700 (PDT)
Message-ID: <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
Date: Wed, 30 Oct 2024 19:44:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1730298502.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_184417_218430_86E0EEBC 
X-CRM114-Status: GOOD (  14.28  )
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

On 10/30/24 9:12 AM, Leon Romanovsky wrote:
> Changelog:
> v1: 
>  * Squashed two VFIO patches into one
>  * Added Acked-by/Reviewed-by tags
>  * Fix docs spelling errors
>  * Simplified dma_iova_sync() API
>  * Added extra check in dma_iova_destroy() if mapped size to make code more clear
>  * Fixed checkpatch warnings in p2p patch
>  * Changed implementation of VFIO mlx5 mlx5vf_add_migration_pages() to
>    be more general
>  * Reduced the number of changes in VFIO patch
> v0: https://lore.kernel.org/all/cover.1730037276.git.leon@kernel.org
> 
> ----------------------------------------------------------------------------
> The code can be downloaded from:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git tag:dma-split-oct-30

On Christoph's request, I tested this series last week and saw some
pretty significant performance regressions on my box. I don't know what
the status is in terms of that, just want to make sure something like
this doesn't get merged until that is both fully understood and sorted
out.

-- 
Jens Axboe

