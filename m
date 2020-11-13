Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CDC63699
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 18:28:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195752074B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kgwFJxet";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1zvTGJoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195752074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=59ZGQkczbt21HBwBXIYDvLHTPF8AwLfBFjFX0nQUnvg=; b=kgwFJxetN+oT6CB+UfdjH/B22y
	QhEBcNertDgJKfqOAok5Ap2W0KOVgwGdDU4dVdo+AAvtK2hu6vFqJ8nnVRWw4D+odmxzkHqY+cO7h
	XR50hikwLM8y5uwlRrWFhwvdgeg4gSDOVGbeAKZ1AiiU8P0tn8nXTbDSgRvbUikuqpwd9K85thuVp
	+Vfg6abWrKV40GY4PTHYhhEe5VSsigk/bYvDpQMrdPn7jebmpp3RVr5ZPw3CYM96+HPlP+jF+Vj8g
	x9mhZaJ+l+hAPjNRP9rd3c5BlFH+Pjki7zJRQTq2B+W+2VRSfLLMYLKxi3eVZUCFG7LM1o07AMSRy
	N5QoUocw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kddoV-0003LF-69; Fri, 13 Nov 2020 18:28:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kddoP-0003He-OO
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 18:28:43 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E835A206E0;
 Fri, 13 Nov 2020 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605292119;
 bh=HgIbydZvR81o/v10wwYj1v3ZR4Uoxpp5Wnlmfwp0HqA=;
 h=From:To:Cc:Subject:Date:From;
 b=1zvTGJoDuwaXgiEATofkkbVdQdO8xfMlM5YzHLGIqZceCgSVhc1OZD9GyvBlmbMSD
 Mqesg/Pz3M4xHCUYoZmM/9U0JoQQ9VLY7c8IpPikcXqW1oC3Jige5w/b00khEFYnXB
 kgv/SMN0QHG5y+vCp0uMkjMbpbA8KnTPaIGDOBOQ=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme: directly cache command effects log
Date: Fri, 13 Nov 2020 10:28:30 -0800
Message-Id: <20201113182830.2642315-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_132841_900587_E1F76C3D 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Remove the struct used for tracking known command effects logs in a
list. This is now saved in an xarray that doesn't use these elements.
Instead, store the log directly instead of the wrapper struct.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 9 ++++-----
 drivers/nvme/host/nvme.h | 6 ------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff90200497c..2c197f69c03a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2954,7 +2954,7 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-	struct nvme_cel *cel = xa_load(&ctrl->cels, csi);
+	struct nvme_effects_log	*cel = xa_load(&ctrl->cels, csi);
 	int ret;
 
 	if (cel)
@@ -2965,16 +2965,15 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 		return -ENOMEM;
 
 	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
-			&cel->log, sizeof(cel->log), 0);
+			cel, sizeof(*cel), 0);
 	if (ret) {
 		kfree(cel);
 		return ret;
 	}
 
-	cel->csi = csi;
-	xa_store(&ctrl->cels, cel->csi, cel, GFP_KERNEL);
+	xa_store(&ctrl->cels, csi, cel, GFP_KERNEL);
 out:
-	*log = &cel->log;
+	*log = cel;
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 83fb30e317e0..140cc4a9e0c8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -227,12 +227,6 @@ struct nvme_fault_inject {
 #endif
 };
 
-struct nvme_cel {
-	struct list_head	entry;
-	struct nvme_effects_log	log;
-	u8			csi;
-};
-
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
