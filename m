Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D2D609B9
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=; b=DNtjbGlboTrDjBy5HvkHNpziI2
	VlzeeFWxDBB6iJKRYOQc4IMc2Uyxqk3CetfZFszXAQqBXWVWjugT3qoyB6hFFJKzQOHd6Xn80vxdK
	57cm73akZ+TUcLrMk+7Ut5+bVRY5M8SGuHiFoy8Y8zdpBqEL3V2qq0HzxkH45QtCn7I0mHJ5iPmRc
	1JyOr6klEtvh1RR2jDDLdxhoZAFPb43guTNXrbUVgKX1PrxQbgq45JN/HSgq/HLCxRgJGpvmPmL2+
	S6QsKZowKHkbke9oYV0A5Leu8I1lm0RWe+a8UZLBmtW9nDe62TWBISfDZVJmG4HTNEO8hoXgjqD7J
	pSzMD/yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmd-0000000CcPy-1QU4;
	Wed, 27 Nov 2024 08:52:27 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDmb-0000000CcOI-13TY
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:52:26 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7fc340eb006so2509394a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 Nov 2024 00:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697544; x=1733302344; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=lPi0HgVihtrJ4Dqw5v4FI2CHwLhRrPDbU956sj4Wwkr/4QggInk73touYHJpreSoYx
         aD25S31DTZ+tgArzolq9+nrK99BWW9zknAHExSz7w7UmuhsYhC4NGrbOms+7H6WXvoyC
         lPO2huvLUoSTgOZY6fyVqyZYyfur4+pGO9o2iC/iLYl0jxMu73/Lqm8fwu9rXvdB071r
         oPjqQo2Z8DvpiBcySp/ATqXRP5iC3XhqQtlGC3mozNNxP9aIf5eGgkeYxqgtLlpZIf8v
         R+NTdMFi1YEEsDvVta8NrCbWDAHaFTiqkzui9ANzZXdMzwclrDw5QBfyWqQiwTNgP0A8
         4KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697544; x=1733302344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=sTf1sYFJCmgku+MZ7fRS1warg9jUBdr/muLT+MUSxTaD+pCrRdSrJlbWYBc2cqBjZm
         tVYINZvh+pe6JqiW0Xdi3HeuMYIYURGsO0/1CBQU75xuKnuD6j9zBk5c714kDDnEpYzD
         CR2qdVTnN9xxaIoHjKxMXCoSDm8qMguK9OqSE9aa7o0TN+GLbrkTLvF+xsqYsi/B2OIo
         /mT/JG3CRCn+XaEMVoElqGORyoQ4dKgEx4IVecoTGJW7/WP9bolYtwmxhP5c5chi1YuF
         0tPJeUcQH304bbkQHHDvmSaXjg8DTOw13Bh3EheRHpLnNBUtdZCtfHY70murl4hDsz9M
         34+A==
X-Gm-Message-State: AOJu0YxKbxue9TKU+TLbtfOcJDVNvexEGWcQyGjskaRcNZGA6jD7a2Bn
	aQcFoY+sirKrp/q1cNULPThETSQRHMMqDYrZ2gZyyKnZv+Z+YbW8
X-Gm-Gg: ASbGncu/QQl2qD9m3i2Btqczf+Kn2MqPFHMpj18oMgW1xyeYXbblj7Nfr84SjIauzuZ
	JuITw1ZiAm8jpesxSDFnwW67JJImCMAiufpJVYJEB8QClLeKcWg5kG1Uq6W9MBP9Z1VXt2dk8Bz
	ngjn3Wh+C7wcFsXa1f9WG8x6wnEWV6/JUB9AvT7YKHbS1TiesNAgrNMHFFXzlR7sIrwIS7oVlMP
	dN+hb64zJaGCjykDnCzU7bVxt0SxUGmLgZiyWsoHJWrEa52J5QHr9J94I8caQ==
X-Google-Smtp-Source: AGHT+IF/cp5rzTT3tE1mP8JhClMCc7LgiUCv5UBMIenswP4dQfK1tVc737MNwzcTj7GoQFR/nN2XrQ==
X-Received: by 2002:a05:6a21:78b:b0:1d9:6a6b:faf4 with SMTP id adf61e73a8af0-1e0e0b2c903mr3625688637.15.1732697544232;
        Wed, 27 Nov 2024 00:52:24 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:23 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] nvme-rdma: unquiesce admin_q before destroy it
Date: Wed, 27 Nov 2024 17:27:48 +0800
Message-Id: <1be6b47b5d05975d7ac7ffbc20257c283b179491.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_005225_284378_8D0A4AD3 
X-CRM114-Status: GOOD (  11.87  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Kernel will hang on destroy admin_q while we create ctrl failed, such
as following calltrace:

PID: 23644    TASK: ff2d52b40f439fc0  CPU: 2    COMMAND: "nvme"
 #0 [ff61d23de260fb78] __schedule at ffffffff8323bc15
 #1 [ff61d23de260fc08] schedule at ffffffff8323c014
 #2 [ff61d23de260fc28] blk_mq_freeze_queue_wait at ffffffff82a3dba1
 #3 [ff61d23de260fc78] blk_freeze_queue at ffffffff82a4113a
 #4 [ff61d23de260fc90] blk_cleanup_queue at ffffffff82a33006
 #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce [nvme_rdma]
 #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced [nvme_rdma]
 #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b [nvme_rdma]
 #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362 [nvme_fabrics]
 #9 [ff61d23de260fe38] vfs_write at ffffffff827d5f25
    RIP: 00007fda7891d574  RSP: 00007ffe2ef06958  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 000055e8122a4d90  RCX: 00007fda7891d574
    RDX: 000000000000012b  RSI: 000055e8122a4d90  RDI: 0000000000000004
    RBP: 00007ffe2ef079c0   R8: 000000000000012b   R9: 000055e8122a4d90
    R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000004
    R13: 000055e8122923c0  R14: 000000000000012b  R15: 00007fda78a54500
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

This due to we have quiesced admi_q before cancel requests, but forgot
to unquiesce before destroy it, as a result we fail to drain the
pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
simplify the code.

Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
---
 drivers/nvme/host/rdma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 24a2759798d0..913e6e5a8070 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1091,13 +1091,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1


