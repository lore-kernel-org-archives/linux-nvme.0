Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D24C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sc7xbx2n6/jigbaBeOi4FbL41CQGO5RApAu30mz7DY=; b=UcoHxlslg78KFUcyFq/oeamnR5
	br+ridggoJjclmLukNa1EwPfBIyV4jbMTMbr8VTN9D+UYVonzna82mRhfMyhqJL/2CqKQUvaZCogD
	7P8DmNnv3IbfO38cYuDsaanelvbYVF9i6j7TrVMY/cg/6anL4A74l64Cn3f7NTFYRYIFqJGnyI/nq
	c4ByBSdNOD0juhVcys86B/2gsbtDRg3pJnj1GRyhOoPOnTPEqx4xV10EsN5ExADW/ZZshLxkH59ix
	uawUNNXWGi3oNf5JoqjesA3WQaksaxnKrXwxoJRVJz7+bDFMu65zB1FL8B+pEWcxAvAiB772B5cJQ
	VZkl88Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDMzY-0014mR-UQ; Fri, 28 Jan 2022 08:52:25 +0000
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com
 ([40.107.243.62] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDMzU-0014lT-H6
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 08:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiIIjkBjkc8DDMmDJJDtlyOBosViGHGiGpIwLRFDRm/BtQMBqHwEbvHgOSVExSYmKo9i6U+V1ZVvnzs2MlQZHX9eimdppFarHbPJ0N8A8FwsO2gmADtIKw3M6iwvPefOaBYNb/YRTSV6wqKa4wUnrTvBWM6FlRiXPqcx+FSI2b/YPg8TD5b7IJ9qVsNnpCG/f8QN3M7Dw9Ffo5SfOeNRpZX8XCBdeSgJSbblYBdphMmGaGvHrIWMiEYAoeHJ0TkOI2onURdoAwXPQk83t7zSPLxHs4ASuzMwxipQQuiBTj7JIcG+U2c1gKplQZYZxiZkwPn+oO4Z7oa4lXcCTW53aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sc7xbx2n6/jigbaBeOi4FbL41CQGO5RApAu30mz7DY=;
 b=YRaKKfB4vdlNRHgNc3u3b+cAJgO/Ow8DulBtppDoUD930Mg5Wc6nWICa2fGGdUZiZsaUvakot+5tTrX1WEUg+vE2i9et0znb6PDyAcRqslaOdaVftRfxppgLTd1/07k4WHq3yYrYOKPdhOgHzw/0cJ3WoFQHyGL15wxqv8kOWRBTIPCiW3fhrQJ5/E1zyJEyPfhCv9KEn+UWtsUPkWVhxyN/l3J4WDMGrPzuCRNrO9NbqwJ37EffK3NC6WkZXaaPbx31zZStRBNus31Eq80U/8L2bgWx4aen7FIlavlGlYKIt+RRI8e+AXN0F68D/tqYfXmHv7sCWwl1GEpLzK/Tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sc7xbx2n6/jigbaBeOi4FbL41CQGO5RApAu30mz7DY=;
 b=EcYDZWbOWhKWRawDHuZqV6pH2aDWc/VzdG4JhHK74Laf3ECpA+A6Of4meHhd9SKTaln02Vt9U0PYr1BfWKJWVfktjXQOCsHRyWjROCcFCdqVIaURWw0cvTuCAib9ceGjMEojY/VYeTndJlEk6tkYT1mq+p8Ibjt+L1vn/ix2p0to5bGpSvFHb3SIy95XQYoofInGHQ3KI/D3Px+ytEgy35cPcrFHGqNpa9Slhf0/Pi0GryGzBA7U7MWU7hM+hD1mljupYKdxXVQGI0PR+kZJ+5p12AgPB9rT/lObdhW0+XgX0xBb6/nbFY8voYjTKCQEHZxjTLu9T2ntNhi0JMbiHA==
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 08:52:18 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::54) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 08:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 08:52:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 28 Jan 2022 08:52:10 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Fri, 28 Jan 2022
 00:52:09 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH V2 1/2] nvmet: use i_size_read() to set size for file-ns
Date: Fri, 28 Jan 2022 00:51:47 -0800
Message-ID: <20220128085148.11638-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220128085148.11638-1-chaitanyak@nvidia.com>
References: <20220128085148.11638-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0686430-5637-40a5-2354-08d9e23b7d13
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4191976B45F408E16A60708CA3229@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUi7J6dgo8kNyo5Cec322ezxqSYOBLfXpmNrDbrM2WndRBK5ESnZlnH/hhSWttThVXX2UptKBf9OKDdmtFaE5IVoVQVCsXY67NWvH/UpXLGTE0wAHCJSiaVfDCfuTievF5CgP++T76NYQ9eBp/kHL2jzJyg6Gqc6YejWJAFCfaL5z/dbBDGSPfFBNbrjDDBROppCx7rjzynuhvvonUu3uPecb4g77hGeh9DUcRzaHRX9WEs7nQ/XQ+G0Qh8QPLiKTOzUkkzovw+5U7PK4JFwGTi9oFYyG6P2BeFdomd2gWRo9ptuHVRRTm6OB/NnQEcgEvi2nCibT7n++cK3K7a4W0ky9EfsJwknYqkGLufpDQ42my2DWkcDo0WRUVZdtGsgtXkuOiojolZ7xaHTAqyhdQFPWQzQaqFZywTPQueizcjYRaLyPGEZpfT4tPjin6HHLujVntBYSlu8Sa5LBAT00Jn9TSiSW3xje827qiSeKjrXzuSycEAJedvG9cwA6QxNunbNMglCkYU0A6vHWh1q257tHtkoX3OD7harkHQHdGU5HDDmH7yyx1SPq2FpHZgAaj4/UFpNSmy6DR3fIp3Uip12RGe8Gq4yL0dgPVQNp9txp1YybKQbGJTOwA2TTeALCNgtEy3i635/ksTL6pfzh0CVVeEhOyjoioE491IRDWDHCkB4EQBG7dM2c+T3SGmdAGGYrj4t+d7h4glR2iJiNw==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(316002)(336012)(107886003)(82310400004)(6916009)(83380400001)(426003)(86362001)(1076003)(54906003)(26005)(8676002)(47076005)(186003)(16526019)(4326008)(8936002)(2616005)(5660300002)(2906002)(70586007)(70206006)(36860700001)(81166007)(356005)(508600001)(6666004)(7696005)(36756003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:52:17.7740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0686430-5637-40a5-2354-08d9e23b7d13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_005222_186642_65F545D6 
X-CRM114-Status: GOOD (  13.90  )
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


