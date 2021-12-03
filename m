Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1386C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 21:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jIRFGxrYQlPRm7z5eZ4R3P7jhnosq67mPO1H2y/DpmQ=; b=KSnNhyJ65yVs4/l6Ktvbjm6jyG
	EF4ozMhVkKrTEVRy2J8Pk+1PB0wcsMC1PR7tT1H1NTKEaiKKbF47xkdvBVbOVtQFfk1NtZLtBguKg
	2aSj+5Pb1de5ooYkvbBFCVzVml14m/Jvco/uWrE1PIG41B2t6adyAR63Uu4DEELsHk42F7t51kpIo
	qCamMeHxESncbRB/jogWf3hnQD1YheEM4I1sArGjFXDplRg1QLUmHPSS4YGFYUSGqXd2wG1xpG/iu
	6MpOem07z+djYVi6b+EHUJ2x1cO84vXnJrADt0xYXfkbikikTvpOrlWJSgQKNLwBsLiJwGqhIkJD3
	vTT7b3LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtGNb-00H3oE-Jw; Fri, 03 Dec 2021 21:46:07 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtGNQ-00H3lG-BM
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 21:45:57 +0000
Received: by mail-pf1-x431.google.com with SMTP id x131so4040679pfc.12
 for <linux-nvme@lists.infradead.org>; Fri, 03 Dec 2021 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jIRFGxrYQlPRm7z5eZ4R3P7jhnosq67mPO1H2y/DpmQ=;
 b=BpzKmP9l5WsKjZFs9SR9AjohNSkKzMg1wMi/L5sVHQlrqA8/vyWQkHbZhrqJ2ZG9nK
 kH4pRL3yClleD1r1eHKwPggfzl82OqELyv2hjMxGO6u6EZ1E5Ez2Nk+UHH88fkEdvzNQ
 gjXOxZyMJ0zpgj1LHvMBUiqvaH4NpTJHqXyYdn208/SyDspY3gIGI9odg+I+HaPcyttQ
 DwqpphZ/G1L14WFUXiOPiOrLHDKSyuBFUGLd7befto1KpBRq9y345ET19MQ+fNdUHp9L
 H/QJhojsf0kAMrM4W1a9VIZ8B+j3lcSOgB5tB0mtvpjTRieJVsyyce10ia0Jq63W9f5U
 cI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jIRFGxrYQlPRm7z5eZ4R3P7jhnosq67mPO1H2y/DpmQ=;
 b=5SKHcr1k+9ljPWZ488gPXO6lQpbuWwOgCVOHCLk19/FQmTxBi/M1K+BcP4we8MbjdV
 P6k9pLNujqlQeTIQBNNHs2UnmzrtrM5sXHWz8tSwp13ZHOO5uBhVw0VTbM6Ng9SSnVXk
 v5d0r2Vp8x2jbm/f6V79tBuOaWQWMmY6fKCs+1Gk+PJQQqs4a5LZDuTUcroKIIq/rK26
 AvOwZx6aKUDrmvFvjdDJGPZQEw4SvmOjG6CY98cBtW+5qRMAI/A6hIQNlZ5h5lFIzP5T
 oAOCuthVa7WiC0kax4yuQurkX8L070a+B3WejsViO7TVQ7kYn8R0NfYhjwB4lrFQeauo
 BS7g==
X-Gm-Message-State: AOAM531eyY/M6DRBAbJEM4BZ5XNJEamObiRgFGD8rWJ2pqk7CXctx3c7
 RITenkCXj3mbCyXvRxuVa/c34g==
X-Google-Smtp-Source: ABdhPJzaqYWCIttA1Pb1xjDkmPu7X7KOjQ/HgtCzoSMTmd0qdLZ1UopuyI3bQqiuAMWNUyY2D3hiug==
X-Received: by 2002:a65:464e:: with SMTP id k14mr6392693pgr.493.1638567955191; 
 Fri, 03 Dec 2021 13:45:55 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Dec 2021 13:45:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date: Fri,  3 Dec 2021 14:45:42 -0700
Message-Id: <20211203214544.343460-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203214544.343460-1-axboe@kernel.dk>
References: <20211203214544.343460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_134556_410433_5E5BCB67 
X-CRM114-Status: GOOD (  11.97  )
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

We'll need it for batched submit as well.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8637538f3fd5..09ea21f75439 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -500,6 +500,15 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
+{
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -510,10 +519,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
+	nvme_sq_copy_cmd(nvmeq, cmd);
 	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
-- 
2.34.1


