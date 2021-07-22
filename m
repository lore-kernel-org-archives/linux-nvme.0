Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52955C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:02:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1984A6135A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984A6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AN2QUzf5O1fMXt2kh6yNnns83wdq0rIHy0z1vQJF8x4=; b=xXmpsUmliJNaSE
	5Pmr/Xb2W/ETuN6MJ29W8z1KazjTDPm5hlSDMyoNsUHrjxpoHq3jaADxtVQVCVMg0Dg8e8DaAVbfL
	6xEqqGt7qSOMwpg34Htr4fj1sPSwGOJ/x2Y/LNLgUnTD2G1qZsdBmJgsqcMSfO/w3RzUbn1qDUM5Y
	obqiWvBY29U0fxYd4etfrFpZxyUd/G6TcYPjHRY7JEKNRndapmUMw/fbjl9JO1gSCCpWWCWOXs1b3
	HWn3mm1N93lArAiC6J7FNFq2vD4kOjcCvta2DYeOpvjNFrLs/InXqP9b32uWmmBnbSt2yhE8spkYU
	+aBz7RKzqfv71msOYoNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6XP0-001Qrp-Bz; Thu, 22 Jul 2021 12:02:11 +0000
Received: from mail-co1nam11on2065.outbound.protection.outlook.com
 ([40.107.220.65] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WXM-001IyE-PC
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:06:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb97q/s1+ZXHF0lcWUHy8CJe1Qxst49HeMkznwLrTkRJhPhdvy/y40WeMJE+zRACsvEH1qiNW7zR7RQ0Wv10esQRPM72U9udQdUkMncQRt/mn1Qt8t6Ze62XG5FAGgz54y1ELVja0S+tSOauMHLCb3eiuLvT1lkWvj4q8mzNF/Di7KDnZxlR+wnf+naSz4i9SweJiKiUO07tUHATh7x12hwpRYrSK4yeh5jUXy698g5B921UanwxYbqtTeENUz6C5Mrm+Hi6RNqfA55aZ6qMINiyqH0Y8bNuqcYNxH2cZ27Al4VDRV/Viru2xXsN5Ki8vnhTITLIMCDWoi/pnAyfqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hgX2eAKk6eToFJ+7VZTHz3wQjJMmNFuvM8vG0/psnk=;
 b=C1C3qp2xD8lUC8vdvI9r7+d2rcoW6ZK5sg+J4MeT1PU+rEyjrH3jy23cXWrtCDoEKJFXPOXra/zxty2aXl2lJWbPIrDpIlEOmhGZNOxUtNguGYlW+WTRWB4c1904R0wIV5KMjpod1+wxRm3zxP/9bm8PSEFA9QIzxbjnOLifX4d8TM//EPunDML8sIaY/cy0iGIEpz0iyexplRAFJccW2XyXhTFPo2yTJ3A7EKHjPYbN6+QuJAyUveSpawVSCzeTLkZcrym25jc4kwcSN2rVXuGV60w5OAIkagIM39zBTCAG/AP24S1KzyAO4dCpbtZqNqCDUBFfGn3m2ewRYjiRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hgX2eAKk6eToFJ+7VZTHz3wQjJMmNFuvM8vG0/psnk=;
 b=UgxAd9wiuIA4Dt/7+qcj2+SYtjUEMFeG0swVCAUmbShZd9SqxkALDx/I9E5Xtpq+10JCg2Biz1pAAFNR83ihOSDb0rvW9w9+K/ZyLrx9ULkxi/0j8PAPPj2d22bbCFvA138I7LDSIPVjJYbffRCS63ecnmOLVg8masQVb6nU6QCtZ8w1Ziqltyqd3r23LKhw8VJQEWBn3wA4dEW+IA9/cb5/s9EfQQRsFZjVBhrmiSD4eLJLhEGmZnen/dIliGpMb5UXdl+TLoSubP80DQjBPE3Wn69YbU4XGTmEt9N3PXDsBQQvFxj2JK7b+0KmQVIyeWcVKHNqzfLk282imthA7w==
Received: from DM3PR12CA0138.namprd12.prod.outlook.com (2603:10b6:0:51::34) by
 MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 22 Jul
 2021 11:06:42 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::83) by DM3PR12CA0138.outlook.office365.com
 (2603:10b6:0:51::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 11:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:06:41 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 04:06:40 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:06:35 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>
Subject: [PATCH v5 net-next 30/36] net/mlx5e: NVMEoTCP DDGST TX offload TIS
Date: Thu, 22 Jul 2021 14:03:19 +0300
Message-ID: <20210722110325.371-31-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e535892-c5af-4d47-cccb-08d94d00c917
X-MS-TrafficTypeDiagnostic: MN2PR12MB4519:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4519EB60AC510F897B6BF065BDE49@MN2PR12MB4519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:25;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRhrv8gPZ6lYjbeXOtH6dg0sZFzA9KTCh9NEWJXhjS6Dia3ERscy6eAONkH5vV4w8F0bF/grEJN+/x/Qc0tW57qxrzc4G8HlMoOzb1wX4KlgDmy93hLp3+MaLHpZvNmIdPyznqDZsfjzdUeMRzl8CmP0UI7uMRmxXmq14E4hnihdnpvVIl38ZyF+ROWgNKmUtdQFxddHdpR9FKn1l0TitMN+NpXx6slZvoCq7st5xw80Ax6c4+ZYkji6DNM/YDoDuJjejtJEgpM19OmPVxFnPxEZ1WPS5xk3jUrnLwD6Gr0QeGGKmw8O3UkXDWFY6eTG+SBlsIiMnE01QqPaqDTwIW2gXXKtfNwq62XFNgBhsINpJFWL68iasYYvXZxUxQGsyl8D+0vSQQAI77e8jQE8qVbUtYruaCwCwaAnlYavH9t28SWl1rMoMZLcS3F6OXDf3Ve4Kud6hliFg1Y8XEvVku8HniV4KUt9ud1iOY0lgO19HGXNNoW5hQ7p3iaGF+LnhRt+b9FCcj1kOcHQEMj37SZnOJFEffkVyPEYthFHEPfOegE8BzCB+E2RQc30XxymmU8QfQmVK6bYdicGZP0nxYz4CmTwIURwXR9kFaqE9xtN6lXUlwTfBpZZSPrlSfJR/jl6cLcqhDn7QU1K1TcvQoOtOh0lg7QwOzXyCU0VnL3aHQRCgB1iMD9b6cOENR/ROaJEdJkYTMfEK1FnkUCacJpDketeprA2tV3j7uPlNyo=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(2616005)(426003)(6666004)(70586007)(110136005)(186003)(5660300002)(356005)(83380400001)(478600001)(4326008)(8676002)(7696005)(8936002)(36860700001)(82310400003)(316002)(107886003)(336012)(36756003)(54906003)(70206006)(82740400003)(2906002)(7416002)(921005)(1076003)(86362001)(26005)(7636003)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:06:41.7655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e535892-c5af-4d47-cccb-08d94d00c917
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040644_910685_416CAE00 
X-CRM114-Status: GOOD (  10.66  )
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

NVMEoTCP DDGST Tx offload needs TIS.
This commit add the infrastructer for this TIS.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c      | 17 +++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c   |  2 +-
 include/linux/mlx5/mlx5_ifc.h                   |  3 ++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index db6ca734d129..d42f346ac8f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -35,6 +35,11 @@ static void mlx5e_nvmeotcp_destroy_tir(struct mlx5e_priv *priv, int tirn)
 	mlx5_core_destroy_tir(priv->mdev, tirn);
 }
 
+static void mlx5e_nvmeotcp_delete_tis(struct mlx5e_priv *priv, int tisn)
+{
+	mlx5_core_destroy_tis(priv->mdev, tisn);
+}
+
 static inline u32
 mlx5e_get_channel_ix_from_io_cpu(struct mlx5e_priv *priv, u32 io_cpu)
 {
@@ -137,6 +142,18 @@ void mlx5_destroy_nvmeotcp_tag_buf_table(struct mlx5_core_dev *mdev, u32 uid)
 	mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 }
 
+static int mlx5e_nvmeotcp_create_tis(struct mlx5_core_dev *mdev, u32 *tisn)
+{
+	u32 in[MLX5_ST_SZ_DW(create_tis_in)] = {};
+	void *tisc;
+
+	tisc = MLX5_ADDR_OF(create_tis_in, in, ctx);
+
+	MLX5_SET(tisc, tisc, nvmeotcp_en, 1);
+
+	return mlx5e_create_tis(mdev, in, tisn);
+}
+
 #define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
 #define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_STATIC_PARAMS 0x2
 #define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b76e590c237b..2a9718d3c2d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3152,7 +3152,7 @@ int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn)
 
 	MLX5_SET(tisc, tisc, transport_domain, mdev->mlx5e_res.hw_objs.td.tdn);
 
-	if (MLX5_GET(tisc, tisc, tls_en))
+	if (MLX5_GET(tisc, tisc, tls_en) || MLX5_GET(tisc, tisc, nvmeotcp_en))
 		MLX5_SET(tisc, tisc, pd, mdev->mlx5e_res.hw_objs.pdn);
 
 	if (mlx5_lag_is_lacp_owner(mdev))
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f0310c24f408..a4965bf1e607 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -3300,7 +3300,8 @@ struct mlx5_ifc_traffic_counter_bits {
 struct mlx5_ifc_tisc_bits {
 	u8         strict_lag_tx_port_affinity[0x1];
 	u8         tls_en[0x1];
-	u8         reserved_at_2[0x2];
+	u8         nvmeotcp_en[0x1];
+	u8         reserved_at_3[0x1];
 	u8         lag_tx_port_affinity[0x04];
 
 	u8         reserved_at_8[0x4];
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
