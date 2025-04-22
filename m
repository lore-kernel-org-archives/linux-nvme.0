Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84C1C369D1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5ll9KUN256iJ21I+GFr1dexXL900a9tJZDKmP40gJo=; b=ZajaZh+kBQ4rGflwNvNDCQhMqM
	F1K/QOyRAF4DxspXYOlDuT1eSlqe5G14O7lvRDvXZ2hvxAtxUGGMa06I5okZXIxzVygfxA1StIeiS
	BLRcfgYJ1XESsgfzi15ZRxJqBgpE5As7wv4k7gAHAlrVlTtyFYECFQar5c0k9fvdL1shLWfd84PLW
	b6R8dJ7VVhgRZUfPeafukvm6Eyi7RvgOM356HYhVp2cUWFwYkCrtHqirmBRFAJJl991ILVaguHCMx
	ZXSionENKcGyiUIWNeDVqthjtIeSgdENBub1H7WloY4/tsUOJ6mhQcg7qS+fz3q+SZ313Qd174aFb
	HEjZPV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7M4S-00000008iN5-3WRI;
	Tue, 22 Apr 2025 22:26:28 +0000
Received: from mail-io1-xd61.google.com ([2607:f8b0:4864:20::d61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Lob-00000008g6E-3xDO
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 22:10:07 +0000
Received: by mail-io1-xd61.google.com with SMTP id ca18e2360f4ac-85b52d6e034so19215539f.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745359805; x=1745964605; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ll9KUN256iJ21I+GFr1dexXL900a9tJZDKmP40gJo=;
        b=VmOqdhu80bqCUriAEHojt6KX7Bk4LatTJBfv3antfnXdBGXgobq03iqgy157JZCbuJ
         sefOw6s4ADpb3Lzph96/3eGOzrbi4fW969IRjINlsiYi014RzrJVbKI5G/QBBRclfQmc
         b+Hme8S9hrgqQxKZeOVw7uuD1Wik6blabtGC9nnvnOIvYnXHTqktCrYR/FjeMUwE3IGM
         wa42padk4kYRJxl9fQBYwUDUphYHh+9ezclYBc4uFrUuDUdnwrgzuLbR6gmyCJgdnG/9
         ibiICiW3Ol9xQLgcXTv4cBqyvRMXL29UdLUB+FUNXEYvfRmgTBu0R8dpp8KEfX23yGVD
         MSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359805; x=1745964605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5ll9KUN256iJ21I+GFr1dexXL900a9tJZDKmP40gJo=;
        b=dcGZT6E3wmFkgfXPWlME7CaJ7ZLXAaYmOFZgVote+Vm2VITwTozHB5BMKeQDncyEGC
         aAmbbaNFIZ4PE8igKEEXrPMPPKB5GUqGLPZ1DSopUE2jqa3N6g1F//rtbFdZITJi9HgR
         SyLeMxnFIlywkQt/G8PiUm2fQDsA79dnKdioFGScpKZJhccwYKjsFc3Q1Yy3q47FetLw
         nuTsOQBN9DUAV4JVD37cS02hJJIFQxH2nPUsHhoAS/BX/sMvP+vppVjosJgPVzDL//Ek
         JVyKge3pimBGo14aweQGzwEYNN+tnUu47BOV1G0M5h+27j3V6DaAXbYsMAPmRc/dX1pm
         rfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ehpFGQPUEIxPmzYkfDvLY2ct0+O87PV0nLeXgP2jIYcdg6ivYIo6hi6ajCCwu4SXQj0CgJS1goZK@lists.infradead.org
X-Gm-Message-State: AOJu0YxARVsgQUrktFwBlf4m7hDPYTGhwBg/EnmoUXf/qcOFUGaiHYYc
	4tsc9czYlOsrQB1mW/rfLqmyzOrTPLyXTlD8cRQUZUEPMYf2uiRScnViAsLe197oJ2do3g2W+z1
	yPQU2WMaTr1PmOHDiQrcsl7oo8zGZw+em
X-Gm-Gg: ASbGncs6sU846xWOBQ9VBEn4ddpY5BJIyPDQdANM/aaWNK4FeEqjBbxgUl/hxQF1Hiu
	rzV6i8ZDxmOpi93E+GauU7QZi+3GTKeNg5SgkJ6JIyA+GatAgAe2BrrpE2eliAWnU9wDwI0v18F
	I6zr+TlvJCUgxjo1Iwt3MUqpPDXit+DoJouL4K0hPz5rG4Cx1psNvcxqukxf2V0efVbZevJ7Jq4
	XmijQJwOUvvmirRaJn8aRfvWkoUZrTE5oEbDltPzvghTSC+oAAl0K8eliJCe2NBCPtbaCvljArr
	A91odNBz87GIzYXg44YQCfWgZxCTpylqhFi2Aii+tXL0
X-Google-Smtp-Source: AGHT+IFCxmBnf+7bB+8snSPZXOEPm4CxZ2zCnH5FCszcDPwSNWzfbpsF/Z45o37K/MtwkopN3C+v+VzcppIo
X-Received: by 2002:a05:6602:6b06:b0:85a:e406:5836 with SMTP id ca18e2360f4ac-86443b6e18emr25784139f.5.1745359804831;
        Tue, 22 Apr 2025 15:10:04 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-86444829859sm1350339f.31.2025.04.22.15.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:10:04 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7E813340159;
	Tue, 22 Apr 2025 16:10:04 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7B817E41D69; Tue, 22 Apr 2025 16:10:04 -0600 (MDT)
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
Subject: [PATCH v5 2/3] nvme/pci: factor out nvme_init_hctx() helper
Date: Tue, 22 Apr 2025 16:09:51 -0600
Message-ID: <20250422220952.2111584-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250422220952.2111584-1-csander@purestorage.com>
References: <20250422220952.2111584-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_151005_983781_3B26B581 
X-CRM114-Status: GOOD (  14.13  )
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

nvme_init_hctx() and nvme_admin_init_hctx() are very similar. In
preparation for adding more logic, factor out a nvme_init_hctx() helper.
Rename the old nvme_init_hctx() to nvme_io_init_hctx().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..642890ddada5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -395,32 +395,33 @@ static int nvme_pci_npages_prp(void)
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
 	return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
 }
 
-static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-				unsigned int hctx_idx)
+static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data, unsigned qid)
 {
 	struct nvme_dev *dev = to_nvme_dev(data);
-	struct nvme_queue *nvmeq = &dev->queues[0];
-
-	WARN_ON(hctx_idx != 0);
-	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
+	struct nvme_queue *nvmeq = &dev->queues[qid];
+	struct blk_mq_tags *tags;
 
+	tags = qid ? dev->tagset.tags[qid - 1] : dev->admin_tagset.tags[0];
+	WARN_ON(tags != hctx->tags);
 	hctx->driver_data = nvmeq;
 	return 0;
 }
 
-static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-			  unsigned int hctx_idx)
+static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+				unsigned int hctx_idx)
 {
-	struct nvme_dev *dev = to_nvme_dev(data);
-	struct nvme_queue *nvmeq = &dev->queues[hctx_idx + 1];
+	WARN_ON(hctx_idx != 0);
+	return nvme_init_hctx(hctx, data, 0);
+}
 
-	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
-	hctx->driver_data = nvmeq;
-	return 0;
+static int nvme_io_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+			     unsigned int hctx_idx)
+{
+	return nvme_init_hctx(hctx, data, hctx_idx + 1);
 }
 
 static int nvme_pci_init_request(struct blk_mq_tag_set *set,
 		struct request *req, unsigned int hctx_idx,
 		unsigned int numa_node)
@@ -1813,11 +1814,11 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
-	.init_hctx	= nvme_init_hctx,
+	.init_hctx	= nvme_io_init_hctx,
 	.init_request	= nvme_pci_init_request,
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
 };
-- 
2.45.2


