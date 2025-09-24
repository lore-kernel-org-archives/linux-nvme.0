Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FCFCAC5B5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CBQnlfCMeBc647t+gcXBKm/W4/ViPHJFr3DjYSecSxI=; b=Bo5qHadzzfR2FI8KekhRlJxHM0
	FJKdT28K4R7203LHG0wH1xnAUnk9etoHOAHBvfvh6toNv21gn5Uy1+QJaiLoiPDlkE00Dk9+WepgC
	giyKhf6LEyL8UpeZfb6VKvk+e7yT+xg4AHjgMGq+TgvUphoFFNl5IGjYPxdMMevJwZnQmtGA4y4wY
	IMu26+3nOe7Jp8bK92QBeGWNnBPIp+spgASDBg1PfNaagg/psqXIzzgdfEORjtM0+WN+SuHMdzew9
	8xkGWWRAagTsSXDVHaE+8NsqEVYP6zRSUP9/j9fUI9MI/TNGhcP5k2gpP7Lpaj778GLOekpePb1jS
	gJGGtx8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WDp-00000003YIM-1iwp;
	Wed, 24 Sep 2025 20:36:17 +0000
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WDn-00000003YFC-0AGW
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okobKxP8YWrD+7J7t+Y7WGZhj52pUa2ae0cmw4Jk1wJ4DHkvGvg4qCT/yJ6QJ5ZoORn43p8a7f4k1tzzloVq+iF+eLffGhWtoaq7so0sGX7h44GUziJtt8pP9pZXZxp0AbpfqP/gE4W72Ew0yFCeIILnYPaiBKucrcoU6Ki2EDTsEcLfL5DJyr892XhNXWfYi+hoQNHIFFhdo9gRU3eA5IVCNb0juv+xPV8fuJBS5/5SB9Hblbf0B8LaPYEwQBh21RNdDZRsB3kSbZFVwVr2XPHLuMk0WpMnhCS0RhzCL7TXtiVRiDwMQf540o+OxgpVCgFhxZsGeuHW0uaRp4Pvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBQnlfCMeBc647t+gcXBKm/W4/ViPHJFr3DjYSecSxI=;
 b=YBnRw8WBYa2v3jdwU0oFDoDvEcV9vuZ2kQFOJigy6hw/u0fcVdz/mDVjwIBdbx9HCnrVM2qRrQsr1S4Q+zm9eaw/Vt5pR5XLVgauTH3JEK0+qBVpMfpO0Q9mF7qKBmy8TMUbv9bYcHEg93ZhBMb1AwMs9ocVpibhkHuzlG8lxlolQK2cnKyhJi+rZNpGWd4yQC/IXtKZhbCLr9gvtc/Ei4J+0AhyJOTYIqlI6LeblfcQi7udz/byQLgnw3ECVeEU0dWuCJjehtyzg/ECqc0bWK8aq9xKFOmx4bNdRbREQC+P2tTD6wbwfNS3Pja2y6HziO4Z8L6wNTv6oa4gmouhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBQnlfCMeBc647t+gcXBKm/W4/ViPHJFr3DjYSecSxI=;
 b=QTzVVFKkXlGfQvkP1xOUhC5cDm7t4fjuWP2KlWrMPeGLvwhpKtHb7p/FAPJGFF3Fsu42q3fO1x0lLWy2nYtsokT5LOsslXQFWyYtEvrkT2NJWeX1UmAaDGWe1Iq2jGV6TyY/DxNsvaSQMO+3SU7m+gavNbyXh8d4++4COcOCiGLka2cJXzk6L/F2OjUE/K0mlGNG4eBLhVGkZ5PdneV1vBtKoZmcb3ajBBKMKgpJJYIjT1sHlNDUn055fBgeT8hMYfLymafBy1ZXEmxWKGLzlmxuoaeTL37N0HhYrauF/azhC9Un+MG7O8PUFlGOicZCmRFA5+uX27AIenwk9z4z6Q==
Received: from BN8PR07CA0012.namprd07.prod.outlook.com (2603:10b6:408:ac::25)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 20:36:07 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::fd) by BN8PR07CA0012.outlook.office365.com
 (2603:10b6:408:ac::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 20:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:36:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 24 Sep
 2025 13:35:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:35:47 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 24 Sep 2025 13:35:45 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvmet: add sanity checks when freeing subsystem
Date: Wed, 24 Sep 2025 23:35:44 +0300
Message-ID: <20250924203544.11494-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f682b8-c51a-40b9-aeda-08ddfba9fd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phGeEyOLHYu8j/zY/v3YzZRo7/OIB55u2x8YrP4mteG06D1ANIVVvFG/CpQp?=
 =?us-ascii?Q?HTC8KfN5NOcKM7OeFejgfy3sTGj6QtHuhr/8q3kucgrlTkfyN25N6O/9nrse?=
 =?us-ascii?Q?ntw63hwDqciI8AjFKeg9DWbutSsQNBOQPs7OFlsANDGUMx8BhCKDeph/57CV?=
 =?us-ascii?Q?9BIRtRSrwOBDFi+dYC6ayLJnoLRpneP/sP850oybHhR97+6yjgQBIr7NUi+g?=
 =?us-ascii?Q?+sCXWGoD7yHUn2PCC4iYXRCf6iksqz7TLXQ4uMIoJRwOxfbivSSQEfx1WLLC?=
 =?us-ascii?Q?+pDl4xnAvLY+Pq1VmGTda2HfqVCwp9zDUgT1JU+7yoRIVJrzMq+Ir4VvZ5BF?=
 =?us-ascii?Q?uMCfUDqyDwQt/4WMUdS6Ci8CvAZYxl+SfEYUEMhud9WYF11j1WRUz4wxtZWq?=
 =?us-ascii?Q?hkL8X6027kd7oZ7ScCfYPD7zuirD9fF8QS6ukBFPbun8cVEChkqEfDVL0fSS?=
 =?us-ascii?Q?ohjGc0MfYi7dKgnyH7+0ogleRUfb8BF3LYZi6tfH65STfK0Kpjayth412wYX?=
 =?us-ascii?Q?m6atQ+0U+rm+1lXhW4Cqf3DjtHGU/ARUGTdfJnHYah/LP/ig7QsmalAHTKDx?=
 =?us-ascii?Q?yZz2HCuXfKnCLwkVZnxlPMo9RRzC3GAR+brvXlpV+NhtS3zCgF0u6dm2cvdr?=
 =?us-ascii?Q?xhQtV7BGRAAdX8QhqaR70dS5gOJKak/6XMDz0Bmdpn7L13CxttTeBzPAE0Hw?=
 =?us-ascii?Q?H5fIq4uwNxy3b+sALQ5S+HD2AayAcL8G0AFzNhyNcXSuWd9d4dTkkQLLVdVO?=
 =?us-ascii?Q?qmvax99KLcrPdnTSTjYurgoh8MDJgHwJ3BcNKiDJ75FDkQqxSz2Tu7nsx50u?=
 =?us-ascii?Q?JzxLEHDtXh5LVlt1LYq3HCJ/Zgv/dvlecjs/bHSRdTU4EYC4K1FLcPl/9e5U?=
 =?us-ascii?Q?wn6ckTsgcXetAZgAbEV+9vXnXbg7WWs3vc3CXRFZMpTc8SDPI2UiUQXz9+8a?=
 =?us-ascii?Q?njZ/UmHzPlsP7txg58FiXXH7EZxefHwDqUFoetI5Qel++2xkRTxSQ1orUffz?=
 =?us-ascii?Q?DwVu1TP8/sRJEnLJoMlA3wbPkU9PSc1y4UQgDDe+DLjoRuDtSOQlgGori0ZN?=
 =?us-ascii?Q?/bIeeQ3OloauOBaTx5t6G1InQpdZi2rTe0VBKqdsNTHfrOFXiScxHQsVvPqt?=
 =?us-ascii?Q?dME4fdikaThnrhVZoFbrEgaahIREMTwtveefKhuYIimKjZ2jAMP7FD/WITWX?=
 =?us-ascii?Q?GYM0gr1UADp3f8/ch4BATlTmURrNRl9/N8Gtmq0QZ1zuxFnE6g4r030IWNy6?=
 =?us-ascii?Q?4wxpHLgldO1I4PElzqd+4c4YZ61Gs5THeDQGckdfQOicUmvThyC3hy0gSj2y?=
 =?us-ascii?Q?yQxufS/5P7Hg8W3CLjkJRdzV2iHkHmUhyukLGBv/l9+OaANbht3YTxWOKcnP?=
 =?us-ascii?Q?r0hKlebkQ1CXFmi9BplHJ+lkC7jnoA0G22hC6xc/MtUa7uHPcrsaRR9rWCDQ?=
 =?us-ascii?Q?q62uhfhpQPGOdp38ncGbyz+WfzfUZuQN8icBbf+SBlP+69DXoeRgRWiyS9mP?=
 =?us-ascii?Q?QhJOWY+RzdSY64X8jEoBSbBK7dOUQRxxhSIi?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:36:06.8007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f682b8-c51a-40b9-aeda-08ddfba9fd0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_133615_077925_33C27E29 
X-CRM114-Status: UNSURE (   9.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add WARN_ON_ONCE checks in nvmet_subsys_free() to ensure that the
ctrls and hosts lists are all empty during subsystem release. This helps
catch resource leaks.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b64fcd2cd92b..61625d692c90 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1929,6 +1929,8 @@ static void nvmet_subsys_free(struct kref *ref)
 	struct nvmet_subsys *subsys =
 		container_of(ref, struct nvmet_subsys, ref);
 
+	WARN_ON_ONCE(!list_empty(&subsys->ctrls));
+	WARN_ON_ONCE(!list_empty(&subsys->hosts));
 	WARN_ON_ONCE(!xa_empty(&subsys->namespaces));
 
 	nvmet_debugfs_subsys_free(subsys);
-- 
2.18.1


