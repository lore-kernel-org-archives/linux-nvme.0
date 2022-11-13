Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B889C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XR5MttkmAlthlfQySr+lmNIPNu5k4E7CQtrEBCMQPwA=; b=KEhQ3vJJ36bg5KOcocddjgCWpC
	mFWn8FSO056En266oSliFBHmDHfbiXMVpJtgp/mNa/z1emeKzzSTT1JCqpP/xGQ+Y7S6Ey7SXfVdm
	TV629mSZvd6OX/+4BH8Lu/NIYP996edvdZrTUFmM9MtgO7wyA3GNSpVussjwpQJ2nDfe24RMlBw27
	kupS5GYsWcDmT8iJTLGltgjCAyiOpsEugJqqyvehWwpju44oDZXS+l49x+04KfPfUzTt43W3qhbKG
	yNj3tzaZSY6hBLy7yGcDKwtOwml1XqPOU4obtvrCAwTbtJ3w9xVIk7Pz/hKnoSUxGuKm8D9nMGB4i
	lyifwHUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB9b-00B7pF-1c; Sun, 13 Nov 2022 11:27:59 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6U-00B6TE-Ks
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:47 +0000
Received: by mail-wr1-f46.google.com with SMTP id v1so12368695wrt.11
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR5MttkmAlthlfQySr+lmNIPNu5k4E7CQtrEBCMQPwA=;
        b=6tvSvd2IQdLWCz7XxozxaSvErwnBkrKUDUyTzg3kaBc14sh2a7yLW6Z6qQVaPR0jL1
         nH9Ch70g0ltHWvnTHoyNlJwOxNNlDpGw5DoVDoGrdzjFgskAO+KmSWcQxDdtNo7YDFIK
         zTEyG1x6oFdWl2QpJkCdX30wC8+hVQuz0OVZU3KmqgtklqLCZr5mqF0Qy7uLhJEBbsYw
         THA2/jraNFAM6pVqScSYQkJXDglzQ9h1dDQlhFAydGiUtvOqtsXLFyx9kB0mdn6l/QgV
         qTRALXF/JhndCGBS7tJQe5Zc83G8PAnB8bUAlG+i+K8aGfxo9PrwfVAT5sPKhcNfr1Yz
         fR3Q==
X-Gm-Message-State: ANoB5pkutvgZa2EhfnpdNhSXs0KKu/S+wUKpc3EK1XwmAhinZ0o57mnQ
	N+Yb9Rn2RpimD2LNckDkkyl117W0L28=
X-Google-Smtp-Source: AA0mqf4y8lOJR6MLPNMWuxhN9j+8QP7mdzR8ZjT3VoRQ0kMcU3nn/Af87ww+XFusz1PcCJQX8euePA==
X-Received: by 2002:a5d:564b:0:b0:236:6613:afe6 with SMTP id j11-20020a5d564b000000b002366613afe6mr5074403wrw.702.1668338684758;
        Sun, 13 Nov 2022 03:24:44 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:44 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 15/20] nvme: move nvme_dhchap_queue_context declaration to nvme.h header
Date: Sun, 13 Nov 2022 13:24:19 +0200
Message-Id: <20221113112424.1049834-16-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032446_704947_A83326FD 
X-CRM114-Status: GOOD (  13.24  )
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

We are going to have an array reference from nvme ctrl, and we want
to avoid a casting on reference.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 28 ----------------------------
 drivers/nvme/host/nvme.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 2bcb33c83534..5fad1b6f8439 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -17,34 +17,6 @@
 struct kmem_cache *nvme_chap_buf_cache;
 mempool_t *nvme_chap_buf_pool;
 
-struct nvme_dhchap_queue_context {
-	struct list_head entry;
-	struct work_struct auth_work;
-	struct nvme_ctrl *ctrl;
-	struct crypto_shash *shash_tfm;
-	struct crypto_kpp *dh_tfm;
-	void *buf;
-	int qid;
-	int error;
-	u32 s1;
-	u32 s2;
-	u16 transaction;
-	u8 status;
-	u8 hash_id;
-	size_t hash_len;
-	u8 dhgroup_id;
-	u8 c1[64];
-	u8 c2[64];
-	u8 response[64];
-	u8 *host_response;
-	u8 *ctrl_key;
-	int ctrl_key_len;
-	u8 *host_key;
-	int host_key_len;
-	u8 *sess_key;
-	int sess_key_len;
-};
-
 #define nvme_auth_flags_from_qid(qid) \
 	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
 #define nvme_auth_queue_from_qid(ctrl, qid) \
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 136582c80ee8..8bd7554b68a8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -188,6 +188,37 @@ static inline u16 nvme_req_qid(struct request *req)
 	return req->mq_hctx->queue_num + 1;
 }
 
+
+#ifdef CONFIG_NVME_AUTH
+struct nvme_dhchap_queue_context {
+	struct list_head entry;
+	struct work_struct auth_work;
+	struct nvme_ctrl *ctrl;
+	struct crypto_shash *shash_tfm;
+	struct crypto_kpp *dh_tfm;
+	void *buf;
+	int qid;
+	int error;
+	u32 s1;
+	u32 s2;
+	u16 transaction;
+	u8 status;
+	u8 hash_id;
+	size_t hash_len;
+	u8 dhgroup_id;
+	u8 c1[64];
+	u8 c2[64];
+	u8 response[64];
+	u8 *host_response;
+	u8 *ctrl_key;
+	int ctrl_key_len;
+	u8 *host_key;
+	int host_key_len;
+	u8 *sess_key;
+	int sess_key_len;
+};
+#endif
+
 /* The below value is the specific amount of delay needed before checking
  * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
  * NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk enabled. The value (in ms) was
-- 
2.34.1


