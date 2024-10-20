Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD843D3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iPWhP6OHEaFSPkCp6KWcw06R7n0lXN0yz9sGWxrtqU0=; b=gnaJ8pBes6hUXFMgYU8GKhbOD1
	MVFvJI13yG/a0KyvsuRrZFIamWJYoJ+9TyZYyiUnrKIRMrLCa3IkOVR54SBpm68BA/2OC8YhJLHkS
	DcNDWG4qc74RO2TEAqisU9zkqTER89MUpFHK3EaU19gVZexuh93T4e9E2Fq9OWXsjfTcEgW7oOSHm
	Ko/5up7LUwHw9xht7IHQzRuc01eWZeVn/ZYxP8M37nY2hQk/4GahqITzvYjSFtShgY/tCw0b9UgUY
	kU3Ac+OIHVBYBLA1QN+rz8wmhuhMZfqWBTBKPEyI0R5wvkzuaWN1wR3UbouyllGzmg4mw7ziK3MHY
	ZcbQc5kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2YZf-000000056Mu-18sx;
	Sun, 20 Oct 2024 16:14:35 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2YZb-000000056MQ-2pSu
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 16:14:33 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-20c803787abso27881505ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729440870; x=1730045670; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPWhP6OHEaFSPkCp6KWcw06R7n0lXN0yz9sGWxrtqU0=;
        b=Pge2+877lmSPYXaIfH/NmUmJiuGrC+rdW5eSw3cJTxuq1dABD28CaGfiqrkzps3mtd
         AaT5p3sWZaTpOIWN9hWg5Ney7CyBVn4H2LZ3i2EDrWU/xnrsUaRiBI2Afz1Wr7KJHuJn
         mgQq8qJFaGCh17WfdS7rfhplrbG30+rxLBkbMVYGLLgvqfQzY7FyBsR2C5fF4gc7DkRO
         6NgDnNvbKleiQDzQ9zuhdt4nEFScePzLuEaIs1nF65c3uKSC0Qqi23sez9inHvmJJtOq
         DHQIJ9w/tLso84EIf+S759mndYC5uFsmv7OADO/lRYEs2s3DC6x1Uo67lUiy6gf96wAq
         Ccxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729440870; x=1730045670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPWhP6OHEaFSPkCp6KWcw06R7n0lXN0yz9sGWxrtqU0=;
        b=oOU9FDnmERQxfA+2JEfbhbjw+2rH42WIME2UqkVP0feftnB3gBMwiSiWGEnSmJZU6l
         IPM/jzxKdilDRz3KFODW/bXmX2KfT7kY54QBUBhN/Cn4qV4Z3hQllkcfDJclyZEj4O9Z
         VIcetJsEsTFibYlolVJagFgyKkwukaf03eD5h5y5BaJQzJE3VxeJLOzuqkvKGItXeDrU
         LQGRFAjhbDxhy8+ah690sc6iL/5kaGzhut3IRhZ7/vEgyDL3E/f5djOlIq36lvwz7Adg
         7exDWy29TRd/mvzE5zkv4gGBaqDhGKOu8gO+4kL6LmTlx9ZXcz4pfkHVK/XbQtQK9KCn
         GM2g==
X-Gm-Message-State: AOJu0YzlwaIh4JtHCTzJQDZCm/nxN5EwVM/laQSIJ8PSTo46lyAHUc/f
	Lui2rh8RwuTWw1qqLw5yppHEs6ma+O5zZWIb7AgizO/jBMvWv4HrqhUpRSkpiu8=
X-Google-Smtp-Source: AGHT+IFL0B0xex+GJf11xNkzfqX325GkJl6JB8eAbOFPhhv27ak2VO9ma1dvwaWEpRlEWLTQybmRNA==
X-Received: by 2002:a17:902:d4ca:b0:20c:c48a:efe4 with SMTP id d9443c01a7336-20d471eccd1mr221588075ad.4.1729440869797;
        Sun, 20 Oct 2024 09:14:29 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:97b6:9c7f:15cc:b0c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee62b1sm11895635ad.48.2024.10.20.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 09:14:29 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: use braces for list_for_each_entry() loops
Date: Mon, 21 Oct 2024 01:13:22 +0900
Message-ID: <20241020161423.225237-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_091431_737584_08C54B24 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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

The loops contain more than a single simple statement.
So just fix to follow the coding-style process.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/multipath.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6a15873055b9..a335d3d65edd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -58,9 +58,10 @@ void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
-	list_for_each_entry(h, &subsys->nsheads, entry)
+	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (h->disk)
 			blk_mq_unfreeze_queue(h->disk->queue);
+	}
 }
 
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
@@ -68,9 +69,10 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
-	list_for_each_entry(h, &subsys->nsheads, entry)
+	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (h->disk)
 			blk_mq_freeze_queue_wait(h->disk->queue);
+	}
 }
 
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
@@ -78,9 +80,10 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 	struct nvme_ns_head *h;
 
 	lockdep_assert_held(&subsys->lock);
-	list_for_each_entry(h, &subsys->nsheads, entry)
+	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (h->disk)
 			blk_freeze_queue_start(h->disk->queue);
+	}
 }
 
 void nvme_failover_req(struct request *req)
-- 
2.45.2


