Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40E0C369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DUxZ7QU0ZXlmoVmoNYzkqFHZEXl8rPwJ/hBKAw0bhQE=; b=u5r0J05gICi1VwzQW5CU7+WCLz
	7K2MbSLHr3jZ6Zy6wT69OshH6asmFluAvgNkC01zBExWSzUB1cYhV3fJy3THQJxfkLUW/xhIdXcX5
	k2/3AxTVM0iaQ2qXoLTB+u03jMQsJD72bR4zOYrKCwLCKqHtS7ppg9EzA/uVmzwPqqmxvShpC6faC
	ExVfO+w1zic2Axt3lUhr2ZcccCMbTPmfljiqrv/bG4TfoJ1yqU2bv+WWqIkpZKRq43Hz2jd4MNB5O
	TGt/ZvXHWbOwDK532x4c25gD/MvBPfR43CIxXeNDBH0a40PXCgZINb8gwe9t0ZfPleVy44lt3ukwb
	no9Q0VGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6tq1-00000004eY8-3rzO;
	Mon, 21 Apr 2025 16:17:41 +0000
Received: from mail-yw1-x1161.google.com ([2607:f8b0:4864:20::1161])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6tpy-00000004eVG-3dyG
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 16:17:40 +0000
Received: by mail-yw1-x1161.google.com with SMTP id 00721157ae682-6ff4e4b8b3dso1502177b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745252254; x=1745857054; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUxZ7QU0ZXlmoVmoNYzkqFHZEXl8rPwJ/hBKAw0bhQE=;
        b=MFbQIaVf242UD0Kj9gkSl2qTJmGoJG6bo6/SBcz0r6Mv8nL160cbnA7Mvv5XUyqok8
         ug80Vn30oK6kk7m5W+t1rDgdLDcZXBAEADVRRf8gOVsrrsc+r0yBslQEMIzgVkVec+ZU
         NbRvoqmBJaSt62KqpVHhNBdvm8ZigMKJqxz4JDFpCxdgXLHxl/oiZ294c+Vv4GnjMz/z
         5TCmUMRRFO2GuuWr6SZ+Xrgehdhdff4ZTPqEFnb7S8itZWI4iZYStkEPya8uhBW5J+cJ
         gnLy79TromClnWJXxRG5AKPy2agToCWeXjDbFYSHng6625cwRBk9bv5NEvMrO2a9dKoN
         +LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745252254; x=1745857054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUxZ7QU0ZXlmoVmoNYzkqFHZEXl8rPwJ/hBKAw0bhQE=;
        b=jr+CnzMf3LxVh59eGZ2u83URM0+ALxK/qMGXQIyXvBGnl5rol1YhjSLjnBTNnVNDg/
         FNxhaF2V/KEkWTVZZVijQ8j5VK8a4bu+pvFbaLGXwnBB5DBuKawBMFaRVabhUriRZ3mv
         nbKJZwWd5cjg4+gSgPZIsr/WDGm3VwaygsLp8U0/AtDlMORS8yjF+G9Pnrex5wklg7d4
         GkeDbgQeI4HYinfjJ2ZQfK+N6IUcrmbgIFCDTKFbJGPe462iEykTHQuxF0lno0RlXB72
         8GlGgt/EqEmL30KAVynjKRikcQO6CH06SNAQgvkqjijcFDeUrynnDQmb5aUwk15QaohY
         o6sg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwp4V1JaWC4DKCmqqFu9Za/f9vb97ltnx23DBmffB5EUCpwbhAw5y82Z3li49Pk1c0PdU8D967xrJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8MBEPEi4os4BN0o7MD2EoM+jWhtUNtdCM1tMh1a+P6pXWj22j
	8ub4dNmDcNBKClOdxGCrYuF2t1LZW9RENmQEuZDxev/Ymwi74FgYML4K8ql0QFbge15eEHler4h
	RMgDYBlvFswKmpfi+KrCGBRpEdTWjzrCiSjEaBul7G9QFvSYr
X-Gm-Gg: ASbGncs9/J6sA2HZ3hbMW89zpFHH9j5w8F8lrj2yhpDd2Ecvpi9qxjW9sUWWuvtU1Ck
	JtLNoILTx7vYCTF4/qP5fKZfb4ZvIUQ6iLPecjlKr86rwzmcYEgj9MfTMHAnBc1JfGkCirg1938
	4QK5VtiTmN5wUpcJFZmH4rkxWZ6vZrNceBp37TpejQvtRJFgp5NCF40aP0CjxwVCstkrYtPCD8l
	6aLybce2ucASGDh9MJkHcqEc89dp8epVEhuwm97Cw+XM825QfaK0XkLawwqnDwm0DiEdL9yns/d
	xfhyr/yStAGNovMx8PdZSiZgaJ+z+w==
X-Google-Smtp-Source: AGHT+IFfEX42iuZO8gjsOnTfTqyOtwPhA9HRGOGMlq76Al8Bo4QESh6GwJGvRDzU3Xned10EsTlCAb4S50nn
X-Received: by 2002:a05:690c:6891:b0:6ff:8418:5afb with SMTP id 00721157ae682-706cce0cc7cmr69058607b3.5.1745252254618;
        Mon, 21 Apr 2025 09:17:34 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-706ca5ba93esm2541257b3.47.2025.04.21.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:17:34 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0A8D53402B2;
	Mon, 21 Apr 2025 10:17:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 04724E41856; Mon, 21 Apr 2025 10:17:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/2] nvme/pci: PRP list DMA pool partitioning
Date: Mon, 21 Apr 2025 10:17:23 -0600
Message-ID: <20250421161725.1610286-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_091738_911852_39919867 
X-CRM114-Status: GOOD (  10.09  )
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

Caleb Sander Mateos (2):
  nvme/pci: factor out nvme_init_hctx() helper
  nvme/pci: make PRP list DMA pools per-NUMA-node

 drivers/nvme/host/pci.c | 172 +++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 73 deletions(-)

v2:
- Initialize admin nvme_queue's nvme_prp_dma_pools (Kanchan)
- Shrink nvme_dev's prp_pools array from MAX_NUMNODES to nr_node_ids (Kanchan)

-- 
2.45.2


