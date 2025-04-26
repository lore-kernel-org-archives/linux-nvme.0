Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCE3C369D9
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Apr 2025 02:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sPxqdCfTuK69NF/+HUMCbay3LkIJWJ0+Y27AGW3mB5w=; b=A7y/c6fwEeY8fRuzBHPPwiQtaV
	EmyNseEjc2bg+PbnPSpYWbQHGyfy91SK+uahos00o1e2cWEaHH57mlgboy/gHSyn9A0bQXeI1yw4c
	XXZQ7p+0UQ0GyqMCGTLMGDL/rjrGtgNnXzddw4o0pUpgHL6El2GzHOkTR8YybQnVIjweNgFxnHCtd
	27YS1jEyV5GC+4c+Rs5W4tOYiEXzcJrS1u5iUXiEJanOOKvdnPYHmkIt4RHP53ikwlFLAEG+aT9lL
	tduS42V1E+EkS8ZTyAQsIK/T1mAUsk6KylWVuU3XEjdA3Ac/lPpkBYu6knl0xFVcbQ6pny8HHX2QG
	LG05aYPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxT-00000001HqW-0RPH;
	Sat, 26 Apr 2025 02:07:59 +0000
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxQ-00000001Hpa-23aY
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 02:07:57 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-225887c7265so4964505ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 19:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745633275; x=1746238075; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPxqdCfTuK69NF/+HUMCbay3LkIJWJ0+Y27AGW3mB5w=;
        b=Q9Ifi2SqwPpcAfKQaOgYME3faZAF7OmDMf7qHRPbmi0fxDBvRNb0KywmS5MxcKwW29
         7YFc3XmdeTElrG81vYQ99nkW+AHjy1yQhL23Efrrw7qwpD9FE/uLsvu7bXM3nEOjoZ5x
         VEwWLv1ZbpmFAOb8kuP1gpgQukb4i8rMOCKf6gMIqXvRULegKwGkPegAjn9vjCiFI5/K
         kndBnngb4TGbhdnY2k79UJoZH89eXzr0KXo1QRkCNJhZShMK4LN77UC5nG63Lu+0pr96
         SgL8dfatCKWmDGGbEAWvLpT2zNNqwf39uqtDxGLCHW0oD3StayrYJDQKGxbMNbgb5ksu
         HUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745633275; x=1746238075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPxqdCfTuK69NF/+HUMCbay3LkIJWJ0+Y27AGW3mB5w=;
        b=J954Wpl/DvW08OgcWPf4Yr/TlbgccvAsoCXikVYSYIj6HUXJzp43g/fPQrxrKJmrqy
         sFuIuq+TE7h6K8txfcRLLMcgYOn2gU2kiPpqqYnsgpPqMFybC4pi+95qf6emn30o7Y6M
         B5SD0IY0E6U2ru8PT0eWqfZirDdA/qez0FHT4dMQIUMqhGc/V2Dlg8Vb7XH7eML8Jq4q
         etjgb7BWoN2HB1exwSHUGBOj8EJiZi9jgrtzlH5wh8jVpVFV7RBakJQzcPdxGjBvfo2i
         ThC3g6uXMYxpIBYcafxP1AJLEo8+iyKC/PBjTpqu6pjxvVf9Y8As9TiGTKGtHL5sSYYm
         MbTA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLZiIX8n6sPubTk6uF3dnIZSs8jWFqsRwjP2OyxiWXzNZzpDB1Y92JpHWEL6zFxOp1simpWYixCUv@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8EL2j5gIKH9QIc+rc2+RfHVAjeGatFztEcJMSewWHeWHZm792
	1hirzB0uQ+c0e0m4sJPd8N5pus/7tvcZdonTNUTesoF33q52M33pa7mK/5sFL/9G2hjGpOZhBG5
	XhmvMic8rUTuxY1OTFHrajGlvB1gi/WRTxP3erYWsmGP0OwoP
X-Gm-Gg: ASbGncsF1C2J5Aop6KfzS/4z7/aVAkkHrMbiWIhAu97QzII+44I8CsZfO+0ZJsOvYOK
	zSjQII6mZnVd5m+jSRMtD/K8ZZNGPJ3G56DiMdpIBglQmM48g1+nmY5CQAVK12Z2X4+TESNVo8d
	8y0Ycc+BbkvalB5RC1UKvHgxIijZom3iCXMa5bDo3OnVYJ51vV9BfAeSkRAmD5gMKYbEMisSdyI
	5uc+TUQOuhjWnDq7wqTg8gAzdD5mtJwizQIIsbZ72PbZRl/soscz/47m9aGUdsPAZLjZgsLnICI
	Dm1LPOfCemeD/muSO/nE1SmniAN+xA==
X-Google-Smtp-Source: AGHT+IFJ+vxaCgBpvVNBnx5B9FTFi2A9sP3f/GstK6F+GJAg/un/9eKqg76budhFn0fn15Cyl/ImHI7SsnmI
X-Received: by 2002:a17:903:2a88:b0:223:28a8:610b with SMTP id d9443c01a7336-22dbf740e51mr24627175ad.14.1745633275567;
        Fri, 25 Apr 2025 19:07:55 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22db4d9ffb9sm2054505ad.4.2025.04.25.19.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 19:07:55 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E4FCB340231;
	Fri, 25 Apr 2025 20:07:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DF47EE41C66; Fri, 25 Apr 2025 20:07:54 -0600 (MDT)
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
Subject: [PATCH v6 0/3] nvme/pci: PRP list DMA pool partitioning
Date: Fri, 25 Apr 2025 20:06:33 -0600
Message-ID: <20250426020636.34355-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_190756_680398_B6CC420F 
X-CRM114-Status: GOOD (  10.57  )
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

NVMe commands with over 8 KB of discontiguous data allocate PRP list
pages from the per-nvme_device dma_pool prp_page_pool or prp_small_pool.
Each call to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool
spinlock. These device-global spinlocks are a significant source of
contention when many CPUs are submitting to the same NVMe devices. On a
workload issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2
NUMA nodes to 23 NVMe devices, we observed 2.4% of CPU time spent in
_raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.

Ideally, the dma_pools would be per-hctx to minimize contention. But
that could impose considerable resource costs in a system with many NVMe
devices and CPUs.

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

v6:
- Clarify description of when PRP list pages are allocated (Christoph)
- Add Reviewed-by tags

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


