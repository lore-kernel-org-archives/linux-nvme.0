Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B026C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:50:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B656128A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B656128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dD5Laz8QoVL4ANN1THxi/rmVbVS7yDjxipBoBpmDngg=; b=uy2+c0fnyyZfQl
	kh2l+w4esBTlFp8vh0yFaVpFwwMRqNqt2s1+OP20e+R3oAXIFdXMKvVM0ATHOxGozT/3YajLDERqX
	4dmA79K0ud6dSiJsUotOYApnbJr6RrjP9SD9HPY8LHXrOCGQYL7JVw/bN3ccLR+y/8opDW998Vatu
	G1agZbPqn+cOqdKjZqAE5aYlB4pQMqKmtKEEkvS8eT7rxM/zQQFMu89Qs1aP6roIxi2byQpVBPiDk
	Nr0R6q3+odxAYBY0U15vqcDkHkgeNgBOpargoDl3jmsQKdqygOEYzM5WxWiUFwnCR71a1qOCIO+nL
	GfxGAfbW2tavSu8uUOQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6XDp-001PCq-3o; Thu, 22 Jul 2021 11:50:37 +0000
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com
 ([40.107.237.68] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WX6-001It5-0n
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si8cQcfcUvqfdZWm4q/a87aWaTsi5GcClHFnP29LQvMbLGNU+nZ0xmZoLO0HbTcYyj3ur/PWQcVAJh7fDsryXZa4yVt46QVojUgUfRjArJ/FmnYzu8PY0vP/Ha5kKUochxMK5JUP4aCERXj6+4MNUVZbOGn2AjVprYy7vl5Pna2TllRO18qPWKvdo2uFxI+VTVt+Kruyogk4AdSk/c6u+2zhTpMfHgZkapFCnuxY706xmL+J00KIY/h43UIvXxsZdPyiCYFY3Xv9gRzs9ogMKCn5FzcLXQRpAXdiOl1CfTX8oQkfurgxdv/aY1n+fAL/e2eLkCOBsAZKL6rdpkpe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23J7hqJpBOuG1GMTJqcmOPI6EEn8sCEsgbnQNG4beLk=;
 b=MdvhpPqCa8YYcvXMpGZJ3ZfddMWDB4RhVtQshtHoZYAS5D+rr7kpt2E18PLuSrmoPwIG4t5sN0We7+tvg39OWFqJixysjKc42/QYOsI0Cq1PuZDENYxceKF+URkvkRa3VrWxiEUnv4jEKBGIHx6g5+rxOudgEDzChbsVOZfmQNNTpicjSsEgAMJSg9p6zdl9ZzchL0jdtgESXBbkDNk2XBvPb4Mxzv7k1QvtyswKkrM+YsqA69/iwJAF/As45lDXu0zdf+HMFojFkbpLyic4e1FR2viMjThZOPPreDXSh+XaMSVFXHVhcuOKo5hDxK/5j1qZzDoUiCVQdEpm0PMoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23J7hqJpBOuG1GMTJqcmOPI6EEn8sCEsgbnQNG4beLk=;
 b=FBKlBpDS+BUw82y/wp+tE9RsWpkPc7YlaJuw9yYyIsQmV+iR2y34dUKKP6V1T++y68AAZkGKT/hBJ7RBjoNDC8MgC3Hk4Vj7zXfc3TaVFJGWomMP0LuMVEDAO9LkwT/5XwT7sGtJQzNw/4Zr2zX/sbyW6xQkvl+a4S/TpSe5yK+gM9A+cRQG5gWuWD5b6wvYlIk3luowSkIF2UiZTfTdS+GPvysMMnyGuWJebbVdd3df1yt6xp8feAi79ikOQ/jEruH2FnKvbs6KPEQqhBylVGaycV2p5Rx300YxvSN4p2Y09EQWS7qVfEt1yY4p1Wz0WU7pxOOQ+3vCSRZjg84/HA==
Received: from DM6PR06CA0033.namprd06.prod.outlook.com (2603:10b6:5:120::46)
 by BYAPR12MB3239.namprd12.prod.outlook.com (2603:10b6:a03:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Thu, 22 Jul
 2021 11:06:25 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::9c) by DM6PR06CA0033.outlook.office365.com
 (2603:10b6:5:120::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 11:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:06:24 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 04:06:24 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:06:19 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>
Subject: [PATCH v5 net-next 27/36] mlx5e: make preparation in TLS code for
 NVMEoTCP CRC Tx offload
Date: Thu, 22 Jul 2021 14:03:16 +0300
Message-ID: <20210722110325.371-28-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8487d01-3690-4ae1-70f7-08d94d00bec3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3239:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3239A026381D7A6579771540BDE49@BYAPR12MB3239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IW8VFQ1ACzrpQQTv3agY6Jdx9PwDI+V4RL4/RPSMm49433TN4npr0VFWXUdX2t+/ij/yYKX9ve83AoIqsb7/hFY4ThUmDAH0gxz6+NNhFU+6BYokHWtYbL3nEUOLHrStqmDQz4FbRzUCNu84vUQQl4nbeGwOROhGvb1dvQEMcD9ucS5HW2pnIzlUGjOXDcylH38FUzPVe4ueyRBFQxpLH1Wo41sidOavOs4u30jRTek55JLPEw03qM9Cgvy0DJMqMHSy2AxhYXMbeHJYKmGcHBFzMNhXWFslC3MlY5T19YQ0VU0D75aw1auv+Hwn2HQhIo6oai0C+zKSTJqZadnynSGfiqfV25CHxtup51JZ/NCRaRQk2jZmGxK8nPV4mU960fwGkWXYkQrT6rZ37JEEYWfvs+M5n61PH+fSqkYF+DRjmleDhi82YRejVbIVgDkLgiyxiZqBOOmjD1ySZP/rNeYVg2GETW8U8HdVC4jEsKP3Qlet9s9LGUu3XBTRnxIiZrAvVDdpVgPhu3edpT/Cf14rhQtEpBTKJqkM94FN9GsvYg7Q1PoJl3GmUVjVyzq94rh1sUTDgueo4EZ2WutBE9JdmOuQxjDGcXNnCeutRm+JyS13ltc2GR1janX1Pc3lSyIjxod8duvbZaOUL4XOtwJkOJ1DtJ5skKmgh3pvafk8B2Y4Ov54HOP1uRuPQ79CvF2zD1+P2jFHimegHJ9K0g2ue3aOYdd3XTdKOG1Upfr2IIda7H2fPQG6rhyEsqrU
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(426003)(36860700001)(54906003)(6666004)(83380400001)(336012)(110136005)(8936002)(36756003)(86362001)(508600001)(2906002)(316002)(4326008)(921005)(70586007)(82310400003)(107886003)(47076005)(5660300002)(7696005)(70206006)(1076003)(7636003)(356005)(8676002)(7416002)(26005)(186003)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:06:24.4264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8487d01-3690-4ae1-70f7-08d94d00bec3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040628_160544_B44BA11F 
X-CRM114-Status: GOOD (  11.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Yoray Zack <yorayz@nvidia.com>

  NVMEoTCP CRC Tx offload is similar to TLS Tx offload,
  and uses DUMP wqe as well.

  To avoid duplicate functions the following changes were added:

  1. Add DUMP_WQE.type field  (=TLS or NVMEoTCP).
  2. change in mlx5e_ktls_tx_handle_resync_dump_comp
     to handle also NVMEoTCP Tx DUMP WQE.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h    |  5 +++++
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c   | 12 ++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index f0190ee6e42c..c7f979dfdd69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -77,6 +77,10 @@ u16 mlx5e_select_queue(struct net_device *dev, struct sk_buff *skb,
 netdev_tx_t mlx5e_xmit(struct sk_buff *skb, struct net_device *dev);
 bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget);
 void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq);
+enum mlx5e_dump_wqe_type {
+	MLX5E_DUMP_WQE_TLS,
+	MLX5E_DUMP_WQE_NVMEOTCP,
+};
 
 static inline bool
 mlx5e_wqc_has_room_for(struct mlx5_wq_cyc *wq, u16 cc, u16 pc, u16 n)
@@ -140,6 +144,7 @@ struct mlx5e_tx_wqe_info {
 	u8 num_fifo_pkts;
 #ifdef CONFIG_MLX5_EN_TLS
 	struct page *resync_dump_frag_page;
+	enum mlx5e_dump_wqe_type type;
 #endif
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 9ad3459fb63a..64780d0143ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -154,6 +154,7 @@ static void tx_fill_wi(struct mlx5e_txqsq *sq,
 		.num_wqebbs = num_wqebbs,
 		.num_bytes  = num_bytes,
 		.resync_dump_frag_page = page,
+		.type = MLX5E_DUMP_WQE_TLS,
 	};
 }
 
@@ -358,8 +359,15 @@ void mlx5e_ktls_tx_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 
 	mlx5e_tx_dma_unmap(sq->pdev, dma);
 	put_page(wi->resync_dump_frag_page);
-	stats->tls_dump_packets++;
-	stats->tls_dump_bytes += wi->num_bytes;
+
+	switch (wi->type) {
+	case MLX5E_DUMP_WQE_TLS:
+		stats->tls_dump_packets++;
+		stats->tls_dump_bytes += wi->num_bytes;
+		break;
+	case MLX5E_DUMP_WQE_NVMEOTCP:
+		break;
+	}
 }
 
 static void tx_post_fence_nop(struct mlx5e_txqsq *sq)
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
