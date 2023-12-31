Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92BBC47077
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajqDfxxRTYvLm8BbyqcFVCem9bdjreDiHvkaa3MZOQY=; b=2G/OLqdVIlSkoeUqw3K+4Xk3fU
	qUGTRIKFGSLGyGkNJ//9ZTV6lImQOgl5hj3965THHEaXeORfSrV1bw0awW/hsLMfPdA+UQDyH9RhY
	XNZE1JXNF1KdLsqB+OKvBE4mHgV2fIsT/cnbGdkEot2eD0xFy5NcqqCV0UWtl2K8gXVd3MOPdGJ17
	labHQ7KEWlGTGqOUeoinDm4LgRn4k+66+/Pd66c+E6Z/Kw+P0hc3nYo+E3/9C5bpeMCWeFfZBn71Y
	reHbSsmYVduuESOCnVkWqYbvarSgjJ1flYr0tdjVwyZKnVnhxPZJOclYVJkzwlJD8yH4Vjye4K5LH
	fqjr12rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk5A-003g9Q-0E;
	Sun, 31 Dec 2023 00:53:36 +0000
Received: from mail-dm6nam11on2061e.outbound.protection.outlook.com ([2a01:111:f400:7eaa::61e] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk56-003g62-2Y
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs+o2Sh6ZcVdVzb12Qzgy/T1dhX1qD2dmC6aqZRuiVa2z+JD25Iqzqvx7RiVF+S/IEJzYqBrjmGE6wDfF8ta0cWUYNZW3jtd2yHyK8JolplMov1VDRc9Xbf0tOFulEY49eiMn8bKXEuzf3eyaVn/Ovve2gNi02xVbTT3aqr9BUfMAa7jRj8NH4xkgoDdADNmsHp6ii/pX/Oi1VZGHbc3ukPYSKAPQQuHm81ElyImEhic2QNq3CrckBKkITnM123uJ9HOv6Ljy56t+oqKFIryxHsY3ZgyWFfptMFK4xSlcAizrj3EVo/r2nfYA6cCPr2HULwmFhqRtuMsoEig+o4prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajqDfxxRTYvLm8BbyqcFVCem9bdjreDiHvkaa3MZOQY=;
 b=WovvKMCQ/t4MWeo3bBwQznWaEmPxprGsC5Wul9VjcMUx11i7YDckQcDEmFjTkgdCl5teifUbRjcEYXOYcb6ToNGSaWqcKjYe5lmeGMOYayNvbWYs7xeoZw1lgHt4UXO3lPX/3zNcrH5CzmIRJ1CaS5uzNghBqPW7Ojs4msUuemQM4sZ32Fx37rDjLEfUG6mcSTX2FLA4atRAzUSG/hpUIp2GM4bQ9dVULtEoYb22Luq+XHFH4icF4cJWajcMINVl0dOW6zI39auNVmUtfYGpin+SF4VSLwMLfdaD6wG5XI40TlhZb0f2kq07rt5un3bwPuTCcPKXCeCxUXTdsPFABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajqDfxxRTYvLm8BbyqcFVCem9bdjreDiHvkaa3MZOQY=;
 b=LHo39Lr2+SMo7oDg3ERfDnhJaHm6CzC4JD092Qw/sy2YxykmFoYZwHvTKNPzXFMbTD2TlQNx6s3Vg/oqg4+IW1ai6iJO2ZPhDFli1wqgWbefKKB6QY2f+n22myQhBa4Odo9+5YUcrSz9RuF+uaj2GI9/S3ZH77z6BOIYP6m3p4NBAE0y/mnAxER/k9tzghB270KidI6yKvR1KDiXUKC2K9cJGh6ehJxhTRb1oya6nyuKfSIVNss8G/XDBl1+fMqw4oe6Vg0UF016v2YhwMMD40pVkMrpGjFfP2Ke5Pk7AtyqC8Kl/WWV+kxuhbsDa5pKR6bDXU3YrHiKtEBCC2HXaA==
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.22; Sun, 31 Dec 2023 00:53:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::a9) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.9 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:20 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:19 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:17 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 10/10] nvmet-rdma: set max_queue_size for RDMA transport
Date: Sun, 31 Dec 2023 02:52:49 +0200
Message-ID: <20231231005249.18294-11-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ac8a0a-b8fc-46b9-6efd-08dc099ae68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLV9ceFLaSujig35ABxyJXiqFQZ6/sYMyDBrH4PYs0or6NzcETsQMyzrdFEwFshCC5+bfKJnhgMyE/wVxNWICX/dAJTInsXmn2TuwULADkApRDtvZi/wWUdqICMoW19dlw0LtZr8giKPLVpsGdL36lOUPrlcrJY/XBf2zN/k2AU72vVZCRKfX0+lXWGCf/cJJ5jHrC/EfHnlgWIHKTWuwvZwpA6Jv5h/wNFc60waKx+aROWWM0HCRDyrui64sPDo1FKthlrTje5v6Bin5mpChJZh6O5ZJyRaQyp7IqrdMqIiyaDwI4yfU9uKBkikGh4BIHxQWdXrlJ4ND70TrDgRVw/m/YT1ESRk7wXcsSM1i1ibt5LFfXCCN6rG8p/RzAl5a+KdoqRE/F11jNnSynDGv8e02kv9Em+nFezfnwq7qXEoFzC7ayP58Ch32EiEN8I6sl7RaZ2mLcE/l80NF48IsMuxrujmrJQcPq0V04P22CNETe/6fZKrZIHNz+ClRUhLxiES+jpE33JZD2glLlgKoCaPRgk0TkDx4L3r76GrRl2ike/M6Cp1y7yqBmZoTazc65S0WJG1ijKYkRqjbJOnbpxaCthIGeLfCyzrAjT7sTx9C0s3iWpJkq0GIadAi2/dg/Tn/sRnLk2z9ljxJQjEXO6r+4I200AId6eGkkxRlMLr/TKFj6GhT/Xp9OLjlsar215nDPtfpfVSdOv3V/G5LfG9l/y8BJP6KJVKiMXS0ucTYOK01IXOjPScdozcz8tL
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(336012)(426003)(107886003)(26005)(1076003)(83380400001)(6666004)(2616005)(36860700001)(47076005)(5660300002)(4326008)(41300700001)(2906002)(478600001)(316002)(8676002)(8936002)(110136005)(54906003)(70586007)(70206006)(86362001)(7636003)(36756003)(82740400003)(356005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:27.5650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ac8a0a-b8fc-46b9-6efd-08dc099ae68a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165332_833416_F28F205D 
X-CRM114-Status: GOOD (  11.51  )
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

A new port configuration was added to set max_queue_size. Clamp user
configuration to RDMA transport limits.

Increase the maximal queue size of RDMA controllers from 128 to 256
(the default size stays 128 same as before).

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 8 ++++++++
 include/linux/nvme-rdma.h  | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f298295c0b0f..3a3686efe008 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1943,6 +1943,14 @@ static int nvmet_rdma_add_port(struct nvmet_port *nport)
 		nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
 	}
 
+	if (nport->max_queue_size < 0) {
+		nport->max_queue_size = NVME_RDMA_DEFAULT_QUEUE_SIZE;
+	} else if (nport->max_queue_size > NVME_RDMA_MAX_QUEUE_SIZE) {
+		pr_warn("max_queue_size %u is too large, reducing to %u\n",
+			nport->max_queue_size, NVME_RDMA_MAX_QUEUE_SIZE);
+		nport->max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index d0b9941911a1..eb2f04d636c8 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -8,8 +8,9 @@
 
 #define NVME_RDMA_IP_PORT		4420
 
-#define NVME_RDMA_MAX_QUEUE_SIZE 128
+#define NVME_RDMA_MAX_QUEUE_SIZE 256
 #define NVME_RDMA_MAX_METADATA_QUEUE_SIZE 128
+#define NVME_RDMA_DEFAULT_QUEUE_SIZE 128
 
 enum nvme_rdma_cm_fmt {
 	NVME_RDMA_CM_FMT_1_0 = 0x0,
-- 
2.18.1


