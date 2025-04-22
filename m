Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A74C369D1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oNVBb0MqY9bnizbNO6iQSnsW/ylB3mD8UiOtg+2Ac/Q=; b=3WK0nx4APU2mugRI+URpOAKZNf
	NG5DRy2VcbBhUcEdwMPnF4PAhJqenyYHnSvccIFSPUXTfWs3N1svld8Y6S80fzNWvQaKVjds2jJTl
	ZeDpteDRida5BM383Cldle8o7efWoewvL5yDAZoqf6dDLX8f5qqpyOAQFB3lyUgkMZrR7w9CXm1/N
	da1Inl2JbkV/nD8xVOZw0ScQzgUWToLyfLoktKrDfeEqkQFdC+lBAWQjNlsPfGRAV2CTRqbggpjxx
	u4mttmB3g3qX3V805b7nkXdbCnAwM5x8B3HEv/swyDenIBrPS3Es0byrFlG/cNILkSVHnaTG3fIOi
	QARqPndw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IQz-00000008AnU-1Ush;
	Tue, 22 Apr 2025 18:33:29 +0000
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GM1-00000007san-22Pj
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 16:20:14 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-736c8cee603so296120b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745338812; x=1745943612; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNVBb0MqY9bnizbNO6iQSnsW/ylB3mD8UiOtg+2Ac/Q=;
        b=Mgngzz+W9KvVQckYes5buY+2F5eA3q32m01hAoQdcnD6mdAN6nMLbvDfY+2TB3nT8I
         ykd9Sj7jAZJR1gfPJewnlXZ5FaZiexFNOk3sHR1kc+8FYfjzUF8GNm2S523yhVBTtCPc
         iSyu6AQQwjFwwrOWaLg7I1N2m6AyMZHD7EzPnlr67hW1Sg54H2uL19HgLKg1WPXXKrsw
         7uTubkwUO/6hXpw+xzxwYdnm+YH+jHSQjXIh+CeR9XRSx7kiAcj7N7qdMartjWQY85n0
         DwjAbvU7SqHWSO3pun0dIrFWKabpGx67L/VQ+5AsQfdQCmg4OrcYURZl5UMwM99U4Wuj
         hoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338812; x=1745943612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNVBb0MqY9bnizbNO6iQSnsW/ylB3mD8UiOtg+2Ac/Q=;
        b=lCgwNdOLC3GhWxkWoS3LYI4iKh+nm5aBybbpM5cZn8kFAZB1Qx/ym3I30BUPMtr4Ao
         kwnWjiSHhJtzRp3p1cRsbocQyLJ7Ts6Whyn1daVjG+FrXn3AH+gZldS8BXiwD32bKkxN
         SsqN7343tFFY5b0qrG1jA9xeUva3Exeue0UMfywJaPmTkX5jpXFqbMJOEhlgyzqzZm5t
         Zok5j2egp8EIlAcEEdMCdiIuGKRrem2V8qwS64neIiqTmlzPU9y91QqbIgyf8ENfGGEw
         iLSJepE2aMoZFvBv4U5SQi9TStpoHOfgxV5JbsydUwRt1H+h082JfK9rp7jhHpaS2UVG
         ESJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp3ciefG7rix59t2oNTFXwa1sutPxeET6aK/7RHd0t7SzL5sRufy5YZmFXeyY1sVRUHscpW3+ui8UA@lists.infradead.org
X-Gm-Message-State: AOJu0YxVMR1lJwkro3jvLy9hdw0ekPZNZJGhik2yFtnmReG/RrH27Lqe
	IS6yQrjBbkd5yYqm3MG5EeJxlKmmFVyutj/yO5i9tSZZtPwPkzSoxLnfzCDCTBqOj3+H4G1G22X
	OQ7kEi+v+n1qh7LGkMF/+TATBAYHUNOiDEbWYU4/ElG+/zLyq
X-Gm-Gg: ASbGnctj8Y/5+99MJU8Fbrn2LBmvOUFv+UveREJL2MzwS7wFr3f25Kx9sfRXRpj4JvE
	XKxkhaEvfUPn2Qa4KYGQnChTod6T/sNM6U8ET4Zkm9ZHItKOdcu+wR+QtAgcMpq/4cTxlufN5ox
	Q3+OLC4F8MKDTpiGBed+75xbtZbtDy8plY5Xw7ybPz2Z+bOn06ATrfrQwPg+Ll79PlQpJVG173M
	SSEZbMItCJ8DSdgg680mX8mZgn2snvZphxS/3z4s9B6s6Jo8ETdrK7KJlnJi7LXoaPKslo+8cY5
	LhD6kPUHZ57yh25X1PhlIAs0tepfkw==
X-Google-Smtp-Source: AGHT+IFqneHEUyLWKxuV3RY8bdak0hnOR4vOHEeFKusLA5+sXmlOc6nAnL/VHqjyoo2JhAD3vCqEFwmeSZnZ
X-Received: by 2002:aa7:88cc:0:b0:736:442d:6310 with SMTP id d2e1a72fcca58-73dc1610237mr7975003b3a.6.1745338812486;
        Tue, 22 Apr 2025 09:20:12 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-73dbf8c0b4fsm513932b3a.2.2025.04.22.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:20:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C11E8340363;
	Tue, 22 Apr 2025 10:20:11 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BB140E41D06; Tue, 22 Apr 2025 10:20:11 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 0/2] nvme/pci: PRP list DMA pool partitioning
Date: Tue, 22 Apr 2025 10:19:57 -0600
Message-ID: <20250422161959.1958205-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_092013_670426_262397FC 
X-CRM114-Status: GOOD (  10.17  )
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

 drivers/nvme/host/pci.c | 170 +++++++++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 73 deletions(-)

v4:
- Drop the numa_node < nr_node_ids check (Kanchan)
- Add Reviewed-by tags

v3: simplify nvme_release_prp_pools() (Keith)

v2:
- Initialize admin nvme_queue's nvme_prp_dma_pools (Kanchan)
- Shrink nvme_dev's prp_pools array from MAX_NUMNODES to nr_node_ids (Kanchan)

-- 
2.45.2


