Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31600C47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajqDfxxRTYvLm8BbyqcFVCem9bdjreDiHvkaa3MZOQY=; b=jdRb5OLM9/98lhG8zmLyJTq7Jm
	gFoN2O00/Trzh/hN9SoNaoXJWd15HQkMzEH/kjSSuArwFBprSEOvHVTKa3Yjdc54KG9g1glZ+gMWA
	jM35zvRLP6F3uwZCk6XXrYj3gHnGLZ8WRCqdl0+KqAuSFQngBxW3lq62i+XV/mXVEUrLhfPgGWYQ9
	Ov4tAamg2qv2wXk4jzrCOoWMQOjplE17ty5NzxcbtZBZ7eOuOWBagZVP6E0zuelKSaIOtl+OPTZWi
	FRGaCEPIyeXW/KtpGqwBNe4bcYAEypU+AlkSTK96YZMT9YcLDdTspzJ827BnKV4ISOoTSFCJ2eP8g
	1jRliGmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzn-00DMZG-1r;
	Thu, 04 Jan 2024 09:26:35 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzk-00DMUr-3B
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JK/DeV5jAVx6pHkETq7zoR7iVz2575h9IFMhM/pOpHFDp8dTLpXBZc4mPsQ0E9dr+ttnaxh9zaRptpifo6Owa+RT3U1eAtc68Nu8JKlBx5Oz7BQWaTdzlmhga50osBws7u7ba3w6erR57Vo2Gqdh2Je6UvhKNcQ1jeGFQPESoWQ9uOXztkm3qt1yb3VNY4hv7kEiqvx0aQqNXGMcN5NJK6Sn72PZPerxyxjVQ9Ds4r4Wv4UgAQ7m2Ynck13nARaOWdu4yX8ZBfg2caiCXohJEM5B8JHhTY2afiyfKDWwOMHqIru0iymRBKb5WNqto3U4DUhlHTxZfjEGIW7qED5Alw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajqDfxxRTYvLm8BbyqcFVCem9bdjreDiHvkaa3MZOQY=;
 b=dei6zCVwHzzVu3uyitNdQic+5RW5tmKgj9FRth0trW7JqhNADEBWh668UF3wcK5UoL9aoobFc5kIsORpIKCeM0hdmtT+R1n16GRs/jbubnAzFYIU7cVuuiXCFGufpBn+SCZ3g5onpfbPJoMA3CZzJfwXTput7RhtMRzHdYn71EUtHgB2VhmG2kN7r+cvDXYqQCBY346+9DMJQU4U6J2Dc+A6sG5obcXcVrXOb394EcDGX8F8S2mJbPzz4ZgHBAm7dZV24qIQdcI3FmzqLtkr52GZ+NwjyYgFAyOUPi6AQlb7BqQ2qQ4hMjptpjT+YxGDMyOEFuRUeG8dQQ9t+8USKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajqDfxxRTYvLm8BbyqcFVCem9bdjreDiHvkaa3MZOQY=;
 b=Dx55HZvMs9Vc1hIU48W21zn6XnZiwjtWboBDRp4XgyUiPZl263O5+4gmKBeSbYeRh5TtmSzYAJ2enOSnOepNC/ryROb5wcGpopdwWOexT9wGPML21IVR87FwZI+GE12U8XBwqJessgvQyt6jOlOyw7U2n32R2y8Zk0+hrerMqUAPJKrnfkhmnNf9Kvy60+wE+oyjGmXuiM+E7qXqGbu7wfbjsk0SfdOvpoEd1pIpzIL3taWQCG0ksWn66WODVrZlWUzgt4pjRILzADMGLTgj0ilqd2R/DIyvCq0U4B0Lz8RqdU/LERRdAvMBDkhfbbVWwcd5Ff6YCfxCrGy4ooWZFg==
Received: from MW4PR03CA0070.namprd03.prod.outlook.com (2603:10b6:303:b6::15)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 09:26:24 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::92) by MW4PR03CA0070.outlook.office365.com
 (2603:10b6:303:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.1 via Frontend Transport; Thu, 4 Jan 2024 09:26:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:26:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:26:11 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:26:09 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 8/8] nvmet-rdma: set max_queue_size for RDMA transport
Date: Thu, 4 Jan 2024 11:25:49 +0200
Message-ID: <20240104092549.25721-9-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c74a59-9734-4fa7-ccee-08dc0d073897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW/Tdce/32aWE/kzJMz9siRrtxzFMAwzsTft9oZ61bDuJf/e/KUzlNarq0LoeO7L3Z7NJLly3uRaSo7MVJuz5m4ud8i57/QqYoxFIDwZHO9Jt3Bn6i+9l2YSyE6I3DLlRxNsetS9mE3njJoyEgQCMLBcgzYepdm4eLGC9ZJhfhJH+qC/pdtSugHhwlU9W7dT+5pOnNhY41nyjy9viousWHLJdeRLLm8XiMie8z7iqgi9vsc+96nBPId8fexGJz781yIhcJnTcK4s6U3lZgzn8jXjMtnHwlC6PxlHuE76Depdern6caJ7HVS02aahcc0XztUQ3w+mjBxc4QJkEJ/lyQPlx33gTznKyVkVVYl5z22ZIrkqGWGRpYbIawk2RvG2I/WRXGMHzgicmK690zBeVa1i4dDOTNAl9YeJdgIyaAec4jiyVmmZYWDzUZo6zG5JvjArpFxd5Zmn4PneL0LEjkX+PS4i1iRgLIsad4S5NZTBiDE5Baseyw7hdXHzoz7riJd3CDNcYCvnfUw0Rt9vl+oFqWFcmV2rgcXsnBZXAeLEeJMi+sqCj8jAhV5A8RcvMP/u70E5r0TTOE76I+HlfQ2b4bKqo7OLohtAN4L1JdxrpoztpA95IXpvAr3RZxIcast53Ncod7R4AKgfDnTjUpKmtP6cS4EYreyDunFRaKflIud0oiznUqdVz8GbYXT9dkn8waAiXfta+66OF1mIcQzy2wXrkAWOYCucX2qwbV3qb8qTEZPwoUOeU7nNqVVQ
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(54906003)(83380400001)(110136005)(316002)(70206006)(70586007)(47076005)(8936002)(8676002)(4326008)(6666004)(107886003)(478600001)(2616005)(1076003)(336012)(426003)(26005)(82740400003)(356005)(7636003)(36860700001)(5660300002)(2906002)(86362001)(40480700001)(40460700003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:24.4391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c74a59-9734-4fa7-ccee-08dc0d073897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012633_077118_9EA6DC2A 
X-CRM114-Status: GOOD (  12.81  )
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


