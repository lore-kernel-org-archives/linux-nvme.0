Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B5DD5B161
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Dec 2025 03:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WBg/4AM5DIHtP1QwW0mWXt6Lf66bW0IS17x3NMFN4PM=; b=GMks6OYyvahNiqqAFuoxlN4Enw
	jHee4btrilNcWZGE9zTD2z9KlvyNvcg49siU4+fpDJbN6sujr4tGmQFL/SSgGVTHm0HXjw+TeX4mt
	8SZgxVeQUMRQwap9M8mA2m7eQjxAay8mIORgQiPUALaA7qt1SLa32jtWanurak1w0E9VavDdqSFUp
	2we8Ypei3qTlxv5ur0Cf2G2wUanPCj64/HHA+lenFTcQDN+SyQfhuH01LGGF8Ck+eXmmxNMekupiB
	uxko6Iz0+zJHORXBQ1YTEcfDm9QdMZpdIvFamYq1VERTtkV6/hw4c8urcjBMzh3ncHE8WmJrXcTXK
	/p0YODuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLmP-00000004d1M-09ng;
	Tue, 16 Dec 2025 03:31:17 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVLmK-00000004d0s-0Mmn
	for linux-nvme@lists.infradead.org;
	Tue, 16 Dec 2025 03:31:15 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so4380498a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Dec 2025 19:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765855871; x=1766460671; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBg/4AM5DIHtP1QwW0mWXt6Lf66bW0IS17x3NMFN4PM=;
        b=EwvqL/BuPpYFLiS+0EdFdNhSEh2sC3vKxnf/aetWquwyNN8S61YqxOlqUPDXntQcC2
         U0AqUaM3vyrkgWNwu5doBWyG7nxzHJ7ibpLqEvtlowFIrcDSnbtiy6XBNSvS58X1JMyb
         v8jrzPUdtY3tZqwLcYEGyP1TQxeVdUoCJxXvKa0uavs/Dtf2PGxXBAEJv+SEK33UKI9f
         djVxumOtdYVYQpcIGwCHy92X5Q49Zf1fPOcK624dRBslB6yC8pumJn5grcy5g25u1ZLI
         ae0rIYz2sCZDy2TtX7gPXAAPMEQzm55oVnnUNBhcg44mOzrO1fI74NTUn8LtZsM6XYCO
         m3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765855871; x=1766460671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBg/4AM5DIHtP1QwW0mWXt6Lf66bW0IS17x3NMFN4PM=;
        b=PbMtZCGkPMu1NoO2E13HzSoZLZty1eXvj2zJyjsNlgDcGYU9hbk9a4n0TKUuMq6n6u
         TsdLn8VWe1JdAIaIFXJDOHx3Z6pB0aD/t2ncX3sNdqhOZ32CFtzSd7ROcixOelxqJ0vd
         UcbFnZ1PtFiELvbCEla8uZdxiW0YQA8zVaBC7VrXBCVfFGQD+dngJTkSfkHvqJLsGeFW
         6RxpTcldH7TNXGmOYeEvqYaCjrFuCkzmO6PbE7/4V08/1SNsFT2LOtRil7MASyT0juFY
         qRKF6mUAMfeemuG+3yzRY93L2Z9MRmpEttD/D+dxiGmsDuILJjSQzqvIHaQ8/XVzhitX
         H0vg==
X-Gm-Message-State: AOJu0YzqvEJZIirssaNZgUXGu0TyQSfjy5xe8uMk4S2ZRQthz/BhEJPK
	4cuhU5FcYMSsXpuItWX7zEu5cPyc7uyBt3AWGUF1zrPeaBl7rxW5Uy/r
X-Gm-Gg: AY/fxX6QZBYEPqEk9FLQI3rs0VxNL4zB8kxzMVJvH8ue9pT9C3n7mhn6al4M08vmq8w
	f7fzHO1nADEGz1kby0cw/GWXzAnNcXEpZXGkf2TTpWXE3D7M3/U3oLHzVXZPxXwNzSRBkDhdm+P
	YXQpROSg+7UfX/n+7cZTwoVa2YaWWrU/k800Wz9Il4B52D/DTaPqJOxQpSq2NryST93QvZXvsbd
	QAWPk+ZGsjTxV8cs6Fuin7sD8224yCTj7u5CyeDowG36iwPgnAiuZFSTijFrfpTnG5Gar1lwO9/
	gSGSieDP06qaLz4ambgSR/pcDQrZbKtL9CKTWtR/jb1JEJvGz2bZ+2EXUjP3XrjyC9hVlX94zzo
	PV9+SAGSbMjUgpjH6haE1CG7xOE5nPt9UrIc1pYcNc9IdtIwn1om8ucxiDjgIJM/sDecygnkfc9
	7G3iHcxZMC27veOz9v
X-Google-Smtp-Source: AGHT+IErh0jYVU5M05aSO86Lg++0GcoF4BaRoogaohEgdZRDHEvYu/r2FW5lvAJdjnX267tvLcl2tQ==
X-Received: by 2002:a17:902:f70e:b0:2a0:97be:61a9 with SMTP id d9443c01a7336-2a097be6574mr95492765ad.35.1765855871055;
        Mon, 15 Dec 2025 19:31:11 -0800 (PST)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea04b7bdsm145290875ad.85.2025.12.15.19.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 19:31:10 -0800 (PST)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 2/2] nvme/host: fixup some typos
Date: Tue, 16 Dec 2025 13:29:33 +1000
Message-ID: <20251216032931.1305349-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216032931.1305349-2-wilfred.opensource@gmail.com>
References: <20251216032931.1305349-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251215_193114_472752_AB70AEC0 
X-CRM114-Status: GOOD (  21.25  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/host/fc.c    | 2 +-
 drivers/nvme/host/ioctl.c | 4 ++--
 drivers/nvme/host/pci.c   | 6 +++---
 drivers/nvme/host/rdma.c  | 2 +-
 drivers/nvme/host/tcp.c   | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 68a5d971657b..b9d629ac2c83 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2513,7 +2513,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * writing the registers for shutdown and polling (call
 	 * nvme_disable_ctrl()). Given a bunch of i/o was potentially
 	 * just aborted and we will wait on those contexts, and given
-	 * there was no indication of how live the controlelr is on the
+	 * there was no indication of how live the controller is on the
 	 * link, don't send more io to create more contexts for the
 	 * shutdown. Let the controller fail via keepalive failure if
 	 * its still present.
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3dfd5ae99ae0..c152e9441976 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -271,7 +271,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
+			"%s: nsid (%u) in cmd does not match nsid (%u) "
 			"of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
@@ -696,7 +696,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	/*
 	 * Handle ioctls that apply to the controller instead of the namespace
-	 * seperately and drop the ns SRCU reference early.  This avoids a
+	 * separately and drop the ns SRCU reference early. This avoids a
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..7e0b7fab1e61 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -367,7 +367,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
 		/*
 		 * Ensure that the doorbell is updated before reading the event
 		 * index from memory.  The controller needs to provide similar
-		 * ordering to ensure the envent index is updated before reading
+		 * ordering to ensure the event index is updated before reading
 		 * the doorbell.
 		 */
 		mb();
@@ -2741,7 +2741,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 
 	/*
-	 * Freeze and update the number of I/O queues as thos might have
+	 * Freeze and update the number of I/O queues as those might have
 	 * changed.  If there are no I/O queues left after this reset, keep the
 	 * controller around but remove all namespaces.
 	 */
@@ -2910,7 +2910,7 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		/*
 		 * Exclude some Kingston NV1 and A2000 devices from
 		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
-		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
+		 * lot of energy with s2idle sleep on some TUXEDO platforms.
 		 */
 		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 20fdd40b1879..cccea72d2279 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -877,7 +877,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..ab349a5a054a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -26,7 +26,7 @@
 
 struct nvme_tcp_queue;
 
-/* Define the socket priority to use for connections were it is desirable
+/* Define the socket priority to use for connections where it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
  * possible optimization.  Making it a module param allows for alternative
@@ -808,7 +808,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			req->curr_bio = req->curr_bio->bi_next;
 
 			/*
-			 * If we don`t have any bios it means that controller
+			 * If we don't have any bios it means that controller
 			 * sent more data than we requested, hence error
 			 */
 			if (!req->curr_bio) {
@@ -2017,7 +2017,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
-- 
2.52.0


