Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09803C369C2
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Apr 2025 02:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/wVUCLEe+0hKn6q/c+4Hvm6QrjTginZMMcE5JFRhMDE=; b=N7micoD4MgOHJ0DYRhUKG1alBT
	r3Oug8XPduR8xPrGkTKzENTrlLVQTk24T84a1K2+L8MsWH/vWINmqxrWRejA5uyXPISw9tfyAANZO
	QePxKzLM1m6ma9F0vFQc2G/DiFT7FCE5wuqZNxGfcQXnQ5AQMVw2hAfOc0lFqilJZk3e6X1njiUx6
	2Kd70OSan4za9I3Z8zaqxdCMS0GS1uXhZK+CSOvBh4u+Z8tiWu6rXrtBpuU1+ZWVpLw6mbpE5+Krq
	sKnTuKHBb6M/Ekxj0Ay0Ah/C3A/M5hNkarZje4AxUWhtsk38Aslh+uG4EjePektEXjyXRYqIwiJ2z
	CAQdBYHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxW-00000001Hrx-1ERu;
	Sat, 26 Apr 2025 02:08:02 +0000
Received: from mail-yw1-x1164.google.com ([2607:f8b0:4864:20::1164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8UxS-00000001Hq6-2TKg
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 02:07:59 +0000
Received: by mail-yw1-x1164.google.com with SMTP id 00721157ae682-6fedf1d7680so1289327b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745633277; x=1746238077; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wVUCLEe+0hKn6q/c+4Hvm6QrjTginZMMcE5JFRhMDE=;
        b=ByZAezSH6jBlkZKn0P/q2rgghiv8yEiHmMsmxhg9Vxj8ahqRe8lRp1BnxUBnYGUu4x
         OlMB4DJMBbdVx8p88CgZOn8VBemcaIcF0lSy9zynazPwWMv9MjAq6olcKbpwYgxB2vtL
         YZ23eaxOrA/EeHdfJG4Ww9jgGxTFIqFQ5Dwrjj1npEUbYw/KMWiPiW4ImxsjjY6fzZ/U
         Iw/BVpF1aiQb/6AhxtuUCTCv9qUZUXHLLGfmFw3D5VLsZiYRerVJgpPNsiFai7d/v2zw
         yiZRbixGcNisU056bR3MrdsmuRIbKLHbjfa3bH2aHQ04YCmaAzCr1oIgH905a+qO+GsA
         IF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745633277; x=1746238077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wVUCLEe+0hKn6q/c+4Hvm6QrjTginZMMcE5JFRhMDE=;
        b=dLvdQOdaJkpPIQMq1Pm4lPHlIBC55AUO3mIeqlmJZkocNM2T3zf9dvHN2CjK9705s7
         EBinneGm/V3sMdc8ZM5Jipf3GZX4DWJrVlQTmtGLYf42mnWZhQGj8vpjxkE4HlFl5BjT
         9FOHWJ3kDoh/jeNRlh2mHWHuCYjbfLi5cQxjFC6JZNk1P0xqPsWl3bCxDwzGSDZwSVEn
         737wPw8Ijg9rcR9D2tgz4sHDzIOmV5uqbyPgKskx9pgiAuEsL2d06JJ5yEJ6VWf+o9Ao
         LP0eSU+Ja8rgEO/OxkrEApv1VkFtP7MThTbiPutQhlIxE9NzRhzsR1El9MzYjIUqPMWs
         ZE7g==
X-Forwarded-Encrypted: i=1; AJvYcCU3A62Ipo0sQXbvoqtWHdUhnnRuUKFTCgMy96U1cPnCQQwicU/hcrHET1dqsW/sDfh7TZQ7eL2X2Drr@lists.infradead.org
X-Gm-Message-State: AOJu0YxhjtrAxLkSYDq1rlXs20AxkZbVhtzN6jJ3u5HTfCBmQgtimsyt
	hRv0QJSMkzp6w/ISezSy/IEhrFXV56HfUo67HEKWISYuwI/MUWZZq0rw6cPsPMp8+0C1PVWbG/8
	X1o0elp1hM8mJISBwfKLbs2T4jbbF3JapVpMsesArxwlJ7jN3
X-Gm-Gg: ASbGnctU5rkxtPl2lh4C0rtHitfKdYzytC25k5z0OtkvuWp6v9fI7XVzarkJcXzR0CV
	2H2tjNXHDXFxmFFPtqPyuGHg8QauVtZ7v5QGiOwbVDizixeP2hD7f6+W5XZQBYw4k1UNKrg8swX
	VmmBZ77gfDoO+S9mFqdpvp/DrzDTLFPshhcGUd+5pBkY/dbTqPH0lrDVnCJhOaZSjQvon2aKy/y
	PJM7KLIU82bzcwNhSeRw0PS3Ob5AmNe15I+3y/quta8Phon+YV6p69tzk28mtGXgxRDVAdhdKWc
	eKxHs2TiIda5PXNLe/Zcai/s+U40JA==
X-Google-Smtp-Source: AGHT+IEOm9b947bh8wKZJPV8BjTdH67+qjOLV0pvz9iI2xoiPw02tnrnJGVgx5zAiKMvH1se85vcy5rkCyEq
X-Received: by 2002:a05:690c:10c:b0:703:b507:de77 with SMTP id 00721157ae682-708540e3d7amr28404067b3.3.1745633277254;
        Fri, 25 Apr 2025 19:07:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7084195d63fsm2366547b3.17.2025.04.25.19.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 19:07:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A07E7340269;
	Fri, 25 Apr 2025 20:07:56 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9E77BE41C66; Fri, 25 Apr 2025 20:07:56 -0600 (MDT)
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
Subject: [PATCH v6 2/3] nvme/pci: factor out nvme_init_hctx() helper
Date: Fri, 25 Apr 2025 20:06:35 -0600
Message-ID: <20250426020636.34355-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250426020636.34355-1-csander@purestorage.com>
References: <20250426020636.34355-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_190758_625763_D445D33F 
X-CRM114-Status: GOOD (  13.68  )
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
Reviewed-by: Jens Axboe <axboe@kernel.dk>
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


