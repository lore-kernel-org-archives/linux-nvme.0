Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDFBCD8C8C
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42lbift3GUSRsYsWcu6WULLrIkIIMX8MmeNmUG1RfTM=; b=3/zfAnuYv9CybcMJRzeFTzl9UM
	T+44mGodTCH43sipPUfQYd/XCfOKehg0IpCvjglt9XAbuUhp7raJ5dleqIdA9rN571eoPpnvCpt9C
	FTqkeu+Xc2tjq4Yh3TOvbZluoBcv6fpv82HANoAo27MybWc7bcJCZSPjiROY6ZF+CwEgpgAyzNJ6j
	hNtgBBzs3epLgksnboFe4yXXbHtDOGtc4/iCQtwIYgPsaXVh8f8vZz23PP37rroddOTNUxSjjxsTF
	NwiYMiR4Vg7OmA2JHzzhVorD/CrsPsuF5ZaZ2uFFjKNAj7ewYD5kKou8V/rLWPG4/15oYPvnhCfp8
	p3mL03zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVr2a-00000001cEZ-0BcC;
	Sat, 06 Jun 2026 13:26:20 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVr2W-00000001cAG-3QcY
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 13:26:17 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-842307473b5so2005733b3a.2
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jun 2026 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780752376; x=1781357176; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42lbift3GUSRsYsWcu6WULLrIkIIMX8MmeNmUG1RfTM=;
        b=SRsqjiE7wLRruSPilgEgUZ1Vvcor6hUf9DNsaE04oFFciVDq4ZzzdOJ3HxcUQmOIGP
         n2DOq1Y50axB4n+A1shvzkLq1H/Kbvz3eu5aHFAGg/L2/HGmFbyAQ2eLQRNNwYwH/+20
         0ZB1N6t1teuNEZdyfEniXJWA8xoDNmwN9i3g9Jw30xFp5S7Yw4O5nJZN3CGD6QkcS+c/
         mcwEjbQ7e2zU7EbWR3PsGYxaS/5mnPE8hOxOnPotzOzuhu5CKfQN332nlXfrndc2kz4m
         lMdptoYA4gvsEhgOxSdkI6oBLwkkCqNf1b+kJIWXBoFCxbChYTGfHP9SBi+WbgAKfheR
         UPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780752376; x=1781357176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42lbift3GUSRsYsWcu6WULLrIkIIMX8MmeNmUG1RfTM=;
        b=C2mCHyfMigoQJ8Yj0DpXQcfgjlCBFXLg1Jw1LkLpwOUzl+unSSFJM1S7avTd8psnj5
         FjhCtlWhDxfXTNJz56Wz0LZBHWof0O/AuqfoRoe64T9M0OXFrpGJozzh3W1VqqfCyvqt
         H/Pw0MvYCG2rZAIAzVOYb0g35vZP2gpH9RxJHY0QJNDtYSbn22MFVrs7LUTnR1r8kbfZ
         BzkpM2rT+xSa/Xu0ktNNhBb6n9kU81avTXUdiyJbo7BZ9ergS/oNyqVj3O3WdEsAOuGm
         Q4okgaP6Wi0cubYR/We/t4H9T3dW8zycO2qeHNHU2VZ5GCkmeN9NUyJX3QJkO4lSGlql
         mBxw==
X-Forwarded-Encrypted: i=1; AFNElJ+kpG0AqcyOHDnIpROq4Afz0BDDsG17CbdAL42gcSBvNmzWfCgV3Peet1i+oBKRHhWYKoaPoWCiS8Ue@lists.infradead.org
X-Gm-Message-State: AOJu0Yzuv9ofsO6aoSl4vEYZyTtyiVTgGNR9vLiM+ark8aO3FBK0FPJH
	FVG8hZcSo66BrowI+CTjGgkDS1rLnk/NoNp5frt4Dke1qoKf46xYRVfY
X-Gm-Gg: Acq92OEa98fciagEZQVj2zBq1FHBlT4Tf+JuRRd6MdpD79IlWFLsUW1SV1hDMVn1gXr
	RIwRfV0XtYik7SKRUq5D06dVHo6RJGx3bKdEqZKOLSTrLTc1p9HvmPJ5vcrNffRjZC085ZyDVnG
	41xpjo/n0aZuNDSD8apN0hkKdt7PGMY+AodHJmsvPKKzMpbb3kEnVGfCBIr1RdmsVITogK0YKLN
	14pjGUoHj31zzFXtg4eIv1a3CQWwwaIKcRUc5KhoK4Dv/RmgxYhM/0uPonKysqxkxv/uhZIPUSN
	hMCn+AnYzmfY7RP9ZCIOCyN267NWGfaCL3HMC4QgMFEjWbwGBTl8KNJAp36mh4cfZDh/uOPVigr
	QgLQ9PmNVQDfvvixnGBJMqCToDTfrPu/ae8xp6t731hrrm2s/XP0qtd7PloPQvwyYXJovJNvqIt
	uJcM+nIyZHBbP0CkN8Gj2bQ6gcS0CGzPRDzOLX
X-Received: by 2002:a05:6a00:4c87:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-842b0d4a0d8mr8693533b3a.11.1780752375873;
        Sat, 06 Jun 2026 06:26:15 -0700 (PDT)
Received: from [127.0.1.1] ([223.122.38.120])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-842829188b9sm12910688b3a.59.2026.06.06.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:26:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sat, 06 Jun 2026 21:25:26 +0800
Subject: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>, 
 Yuriy Havrylyuk <yhavry@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=bXuJzOynK1zfJuBlVU0RMP2QsgG1y48fTK+be2Wr0r0=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqJB/qdLOi84lIuVdy6NqUXI4/UNSlZb9mI5/IT
 TzMsAgCn/aJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaiQf6gAKCRABygi3psUI
 JCCYD/9ncU6Tq/2SE3eURPnZaKM+kVw7fBhpQAjY9+yQc/aPkV4qvYhN7uabU4XpKUOsCw0XmL4
 QjX+clJQRQ3x0ZutsbGUAE9xuC2BX5oUT6UVf7kFr+3QixZJVD2s3kC+noa8DdEaojRR1SC+5L8
 gLEc8CTiDTNqzk3VB/Tvu+2YP1uV+83zggrvi4SasU2wiKjhph9ccd0+sKtS9psNuas9W9TETJL
 LwpAwBJcSlsBCH6fZwI6bZl7IV+lKc4K+/kVDVysKsh1+S4Kz5lNoYE4fiya/aPRa6AojVohiRn
 lgtDpBoveWqFY+92x6g6BrBan2YUuht8Bn1Y4fkfLx7IfMzbFLr0GxrvP8Y6o08aF/WTS/JsXB8
 5jJ5mdavfE6DvflFCt/I8Onc5LqvcJ8kX0rcNgHY5JSATbkd/AjyJxiKVn4vO9zdHH6gqb3W6wp
 t86AS6Zq5SplBtxiRoYzbtjKwFI4lLtt+U27B7GcPAvwKL1eCumB4K8AW11xZFLtLa/SFlfZK9p
 rJSQpX4a6ldMMR3PTzRz6sAOmiaubhFXJDmZ9OYy/EbRICgvp0wTvf0YddUz+Gh4dFlUpMAKLJ7
 +n8bf5cY6855i6t87C7tlfCxfxCh4dokI9XjYDNEjU2835AK0lVGWTFx8zAQa1EwLf9DrXoBJ/w
 7/tbxNCNCdymomw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_062616_883233_DB60D07E 
X-CRM114-Status: GOOD (  17.35  )
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

From: Yuriy Havrylyuk <yhavry@gmail.com>

Apple NVMe controllers require tags of pending commands to not be shared
across admin and IO queues. However, on Apple A11 without linear SQ, it is
not possible for either queue to skip over some tags and must go from 0 to
the configured maximum before wrapping around.

If a pending command tag is duplicated across queues, the firmware
crashes with: "duplicate tag error for tag N", with N being the tag.

Instead of partitioning the tag space, which is not possible without
linear SQ, prevent tag collisions by keeping track of which tags are
currently in-flight across either queues, and return BLK_STS_RESOURCE to
temporaily block command submission when a collision would have occurred.

Cc: stable@vger.kernel.org
Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Signed-off-by: Yuriy Havrylyuk <yhavry@gmail.com>
Co-developed-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/nvme/host/apple.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c1115e27a0d6..6354edf27225 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -203,6 +203,20 @@ struct apple_nvme {
 
 	int irq;
 	spinlock_t lock;
+
+	/*
+	 * Tags of pending commands must be unique across both Admin and IO
+	 * queue. However, on T8015, unlike T8103, without linear submission
+	 * queues, it is not possible for the either queue to skip some tags,
+	 * and both queues must go from 0 to their respective configured
+	 * maximum.
+	 *
+	 * Instead of reserving some tags for the admin queue, use a bitfield
+	 * to keep track of pending commands on either queue, and temporaily
+	 * block command submission by returning BLK_STS_RESOURCE until the
+	 * tag is freed on the other queue.
+	 */
+	unsigned long t8015_active_tags;
 };
 
 static_assert(sizeof(struct nvme_command) == 64);
@@ -290,6 +304,28 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 				     "NVMMU TCB invalidation failed\n");
 }
 
+static bool apple_nvme_reserve_tag_t8015(struct apple_nvme *anv,
+					 struct nvme_command *cmd)
+{
+	u16 tag = nvme_tag_from_cid(cmd->common.command_id);
+
+	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
+		return false;
+
+	return !test_and_set_bit(tag, &anv->t8015_active_tags);
+}
+
+static void apple_nvme_release_tag_t8015(struct apple_nvme *anv,
+					 __u16 command_id)
+{
+	u16 tag = nvme_tag_from_cid(command_id);
+
+	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
+		return;
+
+	clear_bit(tag, &anv->t8015_active_tags);
+}
+
 static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
@@ -652,6 +688,8 @@ static inline void apple_nvme_update_cq_head(struct apple_nvme_queue *q)
 static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
 			       struct io_comp_batch *iob)
 {
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
+	unsigned long completed_tags = 0;
 	bool found = false;
 
 	while (apple_nvme_cqe_pending(q)) {
@@ -664,11 +702,26 @@ static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
 		dma_rmb();
 		apple_nvme_handle_cqe(q, iob, q->cq_head);
 		apple_nvme_update_cq_head(q);
+
+		if (!anv->hw->has_lsq_nvmmu) {
+			struct nvme_completion *cqe = &q->cqes[q->cq_head];
+			u16 tag = nvme_tag_from_cid(READ_ONCE(cqe->command_id));
+
+			if (!WARN_ON_ONCE(tag >= BITS_PER_LONG))
+				__set_bit(tag, &completed_tags);
+		}
 	}
 
 	if (found)
 		writel(q->cq_head, q->cq_db);
 
+	if (!anv->hw->has_lsq_nvmmu && completed_tags) {
+		unsigned long tag_bit;
+
+		for_each_set_bit(tag_bit, &completed_tags, BITS_PER_LONG)
+			clear_bit(tag_bit, &anv->t8015_active_tags);
+	}
+
 	return found;
 }
 
@@ -790,6 +843,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
+	if (!anv->hw->has_lsq_nvmmu &&
+	    !apple_nvme_reserve_tag_t8015(anv, cmnd)) {
+		ret = BLK_STS_RESOURCE;
+		goto out_free_cmd;
+	}
+
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = apple_nvme_map_data(anv, req, cmnd);
 		if (ret)
@@ -806,6 +865,9 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 
 out_free_cmd:
+	if (!anv->hw->has_lsq_nvmmu)
+		apple_nvme_release_tag_t8015(anv, cmnd->common.command_id);
+
 	nvme_cleanup_cmd(req);
 	return ret;
 }
@@ -1165,6 +1227,9 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	if (ret)
 		goto out;
 
+	if (!anv->hw->has_lsq_nvmmu)
+		WRITE_ONCE(anv->t8015_active_tags, 0);
+
 	dev_dbg(anv->dev, "Starting admin queue");
 	apple_nvme_init_queue(&anv->adminq);
 	nvme_unquiesce_admin_queue(&anv->ctrl);

-- 
2.54.0


