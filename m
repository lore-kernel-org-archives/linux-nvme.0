Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA86C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 07:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XcnPXLepn1ZbiRIGMBroskp+ZWCfGcT891DLH80lYSo=; b=PyV7k1SalT08YRJF91kcaa8eHk
	6Yy5E+XxZQt5KWPKUuiWls2qE0FlJEOdyhAiQQailp/JGsCKJXJ0+cZOIZrcKWsiT6pVt6oiDqwHv
	VOgVhmxl2VRU+u2I61oL6lLgCkPkT4ENQn6stlf1rbgh1PVXJrSu8hSVoUkaC4FtVxnWY9pzW3FZ6
	mTHoFanl8Vacg9vFHSGFSuaGt5UP+XyaogNsu+g4cHyw5vXSnVaRhYzYPAZQgdGlhueXH1JEMuI+H
	xzXCIwk05ZPswfMZ1KNGHZLFJ+1b572O5uSaWVzv6of/LWKfMKc2NYhtdpvG0OM2gZyoLV9XKo1/b
	MIacjcZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA5HY-0048Sc-Vg; Wed, 19 Jan 2022 07:21:25 +0000
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com
 ([40.107.237.80] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA5HQ-0048Pp-1Y
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 07:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dxk3eoUqvCxNDZRfjR7bN/5JBm7lsDqzBK6jq7mGktKBwvaDqbkWBTwtuN8zfJsvN73ScGpqvbHzg91kgrJ6BUzSXM6pIoBZWhsed4TbLGA50ac8jCP7ps5kDRusgZix3kHZAlx4v9Sf+ljub/5RqNhOEFcljn8b6o2R6Oa6prmYGh5dckq898t7vwLQWYD1rOmY1bI1cuy3UdJ0tvOTpNKU8lV77iGtIj29lN5ayFloJ5AMKcV0HuPkYW8z1hgzNI1VQyrzi0vXkQ1KtKnXFcoUBnczX2XINapAl8BVNj/hgipGAWqab4u2ij+4j2bxm/QyXMBLT4AljR3B2lN4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcnPXLepn1ZbiRIGMBroskp+ZWCfGcT891DLH80lYSo=;
 b=DshRcidfZd41cMjp4oMsfDRxhiUSTGUpVsJvOS+BlMwkdLzklC1W4DjPMK/zxNnQ9DN2W1x/HtCZ/m0OMX/9Aia1B/e4o1DNrr7d8bs71DAgqL7ly6h+vk0W/4w0s6RV9AZjJRuOgywQCA9fxo1XRCuP0YsqLsCiPj8xw4KV3IiRs4ejNWFX38xphCQwqot6PoAq1iwZ5n3gglL00aeSLr2/MyFp8pwweek17E9Rf6TuVZSPVT0iec5wpyN6BD5j/kZQanprZKYAdOgt/CllW2Q5dIZ8+uPCYbg6f4IncoKl9m+r4jttPLhiB1JEx/RcMkGNFfStQ5awUEKQROCTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcnPXLepn1ZbiRIGMBroskp+ZWCfGcT891DLH80lYSo=;
 b=gOxLCeFcxDf7+wzXbjgzyWnEO4vJ7dFDrGBHfsKVST61H6GPBeKxOgJwmpTiErI1NMHLTv150jvx07fp/ChmUzhT4MJecPQPKF0mO/dHdcZ5h/Z7xOHmGSzOZG1ZjqtjiAhsoaY5YmgbCdK7BukLHO0BS1D+fwSng2xlE6Th62a08bae/kS5OBHOoLXF/k77EEcuJhZG0Q9CDgOKzcSXeTuUAJK05NTuoWSBl5aB5e9csOgyHWj/aqPIo1E5wnf65vJDhqGO5SggSbEeKUPVGG5Y27uo6LRkvKgclQRRGi2azC+yMZG5xLKKoXcqdHz/cloWLBF48GQYpaF70FeuIA==
Received: from BN9PR03CA0457.namprd03.prod.outlook.com (2603:10b6:408:139::12)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 07:21:13 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::23) by BN9PR03CA0457.outlook.office365.com
 (2603:10b6:408:139::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 19 Jan 2022 07:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 07:21:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 19 Jan 2022 07:21:12 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 23:21:11 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 2/3] nvmet: add helper to open block device
Date: Tue, 18 Jan 2022 23:20:37 -0800
Message-ID: <20220119072038.3942-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220119072038.3942-1-chaitanyak@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf24c1f5-0bbc-4869-b972-08d9db1c4635
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41261DEFC6101186FE6AC670A3599@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GiG8NP7NilrYZLQlhn4+R5dnC+dUGj8j3psEHccQmV+HLPHZPvCC7YWftRMjdoKiw8TkHYGLPbLBMEbxLfjl58FYfDYIXacp2gJ7AFQGOhUrRtgrONT3tlJIGFF9vMm1i+Vvb39hHKKKBiOnvecM7GVVTZp/nOkTRuH/d17WKv/1Ilm6E0bJFD8mOWgy5UmQb8xTxG9F1H78SPL6TZXWjCZShEaqJ7CUBLOkl+V5gm5kPWEqATjEPRL1AhgUPT+w84v1LrC5NsG+z6EbdyubvKcZHFFk4BE6WdHsy0AdSIZJuI8G/Obgk7umCJax8dSppwErzho871wzABCcLhnlVKj4AH9nvk3V0RrvNXAUJYfxlSoSwZkwdqpi/XnI6o8gT+f/AwZFUZWpQsbFkwAAr7vVX15aIgW3CLnDQ/Mvvlg79t73wZqhr5hS9tV2YwJkiwfmZW0YY9yEZPbsCOi6tgTFoWkGrW5MQgfj+1nfpsR+8WAjrlRWL8gMRzM4OonqePHomlZcZyXiTREDtYO7VezXi215ODRPH0dHQEbI2ca+xrPPyVZ3vEjP5361WJ+4qDh+MOUYz+SJJyBDnSTPt4ZPsp0oyCEeU4hX0MTLgGZweHwbzicSu4gRwkZsYFhPyDgivvOLGCC+QSgnC/GJzRlLoJ9/Oqlxpl6XxILmWYlzNUcFSiYMhu5StiE09o4DBRHb9i9t1z+AiRBQUevm5l9EN+7Scop60Nv+IC8Mp4V7hCEyqaOCZqCM10vtcgRdK33l6gBcrNPM8hXnbcZqdMaPTbUmy/+SjIoL+hiy7UQ=
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(83380400001)(1076003)(36756003)(54906003)(4326008)(36860700001)(316002)(336012)(508600001)(356005)(6666004)(186003)(16526019)(81166007)(26005)(70586007)(70206006)(5660300002)(82310400004)(8676002)(7696005)(6916009)(426003)(107886003)(40460700001)(2906002)(86362001)(47076005)(8936002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:21:13.1254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf24c1f5-0bbc-4869-b972-08d9db1c4635
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_232116_125705_41F28C60 
X-CRM114-Status: GOOD (  15.26  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

In order to support block device backend in the buffered I/O mode
we keep the ns->bdev handle open so we can reavalidate the ns->size
in nvmet_file_ns_revalidate() using bdev_nr_bytes(). Also, instead of
duplicating the code for opening block device we move the existing code
into the nvme_bdev_open() helper and call from nvmet_bdev_ns_enable().

This newly added helper will be called in the next patch to open and set
the ns->size and ns->blksize_shift values when block device is
configured with buffere I/O mode from file backend code.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 14 ++++++++++++--
 drivers/nvme/target/nvmet.h       |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 70ca9dfc1771..58907304587e 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -72,9 +72,9 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 	}
 }
 
-int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
+int nvmet_bdev_ns_open(struct nvmet_ns *ns)
 {
-	int ret;
+	int ret = 0;
 
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
@@ -89,6 +89,16 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	}
 	ns->size = bdev_nr_bytes(ns->bdev);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	return ret;
+}
+
+int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
+{
+	int ret;
+
+	ret = nvmet_bdev_ns_open(ns);
+	if (ret)
+		return ret;
 
 	ns->pi_type = 0;
 	ns->metadata_size = 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index af193423c10b..534fe2b32e99 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -533,6 +533,7 @@ extern struct rw_semaphore nvmet_ana_sem;
 
 bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
+int nvmet_bdev_ns_open(struct nvmet_ns *ns);
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
-- 
2.29.0


