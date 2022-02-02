Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09300C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sc7xbx2n6/jigbaBeOi4FbL41CQGO5RApAu30mz7DY=; b=hiF7n48pFQbtUDLAsKYQt38SyZ
	j2du+/J60Fw+A5mETQDIb9GRPpcQVDXa6CCrBGCCylttB0HAasCp7RXFfvnWVmnwOG2tPtrdQcKHg
	Y840my6dR+ftwq6gUlkdCSHSrA+uFAQWSV70WBkaBfVM2yZBp0jXwrENQhEG1UhMmfdJA26HpHn5T
	uvqdSvjbnzRtUQ3LkioT3Ee9iO1FreBvYhoLbtCMllXwpNmbAPajYOhx7v/7+5yX9sbkMRbiB5yud
	qRG+WcNHf3espRPI5KWllbzCzyiLI2e91wV8tBFt6pS7c/Tn3gzh/kwXgove0Ryl02WlZjnt6Ks3Z
	CLTx6aSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFBZv-00EgpS-1J; Wed, 02 Feb 2022 09:05:27 +0000
Received: from mail-mw2nam08on2065.outbound.protection.outlook.com
 ([40.107.101.65] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFBZq-00EgmE-1K
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 09:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq8Wi6I2COgtYg1xRdIZHlShWu6oy2fL4VG7fQoIXh034nOlLImKappw5D5yd5VB0n/Ku6BOMuBGRuh3ulH3B0VFis4jFXkxFODG9U7NfIgBCpBibckjyXyO7sJ8frjBHzxvDqRmpIQD/cy2KFTiI/m5/DrhslTLP4dIW5Uhuy6MixHSHtBFCzMEJNCRIeo+tv4e5WOQtkDAh8GkQJTm7U5z9Zux+9yMPp1jtwxzF/o+DktXhs+MViWT+HyBM1SlFAetp6kdguOOzBys0JjFAux43KHjcLV1OoDIII0TK01usEJ8DK2Hdo8k8KNj0jbuIQhTAPGU2z3akuPj7n7fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sc7xbx2n6/jigbaBeOi4FbL41CQGO5RApAu30mz7DY=;
 b=MUmwqgm8Wb9gL/GKCpVjYkFMVD4a0YAfuhD59wtmoGtNAybNurYzNCfrwoEG33o7LGtLjy0ng6CZq0SiJ5fDxFpu+/iYooiK+PyUv5CKBP+T+1m0fDvukzkEVwOHY/v6Cfx3gllFdfSd01dukqxIx6Suf0LUAGNRHrCLOMyGccG6PHaCzaCfKJdEuTcVxpopp8eqlxumGDorqCxUycj7yAOnL5buPirzW6qkiAh6bRrskdmM+kAI2mvnb8WS9nlbqme23PBQHLKCwA/4dBqIyJ2tQYKrkBH49IXSgC5+fYUHArQRInrUhzNMt3/0Y64Jpbp7Lq56zi9MUeg60g++xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sc7xbx2n6/jigbaBeOi4FbL41CQGO5RApAu30mz7DY=;
 b=mRmKwImEE5mXJ5uXty7mK+SH5rETjAPEL/2WeX8sCBreIbkzMvsTZgKW8xK2vDTWxhIPc7tB3x2YjQrCBZa/9dPMsZeJz7co+cUo8itHGj2vMjGq5ROI+eYlHPd1aK9GsHCYNGn8NvdHUux/slMUMmAxZbcKm6kWCqe14p7Z1pR24zeGRJ2ovyDkPsg1oPNYrMtRiV6cnqbsjAf/cwYkrvgF3oLHfiv7zUIno1gSJiPuUQrRx33RkXhDFGBOyp6D3lGBsgwegSExZ7Efaa+4s1hUwuyJG1R1Ue1yJth4pYpamiIZavsJGZ0wl2IrT0c7IGicbyzZajwB7Bv+OrqDkg==
Received: from DM5PR16CA0037.namprd16.prod.outlook.com (2603:10b6:4:15::23) by
 BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 09:05:19 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::40) by DM5PR16CA0037.outlook.office365.com
 (2603:10b6:4:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Wed, 2 Feb 2022 09:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Wed, 2 Feb 2022 09:05:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 2 Feb 2022 09:05:11 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 2 Feb 2022
 01:05:10 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH V3 1/2] nvmet: use i_size_read() to set size for file-ns
Date: Wed, 2 Feb 2022 01:04:44 -0800
Message-ID: <20220202090445.43615-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220202090445.43615-1-chaitanyak@nvidia.com>
References: <20220202090445.43615-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efdb36fb-b511-4d0d-3711-08d9e62b2270
X-MS-TrafficTypeDiagnostic: BY5PR12MB4068:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40688FF26FDA2D47071501E3A3279@BY5PR12MB4068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu0xaJiwUa/z5sP8shSxjHopBdVgm7YqD8lO5P+oY62LQxA9WNIC7sUUi6sR69WXZsjQBOu27ThsJIQP9e5thBMJqve778/+gSTP50VqUmUVZRVEstHa83W41R8QSKk5jIi7s3CtCiaqAqFbaMrTjpuZcQHdF/UfPHEt6BvnRONuvxAhyy2uksg/9LOMVWtk1kpLsydx0v69+FATLhC7KZg7VYBFr+m/fJ7h8O6MoChxrCcCdBobMQiojGBlM1Q1cY5NXd1QxUWNMb4SGlhdhkWPyWMxm1dk/WrEc/rHpNcgpLmgWcdy99yAjgomvlvkFL4C7jz0OM+/kXkqwrBvJD1xaLEBZKa1EEk6j0SajF2gJnGd2Ufy/SjPTdB6QvF77INPNYniXBW2MUcKriNACDrjt3hrm/sKO9IufMvaoGN5zbLqKKNuysar1mnQxe++ZT64K0yok+NCbUMisz3kC/NRCDiKRR86hV06QL+/CsbPtyiIHTc41O53o0jEUQkkRVnk8F1Yvat1oJSIrAzboGJjU4CFJI9aXARFw9v36Dlz+fBJKr4pLTKcq34giH322PRLx+oDsTJGqHrd9pSNtwH4pbFtdZFoG6sSD+HUgOs2J+E03XyJVviLoGy5kXPc4WKmWtSsBFkD2b88y+DT9mVqVzqSn0ZO55X7kyEAr+cs3FbBIZ+R8auoN8L7w+eB5KEm5Ozg1EqCPCR5loV0aA==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(2906002)(2616005)(81166007)(356005)(47076005)(426003)(36756003)(1076003)(336012)(40460700003)(107886003)(5660300002)(70206006)(6666004)(4326008)(70586007)(316002)(8936002)(7696005)(36860700001)(508600001)(8676002)(82310400004)(26005)(54906003)(83380400001)(16526019)(6916009)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 09:05:18.4147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efdb36fb-b511-4d0d-3711-08d9e62b2270
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_010522_309634_6D8470E2 
X-CRM114-Status: GOOD (  13.94  )
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

Instead of calling vfs_getattr() use i_size_read() to read the size of
file so we can read the size of not only file type but also block type
with one call. This is needed to implement buffered_io support for the
NVMeOF block device backend.

We also change return type of function nvmet_file_ns_revalidate() from
int to void, since this function does not return any meaning value.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-file.c | 17 ++++-------------
 drivers/nvme/target/nvmet.h       |  2 +-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6be6e59d273b..6485dc8eb974 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -14,16 +14,9 @@
 #define NVMET_MAX_MPOOL_BVEC		16
 #define NVMET_MIN_MPOOL_OBJ		16
 
-int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
-	struct kstat stat;
-	int ret;
-
-	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
-			  AT_STATX_FORCE_SYNC);
-	if (!ret)
-		ns->size = stat.size;
-	return ret;
+	ns->size = i_size_read(ns->file->f_mapping->host);
 }
 
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
@@ -43,7 +36,7 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
-	int ret;
+	int ret = 0;
 
 	if (!ns->buffered_io)
 		flags |= O_DIRECT;
@@ -57,9 +50,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 
-	ret = nvmet_file_ns_revalidate(ns);
-	if (ret)
-		goto err;
+	nvmet_file_ns_revalidate(ns);
 
 	/*
 	 * i_blkbits can be greater than the universally accepted upper bound,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index af193423c10b..69637bf8f8e1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -541,7 +541,7 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
-int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
 void nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
-- 
2.29.0


