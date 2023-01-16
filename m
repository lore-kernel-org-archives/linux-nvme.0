Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85555C678D9
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojbiO3oZks3LpFd8dr2EcbxBeTeJmJbANwLFaR6J05M=; b=JqLcIL7DcP2g8VGtgHT6g3DXOp
	HNWxnIjFAR7lcdMBhbakYEbKKP92GI/cXANQURSG1igKL9tBCr2+FPvbfffvWHo1GehjpO8DhhiVb
	SxJEH/vRDAaCLBbNCcF03tOdkIk6t88uwAaVmiHWwCNMw9mGx9jBf/Xn8KcWzQqKsABGXJS8wc3+B
	ySejMMtdy6iwn5kmh0NQaV9JV0cwXucvxAU0X255gcjG5zhhC70nGNR8D6/yhtje3LyFsQrSRfwEc
	CioL1RytR0O6mhFSwuGpXNlRvSqHjVzsp3SbcDmks7c0lVGjJzS4uthOMFCrIh1bQcNn1+FzHMw+B
	pK6/J0QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPCh-00AHcj-Kr; Mon, 16 Jan 2023 13:07:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPBv-00AHD3-E8
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 13:06:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ED2B460F97;
	Mon, 16 Jan 2023 13:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A16C433D2;
	Mon, 16 Jan 2023 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673874382;
	bh=vAkRimTAOToGcO2FbKESWn7KypzSRbBcz5r9JH5CQXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADlWSkwHACNAO2DLud+o3x07DseJaWthyhMStPks9JKa3AMvFD7TCTSQ8TZM0fQ3R
	 TXWvlPdUnDpnYl24ITlNcRdLUTeTLOuuVf9xcSA9ISNpqlNKsN/d5rGkznbmjvxyE9
	 qZiBv/tQlQfwjsPz960Yrq13RsUph72exN6wRTnzpQyRbuVxqrZA+czP5JviwZapIH
	 8BWLxK82/4kZPDyD8SyFfgxbcdcubFqUEE97PWhIiPLmUqRmsm2JDukeuGGnDcrUma
	 aPQAEvN4YMtPALZapqy/W/8UppovupAUSNeAIgEwmJ4niNNuj8tJ9dq2bl4kwefxCs
	 3BkpzLZuxGDVw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Israel Rukshin <israelr@nvidia.com>,
	Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH mlx5-next 02/13] net/mlx5: Introduce crypto capabilities macro
Date: Mon, 16 Jan 2023 15:05:49 +0200
Message-Id: <561d70fff0ab0ebc5594e371d9faec2a2c934972.1673873422.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_050623_594114_9D696C57 
X-CRM114-Status: GOOD (  13.85  )
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

From: Israel Rukshin <israelr@nvidia.com>

Add MLX5_CAP_CRYPTO() macro to the list of capabilities.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c   | 6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 include/linux/mlx5/device.h                    | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index f34e758a2f1f..4603f7ffd8d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -147,6 +147,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	if (err)
 		return err;
 
+	if (MLX5_CAP_GEN(dev, crypto)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_CRYPTO);
+		if (err)
+			return err;
+	}
+
 	if (MLX5_CAP_GEN(dev, port_selection_cap)) {
 		err = mlx5_core_get_caps(dev, MLX5_CAP_PORT_SELECTION);
 		if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index df134f6d32dc..81348a009666 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1555,6 +1555,7 @@ static const int types[] = {
 	MLX5_CAP_DEV_SHAMPO,
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
+	MLX5_CAP_CRYPTO,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 29d4b201c7b2..fd095f0ed3ec 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1204,6 +1204,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_DEV_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1466,6 +1467,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_CRYPTO(mdev, cap)\
+	MLX5_GET(crypto_cap, (mdev)->caps.hca[MLX5_CAP_CRYPTO]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
-- 
2.39.0


