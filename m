Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2239C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:22:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849F660D07
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849F660D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=izQ+RwsU8YAYscwjLP5zmTcVKE4034dyvuKRco/YwJI=; b=VuPn2hyJWqIMAu
	Ok9HqD5Vh9BfA5ySgh3OJNYht01AuJdMZSWLpZMH1BKHeZ/wDq/ri5aoQVS0NqLsgIHSrsdHOCNca
	T6SI1d5rPAhW8ohPg5Qd2bv0oIsKjTW0opyvj50067P7dda9X/YD0BILUx/YakThKRks1eV3OO+Jf
	QAVFXnKB9oyz92qoS87CmWgRuqjBhzAgtAieFRcv31Q27hmiI/oHi4bykWzGpLB1z5UDwkxGcd82t
	R1utugUXK6YR2aIRaDk+z4FrWisMGt1P8LuSm+crRetw1a8qa2+qAeaTnv+aifeRzWSO/cUm326eF
	+rNMXdqAfjulSmO6pG7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6WmA-001Ljq-D0; Thu, 22 Jul 2021 11:22:02 +0000
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com
 ([40.107.244.64] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WWI-001IcW-JS
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWKBVB2AGCp3LtyjLBZcGHyNF2Ohojz/nrzpAfueO0QOe1wiN40AWAU4F1YyT4Y4yyJ5FF3Tyk8fLi3vnKX9pUbYqC0HRq1fXlYjZQRrDpWsrlmixPWVA526jXzyoslEsaFYsyEHD1Bt3dWEm9M15wGcMcIOd5nLERtL4zapoT2YhFnyHd5YX5mizMiFqLf/Ct41kVm2+vya1BYr4aiGNqsoCHSh6fFcc1KU6oRZeLQeeNirDjZP11oIWDLC6dHa8/mnTxqmSg6+7rQGP3yNSKPB1SIJbyh6/aU8V8OyydNbEF0RPErw3qw07C4LSWfkHzCNfxS7nbiM+1g1iorG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSghkhcHtwYVrIl5SlfHjm8XRASFNZLr9jSOYysXWmI=;
 b=MJKpYV7I7ah6PPg2ZEA6SS4U3dbv55jpiHux38ldq1MLWq57iJ4DNnkKynmAywpNJlhubuvtF0/ySr0960Elj1UxghQwGuDzPHfAcjFtYmSIkLqxxWljJ0ndY5AJabHwrnDp0UnvdRkInrsd2OsNeWcNfTTGHgoMX7NaYUInNwcQEZe3iNU1j2Qzn6Ll48MtL92UkhQvUUaPhl6dHMcUu1yRDLgR7tFDR9/XuKqNUbGuYMV8YdeWPA4M9YM1Rq457gsn7gYhtgxjvk3z3PFOIu9MdWd+IwD2qZAd2Uz94W2anHPsUyjacYHyUQMz+Qd1PZf+tm9bEt/2cLjOHqa+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSghkhcHtwYVrIl5SlfHjm8XRASFNZLr9jSOYysXWmI=;
 b=Nz3VqiYALA4eqTu0zBGDW4MFb05MEWj004C+LVIxI/LhqbTiVza1pzmTAiWgG8mGwW3zfQ0NtcuQ267tdLYeyC2Gqv+8+TScvnZ2b27+FXW7DldFbccMt/sTWXurYzoG6BwEjG+6vIpc6CAGOXrh3xU9lkx8hmy538nAnOP1jhKeuqIep9bgiqA6rJ7hb/3JVP3LY6298HVhUGybRBzSkMmx8wBQce+cDVun2JRATHeI4ym0X8x3e6kma9aW6Lz9QhO4NXd6oGCVyPX1o4Rl+E5zRhhIYrDJhQTfti2n0M6++W9+R+Z5ZWEPqS2RbR+fZ/oSXOl4T9b3MQdTR9JXMg==
Received: from DM3PR14CA0144.namprd14.prod.outlook.com (2603:10b6:0:53::28) by
 SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Thu, 22 Jul 2021 11:05:36 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::a7) by DM3PR14CA0144.outlook.office365.com
 (2603:10b6:0:53::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Thu, 22 Jul 2021 11:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:05:36 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 04:05:35 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:05:31 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>, Boris Pismenny <borisp@mellanox.com>, Or Gerlitz
 <ogerlitz@mellanox.com>, Yoray Zack <yorayz@mellanox.com>
Subject: [PATCH v5 net-next 17/36] net/mlx5e: NVMEoTCP ddp setup and resync
Date: Thu, 22 Jul 2021 14:03:06 +0300
Message-ID: <20210722110325.371-18-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1776bb6-5ad9-4234-d866-08d94d00a218
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384B3B54A52A292178BE50CBDE49@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwkAvsDtpIvDRLKdnxIshKY8Zb6OpJQJQ4yQEcoS13rt+AeRrT3FysfUnQbYKEMzi5RC5YJLTOqWRN0TEufCocVO1hh5pyIIlxEpV1SR7KAH4U/8fyelGw99IP8KK5lQxFX8x20ECcJFExbxqdwp/RfVpn2C10Vl8O4nvcH1JAh2hqQliK0d4nw8WNLHOI5ndjCmmRbfxDb9IseyW0Fdbi+0XbGWDx+9qQj6fshuqTBccY50XKlRxeGYCYf1/vJ1C0rXWzMHMNteXThLvoeK+ttuYQA+tC5BM/ROrVFD1czYZOPSTmFMy+hwf/y9REWInLo6LemmKo2HBsdBcnBl2vLSOo1XlgovO9nDjsTNkvHzqkXoMuDwtoL2NBlFeVbk8aNO5/JBlIxW0NqS9cDWNoT5K8aqr90NTVP2NgPl3pyFmSxuqo7USs+kmdm58f76xk+roUOt47K1pjgZvI/W3S/ts+pMZvwXbsj5Rk1+F22gBLNeS0mPHw4N0Svh/kzqt9ePwmdr+vtl6wXJPKK8uJLoeXg+4W+EheOVdR/QtR0duDRc5H9bNt9Ij8axWesZAX7usU75AqBU9JPnaM+WSVhBSz3RSuLaxPSFB46veELmSBcJkE3vp6p8y2/80fR395RaxT1aFT4x/E22ekEemg9EUlqAjVJN9Lwj6cQfOraHsvUv+0qjPNhAFSmABhZCJGITk5MyDCqJr5nPpUBRUiOYDutY4gsSZUoWx0JE1fk=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(82310400003)(7416002)(8676002)(47076005)(2906002)(6666004)(8936002)(107886003)(36860700001)(54906003)(7696005)(4326008)(83380400001)(26005)(86362001)(336012)(356005)(316002)(36756003)(186003)(426003)(508600001)(110136005)(7636003)(1076003)(70206006)(70586007)(921005)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:05:36.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1776bb6-5ad9-4234-d866-08d94d00a218
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040538_727923_61BCB854 
X-CRM114-Status: GOOD (  12.82  )
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

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for every NVME request to
perform direct data placement, The registration is done via KLM UMR
WQE's.  The driver resync handler advertise the software resync response
via static params WQE.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 864b080cc8fc..4fdfbe4468ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -762,6 +762,30 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5_core_dev *mdev;
+	int i, size = 0, count = 0;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	mdev = queue->priv->mdev;
+	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+			   DMA_FROM_DEVICE);
+
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
+		return -ENOSPC;
+
+	for (i = 0; i < count; i++)
+		size += sg[i].length;
+
+	queue->ccid_table[ddp->command_id].size = size;
+	queue->ccid_table[ddp->command_id].ddp = ddp;
+	queue->ccid_table[ddp->command_id].sgl = sg;
+	queue->ccid_table[ddp->command_id].ccid_gen++;
+	queue->ccid_table[ddp->command_id].sgl_length = count;
+
 	return 0;
 }
 
@@ -819,6 +843,11 @@ static void
 mlx5e_nvmeotcp_dev_resync(struct net_device *netdev,
 			  struct sock *sk, u32 seq)
 {
+	struct mlx5e_nvmeotcp_queue *queue =
+		container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	queue->after_resync_cqe = 1;
+	mlx5e_nvmeotcp_rx_post_static_params_wqe(queue, seq);
 }
 
 static const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
