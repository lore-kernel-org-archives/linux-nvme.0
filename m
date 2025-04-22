Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0FCC369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KwOPiQZIcSoYiJQce8m9Bf0/9Br1sjvbT2lnDAfcS9w=; b=f7MIa57fUqIYed6Ht/lD37l+S8
	J/XuY02xSH520emkTDVugB6AsscDXM2L44fZC/Z4IyBEwVvasznMwwxxG2KHBRTdBetJVT4hB9Z2I
	llc7mAsMRXm2vFd3if3XHZdpyFshbKHNmtj8wreGHvu/YZGRdvCD5zFhEgzk6Yk6MrmgxhL2GawVa
	Xmae3BiuojKQNmIDINyTj1Nm4BZmuC/0Wa5R7OOAzsoaNeD8IY8S7uT9w6SUYWolM957aiZVQfFz9
	sXc0SljiayRu3Aj6VzfJ8kUz7g4k53FWKwn3ZG/TTluQynp61yoa11pX8ACE/zmabCZFdyjR9Bu16
	rkEcqR1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7M4R-00000008iM3-2bw6;
	Tue, 22 Apr 2025 22:26:27 +0000
Received: from mail-vk1-xa64.google.com ([2607:f8b0:4864:20::a64])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Loa-00000008g5c-2jLh
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 22:10:05 +0000
Received: by mail-vk1-xa64.google.com with SMTP id 71dfb90a1353d-523e895dd3dso173609e0c.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745359803; x=1745964603; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwOPiQZIcSoYiJQce8m9Bf0/9Br1sjvbT2lnDAfcS9w=;
        b=ZmsGISPgNPcx0L4Di3HxhqBQwMJKDRnZF2VX2a1OYRVpRP1mpTG+9X0ON1RfrlrV4n
         CGsyZA7QAlwuVh7Pr5xjOYzQiyhNmKkyDGzYnqaBN/Ff2LMny0QBbN/j2Es+RUP0yzSW
         P6Q4iNfMEoE/vfZfRZy2UMYvfcEa4MmgwrUI732JPV3SkzaWNvRJ/906B3xfw4R5h8Y7
         Uq+fHuIAITAR2n5RSMV2t0mBK/47aUqLOQ8ynJPkpBIxnJDEB37Or3YwUi5VxXKVipEi
         3lZ+FhYDvwDZey9RWuwm1QAAxDmCWDpXUUKukM69jsCNnTjKZNLxR4+TyH20lEQJHGdr
         aALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359803; x=1745964603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwOPiQZIcSoYiJQce8m9Bf0/9Br1sjvbT2lnDAfcS9w=;
        b=VY4b2L64JRbWaJBDNhTbV/vvOhFv7dFVRMQ9T97YDRBTxEa9i+obeJroi7YB4hMNBQ
         ibXXsIozEHlhg2VSqnJNxewjau++TrZChCf5aqlNFQryf9kgUOqskaCH17uAYAw3B/Q0
         XIhIdn2gPylfgKIeMgAtxkCgLhJXQpl5rAAEKgzTMS+jt95sl7aPK9DDFBstgfX8SWn5
         aFn8RavI2TtLz4KY1PZwuMi+7jVkm43mcPuY2UE9ibhTRIgVvDdigmECGVIwtBfbioln
         NVlChvRT3pPvDQj1hL8lewRaAP2PFj228I+JrHshlFI1SurorKOlcO1FHKjK12CaJM16
         m8dg==
X-Forwarded-Encrypted: i=1; AJvYcCWrqeqt5dV/+E2M62SwA4lmy/zaNkZOTkhekeIlr56cSPopWNxQYcSALhcNcOaEdQfk+BViuoIRvb1v@lists.infradead.org
X-Gm-Message-State: AOJu0YzBD0/BTQlDkCO5XVJOB4rjia4UKtYoAuHyKmH+N8mLpDbz1Y8B
	xmQIymRg8udQgSySod3HEhl+FY7yq2ZGYe+KYpTvxt7UMDGqoud9vEBjGIuz8ZN8oyzP2ysewwZ
	47RdxKYLwWryhGG8WdRXECtniDHhQo+04
X-Gm-Gg: ASbGncvvQl4vmOUWEVKaH4AcOl6Ge6jaA2qnjq8tztyJxWcgcmKsmV/Qwm2CSR6KnFM
	9bg1zfoM3F7L6j32CqKhTcUbOIPLOT5mtAkbTv2+zA9OSDK+gT0QK+hHBHVVydDcBCoR6Zsuahd
	tuWnayX276FIa2AAskRHul27oUvB54WSz2dcZ4qNPCbunkLMl97pWNeUjYe8tW99yObqdOYCawB
	enSeyQB+UlsF0ZnMYlMvaSn7WKZPTZOHtxfMP/N7Jfr8xao/P9eil81zPG67WNIiV/EO4Q/WcqZ
	12mCwV1uWNDaJSisOZ4Pd4zIKWjxvIfxv6Q33olPanwb
X-Google-Smtp-Source: AGHT+IFxdjGFL/VvbqbDrlnoQYfdKyqz0v7X9GEE7nLpcx5NH6BX81xcZcT2Wtr3f6QKNmjvv2s/vLJ60LMH
X-Received: by 2002:a05:6122:1051:b0:527:67da:74eb with SMTP id 71dfb90a1353d-529253b58b4mr3568089e0c.1.1745359803082;
        Tue, 22 Apr 2025 15:10:03 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-52922c112ffsm364279e0c.5.2025.04.22.15.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:10:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6653234045E;
	Tue, 22 Apr 2025 16:10:02 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 60268E41D69; Tue, 22 Apr 2025 16:10:02 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 0/3] nvme/pci: PRP list DMA pool partitioning
Date: Tue, 22 Apr 2025 16:09:49 -0600
Message-ID: <20250422220952.2111584-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_151004_687255_6B6D0A8C 
X-CRM114-Status: GOOD (  11.02  )
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

NVMe commands with more than 4 KB of data allocate PRP list pages from
the per-nvme_device dma_pool prp_page_pool or prp_small_pool. Each call
to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
These device-global spinlocks are a significant source of contention
when many CPUs are submitting to the same NVMe devices. On a workload
issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
to 23 NVMe devices, we observed 2.4% of CPU time spent in
_raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.

Ideally, the dma_pools would be per-hctx to minimize
contention. But that could impose considerable resource costs in a
system with many NVMe devices and CPUs.

As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
nvme_queue to the set of DMA pools corresponding to its device and its
hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
about half, to 1.2%. Preventing the sharing of PRP list pages across
NUMA nodes also makes them cheaper to initialize.

Allocating the dmapool structs on the desired NUMA node further reduces
the time spent in dma_pool_alloc from 0.87% to 0.50%.

Caleb Sander Mateos (2):
  nvme/pci: factor out nvme_init_hctx() helper
  nvme/pci: make PRP list DMA pools per-NUMA-node

Keith Busch (1):
  dmapool: add NUMA affinity support

 drivers/nvme/host/pci.c | 171 +++++++++++++++++++++++-----------------
 include/linux/dmapool.h |  17 +++-
 mm/dmapool.c            |  16 ++--
 3 files changed, 121 insertions(+), 83 deletions(-)

v5:
- Allocate dmapool structs on desired NUMA node (Keith)
- Add Reviewed-by tags

v4:
- Drop the numa_node < nr_node_ids check (Kanchan)
- Add Reviewed-by tags

v3: simplify nvme_release_prp_pools() (Keith)

v2:
- Initialize admin nvme_queue's nvme_prp_dma_pools (Kanchan)
- Shrink nvme_dev's prp_pools array from MAX_NUMNODES to nr_node_ids (Kanchan)

-- 
2.45.2


