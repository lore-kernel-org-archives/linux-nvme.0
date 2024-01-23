Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC6C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPt7rHMxPmNfQEMUGwOuv67c023G7THSC/b7+Y+MezQ=; b=x8mKwNx4ZfDm25CZGTNi1ASAOh
	ctoIf7FUmCBgOnRtwUr2fGqayaUmNhJQCkB6G7igf6VA57Yp+rko8j0HDgO+rZSPEm3FnwsDalGRD
	N7EMaz5pYPqxXqht0kCULPIiuhjJwc7UTY6JYK3Ah07E/gV3I7YYWbN126SAw/JFlo7NWBBk3ItE3
	m9kKWiPh8+aHjX3iBZWL3fFS46eDhJ0Hc54dG35rbySflEYZ6HJKU6fbS25rStiZ3sIgvO/3yQQI1
	pMMWnqajLPkHGB3aGxhuiKw/lFd/4DD3cG2eiTvYo3kbgJUyElN/udf04aQ60XQKpgoww2Gy9Yl/e
	7yNtsZSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSP2I-000d7O-2r;
	Tue, 23 Jan 2024 22:14:26 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSP2G-000d6q-0a
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 22:14:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O42JQlTHTFX/mXUfC+C2YEldaLRn3sOPZdyO6ZSa4CUQXu0wrfIc8iwzIFVI3+cD6Z22NrLoADAcgyL7gocTmYYLjUa83IjynetcFWxbDB3r7a5NxRgt/C/RC+zFi0DxpZYQrpHJ6nRl7vUnBJZ9CPBhbFMSbDg7+2YOdreBbI13ojFJj12NC85t3FGdSLUtbbsoFw9tIaCTfrZFnoO3ispy8eEhtYIFCMguztDLGqAdtpZW+IVjcHIBY2MYI7CWu0Gw9k0UiIhCoAcQOCr3GAEYHocow1DCUCh3pQcXdYJvg6Vz4r8snJ4BkHVERAM6LSw5jX/XR8rxTLnhul5NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPt7rHMxPmNfQEMUGwOuv67c023G7THSC/b7+Y+MezQ=;
 b=Rrh96pOC8JTQs2aHQmhFA9GMr6l7AJ8LQP74xSI5RubUc35BMqiLWBhoDGbupJRrseYQtsVS3hmz4IBpUTjOI4W9mPoVwyCCGADZIwJjnFUFCjTM0c/Ys9BOKaxpAUill1ZNSX9xJCDe2eoXlWlEJIXnSXQqa02fqh9mdU7etIPBNKy8gdcm4Js+dRkQXA+/Z6vGRd9FlAGN07tpCk5ppylS3dMS3KpA5Tr/8WAgK3KrIUPOtpWAvacZJM0+6OhHN6TQvocsGJT37rVGwT+ky616EzkOC1x4tn3jilxko7T3/WTQ7eXCT+6sCC0zoEpByT49zee8pbcDXxT+o907WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPt7rHMxPmNfQEMUGwOuv67c023G7THSC/b7+Y+MezQ=;
 b=TUyLR5Gkji0JuqoZ7jXzf3S4b8lbCAFCkh6oiQXS2W/yD7Bd43a+M3vTcTW53YI8+XvgplIA3EB3YKlXiyNjnvq0Iq3ic4dyTfRjmRKn9soPZQQcGsifA4YUz3D59GPJOE/YqQHfUUlg/H0FvErqOhV2snwrqczNtFcYhocb0VZf9D/vTW2kQq/nAZDayQi1lnqQ4hJ3yTEJwbXo254ye1l/pzBqrgFE5OrH6VEyuiu/JGeinx/eeZ3i01qjEBI6fU217VRWaf8ky6G5aq9/kbkq9sa1NObY1NckQiar2Ydk73ZA812i1Nxuq/5u/fcUBAbQ7FE+GvxMebFeK7CUzg==
Received: from CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:14:16 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::79) by CH2PR02CA0019.outlook.office365.com
 (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Tue, 23 Jan 2024 22:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 22:14:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 14:14:01 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 14:14:00 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <james.smart@broadcom.com>,
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 2/2] nvmet: add module description to stop warnings
Date: Tue, 23 Jan 2024 14:13:41 -0800
Message-ID: <20240123221341.7902-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240123221341.7902-1-kch@nvidia.com>
References: <20240123221341.7902-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9cf107-8b70-4eb8-e897-08dc1c60a31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/rkWSEHdTtRReOeaIeaPOFZP7ja25j9znDwZIQmkRc4qOkKRkvl+YD8COHVIzBd9t8CrAZxrqKP9He/ntW+PUevCl/sB0v+LVREoLJEq8D90K7ARuRHOyJCOVqdkFvYJ/ebohAQE1HEHAGxr9TxpPUA6wcnuL32JNIZQyAvI2x4/IJ8/PIDHb0c/UkRwRsDWt79i+Fbe52tXlS3gScs+8eGGhPmtaX+HK3u9FBM2HOd7JT2Jv9M+iawKo3z7cspCs/gc9DVAc2KnlSZd+ch+m8mLXqfSg0YFnTfovIYKd6MNpuyQoCBkd2y3dfSr6Y+WwNHYLp+ziTvM/z/ge+8QkzIWb9uOv2xxhphN6chgBf+308RKKeTpG6IYVykDiKJl1F0LV6ohB6qY0VkVltLOKT5sQoTIAUmTIdPrcpttxqG+QZY6F9Nkc6GLccJKTr535C3/VkPIEx7LtDdjGRNoAqgOzrF516CPPNMlJ6t2pOzmwoVZPPYm9W9WtAemNWyRxOO7fukGapsCCDYvhsbt2KA79MJE2iHT+CrrlGoGydcvoDqIv0bWWTIHsEcaj6dbPb6ICDim4wyHw5SQfb7zcNqzHFNb8D5ydQ+NqaNW4SwS4akNS/kswZJZdkfqfF+c3FzYr9wgEx5tkKHHeePiO4bwc36t9pfNpQXNL5FfeInySpi3vppw8dFzPJab85nB/Fmo2cF6DykmkfYN/Bk7Jr/3r75ZrjunigtoDTaS1LCTHj/Gp+EhAEnlu11Rs3aYGwUa2GWNsI6AAVdirVYN/P9THwGT4UbVJm4eMMAX8U=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(40480700001)(40460700003)(1076003)(47076005)(16526019)(26005)(4326008)(82740400003)(8936002)(70206006)(5660300002)(356005)(70586007)(6916009)(54906003)(316002)(478600001)(2906002)(7636003)(336012)(426003)(36860700001)(2616005)(107886003)(7696005)(41300700001)(8676002)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:14:15.7577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9cf107-8b70-4eb8-e897-08dc1c60a31f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_141424_227352_6F1A8448 
X-CRM114-Status: UNSURE (   8.37  )
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

Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-loop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-rdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-fc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-fcloop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-tcp.o

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

V2: Update description text. (Sagi)

---
V2: Update description. (Sagi)
 drivers/nvme/target/core.c   | 1 +
 drivers/nvme/target/fc.c     | 1 +
 drivers/nvme/target/fcloop.c | 1 +
 drivers/nvme/target/loop.c   | 1 +
 drivers/nvme/target/rdma.c   | 1 +
 drivers/nvme/target/tcp.c    | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index fa35e65915f0..8658e9c08534 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1705,4 +1705,5 @@ static void __exit nvmet_exit(void)
 module_init(nvmet_init);
 module_exit(nvmet_exit);
 
+MODULE_DESCRIPTION("NVMe target core framework");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bda7a3009e85..05e6a755b330 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2945,4 +2945,5 @@ static void __exit nvmet_fc_exit_module(void)
 module_init(nvmet_fc_init_module);
 module_exit(nvmet_fc_exit_module);
 
+MODULE_DESCRIPTION("NVMe target FC transport driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index ead349af30f1..c1faeb1e9e55 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1650,4 +1650,5 @@ static void __exit fcloop_exit(void)
 module_init(fcloop_init);
 module_exit(fcloop_exit);
 
+MODULE_DESCRIPTION("NVMe target FC loop transport driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9cb434c58075..2b2e0d00af85 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -688,5 +688,6 @@ static void __exit nvme_loop_cleanup_module(void)
 module_init(nvme_loop_init_module);
 module_exit(nvme_loop_cleanup_module);
 
+MODULE_DESCRIPTION("NVMe target loop transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-254"); /* 254 == NVMF_TRTYPE_LOOP */
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 667f9c04f35d..3a0f2c170f4c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2104,5 +2104,6 @@ static void __exit nvmet_rdma_exit(void)
 module_init(nvmet_rdma_init);
 module_exit(nvmet_rdma_exit);
 
+MODULE_DESCRIPTION("NVMe target RDMA transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-1"); /* 1 == NVMF_TRTYPE_RDMA */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..da0469978d6f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2221,5 +2221,6 @@ static void __exit nvmet_tcp_exit(void)
 module_init(nvmet_tcp_init);
 module_exit(nvmet_tcp_exit);
 
+MODULE_DESCRIPTION("NVMe target TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-3"); /* 3 == NVMF_TRTYPE_TCP */
-- 
2.40.0


