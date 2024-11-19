Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE0DD44150
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dP9K1xCe3x7QngHbD7VKt4NIpaWi7nUk7H9PVbWTde0=; b=tt+NGU712nBj39CKsqgoR3bq2r
	Rg8Mx9ue6TRWM+/n7u6yDCnucvtUzCqDKbJOgAs76LNEQV3pGyGZi6BA+uEJqgJDJjgNH0HJ7JHYJ
	sVcz+q3siZmrNeZnDOArYKoHqjjpO4s/jENawKyGINnJJlNtJ9zOe9u/UxX3XNWkk5ghWBkyJdpw4
	EaKgcrZasJehZOLF2K9maU5Ac2dsZdE8C9DznXxi8WQEvtujC5llJa34XZbK6G+xZz3lNc2RiQdkQ
	8uMd6vQTp2g+fb441L7uMd/kJ/vpXsii3vITtojpzc+RqPZaLpFPmHpKTkSWpHVbM2jCOuam4jyUP
	6ps4A14w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAO-0000000CJKF-1in4;
	Tue, 19 Nov 2024 12:17:12 +0000
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNAM-0000000CJGE-0iRu;
	Tue, 19 Nov 2024 12:17:10 +0000
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
Subject: [PATCH 12/15] nvme: add a nvme_get_log_lsi helper
Date: Tue, 19 Nov 2024 13:16:26 +0100
Message-ID: <20241119121632.1225556-13-hch@lst.de>
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

For log pages that need to pass in a LSI value, while at the same time
not touching all the existing nvme_get_log callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0d058276845b..b61225201b47 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -151,6 +151,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -3069,8 +3071,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
-		void *log, size_t size, u64 offset)
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi)
 {
 	struct nvme_command c = { };
 	u32 dwlen = nvme_bytes_to_numd(size);
@@ -3084,10 +3086,18 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
 	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
 	c.get_log_page.csi = csi;
+	c.get_log_page.lsi = cpu_to_le16(lsi);
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
+		void *log, size_t size, u64 offset)
+{
+	return nvme_get_log_lsi(ctrl, nsid, log_page, lsp, csi, log, size,
+			offset, 0);
+}
+
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-- 
2.45.2


