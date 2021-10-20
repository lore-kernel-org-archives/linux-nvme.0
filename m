Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F88BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:44:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAE9611B0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFAE9611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70etH+5OPbbJKTJn5N9r4BIblPy0wfHW9NkNVQmmrFM=; b=IaEgBn5eREtd3HNf+RxwAee5pK
	NPt3EtU6qm3lPBKoAT4kWJzsM7lM6qK9QZQNHzj5gJkY+3+ZPtwHgQ5OaGYid8pcQ0inYCXXldhfY
	4lxnC4Q12VxvKbh978pzXjnPDezPSF8FF6gTGTPbGNW1d3MRa0uRgpuJpjS/mufbDOJWGSFmIneKd
	Pk3kFKewrfWO67/5SVxvIE/8C07Y0sy7fb8vs3SvUSYVcsjjGivaK49UwiI8vDBzdN/UDGL/uiqoX
	XeNRftl6P8Zqi1HF1m984wonJb7yFb7TTPAznEZlWsyGNxXmmnWgVE2R5kc2QWzUD28hscDMmFnuD
	LOe2c+Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md94g-004AQT-2O; Wed, 20 Oct 2021 10:43:58 +0000
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com
 ([40.107.243.59] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md90E-0049Of-3h
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMPGX3itgh0pk8GWBc3vHHkqsLEif5NrtxDfBlHJuesYQekP+xjDr4Oi3P2h8clNMPYGRFmwFaNNrxHelkqWaCLQRANR/Jk/+C7Ymni5CRjKC+ZguxOYLpGRSwNYhQRr4pg24YoHQsaquNCisDlDlW9VRRb3xgBhwoFFlZJW0Id4yT0vsvDgXSXe+WSTxdoLohR1dloqNdVcoZH6SY1ZObJ0594wuWI7ERnoLMnOYYpGe8xPH2JoBvohM6qotZzPieFKcChqUhzB7g45Zs3UNyN+orcaltSZYnr2EBKKzK1o+O9T7BHgJv7App9VObpUBzSZpTkxs5pRs7NU/eSkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70etH+5OPbbJKTJn5N9r4BIblPy0wfHW9NkNVQmmrFM=;
 b=BeGKac5g8dGBzjE+FINsluyJhEvqMn5HxrcoxcT26kRXFtCEBlvb46piwooZtl0Q6hPPsgHD5DhBExU2K9wKVcgxGA8s0QisVC/8IJxTjD1Lr8wSw2NZ62plM2fflaPEQLxLqymplaAGWCBIep2T419jShqkA/8LSStYfDqsOC+3I7D4F47E/OYx4cEx/rSxdl6yJ0P9RJIybKUacSM9AzQv8Q8RS/AVkYLjaZDGcvjwkEJy1VrIxVpQ6tXM5xtcahGMkS1O9xVzOnlUIWjOjGpglzzZMSc32t6KQtf1ZSyxeurB8BGHNZvph8eOv+cZrGjzyci7pd+4d7RCNPgpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70etH+5OPbbJKTJn5N9r4BIblPy0wfHW9NkNVQmmrFM=;
 b=TomanzVNSCxAsBEspGuG2IS/tb7S2nrWS2Xl43Os7U8fUrKeW53vMOqJyacdwJHTUw5Q+6nM8xZ303kVsERlDCWIz5b4vBdMOCmnPH/aoe3THDDNMQAvE/6UgzwuDgli9PS6baRYN7aiQTaRPw3OyVFfVRVUPYVfKYPWrIxcL9c10qd2u53v/IGPUOtNoArPrEvCGTwG4/hPt3dJujiJ6oN4vzow2JUaOY1WiC37HQ99iphwqWa5aWFxcsyOPWAL+tE9oKzVKJ6mitwVWe+7yahUWKfRHYnUdf02NSyBOZ3zNzjw1gkj3x8Mq3P1jn2G9dQZgnYd5gxrB1T02tN6bw==
Received: from DM5PR22CA0001.namprd22.prod.outlook.com (2603:10b6:3:101::11)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 10:39:20 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::da) by DM5PR22CA0001.outlook.office365.com
 (2603:10b6:3:101::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:39:19 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 03:39:12 -0700
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:09 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 09/10] nvme/nvme-fabrics: move reset ctrl flow to common code
Date: Wed, 20 Oct 2021 13:38:43 +0300
Message-ID: <20211020103844.7533-10-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d31909e-0196-4b57-5856-08d993b5df75
X-MS-TrafficTypeDiagnostic: DM6PR12MB4153:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41532A61E408C913C4654979DEBE9@DM6PR12MB4153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBAxZ46LTdiRYnlVn+D/GsjZVeaPMoqm/5/Fdj10u/MDXAm6Nrwa2K3mOfnKDohSWjYRD8VET+rK5BIGxHHmZWEDE5PHlN6RbDuLWHjF+Dy3Ykos9AcmM2rRBwhZyn+I9ygP0ZjrAP4YtIEdbD76BoQzkFRw2Ii/Ru43UGJodUK5cIeJnfU8JGMWgsbslhj2dTykTVPZ6ZjEAqaL2azBzofi6gfK584f/Ce8zycgbGIwuVYbfvooJEG+Pdcxu1AI1cQrhDyKbSlhr+2HUWC6qEiNHZcWfsCezxKWLtYT8BFXbH8DuDpDP+6SxtKOK8FVGEQ4jADgXzIxtvV8d21uskZw6z+kidDmNplWnKmcOnaXbh2J2UfhMhqQSyZbIs02rwF8fxDOiLp5kEcP3Ddl0GU7wYFSvfj1NU2W1AHnYXApuLfzAvz8VIWDoR9MZLeVQYErlyUZ2TbfzGwSQ+laHV19z29AdIcFt+UQFauN2yHtB7RMz0ae+mzObxUK6AhpjMVgxhtQ1MKAHiUmAurwYx5opxGZWuMIcIFv28TE5dNceeBAxl3ph1/O2DqpZt52VU7O91JMrpKUBKmSO0KIEWdShW29oSZPixW1DClUDJU8dyToARb+rcxO0iB9JDP78Fd7T0rWBFeKYnYN3t21WUNjN/8kmXWalPh+tTObP50Hw1QKyRqKe3KkwLMkLu0Dm9ESY+1ChT4ebzPtDAH9Ug==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(70586007)(8936002)(82310400003)(54906003)(4326008)(110136005)(508600001)(316002)(83380400001)(1076003)(6666004)(2906002)(36756003)(8676002)(47076005)(107886003)(2616005)(26005)(426003)(356005)(86362001)(186003)(5660300002)(7636003)(336012)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:39:19.5679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d31909e-0196-4b57-5856-08d993b5df75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033922_203822_BD63A662 
X-CRM114-Status: GOOD (  16.49  )
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

Reset work is duplicated in RDMA and TCP transports. Move this logic
to common code. For that, introduce a new ctrl op to teardown a ctrl.

Also update the RDMA/TCP transport drivers to use this API and
remove the duplicated code.

Make nvmf_reconnect_or_remove function static since it's only used
inside the fabrics driver now.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 29 +++++++++++++++++++++++--
 drivers/nvme/host/fabrics.h |  1 -
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 43 ++++++++-----------------------------
 drivers/nvme/host/tcp.c     | 27 +----------------------
 5 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index e50f6b32a286..e13891619de0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -472,7 +472,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_should_reconnect);
 
-void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
 {
 	/* If we are resetting/deleting then do nothing */
 	if (ctrl->state != NVME_CTRL_CONNECTING) {
@@ -491,7 +491,6 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
 		nvme_delete_ctrl(ctrl);
 	}
 }
-EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
 
 static void nvmf_error_recovery_work(struct work_struct *work)
 {
@@ -548,10 +547,36 @@ static void nvmf_reconnect_ctrl_work(struct work_struct *work)
 	nvmf_reconnect_or_remove(ctrl);
 }
 
+void nvmf_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, reset_work);
+
+	nvme_stop_ctrl(ctrl);
+	ctrl->ops->teardown_ctrl(ctrl, false);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	if (ctrl->ops->setup_ctrl(ctrl, false))
+		goto out_fail;
+
+	return;
+
+out_fail:
+	++ctrl->nr_reconnects;
+	nvmf_reconnect_or_remove(ctrl);
+}
+
 void nvmf_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvmf_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvmf_error_recovery_work);
+	INIT_WORK(&ctrl->reset_work, nvmf_reset_ctrl_work);
 }
 EXPORT_SYMBOL_GPL(nvmf_init_ctrl);
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06933e7a4ff4..ca405ecf90dc 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -188,7 +188,6 @@ void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
-void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 void nvmf_init_ctrl(struct nvme_ctrl *ctrl);
 void nvmf_uninit_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e137db2760d8..c654da7e45c4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -498,6 +498,7 @@ struct nvme_ctrl_ops {
 	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl, bool remove);
 	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl, bool remove);
 	int (*setup_ctrl)(struct nvme_ctrl *ctrl, bool new);
+	void (*teardown_ctrl)(struct nvme_ctrl *ctrl, bool shutdown);
 };
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f4eeafee05e5..c49ad0b3ffdf 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2157,46 +2157,21 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
+static void nvme_rdma_teardown_ctrl(struct nvme_ctrl *nctrl, bool shutdown)
 {
-	nvmf_uninit_ctrl(&ctrl->ctrl);
-	nvme_rdma_teardown_io_queues(&ctrl->ctrl, shutdown);
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvmf_uninit_ctrl(nctrl);
+	nvme_rdma_teardown_io_queues(nctrl, shutdown);
+	blk_mq_quiesce_queue(nctrl->admin_q);
 	if (shutdown)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
+		nvme_shutdown_ctrl(nctrl);
 	else
-		nvme_disable_ctrl(&ctrl->ctrl);
-	nvme_rdma_teardown_admin_queue(&ctrl->ctrl, shutdown);
+		nvme_disable_ctrl(nctrl);
+	nvme_rdma_teardown_admin_queue(nctrl, shutdown);
 }
 
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_rdma_shutdown_ctrl(to_rdma_ctrl(ctrl), true);
-}
-
-static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_rdma_ctrl *ctrl =
-		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
-
-	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, false);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	if (nvme_rdma_setup_ctrl(&ctrl->ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->ctrl.nr_reconnects;
-	nvmf_reconnect_or_remove(&ctrl->ctrl);
+	nvme_rdma_teardown_ctrl(ctrl, true);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
@@ -2214,6 +2189,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.teardown_ctrl_io_queues	= nvme_rdma_teardown_io_queues,
 	.teardown_ctrl_admin_queue	= nvme_rdma_teardown_admin_queue,
 	.setup_ctrl			= nvme_rdma_setup_ctrl,
+	.teardown_ctrl			= nvme_rdma_teardown_ctrl,
 };
 
 /*
@@ -2292,7 +2268,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	nvmf_init_ctrl(&ctrl->ctrl);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7f50b423388f..e65bdd0db4d5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2049,31 +2049,6 @@ static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 	nvme_tcp_teardown_ctrl(ctrl, true);
 }
 
-static void nvme_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, reset_work);
-
-	nvme_stop_ctrl(ctrl);
-	nvme_tcp_teardown_ctrl(ctrl, false);
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->nr_reconnects;
-	nvmf_reconnect_or_remove(ctrl);
-}
-
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
@@ -2400,6 +2375,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.teardown_ctrl_io_queues	= nvme_tcp_teardown_io_queues,
 	.teardown_ctrl_admin_queue	= nvme_tcp_teardown_admin_queue,
 	.setup_ctrl			= nvme_tcp_setup_ctrl,
+	.teardown_ctrl			= nvme_tcp_teardown_ctrl,
 };
 
 static bool
@@ -2437,7 +2413,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.kato = opts->kato;
 
 	nvmf_init_ctrl(&ctrl->ctrl);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.18.1


