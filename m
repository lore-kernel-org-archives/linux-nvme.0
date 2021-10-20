Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4994C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:40:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE7E600CC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BE7E600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5//RjsAC++PJGMOLe3HutSPPRZXQjyqhWClrR15ONQ=; b=RGudjrQSg3CS4WEJx8WvfTwjAz
	dxvlWr8VMxaDvAxp4B90Y4EEXWsjNLSOY9ivqd3jNG1t8Z8S5Ps6cS1DGg5dGpI4hRs2yuIbeRgIO
	irePD6bn+02GaZBvtIKk/7BRcB0J7NhS3VpfHi9XGMdWzSvwHzt6epKeC+id2gw6qRDGxb7QXlpxb
	pf04VBgpC9tJUWVaNtn+ju2Hl0znSTFpxLd0bthB/glFYSbSbGwGOgyP8LmBNpj59rgMtnBR8Dnwz
	IL/uvNujNnLQGIwC5yjNleVv6E31Y22+JdaggkztBgf3dkXuhd75AtnWHk+XJ2ZO7SuninlGD3kEp
	aUWlrDMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md915-0049cZ-Hi; Wed, 20 Oct 2021 10:40:15 +0000
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com
 ([40.107.93.65] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8zz-0049M6-Qn
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOM4SJ55rdeISAp0DTUalJb4rGm5v2jwiKwWI3eEDR/lmbwtzJgV6CrgfJmR7972HlLw56xky5cJl7goDC1E52qU8CZMuuFEhpjZuYSeYyRv7DmfY0XqmOLAlXihJEf8FkItHXmbf6nOe/3SsNatsQdZwoA48fBH7Yg1awFAF2Tt2T8T9zMTRJcZryUbfqzNlhxvm69b6MJrCmS26An/gg1pFz13vvlcSM4z0DSwdZzjBKSIIO+0ebMRGlI8yS9kaqPYGRQ7ANouFcLHuk2tNAmlYjk1Yj9LmFY+T2r61SLzGd+KKL3h80CG7TwG444iuwdyvoEYeB+lJehcT020FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5//RjsAC++PJGMOLe3HutSPPRZXQjyqhWClrR15ONQ=;
 b=i2GD0gcsW8U4zQMSrzPV+LWnbrD4si/96VFdREAlMj236ujmHxcM7vSxxRTJa/qHzG5IepFk8BW5Cwg+UpD3dyz7aNSfwnUJONZOxqzhmS4PdQ8bYxk0x2T2EQGUaFzomGaBgrC1omg7a8LzyhEfinKl8x+SmYumLqZGTsgsTJN1uWpFTPyeQLic+GBYYCzEefcTxzsmqZFM6gwekBYsPYDfCn6oE8e00g0xHS0zGvi/GfNZZ/tdnMeoBpDl4aYJ6yoln+33nr8oo4N1uRCjAw2KWgKUv0xkKkrPHqSo61PrVyJ088e1t1WWrpxJ57LVgfOPnO9dvXJ9gyHfnMDZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5//RjsAC++PJGMOLe3HutSPPRZXQjyqhWClrR15ONQ=;
 b=rdpakagzG/8qd+4r9LdmoCvy8cbKJiggTh4sTzatyMpHX+ud2bhO31jHaMT+TP2u0DAgEEK0mjrGykfs3UKIr96KYEIMT11XgpXGwNSCfmGNNY5BeZQEN7pR3rt4blIIcO5qIwAsflxI0UuZwItsSHkpRBiRK9R5gpweZEIYbzrzLP30Y4IqSVExmTcHHdpUDywaiJnZdf27QeYyNmALzuiLYivtNCtLcEipQT60hkiVxptjn5DloH0Gj0Fu/iRBFF8t8eNsDGzFPcFZXLf8Qo+Q+R47DCIN855tMfltHutp1ySvJTVoI+D2Pc3SLNmxWjLyNJWmlludXGdVQ6HWmQ==
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 10:39:05 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::85) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:39:04 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:39:01 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:58 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 05/10] nvme/nvme-fabrics: introduce nvmf_error_recovery_work
 API
Date: Wed, 20 Oct 2021 13:38:39 +0300
Message-ID: <20211020103844.7533-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3d57e5e-2810-44d3-a812-08d993b5d6cd
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:
X-Microsoft-Antispam-PRVS: <BY5PR12MB55449D57261A2ABDC5841F2BDEBE9@BY5PR12MB5544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJ96qqRSeTX/OF6mZZ7eyboCFNLjJCrkjDpFfTURvJUb0yx+3p3dqYwXg/1+GB3LR4gVHzGS2PJCCYUGm8ULy4vm6fgaMseBxVDpzr/ZMthPVGDHV9lLq2DhU4IjSxoDES11cV2mKHd49L0F7GsMHO1rbkrQYmJs9JghRZEqEihspQRuqyFCxdKDm2p1kyX+LGwBTq++8SE6v2o9QXB8NFvtYbIHlMomf5Cfq371QFkWvf7iAGdTph/XGp6Aa+6SZwv8J0I3UQGBTlIvYOgckXuKgzgmLfd0zfbYnWDuIp5pwGhxMo6lIUSnt6W+gQMG0sFHhjV37XLyx2SAgVBcipJIkNB7tSW5G9KXpyRUh9XAsLdLUKNBTc/PkowLdLWw5fYR76Fo15OVhZqU1Vv8/e+ppovXz3r48vmqfoCu7c+24YihRqJ/592aPOJmy5Ov7p1jPxu7vBhVFIP7QbpOJpwS9skmNz0Rwn3cpOLY2axuoZ1Sn7ojIgqBJstcv/jFZER0I0OcRwKGeWaLJOejZLYNaLpTDdd8G5HoIuUECuHnFl1UhB7CHDk4ZC4ZsUHeNJNekxaLEVIyRf3Ez/doUclLScOW72s24dK/E+9dShCyZjOLh2w+yoNXoW6kBBAJ2Va1b7MM31K++8rI5pWKcRCDm8/NTQV7cM3u8D8xlzWLAAyABLbdCdAcS/NYyHHbBU96uFIo+NF5i0auWfgLtA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(70586007)(7636003)(426003)(336012)(356005)(36860700001)(82310400003)(8936002)(2906002)(36756003)(36906005)(5660300002)(83380400001)(2616005)(4326008)(107886003)(110136005)(186003)(54906003)(1076003)(8676002)(26005)(6666004)(508600001)(47076005)(316002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:39:04.5944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d57e5e-2810-44d3-a812-08d993b5d6cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5544
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033907_960176_11E6FAE8 
X-CRM114-Status: GOOD (  15.78  )
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

Error recovery work is duplicated in RDMA and TCP transports. Move this
logic to common code. For that, introduce 2 new ctrl ops to teardown IO
and admin queue.

Also update the RDMA/TCP transport drivers to use this API and remove
the duplicated code.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 23 +++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/nvme.h    |  4 ++
 drivers/nvme/host/rdma.c    | 78 +++++++++++++++----------------------
 drivers/nvme/host/tcp.c     | 46 +++++++---------------
 5 files changed, 73 insertions(+), 79 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2edd086fa922..5a770196eb60 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,6 +493,29 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
 
+void nvmf_error_recovery_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, err_work);
+
+	nvme_stop_keep_alive(ctrl);
+	ctrl->ops->teardown_ctrl_io_queues(ctrl, false);
+	/* unquiesce to fail fast pending requests */
+	nvme_start_queues(ctrl);
+	ctrl->ops->teardown_ctrl_admin_queue(ctrl, false);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
+
 void nvmf_error_recovery(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 3d8ec7133fc8..8655eff74ed0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -190,6 +190,7 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery(struct nvme_ctrl *ctrl);
+void nvmf_error_recovery_work(struct work_struct *work);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f9e1ce93d61d..5cdf2ec45e9a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,10 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+
+	/* Fabrics only */
+	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl, bool remove);
+	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl, bool remove);
 };
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1c57e371af61..4e42f1956181 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1019,29 +1019,33 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
+static void nvme_rdma_teardown_admin_queue(struct nvme_ctrl *nctrl,
 		bool remove)
 {
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_sync_queue(ctrl->ctrl.admin_q);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	blk_mq_quiesce_queue(nctrl->admin_q);
+	blk_sync_queue(nctrl->admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(nctrl);
 	if (remove)
-		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+		blk_mq_unquiesce_queue(nctrl->admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
 }
 
-static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
+static void nvme_rdma_teardown_io_queues(struct nvme_ctrl *nctrl,
 		bool remove)
 {
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
-		nvme_stop_queues(&ctrl->ctrl);
-		nvme_sync_io_queues(&ctrl->ctrl);
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	if (nctrl->queue_count > 1) {
+		nvme_start_freeze(nctrl);
+		nvme_stop_queues(nctrl);
+		nvme_sync_io_queues(nctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
+		nvme_cancel_tagset(nctrl);
 		if (remove)
-			nvme_start_queues(&ctrl->ctrl);
+			nvme_start_queues(nctrl);
 		nvme_rdma_destroy_io_queues(ctrl, remove);
 	}
 }
@@ -1164,27 +1168,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvmf_reconnect_or_remove(&ctrl->ctrl);
 }
 
-static void nvme_rdma_error_recovery_work(struct work_struct *work)
-{
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, ctrl.err_work);
-
-	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_start_queues(&ctrl->ctrl);
-	nvme_rdma_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	nvmf_reconnect_or_remove(&ctrl->ctrl);
-}
-
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 {
 	struct request *rq = blk_mq_rq_from_pdu(req);
@@ -2201,13 +2184,13 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&ctrl->ctrl.err_work);
 	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 
-	nvme_rdma_teardown_io_queues(ctrl, shutdown);
+	nvme_rdma_teardown_io_queues(&ctrl->ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 	else
 		nvme_disable_ctrl(&ctrl->ctrl);
-	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
+	nvme_rdma_teardown_admin_queue(&ctrl->ctrl, shutdown);
 }
 
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2240,16 +2223,19 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-	.name			= "rdma",
-	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS | NVME_F_METADATA_SUPPORTED,
-	.reg_read32		= nvmf_reg_read32,
-	.reg_read64		= nvmf_reg_read64,
-	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_rdma_free_ctrl,
-	.submit_async_event	= nvme_rdma_submit_async_event,
-	.delete_ctrl		= nvme_rdma_delete_ctrl,
-	.get_address		= nvmf_get_address,
+	.name				= "rdma",
+	.module				= THIS_MODULE,
+	.flags				= NVME_F_FABRICS |
+					  NVME_F_METADATA_SUPPORTED,
+	.reg_read32			= nvmf_reg_read32,
+	.reg_read64			= nvmf_reg_read64,
+	.reg_write32			= nvmf_reg_write32,
+	.free_ctrl			= nvme_rdma_free_ctrl,
+	.submit_async_event		= nvme_rdma_submit_async_event,
+	.delete_ctrl			= nvme_rdma_delete_ctrl,
+	.get_address			= nvmf_get_address,
+	.teardown_ctrl_io_queues	= nvme_rdma_teardown_io_queues,
+	.teardown_ctrl_admin_queue	= nvme_rdma_teardown_admin_queue,
 };
 
 /*
@@ -2329,7 +2315,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fe1f2fec457b..679eb3c2b8fd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2056,28 +2056,6 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvmf_reconnect_or_remove(ctrl);
 }
 
-static void nvme_tcp_error_recovery_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(work,
-				struct nvme_ctrl, err_work);
-
-	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_io_queues(ctrl, false);
-	/* unquiesce to fail fast pending requests */
-	nvme_start_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->admin_q);
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	nvmf_reconnect_or_remove(ctrl);
-}
-
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	cancel_work_sync(&ctrl->err_work);
@@ -2435,16 +2413,18 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 };
 
 static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
-	.name			= "tcp",
-	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS,
-	.reg_read32		= nvmf_reg_read32,
-	.reg_read64		= nvmf_reg_read64,
-	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_tcp_free_ctrl,
-	.submit_async_event	= nvme_tcp_submit_async_event,
-	.delete_ctrl		= nvme_tcp_delete_ctrl,
-	.get_address		= nvmf_get_address,
+	.name				= "tcp",
+	.module				= THIS_MODULE,
+	.flags				= NVME_F_FABRICS,
+	.reg_read32			= nvmf_reg_read32,
+	.reg_read64			= nvmf_reg_read64,
+	.reg_write32			= nvmf_reg_write32,
+	.free_ctrl			= nvme_tcp_free_ctrl,
+	.submit_async_event		= nvme_tcp_submit_async_event,
+	.delete_ctrl			= nvme_tcp_delete_ctrl,
+	.get_address			= nvmf_get_address,
+	.teardown_ctrl_io_queues	= nvme_tcp_teardown_io_queues,
+	.teardown_ctrl_admin_queue	= nvme_tcp_teardown_admin_queue,
 };
 
 static bool
@@ -2483,7 +2463,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.18.1


