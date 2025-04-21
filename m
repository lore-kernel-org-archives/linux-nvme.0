Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B910FC369D5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uwb+nOHiz3v41n7Ozb7A7o5HskDoeZoACSb6waE9l20=; b=nxw2b1ULNvZEU5yl6LKscvCCoU
	0G2rndMwrBF3BI5gOVpPpXySogbFiFbwGfuxTln5z+M24rvgga1N+E9zsXdVqQ5J+yZlhPgdxq0zD
	9uU9ZYpPX6gIOGeYf3sZiHb2HRNH59w3piINnp0h0KX6GjSCmWIHZNA43ULC3c1e4bU9qngQYPEmm
	OOyPMo1TbYVWMrQQMzE0ilPNyE7BjZu+GeP6OsdOWaB89v5iDabGM296DZKmJBaAvRzc4x2fjuwfV
	gy82zXWBBfhS1Ur+BxVx5fgPaBNl0EVRK6fPm+ePAPHaRS0+Foj/rMWXAFx2OpE5LcG2FkfQJXwnZ
	OEaX5WHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uR2-00000004mcC-3M6q;
	Mon, 21 Apr 2025 16:55:56 +0000
Received: from mail-pg1-x561.google.com ([2607:f8b0:4864:20::561])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6uQz-00000004mbT-3lh0
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 16:55:55 +0000
Received: by mail-pg1-x561.google.com with SMTP id 41be03b00d2f7-af50aa04e07so374504a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 21 Apr 2025 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745254552; x=1745859352; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uwb+nOHiz3v41n7Ozb7A7o5HskDoeZoACSb6waE9l20=;
        b=CUSzc8wgXlp8xP291BZLbeGdqllSawSZgWpeKOToykdWp8QNqQQGHqDrgeJV8nHqnE
         tOxKt3+rRkXO7+DiQqbarRrDXOH/iSHn53zHJRhTi+s5qY0bEcQGwFIhi4m24YW0fOCs
         u76yJUcYhmrd1IeEHunqlfFVDuJz6jJPzl5PISBlmkolOSrakRbGHL+iWIRv4eI/Qqm4
         HthJt9X9lGgypQdpw8u26aILlg2WaAQ0NvYjBiv1E80di5BIA3mhKC4tQF/YNP0tklr6
         uZ4l4rotKeRaPlk93ezvikb9hEjCphGQIKTqcrv9H5YGHUtmBAmpZ6IMhZcrL1ZGC2dl
         npAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745254552; x=1745859352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwb+nOHiz3v41n7Ozb7A7o5HskDoeZoACSb6waE9l20=;
        b=Ay3IDZpKF3rnVEA2wst2pNHVqtMASy7IYQYnKUCV8vuo38ekgA0vMO+CPBjWQAluit
         Q3qrDGR2UMZ/RZV65A+nk3nJFEMh9C0P8+3D6nGhWLRn2CPOWi5lezPFBeMWTDIGa26D
         hsoPFvzfmf5Zpd4dLfu3HV9OF5rqTkM/Tx3ejLqxq6GPDOwUT6LXrQq5Sy/dPfaEwCtr
         N01b3lXWdDdouPHqCajmaESsrVi7Bk91SOROmnS3hA1WzrUsH3lb+Gd55438Y9QVk6i+
         pQfgytRHG9NjkPAelmmoU0bEixJ9ytvIVW2svohD0S8Fsjy2EdiDixYih93cSerBCCg8
         ZO7w==
X-Forwarded-Encrypted: i=1; AJvYcCXmncvJqokQk+ueTPatMhAgI7T43brkNgQUNmFuOcbWk2ZCOOlNU/Hv+FHSMIpm2mZc/RhOOo0Uji6S@lists.infradead.org
X-Gm-Message-State: AOJu0YwARg6hjm5rUIWgbI1zxqt+dxQmrSITAy3u7LvjSsc7iUX38rmi
	M9F8WLe5b/HAyQV0Yrg/sYdv9LGphj5YpxIaPH4wvaql+FPrSjZ1dQB2lCmu9pEp1O3sD2TEUrZ
	xVy8PZfq7w72yZ98Spif/K5HGlc7dra7opamXTJyHXsW05col
X-Gm-Gg: ASbGnctaQy3HU+29yOyfmPZJNbREwfM2mSj1pHBTpkkkpKVTpXlNd2p0dGU+pvzbLzk
	Teg6ydC9pJqeVr1bhUpH5W6joD0hvQHsXzklRJeh63sxKgyg4/LaOUXgWNK2nZOmvxmUb3ULzql
	+vI31NcbXU1nLIojBMg3KTU5VK6tKrNPucD1/HRr0iXKV0R3IZ/QDmTiS8YYYdKTWPn0G2ktgIV
	GQM43eSAUo6C1jJag/9puDNiqpy+ewfDKwBl3TQ3LvQk6V0BTCUvsXVZnfaGfzi123ehNdEDWjz
	ij7HezF7j1Um/1PRaE7cNziPys2nig==
X-Google-Smtp-Source: AGHT+IG85z2G3DWzfdnI9ROt0oPEDic7f7+JD3nsO3clnZLEeEYh/yLrcOV3fXTUKsric5qazxM88Hpm8ub9
X-Received: by 2002:a17:903:1948:b0:223:5e86:efa9 with SMTP id d9443c01a7336-22c535b4b97mr70058485ad.8.1745254552596;
        Mon, 21 Apr 2025 09:55:52 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c50d80d81sm3912055ad.96.2025.04.21.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:55:52 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DAC983401B8;
	Mon, 21 Apr 2025 10:55:51 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D4F04E4151A; Mon, 21 Apr 2025 10:55:51 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/2] nvme/pci: PRP list DMA pool partitioning
Date: Mon, 21 Apr 2025 10:55:23 -0600
Message-ID: <20250421165525.1618434-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_095553_936845_05F48707 
X-CRM114-Status: GOOD (  10.06  )
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

 drivers/nvme/host/pci.c | 171 +++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 73 deletions(-)

v3: simplify nvme_release_prp_pools() (Keith)

v2:
- Initialize admin nvme_queue's nvme_prp_dma_pools (Kanchan)
- Shrink nvme_dev's prp_pools array from MAX_NUMNODES to nr_node_ids (Kanchan)

-- 
2.45.2


