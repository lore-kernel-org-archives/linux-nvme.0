Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC57C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA306154B
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FA306154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkT+NiaKY7O//ubPCLSHaeKSQH2Ij2TAz+jUOJ3o7gA=; b=cqZTGq8Xf6chrqx5+Q+Kmvif1E
	NZ+xHRaNS9+E4cWFRU7i1suYjX+FBNaUPeQGTsKCXHAwGeUDGeL3ri6Qv2/qesoG0fuBYdtXDLIi3
	gcdCu2JrjOS9SoKTwgWjfZUUwwDi4nlwCb7urxSapPWo7mjIdrVTkQYaNseo9hfpp2hBoeGw2RYY6
	RlYZ57sESt8icqtdPjAL5gfyrdop866vlebZI8DJRP+thGz9Me53zEnyLW6w9oonGhN8BzHh0ty88
	ht/7ct01Ow+Lf86Jo4RL06ZvtlmNxSCYGb4lEAoSzDZmyfDLAWvwZtmH9e2oQqlemJ2o12iuph/cj
	vRr3ofhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcSvi-00Fs8d-23; Mon, 18 Oct 2021 13:43:54 +0000
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com
 ([40.107.96.41] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsg-00Fr52-41
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RliMAo2FAxzLc8FZUw7LjacSkShR96h6iqF0moi0M1rzbf7Hs43FPS83zmnS0sCRORqt45irI1lfbQ48W1ns/yCqYuezQUl7ND0ry17TWDfSNDcSI8+m3hCK9qHRFxLINJJ9QK+kuWiJdOuMOzpOWcCOB2R6N+3Va3Hb/+Os/Ydr8X6rMfsfhkYG+I/Otl/pX+jvsUunGf61Y5ndedlhOVFyNzBkMw0+KHbcDJR7Fh9lJ/GRC5+ljlOz2HN5+wu37R10Aml8AqIgfB83Q9As+qXbtWxB3xrJHXCRbNqOxLKKnjOexp+pqqrmrv+Go09KzDJHnKaE2FL0MFk4YqGcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkT+NiaKY7O//ubPCLSHaeKSQH2Ij2TAz+jUOJ3o7gA=;
 b=CDF33nxv+JTVCd+IafwN1CLS00jOqZayNAs0o0BLTxFhv5YspLTiK7BzanBCzn4LLNgFC1VM4q6S76eiBpY/yOxAGJPbe6oEr/beHYHGVVM5JUuW7n7cHT3mYSJEKVwcKNsMfr3nWpm+9DD57WKFiVDkWXy2BqYi/S5XeEKSdYd2ZReZyU24ERGa0aA/TeskmZSejOkaDF1TBw02t1Y+sfxuoym9oVGIBf4yof/5+7XUeNGoGf+jKJ4tMo75DIdxig5Usn25VM9e4ctj5VZQxfzAErUOC6gNAUF+rrjC0vBeOYMfiFdlkVsRYxI0hTKIN7NORZU52aU/f9Rd6KAysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkT+NiaKY7O//ubPCLSHaeKSQH2Ij2TAz+jUOJ3o7gA=;
 b=IQlmKFE76SlDCfnwQXtEbOgSfj5NodjpL5e+PZ1p+B7SAdXgY8OZhm6l6SAyOix7e66zi69ngHNOoYelVCqcJBl//yCtM+JpR+mMhcLCQCLiJiGXyTxLk99sckWQYD7vZaI4cGQf39MQtntG5GmXyX1R5zEpEZk5u8+MJLrwBvo2RkpRQ+Yb/VscBa/Q1rAa9iNFaZYpoIQSzVvjYBFvNkrGAsqDSPLR83WzoSi6dj7g/zZGmuGI4RMfcxSf9d71DIy5qqfOJe/HpphLGmCIt0oknIPSO58PRaas3mfBtuFQOj0omnZzE+Ee5d0lOr+7L9388pgEsTNGEqoMa8S6Zg==
Received: from CO1PR15CA0080.namprd15.prod.outlook.com (2603:10b6:101:20::24)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 13:40:42 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::af) by CO1PR15CA0080.outlook.office365.com
 (2603:10b6:101:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:42 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 06:40:41 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:41 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:39 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 7/7] nvme-fabrics: add nvmf_init_ctrl/nvmf_teardown_ctrl API
Date: Mon, 18 Oct 2021 16:40:20 +0300
Message-ID: <20211018134020.33838-8-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8e600b5-56ea-49bc-6a63-08d9923ce159
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39497CFA0CDA34863F72A6A9DEBC9@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LS3hdHRJUB/RC+eohYQmK8dl0EKIpGj2nGRRZZ1ePK4jL97MSiMd4iCLbNvgs0fkogYhWZRhrq7PLnoPusKAy+5OKD40YIw0RDIcYygZZibpfLQwNw5aKDEYFExCIc2X9ld9TGR+s2bUWO7qBbigLCirk9olU6jB5FfrAgCZrgCnoaEtv3d6zHTSPQ6sxYa2Xf901yoDvNgtBZmWPKpd8fR8cEVZanjjtpX6wKDlmRY18Pa3DfSrdjHg/NjN2ezNH1o+dhEIdqE+6Nb14/m+a9ChmIH1HZaqOTSzFSNXvk9m8bIdw6QwsslXtqFA+chIWV3MyxLZVTANNr48Ch/XQdyogfwid3eA/aNe4DQl6ukRtKMAeXp6sIVr+VZQt6/yf74Xeltp6gVgqx4Dw+jH79nb+M/zikLiYOWd/Yur/SDH9yjYtdWd5HfXj/kMIFUGmbUyf/AadqfGcrR3RDM1XTOxtbvTLVuOFVVy6gpooWiqytSl87dQhDHpHOY6ZHvwcrfYMsV9FfiQa2s5xMmaJZGDGOJ6lrVG9dn1EtW1f1t/D4xZ6T5nmua68TBE+4cHnamu/f424e3Us1fD1BKQSegZWBlnh6VUh8cJftTdF6hhTG6+hdn5/HXmCDQzkygIngJRXXFREph8+tRGbdQOvi3+ie61jLwM2xeWCGyuvaddoEFMYD4eC9v/8pVayLA4d2Gd6Lc1rgCqnkAw48jFHA==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(1076003)(426003)(7636003)(5660300002)(107886003)(508600001)(316002)(186003)(83380400001)(2906002)(8936002)(2616005)(47076005)(70586007)(336012)(26005)(36756003)(54906003)(86362001)(356005)(82310400003)(110136005)(4326008)(70206006)(36860700001)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:42.4763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e600b5-56ea-49bc-6a63-08d9923ce159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064046_198552_872980F2 
X-CRM114-Status: GOOD (  10.53  )
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

Centralize the initalization and teardown of fabrics specific settings.
For now, only used by RDMA and TCP fabric transports.

Also, convert the reconnect_work and error_recovery_work to be static
functions since they are not used outside the fabrics driver anymore.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 20 ++++++++++++++++----
 drivers/nvme/host/fabrics.h |  4 ++--
 drivers/nvme/host/rdma.c    |  7 ++-----
 drivers/nvme/host/tcp.c     |  7 ++-----
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7f76b27ce1f2..4a16e5f85d24 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,7 +493,7 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
 
-void nvmf_error_recovery_work(struct work_struct *work)
+static void nvmf_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work,
 				struct nvme_ctrl, err_work);
@@ -514,7 +514,6 @@ void nvmf_error_recovery_work(struct work_struct *work)
 
 	nvmf_reconnect_or_remove(ctrl);
 }
-EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
 
 void nvmf_error_recovery(struct nvme_ctrl *ctrl)
 {
@@ -526,7 +525,7 @@ void nvmf_error_recovery(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_error_recovery);
 
-void nvmf_reconnect_ctrl_work(struct work_struct *work)
+static void nvmf_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, connect_work);
@@ -548,7 +547,20 @@ void nvmf_reconnect_ctrl_work(struct work_struct *work)
 		 ctrl->nr_reconnects);
 	nvmf_reconnect_or_remove(ctrl);
 }
-EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
+
+void nvmf_init_ctrl(struct nvme_ctrl *ctrl)
+{
+	INIT_DELAYED_WORK(&ctrl->connect_work, nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->err_work, nvmf_error_recovery_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_init_ctrl);
+
+void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl)
+{
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_teardown_ctrl);
 
 /**
  * nvmf_register_transport() - NVMe Fabrics Library registration function.
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 49c98b69647f..08b290c2e01a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -190,8 +190,8 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery(struct nvme_ctrl *ctrl);
-void nvmf_error_recovery_work(struct work_struct *work);
-void nvmf_reconnect_ctrl_work(struct work_struct *work);
+void nvmf_init_ctrl(struct nvme_ctrl *ctrl);
+void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7fb2f434fe0d..aa3e142047eb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2169,9 +2169,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->ctrl.err_work);
-	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
-
+	nvmf_teardown_ctrl(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	if (shutdown)
@@ -2302,8 +2300,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	nvmf_init_ctrl(&ctrl->ctrl);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0e5bb3949b3..26c2b181edb9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2049,9 +2049,7 @@ static int _nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
-
+	nvmf_teardown_ctrl(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2453,8 +2451,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	nvmf_init_ctrl(&ctrl->ctrl);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.18.1


