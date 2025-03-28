Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26DDC28B20
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PiM/K3/LNJeWfZPJqlTVMyu2+2d/PdeW0HFMNzOHQgI=; b=aRNPpuI90u7eRnijjsbnCF4znL
	UQyLbQTwbpFFIunTDhd45/l2VM+SPPMUn3HozlpJBwbfG3+U10WUje4X2+yhhZkoXmWBVjpC1Gg5H
	shkE5RshvkgtsSsjEmW92Gb2sGyYi6SDFfdMZmBrlQhQ85HHjjPzFRLwYkGJuQq1EF7G5Zn8bi2Nv
	DwR/pPoh/kcyt/dqaMNrMrGAeGBTV14MyPVbjdS1iZfLHuRhD0fA9KXGFtdhnYFVbfVyLXgZtz/kj
	WOr4Ov6+JCeo3tN40IiM9EbgLInPmzmzQKX9PgsLYB5ynmqgS4De1iB+Mn7t+mzW9JyWbyqmXPFzY
	6Ws7wzbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyB8n-0000000DfeS-1ZhR;
	Fri, 28 Mar 2025 14:57:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyAe0-0000000Daa8-1kq5
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 14:25:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 621D05C6336;
	Fri, 28 Mar 2025 14:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2C3C4CEE5;
	Fri, 28 Mar 2025 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171911;
	bh=NF/NsSaGzQgrMigKCwS79D/GaMkgDB1dF0QZBIL8yIY=;
	h=Date:From:To:Cc:Subject:From;
	b=ssWLEUdC5GNsvoMJw38U3qhtmJvRq8N1dBTq7LkgnL8xO0IlrsTkgpZumRr0pG3AX
	 aFzuIbON/gO2TowE6260ADpKUebYVtEPYQ27EbonDBXNKWVpUvLKv7mamMzORYOUGi
	 MhY41QxstEx5GV51XPMYOS5dMwzekAgNGWvmSBvigv44abzCnlgAtr3sLfVCRepwsS
	 J9e+G6gOPwWnm4BINDcgUofRaVzpRImDNHLMCr6xVjZgXPB/0SJPkzdhrvSYf+IdJJ
	 fJ6sRdSKD1TDKKF/IT5l2oeaZcKjdTKp5ePxPCLOmbzwxrkDgM0azke3y1GsV6qcow
	 R7DZCpwq7wKmA==
Date: Fri, 28 Mar 2025 08:25:08 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <Z-axRObjXYjIHGQC@kspp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_072512_498969_F99A3397 
X-CRM114-Status: GOOD (  11.56  )
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

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the structure. Notice
that `struct nvme_loop_iod` is a flexible structure --a structure
that contains a flexible-array member.

Fix the following warning:

drivers/nvme/target/loop.c:36:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvme/target/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a5c41144667c..d02b80803278 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -33,10 +33,12 @@ struct nvme_loop_ctrl {
 
 	struct list_head	list;
 	struct blk_mq_tag_set	tag_set;
-	struct nvme_loop_iod	async_event_iod;
 	struct nvme_ctrl	ctrl;
 
 	struct nvmet_port	*port;
+
+	/* Must be last --ends in a flexible-array member. */
+	struct nvme_loop_iod	async_event_iod;
 };
 
 static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.43.0


