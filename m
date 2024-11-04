Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7697DD132B5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=noss4JzKSmsBngEFnQJcUyJxc5mA+0TM8Vx3hh7eYas=; b=B8VsZZdQ+NzzsZSWt8cPGoFB9H
	kzax/nVUps1GkVen+gUbLMDoD5AGeviWnl6zdIQLz2+0m2yEtZLpQFVMBnXMwPKcvAC3zoma5zRT6
	kE0CfAB2MFqscoTna6MhSUBMDWprOgQEyOZP/RNBGGU3b9nOgQfayp7DvbfxiyhQO9zNDyybkBCjz
	nNkMIe3yRhRcjUGhu4bIajhA3dGGVS+0aBuM9OAizujUU1XrFPPUf+eh+5j8Ob3JrP/PVSbo4R40a
	TDLchDlypgVjw7q8Xq5p0RGvM91xg9CulvwVNUMxKtUZ56EEIC7wLnA7eiOfCnJledpZyl54VSEUC
	lAIY3k8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7wAG-0000000DhIJ-33Bc;
	Mon, 04 Nov 2024 12:26:36 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7w8i-0000000Dh7n-1Rvc
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 12:25:01 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso699148866b.1
        for <linux-nvme@lists.infradead.org>; Mon, 04 Nov 2024 04:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730723098; x=1731327898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noss4JzKSmsBngEFnQJcUyJxc5mA+0TM8Vx3hh7eYas=;
        b=pzDlikCvZkd7jRqW7UCj4WqMpUKwg731Vx08tI1+oDaR6J5k6aSGmBpxK5CdtuclaP
         6DilW8i/GARWyo+HJHRCkE/K7ys2fgYf5ZgcCZc7euSpntb+xm0M7FQZLZECQWY7ZzB/
         cjXcMvwHfCYM/FHEQnBFrpS7y9nuGanxGkToS2KWNY32NHbXUUPxEspjo8/rF8lgoFnD
         0TBelVb3UoQaO04JXn2D2j1u3FiWEGmpxQ4zNf9z7PnnFK7lrSrT4NpPBzbGQ7nITT2g
         UG/FV2KbbH7nUy6wAbiu4YARuCGWfJo8Gh3/LkZqMjoBR2n8AfjoL5OCCs1m7HnMl8ym
         ZspA==
X-Gm-Message-State: AOJu0YzTsnrBMOVx1BD+i46a7gZQHF6nLWoVXlCVAT1agdhDnEOzeuk6
	lDTVTFDzANOfqXHJGkSl9y5foHQ9wLl6061mMR+o7fxPtT92wZma
X-Google-Smtp-Source: AGHT+IGom24GOsnZKz6VayrnkwHTK9IsOyw+hmLZpO+PThRjb8M4Xrqczs2ChZQUUPF5sy3LVE9DRw==
X-Received: by 2002:a17:907:ea0:b0:a99:f9d6:5590 with SMTP id a640c23a62f3a-a9de6331185mr3195394366b.60.1730723097614;
        Mon, 04 Nov 2024 04:24:57 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5668491esm544932466b.204.2024.11.04.04.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:24:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 04 Nov 2024 04:24:40 -0800
Subject: [PATCH] nvme/host: Fix RCU list traversal to use SRCU primitive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
X-B4-Tracking: v=1; b=H4sIAAe9KGcC/x3MWwqAIBAF0K0M9ztBpYe4lYgIm2o+slCKINx70
 FnAeZE5CWd4epH4lixHhCdTEcI2xZWVzPAEq21tjK5VvHceU7iUs40Orbad4xYV4Uy8yPNX/VD
 KB4+D6dZaAAAA
X-Change-ID: 20241104-nvme_rcu-8250c60278e6
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3965; i=leitao@debian.org;
 h=from:subject:message-id; bh=hMnNvV795UWRRyeGynz3zzxGFDq7gm4n+LsNUESRa5g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnKL0YI6M+hK8w7iHenAB5FxQUv8SBDtrAwnrZd
 cX6CyvRLfaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyi9GAAKCRA1o5Of/Hh3
 bTBMD/9aSUmUCp5S0ckOCcGfb13sTp7X8To3/7fBfml9HauKYJF5l+04zV3EU9vEDMIGpW/YxWN
 K75B9DO3tVEk2bIzdI3mq458dtXmfJ7MEs5MeYDkJSNFih7PssJ+qtWGcB222O7e0OuWjv3B2l9
 D+EK52k/y41/pxi5XFoQkHRgf7qWfZRa5FcvZ3YYzE3w9vkPU5wxmFNJN0nVfl74PQ/buB0G+vo
 e0XLkTqOywNwUxU8qfHc6GrR2AjupqjF1muCJDzZ5jkwnD65cKZeOyUXCC/bqGRw9P65Xm9d2NX
 EBUqak2rA0B2QHIjhV9qFXKXlkiD1neAN+jrLfhgXaZt73ENOqWNvu7tsdUIFjuOkDRXtJoiH8x
 QvAhww0YRT8YuynBi3LFlVS9mUAXkkjD5Eq4dscIMatNDKGkER/kJhwRqaUoWEHgwXpghoTKcbw
 S7ae4s+JdtrPDNPBt2+MYvCdmpgh14uesrZBKNFm4P1bJ2QdsTNWG27coH4c+VEE3L1cOlswvzA
 A+2ZHapIxMwVLLUQ7JqA/aX9wki/7Yv3ktBVhJpN6MVsBOQsaDehlrfkJqwDeEH47Uisv9ZzZBk
 YiSvLao6RDFPk2mJEqdrs1v7xw9rxNhw7E42BluOgB9WV86KJSuPlifQndHpYBA7eaQ7ktNV43I
 LWUJkkFCPFqio9g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_042500_420845_590D2146 
X-CRM114-Status: GOOD (  13.27  )
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

The code currently uses list_for_each_entry_rcu() while holding an SRCU
lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
enabled:

  drivers/nvme/host/core.c:3770 RCU-list traversed in non-reader section!!

While the list is properly protected by SRCU lock, the code uses the wrong
list traversal primitive. Replace list_for_each_entry_rcu() with
list_for_each_entry_srcu() to correctly indicate SRCU-based protection
and eliminate the false warning.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
---
Something similar will need to be done for multipath. I will get it done
once I get some feedback about this patch first.
---
 drivers/nvme/host/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d09dbe71b2f1ac473ae687c4dc687..3583bae69ef74c6f1fe6d465531a9a09512a6f13 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3767,7 +3767,8 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		if (ns->head->ns_id == nsid) {
 			if (!nvme_get_ns(ns))
 				continue;
@@ -4851,7 +4852,8 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_mark_disk_dead(ns->disk);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
@@ -4863,7 +4865,8 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_mq_unfreeze_queue(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
@@ -4876,7 +4879,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
@@ -4892,7 +4896,8 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_mq_freeze_queue_wait(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
@@ -4905,7 +4910,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_freeze_queue_start(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
@@ -4953,7 +4959,8 @@ void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_sync_queue(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }

---
base-commit: f488649e40f8900d23b86afeab7d4b78c063d5d1
change-id: 20241104-nvme_rcu-8250c60278e6

Best regards,
-- 
Breno Leitao <leitao@debian.org>


