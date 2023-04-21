Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0EDC7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nzB2tRHUMpY4/jWB4OcD6fcV69kfby6bK1LT2yyBg70=; b=ww+oRkfH9VbF23MDrIzL7vRsQ0
	wr9A4uxCdzoVqzbBF5bwJ6OnUG9k9C96uxFoRr1d009yABDbrHGoQeCsGB3wrkse/fLGaLQ0knTmb
	5OMV3nJSoI75Ab/oqsXXNMXUQa2I7RzXP7Ut8gik7vSNRowBkii5OJQGPYy+pXHqGkbeBE1xtr+fW
	eRV52f2BNv9F2N5uTZjRmv0UQxGxSZ92Cg7B2qpkwIENuXtMog22lKQE3rKHUbegq+V/7fhdtQrHo
	V3kX2HcjMDV9UBkGuY2Ud0+XKMiX+270qF0gfISlgKbseH+w+QRhxENju8t9+wU7TEybPCQiMt3iI
	rAh4KtSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pplpA-00A4Dm-13;
	Fri, 21 Apr 2023 08:08:56 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pplp6-00A4D8-1q
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 08:08:54 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1652684b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Apr 2023 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682064531; x=1684656531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzB2tRHUMpY4/jWB4OcD6fcV69kfby6bK1LT2yyBg70=;
        b=g9kfim8d+Vk0mQnBvIOH4ImhS4V+c+JFV4XsRodLvmi576g3CWkjVBQhiGve+JGO2W
         ciCAzsUNG6deM3sUmB/IDi4J/OXFFlxbV5xXsg7zLhoZIE98++44wg9UQERwzuAUL+TW
         B39puxyPpjQn2Vi5j5bG6sTYfvF0kGSXTTX/J/WS0rDlz0iN6EOE3ep7dQqIdyWPG3xY
         frCXhqUOSHuwedCyAjnB0jumW6e4zHKAmD3+KxpdaXXClaiQWZmVQ+ckXRVDNSX5iKWU
         7wL0K4yqLUV8EYdhWs4yY/xjMIZAj+BdP2avNaal+Fsw6zl1wDdNqWHDfpS0xfLE/v04
         WpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682064531; x=1684656531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzB2tRHUMpY4/jWB4OcD6fcV69kfby6bK1LT2yyBg70=;
        b=Ax/8rDET6UlTAJ/b4r5Lh0Z8Io+ud/MGTa4iXCdNQos1smaL3VCI7MpCCkpE3Qwu4h
         lLcO6FzmFboxgWcQRdHoxXhvX9sF9XpolhkADpJIOwQb6GmADiKrYassWl6VqQt/BKUm
         0+c4wYTKZhjc1pwwVn53v9uzxSW4F/VSbdXUUH7n6kds0UO/nLN0bVB8CEcgRhf9dVxj
         7DMEvaW1dA0E80g7jsAviKJOtAn1vKgvHcpsJ6lrHKTVs4vaalJPWw+DqoLneUwM7/4G
         6N/ywAEsJAibtB504ggRa2Sf7NXJQNLkhru5YL3xPcbvXg3sY2/AXjBmo872pgBV+l/m
         GrHA==
X-Gm-Message-State: AAQBX9cxMzg6BZZu4tRg5mR3ciqLYLAz7+L7yLmuZ1rIA2t8dW9gQAIB
	eFPVFpl/lzdn39NfuEA8koSRrfzGeunSiA==
X-Google-Smtp-Source: AKy350YGRd1wzVogkJKU8OrquqXB6g+GXFM2plXr4/0HV+QHcdO7zKGrsiRb3HrK+iYKL1k9vhhJtw==
X-Received: by 2002:a05:6a00:2e8b:b0:63c:6485:d5e5 with SMTP id fd11-20020a056a002e8b00b0063c6485d5e5mr5501907pfb.22.1682064530738;
        Fri, 21 Apr 2023 01:08:50 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-221-73.dynamic-ip.hinet.net. [220.143.221.73])
        by smtp.gmail.com with ESMTPSA id c139-20020a621c91000000b005d6999eec90sm2416817pfc.120.2023.04.21.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 01:08:50 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA optimized limitation
Date: Fri, 21 Apr 2023 16:08:00 +0800
Message-Id: <20230421080800.18837-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230421_010852_629495_6B3895F9 
X-CRM114-Status: GOOD (  15.62  )
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

From: Adrian Huang <ahuang12@lenovo.com>

When running the fio test on a 448-core AMD server + a NVME disk,
a soft lockup or a hard lockup call trace is shown:

[soft lockup]
watchdog: BUG: soft lockup - CPU#126 stuck for 23s! [swapper/126:0]
RIP: 0010:_raw_spin_unlock_irqrestore+0x21/0x50
...
Call Trace:
 <IRQ>
 fq_flush_timeout+0x7d/0xd0
 ? __pfx_fq_flush_timeout+0x10/0x10
 call_timer_fn+0x2e/0x150
 run_timer_softirq+0x48a/0x560
 ? __pfx_fq_flush_timeout+0x10/0x10
 ? clockevents_program_event+0xaf/0x130
 __do_softirq+0xf1/0x335
 irq_exit_rcu+0x9f/0xd0
 sysvec_apic_timer_interrupt+0xb4/0xd0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1f/0x30
...

Obvisouly, fq_flush_timeout spends over 20 seconds. Here is ftrace log:

               |  fq_flush_timeout() {
               |    fq_ring_free() {
               |      put_pages_list() {
   0.170 us    |        free_unref_page_list();
   0.810 us    |      }
               |      free_iova_fast() {
               |        free_iova() {
 * 85622.66 us |          _raw_spin_lock_irqsave();
   2.860 us    |          remove_iova();
   0.600 us    |          _raw_spin_unlock_irqrestore();
   0.470 us    |          lock_info_report();
   2.420 us    |          free_iova_mem.part.0();
 * 85638.27 us |        }
 * 85638.84 us |      }
               |      put_pages_list() {
   0.230 us    |        free_unref_page_list();
   0.470 us    |      }
   ...            ...
 $ 31017069 us |  }

Most of cores are under lock contention for acquiring iova_rbtree_lock due
to the iova flush queue mechanism.

[hard lockup]
NMI watchdog: Watchdog detected hard LOCKUP on cpu 351
RIP: 0010:native_queued_spin_lock_slowpath+0x2d8/0x330

Call Trace:
 <IRQ>
 _raw_spin_lock_irqsave+0x4f/0x60
 free_iova+0x27/0xd0
 free_iova_fast+0x4d/0x1d0
 fq_ring_free+0x9b/0x150
 iommu_dma_free_iova+0xb4/0x2e0
 __iommu_dma_unmap+0x10b/0x140
 iommu_dma_unmap_sg+0x90/0x110
 dma_unmap_sg_attrs+0x4a/0x50
 nvme_unmap_data+0x5d/0x120 [nvme]
 nvme_pci_complete_batch+0x77/0xc0 [nvme]
 nvme_irq+0x2ee/0x350 [nvme]
 ? __pfx_nvme_pci_complete_batch+0x10/0x10 [nvme]
 __handle_irq_event_percpu+0x53/0x1a0
 handle_irq_event_percpu+0x19/0x60
 handle_irq_event+0x3d/0x60
 handle_edge_irq+0xb3/0x210
 __common_interrupt+0x7f/0x150
 common_interrupt+0xc5/0xf0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x2b/0x40
...

ftrace shows fq_ring_free spends over 10 seconds [1]. Again, most of
cores are under lock contention for acquiring iova_rbtree_lock due
to the iova flush queue mechanism.

[Root Cause]
The root cause is that the max_hw_sectors_kb of nvme disk (mdts=10)
is 4096kb, which streaming DMA mappings cannot benefit from the
scalable IOVA mechanism introduced by the commit 9257b4a206fc
("iommu/iova: introduce per-cpu caching to iova allocation") if
the length is greater than 128kb.

To fix the lock contention issue, clamp max_hw_sectors based on
DMA optimized limitation in order to leverage scalable IOVA mechanism.

Note: The issue does not happen with another NVME disk (mdts = 5
and max_hw_sectors_kb = 128)

[1] https://gist.github.com/AdrianHuang/bf8ec7338204837631fbdaed25d19cc4

Suggested-by: Keith Busch <kbusch@kernel.org> 
Reported-and-tested-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
Changes since v1:
  - Clamp max_hw_sectors at lower level driver code per Keith's suggestion

 drivers/nvme/host/pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5..fa351c56d690 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2914,6 +2914,12 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	size_t max_bytes = NVME_MAX_KB_SZ * 1024;
+
 	if (node == NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, first_memory_node);
 
@@ -2955,12 +2961,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
-	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
-	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
+	max_bytes = min(max_bytes, dma_max_mapping_size(&pdev->dev));
+	max_bytes = min_not_zero(max_bytes, dma_opt_mapping_size(&pdev->dev));
+	dev->ctrl.max_hw_sectors = max_bytes >> 9;
+
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
-- 
2.34.1


