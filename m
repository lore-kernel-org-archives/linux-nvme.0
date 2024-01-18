Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8630CC4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 05:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZ9kTHjOkt86SBvlVY0f0CFyw2ID1M/Q8etuDWXJKJk=; b=H02RAyqcYP6AjKx+J+9UYmVpvH
	HwnIpmu95YlnQRbtVyB2/HqWxmuhJI/AnxdKsf3aRHCTxL0IWJJS0e2NFTUbbbwpTYQYdoszFm8qC
	+wxgCmKJaX9wT3nEMXDhzGj4EKcOnSggnAJsnTCyzdF7lUkLtJrNUNVh4BHCEDiheCP4LLgSSYF9l
	aTIfn0Yao34vLBmVSze6ystmPfJ7RAllCSzS+IE4SgbK5p5mjeBZtmUti+Z5Yuk5ZD0dUNJYeeBt/
	/igQMIFUYV+d+ejf4PaHHHHvMGKtKAvrFGejL/MSHgPANK4eri+0vPTueVG88ZjMNDNaTFEpvppS2
	fNXrla4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQL5C-001iTM-0a;
	Thu, 18 Jan 2024 05:36:54 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQL58-001iSh-2O
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 05:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXN/QOvu0ttp5LOkYpvXlRiJAWnhTc0eUq6B0souEn+XPSA8y40lJZfOygc//O3iiU1+3/0F+YXLxxIZ+hFf0gCQ3GfOkv87mgR6T3Hi+LasCSWkQRh3uK7DgGCLwBZVcWF2CTGWxL1201n8sYox7xOK+/pWFS86RkaBHFY4UvZsbj71LqlxW1NVQk2eEMke0WatKE8PTdutvYU9qfvOXcoFfPI4GOLUUnpqn/aD6BHYDa1h5dAA/jsd48JIu+rFVCg/kYQ6cZRIK9EOPm9P8m/jS1DWQ/Iqk1BLdX4j8Cnzo9sMR0GTas5Exj19Hot/0S0iaeWRIzL8sqAAxZb7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZ9kTHjOkt86SBvlVY0f0CFyw2ID1M/Q8etuDWXJKJk=;
 b=Cd7nqiShP3ss1B1QZMxE30nYuQjVwgo2r7lTwfkKjZoxLAY2atLYp09qetYuczBEmeXIzUzWKRIuuDiSPMb6hsqW4mSiJi9z+PWPyxcoF7mkqWjE2rbtkBNj8HUse7u5r8MtNbGNP7E/L1EyiC4LE+CVkZryo6gnwLpam/nXQtzSTk9zEEXuMZcpGFaTzj9Yo3GTM5UzxfJnAuquctsnpXonOJJIMOs6TC1/J5NFqIlmBVYiQceXNgkBbIQmZ1WrkVcAJGzuM9pVQGSXoGXGEs6eHS03w4LYws/z2PhZznXhJDgpSO8H3RgEdcy+zKZc/n98P2AD113GXMbGL1LwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ9kTHjOkt86SBvlVY0f0CFyw2ID1M/Q8etuDWXJKJk=;
 b=tjbHBPXxuFHUuWUlaM3RORKNJy6tLbnL+ANASbYu8ZHgBQOfyTWjWrJ7aUpC4I1iZiGeU8CxX6HUBFFXbOuN58LHtBVbLvTebJ6aDeCoo3wdnaPVdvCypPST/er4IG8J8CmQLxg2LkeYlarO6AqGcq9D4VA6XZFFriDP9TsJWSeoyM2PR7ME5Sncp5FBEkJh2sJ7T/rFRlHNkgmJruHxP04X7OWOGwoa6XZxPaEUN7Ozer3qfP584jvecetttRG6tBgF3Y9bwEmTO+hi2n5F4WS8wpe6ONO0sLTi4jlhj+B1e6mlJvSGlvDk8JL/Tglz82bhkZPVW6nlG4LR3dHV6g==
Received: from BYAPR11CA0063.namprd11.prod.outlook.com (2603:10b6:a03:80::40)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 05:36:37 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::a9) by BYAPR11CA0063.outlook.office365.com
 (2603:10b6:a03:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 05:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 05:36:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 21:36:21 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 21:36:20 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvmet: add module description to stop warnings
Date: Wed, 17 Jan 2024 21:36:02 -0800
Message-ID: <20240118053602.215765-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240118053602.215765-1-kch@nvidia.com>
References: <20240118053602.215765-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|CH0PR12MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd4ab5c-5751-438a-7c13-08dc17e77067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uY/y1K2mE4eHoRs4PZ7x2RfQFz+uaTs7wiDohWEP9c//RvRcgDbNaVWx/mfYY83hNfPXQIoeddlv9yVyvB5DasW7H7il4pLKO47DD4bRG8oAN/X7KPukLe2JH8npwqBY9vOWz8hrShBuDO/04TSzqcPgz48mpTPKNNz8MkDw3Ex9pU3fLOU6S8ChIVGofC4HPgIkXJPTPF4kQFJ38tB5TLt3p5fIC1I058k7gdY/ZHTZSaenmVkHTd1ctm+Kx445xvmzXum4VLtipefNqDoDKTpgbfhIpdQyFcmMOGs3eOokUDOxqKXIwpGwWXljOIwoTK4brlBTsepWPSdRSMeVMHjZrSLM1iyTSu2NNI4K5Ys9AJBbvaz19crCNngEr1nP9vKTUzafiG4u4PVwzTJs/aIQNh8tf8qr8zD0STMyQMoSauekraxORECw6N4iMXES76WxF4JaqsLID0OvovXrz6wK5zQRMdKTjr92F/nA5zmgY2Gfcru4b25IdEjmDg78sVmXumVMN3iSI7h0axvyredzqfXlJpb+Cx1HeDDnLk4t4idLzbp5vg4vV5S4pcDQDqFmnMH8Ws8j7GNna3UVbH6kpvpOMq+sHVbJ3jUYxz9MblFz/jDZYfVdNQYW+lCYb5jbEhRqscPQe67heDrz9Q3AQ1wfp/K7ZqBnMPR35UcAGmgdNOsYNHUYx6tVZ2uBKZUWseciqHbTy/65yNatYMJWi9LsBn/DM89L1l/uXvE3R2sPuENEiO/en9DMMC6h2m4Z5kElaoLhk5dpIpldT2FMXXCJjtFdmM9FtjGXD3w=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(336012)(26005)(16526019)(426003)(83380400001)(7696005)(2616005)(107886003)(1076003)(36860700001)(47076005)(5660300002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(36756003)(7636003)(82740400003)(356005)(41300700001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:36:36.9232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd4ab5c-5751-438a-7c13-08dc17e77067
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_213650_786024_2C256028 
X-CRM114-Status: UNSURE (   9.40  )
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
 drivers/nvme/target/core.c   | 1 +
 drivers/nvme/target/fc.c     | 1 +
 drivers/nvme/target/fcloop.c | 1 +
 drivers/nvme/target/loop.c   | 1 +
 drivers/nvme/target/rdma.c   | 1 +
 drivers/nvme/target/tcp.c    | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d26aa30f8702..5192f4d71243 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1705,4 +1705,5 @@ static void __exit nvmet_exit(void)
 module_init(nvmet_init);
 module_exit(nvmet_exit);
 
+MODULE_DESCRIPTION("Essential NVMeOF Target core functionality");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bda7a3009e85..f72f912fc1de 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2945,4 +2945,5 @@ static void __exit nvmet_fc_exit_module(void)
 module_init(nvmet_fc_init_module);
 module_exit(nvmet_fc_exit_module);
 
+MODULE_DESCRIPTION("NVMeOF Target FC transport");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index ead349af30f1..49fd1f7380dd 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1650,4 +1650,5 @@ static void __exit fcloop_exit(void)
 module_init(fcloop_init);
 module_exit(fcloop_exit);
 
+MODULE_DESCRIPTION("NVMeOF FC loopback transport");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9cb434c58075..35b1ff0cf16b 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -688,5 +688,6 @@ static void __exit nvme_loop_cleanup_module(void)
 module_init(nvme_loop_init_module);
 module_exit(nvme_loop_cleanup_module);
 
+MODULE_DESCRIPTION("NVMeOF loopback transport");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-254"); /* 254 == NVMF_TRTYPE_LOOP */
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 667f9c04f35d..f7e1ac6ed3ad 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2104,5 +2104,6 @@ static void __exit nvmet_rdma_exit(void)
 module_init(nvmet_rdma_init);
 module_exit(nvmet_rdma_exit);
 
+MODULE_DESCRIPTION("NVMeOF Target RDMA transport");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-1"); /* 1 == NVMF_TRTYPE_RDMA */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..1f3ea988b671 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2221,5 +2221,6 @@ static void __exit nvmet_tcp_exit(void)
 module_init(nvmet_tcp_init);
 module_exit(nvmet_tcp_exit);
 
+MODULE_DESCRIPTION("NVMeOF Target TCP transport");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-3"); /* 3 == NVMF_TRTYPE_TCP */
-- 
2.40.0


