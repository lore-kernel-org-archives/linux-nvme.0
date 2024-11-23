Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B08E6ADF8
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Nov 2024 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=; b=Afiebre8sMgvAuhXOPssaANAJT
	zz9WjW86U7AwKdG1TGck+QeYJBVDF8pSWa1WPf3R4CV45eMXsy7/JdMqDQI1rCapA1KZcPqXjkkMd
	eQvT5ggwMqXR784DTBFmr70pYpnZg/+0gdEve5QXu7ZnGOYes8XabmkfvhHBbAGTLpC3EhMOivdxt
	zYiwPvOb+eldDjKq1ilAQDbs6X6EO+VqWc0op/jLpbBCAIscavQEbEFNpyNL8xxv7Ct/iAN1wFKQl
	J2EAb7mIso2Z3yVcW9Hv3+RpnkZK0X01e0ZpVxsBofCDysZneO0qPW69Htm6298XDiVvn6M1rKVX2
	a5+1eUrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpmB-00000004Lt8-3o3t;
	Sat, 23 Nov 2024 13:02:15 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEpm7-00000004Lrd-1Z77
	for linux-nvme@lists.infradead.org;
	Sat, 23 Nov 2024 13:02:12 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-724f41d520cso268970b3a.1
        for <linux-nvme@lists.infradead.org>; Sat, 23 Nov 2024 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366930; x=1732971730; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=XiQKFgvybJzOAdL7x6bjbEJKPMDKqiOthTV5ngGN7uh6Z1Y/KLPQ4W/NdY4z9NI7RN
         kyefXrQo2bEYLi3zFcH6NoY+9MzD5Z1R6rUtfYuFXeE0M7/JtUvkvB/Opz8YgqygPfkB
         dU636AmZ+pyIglQfs3w0V3i33f+ztOIaACXWKiYAGsHEDN7H7v7leWCzG8NenmmHkhZI
         z74oOXyOzTT5OzrCWHemMpqVzjknUdXr4xY+jEHwXJAXAHed3+BlICOeQhNVpKKl2QfF
         EMBDQOV6LgDRgd3DSOlZ5k26FtSz7EyfxytimFknQKC8oUuDnlFtyO8BWWdHBOjnWnEr
         1mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366930; x=1732971730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpmERBoqTwRUxsoOOwQBdGMoKAty6EzjZaeUApmpNRM=;
        b=HBk6AUuMBRPLtlJenzIa3xPhyRgw1M7uilGWeKadZbkyW+HI/5zE4cKVe+uV5U/MvZ
         PM/ArzOlFocIzf+wNbQjjkBA7y+liZPYdOBu6DS+hJXv1VkmWQq6E/vS7BMKheqUBHPL
         GsJYUAL4+KeOgb0P1cmAZMinq55DHJcf6wT1K887LOrEsObzPmcMu2lby2aXx6RBfCyk
         3RrsAOU8FWblQscBaNlXxveoSdlNWGlRcp2pUt2Z3e7saeij1As+91UI4xTIt7ToTiAV
         wsAn18CcEwifPPAZD4Be1Rremv7s4DY8jggEhrDrYF/6DixEeQ6cyUFGHhEBuqrToJ4A
         qQhA==
X-Gm-Message-State: AOJu0Yx6RA6v+IAEcaGnwt9lbnXi+X+zKalpQRPIiY5fL/foN001z2Zt
	5MLvM1iREe8y/KeZKufmAGdOFzAVgNoempNPh6eeAsf4UC9pFLUd
X-Gm-Gg: ASbGncvlNRDvksYsNdUyqjI3o1GmPbsmYDg869yEwBffqYwzQegi2mUwLhwAOLrFAxp
	FLNNHtlVGjGIQgTECaSx5lirrjSZAOx/gUy+Ai4vGmNrWFIkaP97tnR/11CErC8O+W9sibAir/Z
	AorxQTmm18o5g1gBD2tEnV9t+i5F7GAF+y/wUpiXH9JMf9YWp+9zsRpfY5U9JwRQgZo28l/rXbq
	q2ovzFKqNcC5RIr5+fyxHZUUsrb4TbgFQKGDoWxDVjv4zzZbSlY85bYgv+yXg==
X-Google-Smtp-Source: AGHT+IHN1KnxNuN0h9IWrcLc767Cg28zWfmxg2oWBIUrJnGOr+F9L16qXfjIjHvwcl/xeP3fhKiWJg==
X-Received: by 2002:a17:90b:224a:b0:2ea:aa56:4b0 with SMTP id 98e67ed59e1d1-2eb0e1269eemr8048875a91.3.1732366930176;
        Sat, 23 Nov 2024 05:02:10 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:09 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
Date: Sat, 23 Nov 2024 21:37:37 +0800
Message-Id: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_050211_411964_B8B70349 
X-CRM114-Status: GOOD (  10.68  )
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


