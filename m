Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EC4EB64DB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hb5ZkS+IZC9/slX9bhnXfFu9wz4VkSb/mHG9Yr4vZ9w=; b=jnoaDXX00ciD2mgSPyCyEYw3ix
	aH//mdg0fB5MCZsWE1nlLnr+MPKBEDYbmfkjJUBZ3nNX68b2+a312EIxRz2y8iae6BaoE/Ch7+QgH
	GZLUIJ9E1Cf5rUAuGbkTptta91ZuFjb5NKrboNjLnSbj+3lZILjpy3sg8B6NRElAJH6vJcWTgADXZ
	5eR/Oh4KVN1m5BAs73ozx5oDwV5CAlA4LMQOuagU81h7IwyGFzyvsOhNwG0d1LWOYRyXxrvxByxD7
	kgWndPItOiouCqNGPp4JGP7sywZ+/ij80px8xgkhypdmYj/ntd48qbjXv+KUC6sByWmlmlMfJPt2K
	hKy/1tGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lIs-00Eioz-39;
	Thu, 15 Jun 2023 11:38:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9lIo-00EinZ-0p
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 11:38:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C56106394F;
	Thu, 15 Jun 2023 11:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4573FC433C0;
	Thu, 15 Jun 2023 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686829089;
	bh=C+fvDRyW0tDkp4BZvbnuqRj9pcD+fFL2RdihwEeqoj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4WpnlfQXuGTbCpwu5IOPUlMcVA3+4RXtu3NI4szYJxtJz2GL85xvMVX//Oj5JH2a
	 wn7QWqMk7ekLB6u0Aad1SvhsJ3AqnbJwnj1U8wz8yblktvFDirhFY2g1o9LcZoDfMq
	 ykhzBQJJEquUZAt6tSFs6BmiV1C+sF3BsGhd7qxSOqQLFltEJh1Nld27BPzoIz2WKX
	 0anHu0D0eDGIG5rQdgssQa7RfaHobVQEYSQfOQ3qi+KP1NWRWa1pGKIlFbK8+YE6Lq
	 JQy0lynEdNddSAPgN699OrA6xs9Z8chYtLuMkneARL/7M0CDZyyJPoQQMYihX9FRvD
	 ayMaKusghMiAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 15/19] nvme: fix miss command type check
Date: Thu, 15 Jun 2023 07:37:15 -0400
Message-Id: <20230615113719.648862-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113719.648862-1-sashal@kernel.org>
References: <20230615113719.648862-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_043810_369619_F78087B3 
X-CRM114-Status: GOOD (  16.16  )
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

From: "min15.li" <min15.li@samsung.com>

[ Upstream commit 31a5978243d24d77be4bacca56c78a0fbc43b00d ]

In the function nvme_passthru_end(), only the value of the command
opcode is checked, without checking the command type (IO command or
Admin command). When we send a Dataset Management command (The opcode
of the Dataset Management command is the same as the Set Feature
command), kernel thinks it is a set feature command, then sets the
controller's keep alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c       | 4 +++-
 drivers/nvme/host/ioctl.c      | 2 +-
 drivers/nvme/host/nvme.h       | 2 +-
 drivers/nvme/target/passthru.c | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdf1601219fc4..dba10d182c6b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1115,7 +1115,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1132,6 +1132,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e051564..0264ec74a4361 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -254,7 +254,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1e..fcf3af2d64509 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1072,7 +1072,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 511c980d538df..71a9c1cc57f59 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
-- 
2.39.2


