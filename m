Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC8E7718A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=it8TC3omcvsc7cT+tTzeGuirDtUVOh2SOWzG+1+B1qo=; b=h/fzMOVlHoyd5qlT3WcOnyrUxS
	CNl59xDvBK8ZRhObb8HsT6AB/yO036WiAFyMNoVVPWwLlDe/tjgG8RabZ56hYCYjA5JcRMpgkjWve
	gua2raFdO12iEjMgZP2Rm/httP1/qdeZNFlI4GzHcKYDEip8mSE2YE0B2R/edDjdSSvJAHJs45BJP
	h7GxF/RLJTmvZJ4Ix7i1Oe540ycBIr3mHqDwv/sC4QLkXmNxSe4IUOfiZmRZPnF+oZzwUlLHPrvSp
	M8T1fsTrR17cLxnR10uS7S3nOl/9AH56lnTSpfSDAZzouCt1Ld0R/P6UoHKX3OyFZ8l5gvyfh5inG
	tnICg3jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZf6-00000004TZm-3x91;
	Fri, 20 Dec 2024 09:51:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZf4-00000004TVo-0ajB
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:51:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AD4195C4C3B;
	Fri, 20 Dec 2024 09:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E93BC4CED6;
	Fri, 20 Dec 2024 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688269;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHdBHGVzfuX7rjiT9HSsgX8WouN+Q6OKSuXrpXMdC0nyeb7c7CDsqwJaUqNj6wYWB
	 l3GRPgCeh3NZMLVM5lmnVkU3tt9D9edtEN7nSP58FTRdm51VKAddgCrdv7sEbZ5d6S
	 QtKj4Aco+f5DPwBEtOtlIksqIQb1cDNnImKCzlO1RRqQPKStmQj8S5UTsev5KsFF+k
	 kYskob8Ee7m05oxrNkME0+RfdrCN1wR9sVeR3qsPIj9mcpKTYjuVY57tha1TVtlrZC
	 QxHFGRRpM5+l2sSrkYsvYmqM78lt0RLnaxPN4lMWPwbmFDdoCrxj+mTztqCATyLwQk
	 HX2rPamu9CraA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v7 12/18] nvmet: Introduce get/set_feature controller operations
Date: Fri, 20 Dec 2024 18:51:02 +0900
Message-ID: <20241220095108.601914-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>
References: <20241220095108.601914-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_015110_237180_B5740007 
X-CRM114-Status: UNSURE (   9.01  )
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

The implementation of some features cannot always be done generically by
the target core code. Arbitraion and IRQ coalescing features are
examples of such features: their implementation must be provided (at
least partially) by the target controller driver.

Introduce the set_feature() and get_feature() controller fabrics
operations (in struct nvmet_fabrics_ops) to allow supporting such
features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/nvmet.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 86bb2852a63b..8325de3382ee 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -416,6 +416,10 @@ struct nvmet_fabrics_ops {
 	u16 (*create_cq)(struct nvmet_ctrl *ctrl, u16 cqid, u16 flags,
 			 u16 qsize, u64 prp1, u16 irq_vector);
 	u16 (*delete_cq)(struct nvmet_ctrl *ctrl, u16 cqid);
+	u16 (*set_feature)(const struct nvmet_ctrl *ctrl, u8 feat,
+			   void *feat_data);
+	u16 (*get_feature)(const struct nvmet_ctrl *ctrl, u8 feat,
+			   void *feat_data);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.47.1


