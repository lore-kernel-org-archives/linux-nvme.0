Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1988BD44148
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gIxXCn1b8yRUHIv/Q/T8s0ufDNDjaj42bcMFpNpW0/4=; b=HDEUeouEYDIzhK6b7k/Ej4Fbj1
	Y8mVDUpTMHzWtXu9BCxWyX9g9RVn+ekRxdiEj5WFEwTSNazGdj0Asp6kX55LQI1wzipcM0U5kR1tN
	ikNaBiaikjA+/+ZMAHJx1u2yC0AE745LXjVsmzT2aLluOz4eHMTIa1aZJ5FJ3cSRIM8UP7glcItuM
	VNsHkyEMpGUK9pzKnyLWbY1vvqX/LMzh2Zgg3Pf6jY1kvbJg3boZVNAK2tbsB/d+1FRF6cJoDsOhm
	06tmwEdKiMISpcv6eUffSAsJ+u+e3DFEF106lbX4GuhBOp9btOLkcO1w9CFXmJvY8aDE7qhdmD+tv
	eRhceMaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAL-0000000CJH9-2E7D;
	Tue, 19 Nov 2024 12:17:09 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAJ-0000000CJDT-1zwp;
	Tue, 19 Nov 2024 12:17:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH 11/15] nvme: pass a void pointer to nvme_get/set_features for the result
Date: Tue, 19 Nov 2024 13:16:25 +0100
Message-ID: <20241119121632.1225556-12-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119121632.1225556-1-hch@lst.de>
References: <20241119121632.1225556-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

That allows passing in structures instead of the u32 result, and thus
reduce the amount of bit shifting and masking required to parse the
result.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/nvme.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d194b36b08ac..0d058276845b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1671,7 +1671,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result)
+		      void *result)
 {
 	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
 			     buflen, result);
@@ -1680,7 +1680,7 @@ EXPORT_SYMBOL_GPL(nvme_set_features);
 
 int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result)
+		      void *result)
 {
 	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer,
 			     buflen, result);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b916a904f00..8cea8416b0d2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -892,10 +892,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		int qid, nvme_submit_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result);
+		      void *result);
 int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
-		      u32 *result);
+		      void *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-- 
2.45.2


