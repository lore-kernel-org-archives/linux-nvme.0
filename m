Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB2C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:14:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F8C61289
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 11:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F8C61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=13C/0Gaod2ABC1IlUJ0hGzorccr8nXTv49235IP9+BQ=; b=IIteyRRhmVq+nb
	346oYOtW4cs2mHj4V00tq62rqZgvt/KH+Pj5GTGyoHBmWE0qswk4sMvrITphoYPyalsUoVsiM8qn0
	QLtNe6OdUbFMH4ZnM71Ki3XUprq+MvBjIF5O3DrKXpLiFfYr2b8KsVZVteMBl7KOrJuL+zI/Z/Rua
	JGvtRl1iJALcw60XNn8v8mpO/IsYZKPS0CPzonzCXCsExpl3yGORuN+gT7+fbp+f3OrZq0pg9uW+Y
	k6/OvD7UrjQeybiW/vTmtJ8mUjgTWYzpAVpszilF+pQI+0Y2Ytn6x7RmNatw+NUA7u3kbDYEGtxVI
	y5OdmsAcOh9fBzMwsQqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Wex-001KdH-Lg; Thu, 22 Jul 2021 11:14:35 +0000
Received: from mail-bn8nam08on2085.outbound.protection.outlook.com
 ([40.107.100.85] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6WW0-001IV4-Fg
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcB0XpOQlcOyXnE8ycyuirGwQX3+Z6qochVfQGgkHK6Wtu9f2+W8sh7iW91QVYf2AKmfOkvDccWhiKfJSY6sHkwmz1Wn0qRr9I9DQQLWwTweukkPg6rlep6LlmcT4ZKjxm5l5MJmNyVIWMKOe/bnfMWIoraKP65kIYg6e+FoROAF5iJz4zw6wAQMt/RoR8l+Z3h57RP0W/NyHyMlR/43o5TO0NA4u24zOdfSlPzOT7uFvs1QTGsiT22epr+R2d5CYePkORIMkGmnbFXDCwE4mX1JExwcJBjOAgB0i6jJKiO9P5l/U0w1hvieGl3U5XgBUG896uIk7p7s30ieKCBA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ShtaS6eo8A2UqvC6wCE654NQk0YfniZ9oq5OWx6/J8=;
 b=DDhCnWVmCah1wi3ik6MVwugNfpboQxe4vt0sS+m5aJtG/m0GDHqrxEWOcYbB/jux10nWpLl/ZDMTTzVIaYBPd5OQ99RGjpLkWACSE7vN9xlzZHLxtTfmk9h5YIyd/tlINvhcNLbzE9x3EaQuWg46vFbAWHc3q413j1B9NaQqC+MxeGnBB51LRwWxuWOgId76RppoRsYuvYnnvZxJYtSf0YLG3nKZjjKo58Akf5NTTUcrmdaxz4kMG39m5jqOcp9aPji748DsxqKSxuC2kLUfbbvfInsdLPPPkPCuCL7Bm8JM8Ul2aNW6Qlk747+qhGLdpNeNCmlg8os45wYwXsdcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ShtaS6eo8A2UqvC6wCE654NQk0YfniZ9oq5OWx6/J8=;
 b=tqYi3nuvuqXEeBlvbTgt7hD/OwbXpU9RE3SfXBfoTH52TRtW8Bb/NLhEyezvmWnXO3df5AqF9hJTnp+aKgEcAG/VVJENaRT21q9g989V+lD5fpc5yS/LtWU3ZGU044+3T0nyXViIXp7Pb3xN0EQFV2wyIoWZ5xduzeZNHRYlScq+UQu8wxbE/fw377qra5+IV9waHvkaKQ0ne9CzGKMEyXlwt6TOWju/bzPIyG1O2SnBlOUVi4zGvyYzKaRGoh0WQRLz57u2dz87WBqUbrPM2QCaq2lydxjRwS2gAeD9D4duOPqRz/j4HPLpWO2AAFY73cCSQ3913yUB5tOacw9qGQ==
Received: from BN6PR12CA0033.namprd12.prod.outlook.com (2603:10b6:405:70::19)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 22 Jul
 2021 11:05:17 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::f2) by BN6PR12CA0033.outlook.office365.com
 (2603:10b6:405:70::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 11:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 11:05:17 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 11:05:16 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 11:05:12 +0000
From: Boris Pismenny <borisp@nvidia.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
CC: <boris.pismenny@gmail.com>, <linux-nvme@lists.infradead.org>,
 <netdev@vger.kernel.org>, <benishay@nvidia.com>, <ogerlitz@nvidia.com>,
 <yorayz@nvidia.com>, Boris Pismenny <borisp@mellanox.com>, Or Gerlitz
 <ogerlitz@mellanox.com>, Yoray Zack <yorayz@mellanox.com>
Subject: [PATCH v5 net-next 13/36] net/mlx5e: KLM UMR helper macros
Date: Thu, 22 Jul 2021 14:03:02 +0300
Message-ID: <20210722110325.371-14-borisp@nvidia.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210722110325.371-1-borisp@nvidia.com>
References: <20210722110325.371-1-borisp@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcfeca52-a895-4e25-6fdd-08d94d0096e2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5043:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50430FF8FB42B776ADFEDA0CBDE49@CH0PR12MB5043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8ixLzW051jwRcdhKIbeEwdCNE4dn3bnMEqFADKqI8dQk9N0HKhxFzOoS+3uv2TBNv91GG89AThvbBQHtMWBr/T2qpphhyZTDtoL+/WPIuTq1Ou+EF0ti871LYXpsku7kPtNWvTJoE+j/q+GQ1h7nrulKyt4cT2d6rwHhOhkXLTm/XBj/XxwHBrz6a94fcM6iM+MzNmpF+fLACvlc44pXd+HFi00qFZ7VPxOtRzdjrFxcaZOIhAvSepZOu//E2prVu34dEu1N4wR6+y3OyquYLZDNUTBw3mWyYobBc3IBXqgV6ePhfnR4fh1WloF7Wf7QL2wA3AxYAFovAUvuk0FMgzf7AHRZvC8GbjNJoCdZB/0oGsX94ec62iw7rHPNKDLFAYAG0UW4ed0bBuTyXlTVynOBgagKjMyPiur/x5bt3dJb8go00D5Mcrs2x68xurzSWNH1fyW6uonrqIj/WUf2GD8B984+khXPcKY68lN7kWh68AoDyIEArLW2ymyveQl/qe5rc+L0rlFQtFt+9ChXwFYzDT5tMveILByWs4/TlHNA2NDUf8eD+jQwlY6eMTJFfswolb6rj5ESTTICNF3QfiH/8EnYgnrszDhJMAYgZuvpTRHUn10w9VKOjQWYDdsotTrr3ZepJwm1MvXmo3AXsysy/A1PvG8zhwXILJ/eMx/y5KOTh/tIwfklmGypO0lhmkMkck7BQqo37hs1yX7gn6avr5sbnzVsxT49qAAtmA=
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(107886003)(186003)(8676002)(82310400003)(86362001)(36906005)(47076005)(1076003)(7636003)(426003)(2616005)(356005)(54906003)(70206006)(70586007)(316002)(508600001)(336012)(7696005)(36860700001)(7416002)(36756003)(6666004)(5660300002)(110136005)(26005)(4326008)(8936002)(921005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 11:05:17.4817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfeca52-a895-4e25-6fdd-08d94d0096e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_040520_595750_28A751C2 
X-CRM114-Status: UNSURE (   7.15  )
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
index 1233ebcf311b..5bc38002d136 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -155,6 +155,24 @@ struct page_pool;
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
