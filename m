Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA953C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:11:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4610623A7F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 15:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4610623A7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qMB2VrX29tF9zIQvAx7DSy7S/DdC9LSD3Fku7jhcxsI=; b=w2aeAg3rYsL456cHXIfZ2XH8S
	dqkLbkMMd6GpY5mOLGpmVKW/d7niw0mXRRshEUOrfjnY1F2xIMW+1f/5P5njxoisUg2HgvkAx3qlu
	94nRONc7U2vjyZY71ivAB30YVkH+yfLbibWr4Tzbq8U0y9aTUWE9BXERtwQvjXiPSf4LLUXbKuRwh
	r4uXyQFsC2zrD9BI3avAIZWQaPV1lhrAFa7KxhaBGomK11ZnCT8xBiweEHZFKzTeDzLfHxQxE3XYh
	Ml0awCC7cV5j/bVn1EowpZEyNRdqcov2OsxDouk27eo2tIxqlx4AaXa0soDdfGKDKXrzjp4g6S9ui
	QCzYLJurA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l04H0-0000kU-Jr; Thu, 14 Jan 2021 15:10:54 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l04Gv-0000g7-Ja
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 15:10:52 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 14 Jan 2021 17:10:45 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 10EFAh0E000835;
 Thu, 14 Jan 2021 17:10:45 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, dsahern@gmail.com,
 smalin@marvell.com
Subject: [PATCH v2 net-next 14/21] net/mlx5e: KLM UMR helper macros
Date: Thu, 14 Jan 2021 17:10:26 +0200
Message-Id: <20210114151033.13020-15-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210114151033.13020-1-borisp@mellanox.com>
References: <20210114151033.13020-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_101050_002189_5680088E 
X-CRM114-Status: UNSURE (   7.71  )
X-CRM114-Notice: Please train this message.
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ben Ben-Ishay <benishay@nvidia.com>

Add helper macros for posting KLM UMR WQE.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index ff100c290b59..26259d68b98a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -152,6 +152,24 @@ struct page_pool;
 #define MLX5E_UMR_WQEBBS \
 	(DIV_ROUND_UP(MLX5E_UMR_WQE_INLINE_SZ, MLX5_SEND_WQE_BB))
 
+#define KLM_ALIGNMENT 4
+#define MLX5E_KLM_UMR_WQE_SZ(sgl_len)\
+	(sizeof(struct mlx5e_umr_wqe) +\
+	(sizeof(struct mlx5_klm) * (sgl_len)))
+
+#define MLX5E_KLM_UMR_WQEBBS(sgl_len)\
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(sgl_len), MLX5_SEND_WQE_BB))
+
+#define MLX5E_KLM_UMR_DS_CNT(sgl_len)\
+	DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(sgl_len), MLX5_SEND_WQE_DS)
+
+#define MLX5E_MAX_KLM_ENTRIES_PER_WQE(wqe_size)\
+	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_klm))
+
+#define MLX5E_KLM_ENTRIES_PER_WQE(wqe_size)\
+	(MLX5E_MAX_KLM_ENTRIES_PER_WQE(wqe_size) -\
+			(MLX5E_MAX_KLM_ENTRIES_PER_WQE(wqe_size) % KLM_ALIGNMENT))
+
 #define MLX5E_MSG_LEVEL			NETIF_MSG_LINK
 
 #define mlx5e_dbg(mlevel, priv, format, ...)                    \
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
