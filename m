Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690CFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VCzqBQhxDZ4RSqHjs3iu/EY/nWH2G01zLc/I2KHCjcM=; b=jhqnP6CIBCxIEIlHW6gKS4gpXl
	ARu8j9VDPnr6yAwR+T2Jy6RqBz3uvfiiMnG78wiy7gnjtGCev51TZhwNi+15PaKH1Zx5HbzUISzPp
	Q2/4H6FYsvf4nWXOoyelD3Ck4GhsY0vN1us/CpXvbhZDdkQaRz/7/azLxBX+rMMGkdJuJ4OwaBRxH
	Gm0W3wbL+Hw8k/OGJg7KFCg3jAhtcmwd9fN1GF72nyjZiVPxhKhkD+f2ZRRfRuPkH1A2lShLUsU4B
	mM1+HChzuEALZNJohHVzY9ycfAPBfpONildkv2Dt4IFp4/q7Eceo2X2JKdSjbi5IXtJNW41PBQk5F
	1ogbeGFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOn-000Vbf-3m; Wed, 14 Dec 2022 16:14:25 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOU-000VPQ-R7; Wed, 14 Dec 2022 16:14:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6/9] nvme: only return actual effects from nvme_command_effects
Date: Wed, 14 Dec 2022 17:13:44 +0100
Message-Id: <20221214161347.764071-7-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214161347.764071-1-hch@lst.de>
References: <20221214161347.764071-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Only return actual destructive effects from the command, and not misc
information like if the command is supported, the scope and support for
the UUID index.

Note that this causes the nvmet passthrough code to now execute
admin commands asynchronously, which it previously did not due to the
supported by in the returned effects.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6f3ac102e9488..945a947f90b757 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1093,7 +1093,10 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
 	effects |= nvme_known_admin_effects(opcode);
 
-	return effects;
+	/* only return actual command effects and not misc information */
+	return effects & (NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			  NVME_CMD_EFFECTS_NCC | NVME_CMD_EFFECTS_NIC |
+			  NVME_CMD_EFFECTS_CCC | NVME_CMD_EFFECTS_CSE_MASK);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
 
-- 
2.35.1


