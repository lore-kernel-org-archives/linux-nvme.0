Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C970C46467
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jan 2023 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTnnWnp7UUWhj8ee5w6z9hZcVjDAoeqkUa/6DelfCYA=; b=pQkFkjmP68/HaagE6b2+mKOwmH
	y2E5iNcwW5h0cSKGffqXD8HWI7Vjyvwc7MPDzlUUPz/mqjiWrq3+sfwEHQXaUZkH+vMwYi/yMXfOp
	Vy7ccpPF1ASEBoFpYDiqVTupoli4fy1c3k/SHEaCMe2nGrE62ZDnUTXtNhWKRZ/HnT0/HsgJXIBCH
	i2hfyGVnsPzBlZHVSl7ONo7j7d6dNHQG0dcuE7ieTYplw6WMsbSwmrG8TL2MbCMvrI7vJpGxSVLB7
	eRzZAywQsPn6j0la0hTfN4kunGnzZxCoykI+rDhovFGSrl8yMBdz6hbZZ4K8/PIt9YpD6og9KSX1I
	pIIRUuag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPGG-00AJC3-DK; Mon, 16 Jan 2023 13:10:52 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHPCP-00AHR9-VP
	for linux-nvme@lists.infradead.org; Mon, 16 Jan 2023 13:06:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9E6F9B80D20;
	Mon, 16 Jan 2023 13:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B85C433D2;
	Mon, 16 Jan 2023 13:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673874411;
	bh=yXankd3ADXRZerTodbpyETr0H4Qj01JdsQgtwpw0Dpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgIjibUjt1g+aWE/ux7w8lldiqti9MPTOYrg664GTgeLLIko4iPlQIWTchtK4PPS2
	 E/Nj7bdo+U8PXiZB22s69BYxYSo2jkj8gYzgB/2jWsva2ntMUuI2Aq3657DptC5dE5
	 4Jr0jMc+OseLWn678RNGP/CbyWwuU5rWZ4YS+wtBZ9xex7dzm7e7WMNr0g149oyV5g
	 bV1mGiJJ9b8fsOyoNu+nM/BzhRhn01fxJYL0KHLx7WVH9RdBd24jGTRwxpOzoj8iDi
	 A66sE/zByovan3DalETwgdA4lfwZfOcUxm25T0qqmVAvszBo4pnTSvZLqnjof6c1O+
	 WQcxe4oVbyRIg==
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
Subject: [PATCH rdma-next 08/13] RDMA/mlx5: Add cryptographic device capabilities
Date: Mon, 16 Jan 2023 15:05:55 +0200
Message-Id: <39ba2f3cd1786e47f2541f4a7be59cc5af4b03c7.1673873422.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
References: <cover.1673873422.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_050654_359313_5CB33FC6 
X-CRM114-Status: GOOD (  19.91  )
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

The capabilities provide information on general cryptographic support,
maximum number of DEKs and status for RDMA devices. Also, they include
the supported cryptographic engines and their import method (wrapped or
plaintext). Wrapped crypto operational flag indicates the import method
mode that can be used. For now, add only AES-XTS cryptographic support.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 drivers/infiniband/hw/mlx5/Makefile  |  1 +
 drivers/infiniband/hw/mlx5/crypto.c  | 31 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/crypto.h  | 11 ++++++++++
 drivers/infiniband/hw/mlx5/main.c    |  5 +++++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 5 files changed, 50 insertions(+)
 create mode 100644 drivers/infiniband/hw/mlx5/crypto.c
 create mode 100644 drivers/infiniband/hw/mlx5/crypto.h

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 612ee8190a2d..d6ae1a08b5b2 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -6,6 +6,7 @@ mlx5_ib-y := ah.o \
 	     cong.o \
 	     counters.o \
 	     cq.o \
+	     crypto.o \
 	     dm.o \
 	     doorbell.o \
 	     gsi.o \
diff --git a/drivers/infiniband/hw/mlx5/crypto.c b/drivers/infiniband/hw/mlx5/crypto.c
new file mode 100644
index 000000000000..6fad9084877e
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/crypto.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#include "crypto.h"
+
+void mlx5r_crypto_caps_init(struct mlx5_ib_dev *dev)
+{
+	struct ib_crypto_caps *caps = &dev->crypto_caps;
+	struct mlx5_core_dev *mdev = dev->mdev;
+
+	if (!(MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
+	      MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY))
+		return;
+
+	if (!MLX5_CAP_GEN(mdev, aes_xts_multi_block_le_tweak) &&
+	    !MLX5_CAP_GEN(mdev, aes_xts_multi_block_be_tweak))
+		return;
+
+	if (MLX5_CAP_CRYPTO(mdev, wrapped_import_method) &
+	    MLX5_CRYPTO_WRAPPED_IMPORT_METHOD_CAP_AES_XTS)
+		return;
+
+	if (MLX5_CAP_CRYPTO(mdev, failed_selftests)) {
+		mlx5_ib_warn(dev, "crypto self-tests failed with error 0x%x\n",
+			     MLX5_CAP_CRYPTO(mdev, failed_selftests));
+		return;
+	}
+
+	caps->crypto_engines |= IB_CRYPTO_ENGINES_CAP_AES_XTS;
+	caps->max_num_deks = 1 << MLX5_CAP_CRYPTO(mdev, log_max_num_deks);
+}
diff --git a/drivers/infiniband/hw/mlx5/crypto.h b/drivers/infiniband/hw/mlx5/crypto.h
new file mode 100644
index 000000000000..8686ac6fb0b0
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/crypto.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef _MLX5_IB_CRYPTO_H
+#define _MLX5_IB_CRYPTO_H
+
+#include "mlx5_ib.h"
+
+void mlx5r_crypto_caps_init(struct mlx5_ib_dev *dev);
+
+#endif /* _MLX5_IB_CRYPTO_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fb0d97bd4074..10f12e9a4dc3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -39,6 +39,7 @@
 #include "srq.h"
 #include "qp.h"
 #include "wr.h"
+#include "crypto.h"
 #include "restrack.h"
 #include "counters.h"
 #include "umr.h"
@@ -989,6 +990,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	props->max_ah = INT_MAX;
 	props->hca_core_clock = MLX5_CAP_GEN(mdev, device_frequency_khz);
 	props->timestamp_mask = 0x7FFFFFFFFFFFFFFFULL;
+	props->crypto_caps = dev->crypto_caps;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		if (dev->odp_caps.general_caps & IB_ODP_SUPPORT)
@@ -3826,6 +3828,9 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (MLX5_CAP_GEN(mdev, xrc))
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_xrc_ops);
 
+	if (MLX5_CAP_GEN(mdev, crypto))
+		mlx5r_crypto_caps_init(dev);
+
 	if (MLX5_CAP_DEV_MEM(mdev, memic) ||
 	    MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
 	    MLX5_GENERAL_OBJ_TYPES_CAP_SW_ICM)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 295502692da2..8f6850539542 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1100,6 +1100,8 @@ struct mlx5_ib_dev {
 	struct mlx5_ib_delay_drop	delay_drop;
 	const struct mlx5_ib_profile	*profile;
 
+	struct ib_crypto_caps		crypto_caps;
+
 	struct mlx5_ib_lb_state		lb;
 	u8			umr_fence;
 	struct list_head	ib_dev_list;
-- 
2.39.0


