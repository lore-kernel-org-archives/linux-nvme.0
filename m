Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72400C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:13:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027F164DCD
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027F164DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aT0WOwK6+jAbEvqWlIpfi261Joj/+QRmtvvoS/Jf7ok=; b=qooNVmZ5OpAfo34aD3MoVGk7M
	S2Cdc/di+I64+6KJ4pfMTIdNa1K2LBAvh43XHUSCli6Fq3H225OurZJyrBdV3GRHBKnMIRR3ythjR
	V1Jz/8alKT3n0WUsEfJUQCQZ8TLgXFRgsjxK+mZLQ+f1je7U6giXdV19lEr4xJI49THwy58dKQE4V
	eFv5D3ARlQpKcqo2GZQllANNerANzmUM6XFO92tW/rKUlqEAClyik+hfPCOHKjtfzH1NlZdC1vgTI
	XEcIgqxTf73mdVHu71wyc7LDxrtq0qAK+wT/3nolrZ3FmQuj+vDOQ7h04MWpOu+5BEDcGR0GvUW5M
	fR5wZrnaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAJH3-0004m3-9a; Thu, 11 Feb 2021 21:13:17 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAJFu-0004JZ-0a
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 21:12:10 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60259da50000>; Thu, 11 Feb 2021 13:12:05 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 21:11:54 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 21:11:49 +0000
From: Boris Pismenny <borisp@mellanox.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
Subject: [PATCH v4 net-next  12/21] net/mlx5e: TCP flow steering for nvme-tcp
Date: Thu, 11 Feb 2021 23:10:35 +0200
Message-ID: <20210211211044.32701-13-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210211211044.32701-1-borisp@mellanox.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_161206_198837_EB852187 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Both nvme-tcp and tls require tcp flow steering. Compile it for both of
them. Additionally, use reference counting to allocate/free TCP flow
steering.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h        |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  | 10 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h  |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index a16297e7e2ac..a7fe3a6358ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -137,7 +137,7 @@ enum {
 	MLX5E_L2_FT_LEVEL,
 	MLX5E_TTC_FT_LEVEL,
 	MLX5E_INNER_TTC_FT_LEVEL,
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	MLX5E_ACCEL_FS_TCP_FT_LEVEL,
 #endif
 #ifdef CONFIG_MLX5_EN_ARFS
@@ -256,7 +256,7 @@ struct mlx5e_flow_steering {
 #ifdef CONFIG_MLX5_EN_ARFS
 	struct mlx5e_arfs_tables        arfs;
 #endif
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 	struct mlx5e_accel_fs_tcp      *accel_tcp;
 #endif
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index e51f60b55daa..21341a92f355 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t		ref_count;
 };
 
 static enum mlx5e_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -337,6 +338,7 @@ static int accel_fs_tcp_enable(struct mlx5e_priv *priv)
 			return err;
 		}
 	}
+	refcount_set(&priv->fs.accel_tcp->ref_count, 1);
 	return 0;
 }
 
@@ -360,6 +362,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_priv *priv)
 	if (!priv->fs.accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&priv->fs.accel_tcp->ref_count))
+		return;
+
 	accel_fs_tcp_disable(priv);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -376,6 +381,11 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_priv *priv)
 	if (!MLX5_CAP_FLOWTABLE_NIC_RX(priv->mdev, ft_field_support.outer_ip_version))
 		return -EOPNOTSUPP;
 
+	if (priv->fs.accel_tcp) {
+		refcount_inc(&priv->fs.accel_tcp->ref_count);
+		return 0;
+	}
+
 	priv->fs.accel_tcp = kzalloc(sizeof(*priv->fs.accel_tcp), GFP_KERNEL);
 	if (!priv->fs.accel_tcp)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
index 589235824543..8aff9298183c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.h
@@ -6,7 +6,7 @@
 
 #include "en.h"
 
-#ifdef CONFIG_MLX5_EN_TLS
+#if defined(CONFIG_MLX5_EN_TLS) || defined(CONFIG_MLX5_EN_NVMEOTCP)
 int mlx5e_accel_fs_tcp_create(struct mlx5e_priv *priv);
 void mlx5e_accel_fs_tcp_destroy(struct mlx5e_priv *priv);
 struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_priv *priv,
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
