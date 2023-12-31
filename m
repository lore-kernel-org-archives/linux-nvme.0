Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A860C46CD2
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SOWcymORNuSAo3QRxACGKX303qM8w8GtzddIhSnq/c=; b=qWo6mtDQIgt+MR6y0cWSjOsiHH
	vn6d+YfdGIcnPSWlVhre92rdr0SVYXnT1lsNub/eivXUbGl7J67cFa3yJfA6vnxfOHkYZjb39Ie3G
	MUZA9+Q/pibS7MyPHGnd/zBwTTDf363xfxu8Gn50cngHiP+vR/fjtGPcnkcZ8wEBHvQUI5m026SI3
	HaMUIfbegL8Ah6FgLoSnGj8B1yqDNcVzp7zL/7rWuuIuED2sXXF4PS452iGnb/fUj0N1Ne9McDtFu
	CcMIwco++Lp+aXaGvoKHme4WFM5GOsQ21A6VIkwReXTo5U4D5/gDJhZ6/wCHkb8q7w9Y1k/hSQqGe
	3S2VE49A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4r-003fyc-0O;
	Sun, 31 Dec 2023 00:53:17 +0000
Received: from mail-dm6nam10on2062c.outbound.protection.outlook.com ([2a01:111:f400:7e88::62c] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk4m-003fxz-01
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2iOl1SdvM3UyosetSJkTG+4Bt3hn/xrmq7gaSzZH7YnjJDPRSU6lJBHMbizDEmetMO03Hd5bDbxk0Ddk+7fdB8yybSz/3j+VPKwgO4+QIzVqn9JGMkePxNT19krBfaOjwuObSX/0VlDn5gEllSL7PuB8IHpXnojGLVgb+a8r0BmXsXJ89ZJ0YJghiF+PewGK42fLs6qa7YqnKNGA5mgq7pkyvMnH2GYpJcSQCRobzuZBn4+S0ua8kPYV5o3He6MN5Kx0yTLbnvACxDoO5ln5ICVey7tYPTBBTzRaq2rPdlTTUMwCoRTKM9Tw+WT9bkoVRlSJSF3t23MT7JOu83u6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SOWcymORNuSAo3QRxACGKX303qM8w8GtzddIhSnq/c=;
 b=dvU9GgwyrFpH0jhVHEbkhBKXhM7lq8esNOPCySzobFUkRXzas/c5+p0kkpXeRht/s6a6m5EQC4oN1AZaan3UE+dONyhYfCxDyLiOVB992UvfemMkAuQU2S6t6YLlxSwsVenKHSL1E8J6xnueIVdWb/H9sJdiMv0q9K6xjZ2NhklmhMrC4AmjVKa3ZT7N7XNV3cy8NLc6I7bXVBzhmdvhMefICJR0qUvb11+m1xtCB+paW7Le3xIOIku1ZG9RS4wDvQfDcJZO1bEMk2gKihfNw69gY/2sh5W7LV6MvF9zQXiAkFv4M3LV2PGtglPqBdy+jCVI55WfRHGFnmAs0cY6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SOWcymORNuSAo3QRxACGKX303qM8w8GtzddIhSnq/c=;
 b=J3pg5P/s2s0mOMElvx66Mma8IJh449+zt8W8ut4dqOE5L6HuNuAwjq8ECthySlXl/p1S8oC1ul1uP9PFRsegiTlXjyHYZGzW8LHPQUNLOvPVTy4Ta+IxOKelOZrTblZ4BDgCNmwfg3oPsCTT+iOVl9k6nT9aUGmAc3Q4dtQUra7kLdT34RY+ttCWPNbDjlZpFXICiYgmvRYTwQf/v5Q+OKTtJoOIPNbtEqpKObMbisWckNiP3ec91uoRx8EPQtqbOlUWk9g/eWhW4LJRhsAx+KFdj+bfGCaVZCWYjj0JQHe9tBWXnAIXAbQET710zkS8DlfSjH88sd+tDRv3GhVHaQ==
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:53:02 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::74) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:00 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:00 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:52:58 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 03/10] nvme-fabrics: move queue size definitions to common header
Date: Sun, 31 Dec 2023 02:52:42 +0200
Message-ID: <20231231005249.18294-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 681b0b5f-47da-4879-1715-08dc099ad755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efrJj4d73/PLMFc6O0DhHF2t/XzLPsVcaSEdRh04DBRjSsunj2uG/+sBK3Ae9IgGLUN3OoaUPluJlbv8OYbFfhgQWi0C8cAy1z5fzqw2dpNTRL2hwHPaZIy2/W2rhS6TX5+PXOe44Wg6vv1Ws7vwgMycBT1a5aHpqgvAk6y8SzcCFYwHaR2/Z+k/GlVKBFTNVThSotkoU+vzh+e79CyoeDXejlT8K+e38k4E/Xw7If2mwu9wMoMI3vcBYeWrjH3tNTkHjHpMLumuIstiVorH7JbmWdJt03F0vEM3JVDdv1LysE27cCFs+QOcgq4uanqYi0XrTr5YpyZW/wd3505mpglHnGODiRgMVP7/klVvUxVCeZbLan+b/28ZYEM40HS0ufk7EojKguUTUHcBP81TktZ7rsTFqc2viddRexes7sOkBawnpI4aWSX370Uy1qJF7fG2Olu707HWNmt7MpUXev5aiRd4bdXq5HvuqXHYKgEUXbd4cdGjHe3GsOQUNGwn9j7G35c5s/FliOqLVpWpv6gxp6qwTzhiWx3WuJ9FuQPq/1EyjcMqWPkfO/bZ/2gM9I0i1VIaiEUL/SqUB+NJMlF5IM8xS+Vud4L9Sv/gSHTLzA/KTCGiEIjn1YxFYXavhfN94lFwZQbyzgrGZvLwOZQO/jB6ToBFixSDcAR07IgdKn6BWqDVw5XVbsGDOLM8hdd9DTWteK/UTHztW9Sna/r3o0ked4qEgDj7gNcMt/GAoBUbk9kk34EBI9DAmQnL
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(336012)(426003)(4326008)(8676002)(8936002)(36756003)(83380400001)(40480700001)(2616005)(2906002)(107886003)(478600001)(5660300002)(70586007)(316002)(54906003)(110136005)(70206006)(1076003)(26005)(6666004)(7636003)(356005)(82740400003)(36860700001)(47076005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:02.0653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b0b5f-47da-4879-1715-08dc099ad755
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165312_132546_DAF4E601 
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

These definitions will be used by host and target fabrics drivers. Move
them to a common place.

In the future we can introduce a common nvme-fabrics header to ease on
the maintenance of the global nvme.h header.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.h | 3 ---
 include/linux/nvme.h        | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index fbaee5a7be19..1fd75702d5f1 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -9,9 +9,6 @@
 #include <linux/in.h>
 #include <linux/inet.h>
 
-#define NVMF_MIN_QUEUE_SIZE	16
-#define NVMF_MAX_QUEUE_SIZE	1024
-#define NVMF_DEF_QUEUE_SIZE	128
 #define NVMF_DEF_RECONNECT_DELAY	10
 /* default to 600 seconds of reconnect attempts before giving up */
 #define NVMF_DEF_CTRL_LOSS_TMO		600
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ee28acdb8d43..6fca2ff6d0fb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,10 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_MIN_QUEUE_SIZE	16
+#define NVMF_MAX_QUEUE_SIZE	1024
+#define NVMF_DEF_QUEUE_SIZE	128
+
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
 #define NVME_NSID_ALL		0xffffffff
-- 
2.18.1


