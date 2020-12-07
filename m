Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E7C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A552388C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A552388C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IAhwNUp1kgnCZUkFve40vFLpjPkFvFmHf8HowsRAaRU=; b=YDpzOwoB6dZY5pWKCBE/2vUBT
	SE7cqjlCdKowRjZxqGbqQo8/fQFL9f5ZJSIilfPJpsT9OMOdOpoxhJJ529y/CwzotG9fUAhJQu9SJ
	v9EqQvbwHiF3dE78/cz2JZTZEJWC4VuVUhrDLMvEXfLPzAWNdmTpjNPa8POy6zIAQXje3KOWvn1Lp
	Oa/Oja5RW6OJvq1u959f36HWGAvl84yn4RuDWzssDtqA3n33qLY48tPbkSAUxuHA48z4pQOjpaEbm
	y2hwogsOixN5BSjbsoB4FnAlAmMqIIAmEyAa2WjZIPNOYj+BZifI7oR5vbFFCqBghpMcr4ATDe7uc
	4K6qWfS/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmNjG-00017h-Fp; Mon, 07 Dec 2020 21:07:30 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmNil-0000un-3l
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 21:07:06 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 7 Dec 2020 23:06:53 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7L6qIJ029788;
 Mon, 7 Dec 2020 23:06:53 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH v1 net-next 11/15] net/mlx5e: TCP flow steering for nvme-tcp
Date: Mon,  7 Dec 2020 23:06:45 +0200
Message-Id: <20201207210649.19194-12-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201207210649.19194-1-borisp@mellanox.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_160659_938214_551EE6AD 
X-CRM114-Status: GOOD (  12.67  )
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
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
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
index 97f1594cee11..feded6c8cca1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t		ref_count;
 };
 
 static enum mlx5e_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -335,6 +336,7 @@ static int accel_fs_tcp_enable(struct mlx5e_priv *priv)
 			return err;
 		}
 	}
+	refcount_set(&priv->fs.accel_tcp->ref_count, 1);
 	return 0;
 }
 
@@ -358,6 +360,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_priv *priv)
 	if (!priv->fs.accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&priv->fs.accel_tcp->ref_count))
+		return;
+
 	accel_fs_tcp_disable(priv);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -374,6 +379,11 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_priv *priv)
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
