Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CFEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331FA61260
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 331FA61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OB4yp9A1bjWxqioUBKB30sxpIZ3tyGeaFhVzBlkne3A=; b=pXC8uc/zk2MlQK9jh5H5ee4zBd
	wXkbEpiD2/4yq1ixWMCou10SnyqiFrf0/B7wSMpFuu9O1Xwfr5F0TK4clhu5ARAlKG72xS4Pr0gzw
	bT7D+b6HQ/aaFjszifZXOeFHHBzOhEWTVR2EgGqZILyPhn9KWBU10H71sSHLtkIQsMdREk7RlrZOe
	VBo7pE5v1Y3iU4TK3wsBtVZkAAfi84ofnRNj0R2jQwhg5F9YjIsR9OmZTEAaaMgGKzItknUB2L+MR
	dVx9rcg7izSnNvBY4CQH4GbTZfwCliIWQKW/aMYuYTfqSrmpRj1em1Cw46+lq2qgr8spS3R2MNsut
	1DvpISmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md905-0049NJ-SX; Wed, 20 Oct 2021 10:39:13 +0000
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com
 ([40.107.243.54] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8zs-0049KQ-JG
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/YR5spy13J/p7UmVurOJQrpoSItYZLWdy/Dt4lSzBSI8L8P+NgGBOD/Ri1CxSBH4Zx6MMMCWZbspicoeiQnvFYJUga2hrGBOO79PDYVyJWRK27h4+BpTF55mmCKwOyung+jggvNx0bxNkWqGL3BC3lrm2AzFYh/GdxlkDvKCCpdb/hShck6H0fdrOuac6KDuEL4iB9A3rueMSWzW2AqV9bDBl89sGvyl3JQoHwiG2P5IiiA0vyFVg7RB36FLg6jGbNsWU0gEOdqlOS2fsIzc3Nc9H1E/LiqalOIhMFGrrNDwDS1G2J2y9YsToeJYeOVjdbVvyhLVfepV4i9zYNOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OB4yp9A1bjWxqioUBKB30sxpIZ3tyGeaFhVzBlkne3A=;
 b=DZDKXVH4xYRvU7AWfXJyKzNEGrLiOcuNz1dC7a9Sz7ZetGbnXuRDBpdI3inJOXJFEGnfuLJ9Me7JlltKWF1jKdQErTD+Fw8iakYih8enMPT8GjkMNjKRHhsxmEcpNPaKsV/IZMKm40LLOuh5ADKZzKT6Uyh0Jxm/3ZZr8fc9u6rIF7gEbDcdHMx077ykN4bHK5UjsZ3ObT+W6kjSwBcBV8KtnO/RuE877NuC8mbchtGRzgIT2JKU3L+Afx0HeYBnCbYD5DktoS2r+jELjTNVAM2ne/fo9cOzr4YTAWrX1SH4sdexCSJwYSPAzcyggXUbvz1L/O72ST0dxHUt/PcNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OB4yp9A1bjWxqioUBKB30sxpIZ3tyGeaFhVzBlkne3A=;
 b=qNs0aEXI6JPUvk6bVi25JpfqCk6A7OJBo/Ju55jjV4Kq4irUv5Slg7EMWxsGLDRnNwCvicEturSg5ILNFNamnwwPwDgLhDb+LSfZc5smTK+q4mlQ9Vb/ZNbU6uCUz5f19m51brThtJB3qpcbFHnvI4tBqO8wHCZTzgOzCLfqaYzCohldPv2ccad2cYviFqwCmpf2Dy2i3JN8NgHrto8GFrWvv4qNsmdjFDYPWNgDY/kE1/sg+osSNM0ZcReiaomd6dhmxGL9y86+7R1lQyBJPKajwvvvwRdcK6n1xxiLYrrGq80aNEPh7VKy38gReiHvn/45yEhGiaaiS0e+jGd3Dg==
Received: from DM5PR19CA0039.namprd19.prod.outlook.com (2603:10b6:3:9a::25) by
 DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Wed, 20 Oct 2021 10:38:56 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::54) by DM5PR19CA0039.outlook.office365.com
 (2603:10b6:3:9a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:38:55 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 03:38:53 -0700
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:50 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 02/10] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Date: Wed, 20 Oct 2021 13:38:36 +0300
Message-ID: <20211020103844.7533-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6896bf1-ab9e-4005-e80c-08d993b5d175
X-MS-TrafficTypeDiagnostic: DM6PR12MB4843:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4843BE7B6DF9F6923CAD1074DEBE9@DM6PR12MB4843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKunsAM7/vQcpTa/RHfOGMcu2pcsOkgZ8G4zCqlSWalOaj1fntyEIAXFFsFvGembJcouDFPS9LnHVEJ6EbbbzyFSzu7uYzfMsF72PR1uKdaZfWZeUjme6QDduHLmvQSzGxBPHrvzhiWm8DARTWWvzS5acaNgiVfLYKz6uOwvHbZ+4YuBTEMS+eJLtQDfOX72tEK/Oy/alUI9CUuX/ew85V83/JbnOGIpSoGmh6n+XmWy76sVviwTmlL2J4GnyPchEZ0pswY7d5y1o169Trk/BDJCv3LC/dRWDcnGj/gtIpEwiALfSPeRzQbNwkPsqovFEQ3097ForxR48TyMfKmIySk6mGN43KhCZzcTBzCufqXaXGV4EUkxK1/o6Qe8Ylgii+DTpAYiLwbrE+t2ERwkdxgA/YRJh+ee8sLhhn/wRSwsteHJaaxWo54X8At80ZIQX1gA0oWI6Ldy/4eEXunDCZIswvWiOcwsVnaPZqDJrCk0sTk9CYx0kfdtjxv/gVm+1VYbitWcey0wvcOannMK6l7Va8orixzbDZtba0wd09O6vMhYWqPEoyZ6aSeLiLIA00UnGas+YhN4jhVr0N4GLVis+7QKV4CNWGNGTfUHlOnsecsSqYkz9LeGjsaJtliuNOfa8iPJS9qkbISRf9eHBALfRWRmlqlq9hRGnHIYmCvJOFM0RtfDSI3fWlbwGWQXLI+on19lixajzC6kxG/vqw==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(110136005)(86362001)(2906002)(47076005)(316002)(2616005)(6666004)(336012)(5660300002)(426003)(1076003)(107886003)(8676002)(54906003)(8936002)(70586007)(70206006)(36756003)(4326008)(508600001)(26005)(82310400003)(186003)(7636003)(356005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:38:55.6917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6896bf1-ab9e-4005-e80c-08d993b5d175
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4843
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033900_684963_FB1974E1 
X-CRM114-Status: GOOD (  13.68  )
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

This logic is duplicated today for RDMA and TCP controllers. Move it to
the fabrics driver and export it as a new API.

Also update the RDMA/TCP transport drivers to use this API and remove
the duplicated code.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 21 +++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/rdma.c    | 25 +++----------------------
 drivers/nvme/host/tcp.c     | 26 +++-----------------------
 4 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567..4a1ef67c6fb3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -472,6 +472,27 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
 
+void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (ctrl->state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
+			ctrl->state == NVME_CTRL_LIVE);
+		return;
+	}
+
+	if (nvmf_should_reconnect(ctrl)) {
+		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
+			ctrl->opts->reconnect_delay);
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
+				ctrl->opts->reconnect_delay * HZ);
+	} else {
+		dev_info(ctrl->device, "Removing controller...\n");
+		nvme_delete_ctrl(ctrl);
+	}
+}
+EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
+
 /**
  * nvmf_register_transport() - NVMe Fabrics Library registration function.
  * @ops:	Transport ops instance to be registered to the
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a146cb903869..de213ab26977 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -188,6 +188,7 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
+void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index fbfa18a47bd8..f31a56d8fd73 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1064,25 +1064,6 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
-		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
-			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
-				ctrl->ctrl.opts->reconnect_delay * HZ);
-	} else {
-		nvme_delete_ctrl(&ctrl->ctrl);
-	}
-}
-
 static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
@@ -1181,7 +1162,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvmf_reconnect_or_remove(&ctrl->ctrl);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
@@ -1202,7 +1183,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvmf_reconnect_or_remove(&ctrl->ctrl);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -2265,7 +2246,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 out_fail:
 	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvmf_reconnect_or_remove(&ctrl->ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3ace20e39c86..530ff76d4ac9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1970,26 +1970,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
-			ctrl->state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(ctrl)) {
-		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
-			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->connect_work,
-				ctrl->opts->reconnect_delay * HZ);
-	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
-		nvme_delete_ctrl(ctrl);
-	}
-}
-
 static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 {
 	struct nvmf_ctrl_options *opts = ctrl->opts;
@@ -2083,7 +2063,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvmf_reconnect_or_remove(ctrl);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2106,7 +2086,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvmf_reconnect_or_remove(ctrl);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2150,7 +2130,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 out_fail:
 	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvmf_reconnect_or_remove(ctrl);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
-- 
2.18.1


