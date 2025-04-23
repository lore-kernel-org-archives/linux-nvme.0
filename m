Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5116FC369D1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yFxbUqe4x1e+3vHnnMvSYfdGB6uDRsaUIx6ClI9ClLM=; b=YNLHfaSbCj0QRPHxS/c1hf8rOD
	KwZy1W7OlB+ZH7vXeX2JWAVVDDe0pSlV1b+tSZNpcoFA1eYCMAar4RPesHEZCCesZDyda7F35vXID
	/qPpJUOkodjGeAplqySGTEHlPlmJvaSsflP7IOie9ikiYgo1VRQdpWYfGL8ZFtpam6WUZo1e13V9y
	ozu6+9WFOZlfYRASId/b+ENk2mahnBcEM+824i/ydlgYV6wX+cDsEU4aoqRU92/Uu21x8W8LdrfEI
	Fn1pfjKI7fRv+WXMIq91NHxO+BwiRbUJwCKfqsH1aoMR6ptv57TyLYF+cKvfHF5giDDMAJLi06CW7
	+NWaoVkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aX9-0000000AhMR-3oap;
	Wed, 23 Apr 2025 13:53:03 +0000
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a35-0000000Aaha-2O2r
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:01 +0000
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3d6e11cd7e2so48262345ab.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745414518; x=1746019318; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFxbUqe4x1e+3vHnnMvSYfdGB6uDRsaUIx6ClI9ClLM=;
        b=aN65KII1FyzFGoZeZ5oewQpbWLnoft2RbgVCgymlIxdnzc8R6D8M12XcqkC1BAYPCb
         CX6MTjMNftk8QEbPsxLOWKE4olX3xkwgBV9I71tFGLMdTo5MHnGYpAmmhUu97BsfwnzK
         xLwgfEDGA3iDRA2pmt7E1N3BVxwjGPPgNoyhyrh14fiq2m6pbwJgmaiLH1FYbEHvtJ1L
         m0T+PEra7IXKyWihBZN8Mv84ZHGp+XASq9jajElX7WCCRW1z+QL9yraix8kNlZ+FEG3C
         KTcRV+wlgV7OKOyE9o31bmwyNTyhDdQiwNypCchz4xOj1KCpR8FGLV5dmpmyHd/XcjRG
         WELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745414518; x=1746019318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFxbUqe4x1e+3vHnnMvSYfdGB6uDRsaUIx6ClI9ClLM=;
        b=wLn7jR4ZWRJhuuW31+3UyEg8Ml4IUkjt3HvQHBX/x9G2/rwUHYDl4VHyB7MsCVo1Nj
         KKqzaMo5crxR9c8+rmcrlahTnEBg94mWC+rHw8e88Wz0T1Z5ois3YkIpS9taUuPcmr1D
         WIPBZhkNKMbSs+sNRdGhTXfQWi18aVzSk86R2EGfqEYJy7VzilnqCBuiPi8Dw15KSvtE
         73pbPuxzv1b7mKu8P+NXveYxrixEgEjmpQWbE4Mlk2RKSRo5fbPGcve3kHOHb+LglDgy
         86TkF7kz7lw8n3xlsb4ij4EJbuHUtS8F0tXFoO3UIMyiaYikzOynYVllN1SEBfv8Ii9I
         VF2g==
X-Forwarded-Encrypted: i=1; AJvYcCXG1ekSt+9+VI9jzAkt+o3+stfMiDt1pDWJmMFOO6+inCq7MDX3uF4yG88hbEygNHuXfB9e5+xZa8w9@lists.infradead.org
X-Gm-Message-State: AOJu0YxDviJb59ZMh13NNzVLB0rxNTzThFfajYbi4JtKJWl5f52Y3f0a
	kCXDwZ9d0LE1zSKK/ISApwTwgrtxQXKMwj9k9wxXYd27zrvy9FKADl8b7d8UxLs=
X-Gm-Gg: ASbGnct+oyu/eSqgU+V0XVDsQf4zgsB0y7wMB8TiljrR9Ei51TdNIu8WAwE56iu50jW
	lUF5XEHe1DQbS26gbpPD5mawDQ+P3frE04DC4whodOY1MWxpCiE1aICHT3UuO+M5teY6qb5Nnrj
	mvBqRagrFk27DIawtu67JpyTqtOx9NbO8UJ5jt7TE0BryP+9dAC/nbCanky1pw6zgluOjKy84l5
	77WtqDLLRwIuKs3/3nAKt0qhgA8/Bq09Ak+vF0nxunUmMGwoBeCOEekuiOvJXm2B1guR1iYrM3+
	DvyqWPFKOfqlwGVzn3RtFqK/LCKQLmuiEfdrwrnY/zcWTbql
X-Google-Smtp-Source: AGHT+IGTVEkt9W2JltunyBersFyZ6wDo6AvaUWgTrYHtS8zxIbIrUCUZrDuNaD9JWWXTO8zilUtOtA==
X-Received: by 2002:a05:6e02:17cd:b0:3d3:f6ee:cc4c with SMTP id e9e14a558f8ab-3d889047eb1mr178691565ab.0.1745414517912;
        Wed, 23 Apr 2025 06:21:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3806326sm2806031173.42.2025.04.23.06.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:21:57 -0700 (PDT)
Message-ID: <09bde11c-a3f3-4c5a-91ed-74bfd2e0f61d@kernel.dk>
Date: Wed, 23 Apr 2025 07:21:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] nvme/pci: PRP list DMA pool partitioning
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250422220952.2111584-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250422220952.2111584-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062159_619000_28AD757B 
X-CRM114-Status: GOOD (  13.27  )
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

On 4/22/25 4:09 PM, Caleb Sander Mateos wrote:
> NVMe commands with more than 4 KB of data allocate PRP list pages from
> the per-nvme_device dma_pool prp_page_pool or prp_small_pool. Each call
> to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
> These device-global spinlocks are a significant source of contention
> when many CPUs are submitting to the same NVMe devices. On a workload
> issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
> to 23 NVMe devices, we observed 2.4% of CPU time spent in
> _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
> 
> Ideally, the dma_pools would be per-hctx to minimize
> contention. But that could impose considerable resource costs in a
> system with many NVMe devices and CPUs.
> 
> As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
> nvme_queue to the set of DMA pools corresponding to its device and its
> hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
> about half, to 1.2%. Preventing the sharing of PRP list pages across
> NUMA nodes also makes them cheaper to initialize.
> 
> Allocating the dmapool structs on the desired NUMA node further reduces
> the time spent in dma_pool_alloc from 0.87% to 0.50%.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


