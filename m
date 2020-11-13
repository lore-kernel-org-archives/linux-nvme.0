Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D98C55ABD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 18:45:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57E3208D5
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 18:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G9Gy/No+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqPTqfbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57E3208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6ecikf0U9cgSmoqsaMVMM5VxTJFKKd+CcbuIPtLgSjc=; b=G9Gy/No+wfTy/1izRhbYQzAvVY
	iCxDR8crb6irBtpybw+7ay+oUga7xJ+GfqAmN/WB6MeA6kghU1+X0YY/GcU1rA8Paq7miv1u2knb7
	rMiFXvfnQDPTdhAiiqufFvQcnhCsyejvOjxdhThMyMLnfe7dfivCXfeAU2wydgeR6nJU3jVzx6MLr
	NUJoAsIQl//caJzDxQVnmFUIkIKD1Fea7DvkfrO0A4R1bwjMTNg8h8ur9O6s5+neAHvyziEuQAYYl
	yfgI6w0CliHJkyGdc+ihDirXFSDCAWrFWkXyW6YlFPGEtj3i9sPYAdrpJa6kQaE1h6Autu6vz8MIe
	3VAO+R3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kde51-0006id-4Q; Fri, 13 Nov 2020 18:45:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kde4y-0006iC-Ot
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 18:45:49 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43C6F208D5;
 Fri, 13 Nov 2020 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605293147;
 bh=WwMzUqs80cYMsYG+cr18yRglH/y1GTB1vbC1AebutYM=;
 h=From:To:Cc:Subject:Date:From;
 b=lqPTqfbMMLH+ELJ78zO8vboXLq+5TXb7qkMFOs1gTTwXfioiJduxGCkKI2udHl126
 DSPGcHxszYMU+6JXRk3MJAMMePrRPXWuIuSMK4DhVPDbIsfJ393gZMqzstu9ldnupU
 i0kGD5PVnIaMLaC3EW8OCwMqDJabaOkGYgdxz2w0=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme: fix memory leak freeing command effects
Date: Fri, 13 Nov 2020 10:45:45 -0800
Message-Id: <20201113184545.2707853-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_134548_897864_1AB67F91 
X-CRM114-Status: GOOD (  13.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, chaitanya.kulkarni@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

xa_destroy() frees only internal data. The caller is responsible for
freeing the exteranl objects referenced by an xarray.

Fixes: 1cf7a12e09aa4 ("nvme: use an xarray to lookup the Commands Supported and Effects log")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2c197f69c03a..a288d925f71b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4398,6 +4398,19 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
+static void nvme_free_cels(struct nvme_ctrl *ctrl)
+{
+	struct nvme_effects_log	*cel;
+	unsigned long i;
+
+	xa_for_each (&ctrl->cels, i, cel) {
+		xa_erase(&ctrl->cels, i);
+		kfree(cel);
+	}
+
+	xa_destroy(&ctrl->cels);
+}
+
 static void nvme_free_ctrl(struct device *dev)
 {
 	struct nvme_ctrl *ctrl =
@@ -4407,8 +4420,7 @@ static void nvme_free_ctrl(struct device *dev)
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
-	xa_destroy(&ctrl->cels);
-
+	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
 
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
