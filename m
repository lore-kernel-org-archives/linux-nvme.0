Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D80C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mYbBV90oldDuiaZ93LZje48sMdn1tlLnLGiHR/5Kdrs=; b=hRpC+lozaRghv2cOtVlBVLATKc
	VNjiNis+UEZ3dtcOqa9GdhBTaGYbjPojP7+GT1J/VxjFS4ti/fTdwFYzZomJFZIes54qjLUuNCSic
	Tn62S2riAQAcX+BWSkAPHf4SX1sSGScyzMpWz+Pf5iJSUM6Ek5rKQy8iWH1SxNbKClFinYQuICHRY
	aaYRgawdOWHecV0VEB+0LyaG3byC8MHYiAjvoFKiYHDItfEVIBrJP44mYR/0AfubJvVfMHIl4qOHJ
	ZM0ajFv86MTFG0ZWynxkk0jCPLLmh/NmzmaXiz6P+Ea4DKj9tFz1Ub/9ili32aL/VsAMTobzo9afE
	XC6TQQag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB7j-00B74d-Dv; Sun, 13 Nov 2022 11:26:03 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6O-00B6QC-Im
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:42 +0000
Received: by mail-wr1-f51.google.com with SMTP id j15so12421442wrq.3
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYbBV90oldDuiaZ93LZje48sMdn1tlLnLGiHR/5Kdrs=;
        b=v9EGOVIGfywxST85yN2ZfjHtmIiGkM3VYSRGhHFuTTKCvKOTMtdOPO/+LMVJ36y4Gq
         72wh0QbsW0aYZcOY929X8DwN0nebK12+P35/9sV3Av295M833zjYBhQoubedMCDEd77O
         uBddxQCZuMsCkgO+n6mYHF3JuD5xcPiplRBhU5uVrX8rxP/wDDzoyY1sPbup6+Q+a0Ms
         kiiIm7/1GCn2J/bZX+8DKAhXWD6dHH4FDl70/7wbTEG+Wp0QEsLYcMKUyFFQC6Kt6OdA
         8hp97FxkoFTWD7TcRbeGYeaH4zbFEZ5qcioMH7zv/pQuv5qudPZu7yCjEM3XHbkAMnJc
         6JaQ==
X-Gm-Message-State: ANoB5plkI0IezLmNup5lc9UqEJnfCx256ILmn6RnXe1gWfq1YKI2pErB
	rBhRRgjKXCzk4pkTPJomhGEQIG6QFcI=
X-Google-Smtp-Source: AA0mqf51OixeYozBZEncYqnhUr7tZYznyawC6zTZ3bPP0kwiebk5KcNcRde+BBwpo6Isc/yUJmFeCg==
X-Received: by 2002:a5d:4568:0:b0:22a:e51c:458a with SMTP id a8-20020a5d4568000000b0022ae51c458amr5411116wrc.577.1668338678670;
        Sun, 13 Nov 2022 03:24:38 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:38 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 10/20] nvme-auth: guarantee dhchap buffers under memory pressure
Date: Sun, 13 Nov 2022 13:24:14 +0200
Message-Id: <20221113112424.1049834-11-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032440_656441_C385B649 
X-CRM114-Status: GOOD (  16.44  )
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

We want to guarantee that we have chap buffers when a controller
reconnects under memory pressure. Add a mempool specifically
for that.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 30 ++++++++++++++++++++++++++++--
 drivers/nvme/host/core.c |  6 ++++++
 drivers/nvme/host/nvme.h |  7 +++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4d288333b0fd..4bfe9ecda12a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -14,6 +14,8 @@
 #include <linux/nvme-auth.h>
 
 #define CHAP_BUF_SIZE 4096
+struct kmem_cache *nvme_chap_buf_cache;
+mempool_t *nvme_chap_buf_pool;
 
 struct nvme_dhchap_queue_context {
 	struct list_head entry;
@@ -675,7 +677,7 @@ static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 	chap->transaction = 0;
 	memset(chap->c1, 0, sizeof(chap->c1));
 	memset(chap->c2, 0, sizeof(chap->c2));
-	kfree(chap->buf);
+	mempool_free(chap->buf, nvme_chap_buf_pool);
 	chap->buf = NULL;
 }
 
@@ -701,7 +703,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	 * Allocate a large enough buffer for the entire negotiation:
 	 * 4k is enough to ffdhe8192.
 	 */
-	chap->buf = kmalloc(CHAP_BUF_SIZE, GFP_KERNEL);
+	chap->buf = mempool_alloc(nvme_chap_buf_pool, GFP_KERNEL);
 	if (!chap->buf) {
 		chap->error = -ENOMEM;
 		return;
@@ -1027,3 +1029,27 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free);
+
+int __init nvme_init_auth(void)
+{
+	nvme_chap_buf_cache = kmem_cache_create("nvme-chap-buf-cache",
+				CHAP_BUF_SIZE, 0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!nvme_chap_buf_cache)
+		return -ENOMEM;
+
+	nvme_chap_buf_pool = mempool_create(16, mempool_alloc_slab,
+			mempool_free_slab, nvme_chap_buf_cache);
+	if (!nvme_chap_buf_pool)
+		goto err_destroy_chap_buf_cache;
+
+	return 0;
+err_destroy_chap_buf_cache:
+	kmem_cache_destroy(nvme_chap_buf_cache);
+	return -ENOMEM;
+}
+
+void __exit nvme_exit_auth(void)
+{
+	mempool_destroy(nvme_chap_buf_pool);
+	kmem_cache_destroy(nvme_chap_buf_cache);
+}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f2ae4ae33d68..b75e8433c3b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5356,8 +5356,13 @@ static int __init nvme_core_init(void)
 		goto unregister_generic_ns;
 	}
 
+	result = nvme_init_auth();
+	if (result)
+		goto destroy_ns_chr;
 	return 0;
 
+destroy_ns_chr:
+	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 destroy_subsys_class:
@@ -5378,6 +5383,7 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
+	nvme_exit_auth();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cc314f45ddee..e8eff9edf7f5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1019,6 +1019,8 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 }
 
 #ifdef CONFIG_NVME_AUTH
+int __init nvme_init_auth(void);
+void __exit nvme_exit_auth(void);
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_auth_stop(struct nvme_ctrl *ctrl);
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
@@ -1026,6 +1028,11 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_reset(struct nvme_ctrl *ctrl);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
 #else
+int __init nvme_init_auth(void)
+{
+	return 0;
+}
+void __exit nvme_exit_auth(void) {};
 static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
 static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
 static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
-- 
2.34.1


