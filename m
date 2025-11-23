Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306D7CFD316
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6XYP6M4yTt1qmMNVTJGvjFxmCyRCFcZp21DmV1BJvo=; b=tDPGymgm/M5NM5OyXOUMNwJf0h
	bbHZn/aRDsBsDxadpV2PBnox3NbgxhCN66OOObu1nDOjuU0tpPGoe9qk92FWE/gTEdJ5nwo8UOiq9
	E5yry9vhbj2cfFmvfhu/EzFWDZyewD2MGR7B7wmrVx3ycFct0rxAgVYFH8RSjcCKqBE8JmPVFWyWH
	BsRibmrNKdCw2jwiNmYsuIHLDsuuLraEDxBJ/7C7LHQhlRKIa4g+6lnxunMdZ0Z17XTrJNfo9tGVZ
	6WcoJ2bVDQmCZNzvG7MTnSSZtN8fd8l1cHxAwy4uZ7485Rk0lNdUSJvCRteEIVi4FFMSZ+wwkyWpM
	2KeZ+rCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIw1-0000000AknD-2A64;
	Sun, 23 Nov 2025 22:51:57 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvz-0000000AklC-1Yff
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:56 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-42b3c965df5so1865955f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938314; x=1764543114; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6XYP6M4yTt1qmMNVTJGvjFxmCyRCFcZp21DmV1BJvo=;
        b=TY4P9dLcHKUhPveK3pzWkyqCULmKN8QDnM5IXf53Gyq+zmD6jrxTTWOBL95RIq2Jpf
         IpRQki7Ak4tCEufIX11431CZb4gYiDuhql7Kf8I9j7vPbAOthpR5oOgHB0wKsYbmSP+1
         I1CWTcfEjFZtcgystEt/p/OQvTcPEa6DgxCngTQZMcEgSKOY33GCjxJIzusSpoamliut
         syOAfg/JJoZoc/TNfPcq1KMwUNQJfeitqtFyOdCs2DgrQIQphUdrRbhhbO1RueQZ/wLk
         2uqDHXZh+zlILcCH5xQ10U2ou8K/L5+aWXo9xpzWs0No2LnJ2NG/FHNt7d1LO/CraHAC
         zUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938314; x=1764543114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o6XYP6M4yTt1qmMNVTJGvjFxmCyRCFcZp21DmV1BJvo=;
        b=KP5rxX08Sjq8NcWUjkrBx4fpQGwUlXE18zZX4H9Yi/P51juMGRFeml5W/4egc7KnZA
         YRMdnPZRcjZ4A298Cqma7N/nbN1DbD2E7oJAZXcvk3WGSSreayFazgKveRsYqUABMnCw
         sJ5YN179kKZ5LBsu83kDH704xPaXUY4S2lkXj3tMSkLlO/1/KTjoRx+PSxaln43dPYb0
         9OBEocnfRzhgUND+pVqL1RsnjfHRx3r+ouJlZjT8X3YTwiPs0fK2NZZRY4UWJiEpFjMd
         naQyL0s+4LjElXxEitfRgpJ8RybU4DmVHP9bHTQUAEO9uP66GJNg4iWNOJG1pwRZfwcZ
         NkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgIeK6enRtxQZ+JdHFHt3Icgaldzp3dEhG92MTTGL6anhxMn8wU+nfEVar6KaxeGQwWfseQSsNctze@lists.infradead.org
X-Gm-Message-State: AOJu0YwIbbI8PiREF/cb/htEHUmnBokYZW3zB1fpvm7ljvQ+wZflguVc
	0iPfKxJJUmG9+qvjLcNXLpOHthYobJ7jse3G4gbcoowPu55Jspzo0vXM
X-Gm-Gg: ASbGncup1Jh/LK1SeO6UhJQveY3r+tr5VY1U9LLKN0vbcEZ9wPmfww9qUh/DmidzRkp
	6EFQq9MUhH4XAyLmqt9WDTi7E1YzW25uu5tqE/gkfB2uZW/ZiWbsMTVfquqaHZ4+a++jRk2h1RR
	dQnoRrf15Ny8hX9zpKVIjsdOsvp8VOj/Yo+z0XYC9FwjsddFulps2PCtifvMbR16O0wcsoP2pN0
	PFMsZYLEN834qx/7m4OGw4ZVspFWljGWiPyBqud8D56M4R0YSpCf0+wbfw2j5GWDK79gtJ/y+EM
	M3/8pQs9OFvvPjmJQY0pWBLRD0DAXBc2uWvmPmx51HqRrb1cSkp9fwPY5YxXQt7pvuA7Mrt5kQQ
	tkqUqPz+WULotSFS+EeNSMheQ+gau2/SKjTNG9rlYQN/EPB7S8ww/aXbEPKcxK/ta2Z2buB8kF4
	aGpBzK2FzDowlfYVyZktc06+Mn
X-Google-Smtp-Source: AGHT+IGE0ZjscP742EdyKh9uzu23uLZ3l6gi0agALTuRuYrf+rNDfvZsYNVo2p4Uu5MAT2Id6+WoIQ==
X-Received: by 2002:a05:6000:1447:b0:3ec:dd12:54d3 with SMTP id ffacd0b85a97d-42cc1d0c37dmr9157966f8f.35.1763938313681;
        Sun, 23 Nov 2025 14:51:53 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:52 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 06/11] nvme-pci: add support for dmabuf reggistration
Date: Sun, 23 Nov 2025 22:51:26 +0000
Message-ID: <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145155_437426_E62ED407 
X-CRM114-Status: GOOD (  15.93  )
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

Implement dma-token related callbacks for nvme block devices.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..63e03c3dc044 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,6 +27,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
+#include <linux/blk-mq-dma-token.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -482,6 +483,92 @@ static void nvme_release_descriptor_pools(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_dmabuf_move_notify(struct dma_buf_attachment *attach)
+{
+	blk_mq_dma_map_move_notify(attach->importer_priv);
+}
+
+const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
+	.move_notify = nvme_dmabuf_move_notify,
+	.allow_peer2peer = true,
+};
+
+static int nvme_init_dma_token(struct request_queue *q,
+				struct blk_mq_dma_token *token)
+{
+	struct dma_buf_attachment *attach;
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
+	struct dma_buf *dmabuf = token->dmabuf;
+
+	if (dmabuf->size % NVME_CTRL_PAGE_SIZE)
+		return -EINVAL;
+
+	attach = dma_buf_dynamic_attach(dmabuf, dev->dev,
+					&nvme_dmabuf_importer_ops, token);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+
+	token->private = attach;
+	return 0;
+}
+
+static void nvme_clean_dma_token(struct request_queue *q,
+				 struct blk_mq_dma_token *token)
+{
+	struct dma_buf_attachment *attach = token->private;
+
+	dma_buf_detach(token->dmabuf, attach);
+}
+
+static int nvme_dma_map(struct request_queue *q, struct blk_mq_dma_map *map)
+{
+	struct blk_mq_dma_token *token = map->token;
+	struct dma_buf_attachment *attach = token->private;
+	unsigned nr_entries;
+	unsigned long tmp, i = 0;
+	struct scatterlist *sg;
+	struct sg_table *sgt;
+	dma_addr_t *dma_list;
+
+	nr_entries = token->dmabuf->size / NVME_CTRL_PAGE_SIZE;
+	dma_list = kmalloc_array(nr_entries, sizeof(dma_list[0]), GFP_KERNEL);
+	if (!dma_list)
+		return -ENOMEM;
+
+	sgt = dma_buf_map_attachment(attach, token->dir);
+	if (IS_ERR(sgt)) {
+		kfree(dma_list);
+		return PTR_ERR(sgt);
+	}
+	map->sgt = sgt;
+
+	for_each_sgtable_dma_sg(sgt, sg, tmp) {
+		dma_addr_t dma = sg_dma_address(sg);
+		unsigned long sg_len = sg_dma_len(sg);
+
+		while (sg_len) {
+			dma_list[i++] = dma;
+			dma += NVME_CTRL_PAGE_SIZE;
+			sg_len -= NVME_CTRL_PAGE_SIZE;
+		}
+	}
+
+	map->private = dma_list;
+	return 0;
+}
+
+static void nvme_dma_unmap(struct request_queue *q, struct blk_mq_dma_map *map)
+{
+	struct blk_mq_dma_token *token = map->token;
+	struct dma_buf_attachment *attach = token->private;
+	dma_addr_t *dma_list = map->private;
+
+	dma_buf_unmap_attachment_unlocked(attach, map->sgt, token->dir);
+	map->sgt = NULL;
+	kfree(dma_list);
+}
+
 static int nvme_init_hctx_common(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned qid)
 {
@@ -1067,6 +1154,9 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
+	if (req->bio && bio_flagged(req->bio, BIO_DMA_TOKEN))
+		return BLK_STS_RESOURCE;
+
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
 	 * significantly improves performances for small I/O sizes.
@@ -2093,6 +2183,11 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
+
+	.dma_map	= nvme_dma_map,
+	.dma_unmap 	= nvme_dma_unmap,
+	.init_dma_token =  nvme_init_dma_token,
+	.clean_dma_token = nvme_clean_dma_token,
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
-- 
2.52.0


