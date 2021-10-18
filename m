Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9F1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBB161352
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEBB161352
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m0tUCqqM0ODM9rUx4Q/Zo/KDb+9DXbbjSPVoI3634nY=; b=q9m+HfC3F4AZ1MqNz4k4kQyd83
	RD/hOpSZMLDiLJ07CXlkjJ2r/n/dIP//HCSAMSN7jJ7ovZi+dgMGOMXqZgjc9XUco0Vp9DCj/YmEx
	zkOvnJQtLoeew4l0pFLtyjb7PhUAq7g13bR6tYD3V7fyKObmFA7zSaC5l/lKjeJ2ULWOHzgXzWckD
	W+x7nVl2/lR23TA33XO0W1LM7AKauvQ4eUXA+Dsn2jBrUpscHwpZV4lhnqy4LwVSQSff56fz/Gl1N
	EBltXDVaTAjhbJf3N/2nXzpOrNkZUi3ObNIVCbBxK6c9XCEde7/LZoEaz0Dg3tLTJA/uUKpxH7bkK
	gCBj/i0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcSsV-00Fr09-LD; Mon, 18 Oct 2021 13:40:35 +0000
Received: from mail-co1nam11on2044.outbound.protection.outlook.com
 ([40.107.220.44] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsR-00FqxT-Pg
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBOmbT5CoRcEd6PojbnhcDdnnQabIOYlqNvTdWXaDQVqMKyYlxslqCnA00DmWZ8+rNQatFBP+eLlyWOHSXX5M9lf9I7HkPOBTkhrvYfkb38d5neE08pKH6+ZHUwYi6ZSfPrgD0+spFAspmwlsPmQ0pQirpcL3oqvGUrJqdhB0YAhRuF15YJTShbyT/kCqFh7t/t/e+5aelgkqHD3NfORTImVZ/8NFZxWM+H4Px3xaaK98TVKd+RAlZLQN6zUS176cUFnwFUBZapBb38CEYlBpWON/geTv20jENWHObNVK0iAdMjMviz7OFIILomSxzzg5rERBoCSKcV4YRmfKExAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0tUCqqM0ODM9rUx4Q/Zo/KDb+9DXbbjSPVoI3634nY=;
 b=Jdxv3qCMngc/o5Le2gKj4Z2PpEYsn2RJcJX+D9QPKllMPVKzg/kKAYQYtZrF1y0+AO13/wZ/RHYXJ2nMEtvbpSyWuZwsN0dvY2wrQunQEBGVFNLjQfKZ/z/7I9tCvZ1nTQi6isNMcLPC24rpZafI/w6fA5ivn/jW9EFwrqrKTbZE+hy1eHVLPKzNkGwnI72PQc4woTlqxKs0hlgsqTknabB/YZWyD8+5BkPP3RNMz9FYP1S1bhem6niEQ3baGMYSUqj+2VNQhSSy3myHMop/ga3dwC5743JKtNLSW0lbgbUmjTFCKpWzF7B+7d2SdIO6ozRKUUeaitctIMWZxt5I1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0tUCqqM0ODM9rUx4Q/Zo/KDb+9DXbbjSPVoI3634nY=;
 b=TBu9gn8fR/E44JKwxbOfOPr+CaLMpW8im3DdfOHRSXMmOd5rl3ASWkvZJaw42kt06qU+lPGOgbj4cfYMnAri0qCLxIQuTi6ZyLDhXKHfontyNOlkAy6WoMRXcM/xr0QW93nU7yojCuaSxYjaxNqg4IacNReNgVzjYCwDn4y32cMTIVHe55Hqkbll32ZaoVM4JsfIOW06NmfJKc17hofVWvgJm/HLegA80pXCSgXKWO2EbpHjVViq8hjVrdvxAjFjWnSax6DDVLWE20y7PXCqF/G9UOKu8Ym91a8CiYbL3Dwrb3aF3i+wRjsHPjO92UjC4w+FTRylDS7khxFcE6ZT2Q==
Received: from MWHPR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:301:4a::19) by DM6PR12MB3482.namprd12.prod.outlook.com
 (2603:10b6:5:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 13:40:27 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::d0) by MWHPR1201CA0009.outlook.office365.com
 (2603:10b6:301:4a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:27 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:26 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:24 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/7] nvme: add connect_work attribute to nvme ctrl
Date: Mon, 18 Oct 2021 16:40:14 +0300
Message-ID: <20211018134020.33838-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc1ad1d0-c29d-41a7-db33-08d9923cd825
X-MS-TrafficTypeDiagnostic: DM6PR12MB3482:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34822B7DC516256FCE277727DEBC9@DM6PR12MB3482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbRG14ZEIQQ9Nm5GQe6UjQWXTotXpIGLZjuTGs90trXaKR876q+q31vfVr5cA7Y6vBwEpR9fpPNs4JkDJ98s+NOx5/Y/YdBNQYsRZHblv7x8fxxkPgJjvqUK8uAfk9iKIFLtflfE0UqZz9kfrMEjbkJgk69Qlla/8TecTtewZlseL96+m+STBfdE4zAF0bNCd7JOrQDDK9yEQZcAmGq+nLbSsio5Wzdj8XXyV8DbxHK6vQe3kt5KytwR9jL6itKxcNlD24ShKWEU5kg8i+kXWKVWxoCMp9/1uT+BfVGjPZCspL9Rl1UOSxYgeeY5TzhuhV9KFfnlnpYnSNB2stMAmka99LBYhR4VlmooPsrvDb1rCfuihBhxP5GjLDsnnrUPABDaINY6V6thcN7r8hSSE3W1VK9WuurF/6/BrEiGayYjPx0lLJ3mjXT1mN5DZ+NDsn7m6LAtmDNT8KvChsZH9ILrN2EwiRubz2y0NNIGEHEc7g/VQWojcH9Z2/94abRT2YH5ZDJaOpykD57XsaUGfzI2ZWLe7ZH4BbdC3H4/jeUOi67197hc/ZWw5vUdICOG7fytqDp75lHaXbLfXSZiB8YpkaxoODGrgSfaS4S9g4ZdCzWSmTnBvbU8KBofJWN5FBgwyc/uvMYcdymQR5SlyxFCZTn9KnRvmXvTU3yLckEQIAp+95Tr9lpVMMVovfl9mf38dUZWQIHmpdDVSP9a2Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7636003)(316002)(36860700001)(4326008)(8936002)(8676002)(1076003)(356005)(83380400001)(110136005)(5660300002)(54906003)(47076005)(82310400003)(70206006)(70586007)(6666004)(2906002)(336012)(86362001)(186003)(26005)(508600001)(2616005)(426003)(36756003)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:27.0470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1ad1d0-c29d-41a7-db33-08d9923cd825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064031_910151_BEAB4F8D 
X-CRM114-Status: GOOD (  15.68  )
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

This structure is duplicated for all the fabric controllers. Move it to
common code.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fc.c   | 23 ++++++++++++-----------
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c | 10 ++++------
 drivers/nvme/host/tcp.c  |  9 ++++-----
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..4c7dffa8126e 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -167,7 +167,6 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct work_struct	ioerr_work;
-	struct delayed_work	connect_work;
 
 	struct kref		ref;
 	unsigned long		flags;
@@ -567,7 +566,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 			"NVME-FC{%d}: connectivity re-established. "
 			"Attempting reconnect\n", ctrl->cnum);
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0);
 		break;
 
 	case NVME_CTRL_RESETTING:
@@ -3263,7 +3262,7 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
 	cancel_work_sync(&ctrl->ioerr_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -3300,7 +3299,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		else if (time_after(jiffies + recon_delay, rport->dev_loss_end))
 			recon_delay = rport->dev_loss_end - jiffies;
 
-		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
+				   recon_delay);
 	} else {
 		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
 			if (status > 0 && (status & NVME_SC_DNR))
@@ -3340,12 +3340,13 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 			"to CONNECTING\n", ctrl->cnum);
 
 	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
-		if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
+		if (!queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
+					0)) {
 			dev_err(ctrl->ctrl.device,
 				"NVME-FC{%d}: failed to schedule connect "
 				"after reset\n", ctrl->cnum);
 		} else {
-			flush_delayed_work(&ctrl->connect_work);
+			flush_delayed_work(&ctrl->ctrl.connect_work);
 		}
 	} else {
 		nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
@@ -3373,7 +3374,7 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 
 	struct nvme_fc_ctrl *ctrl =
 			container_of(to_delayed_work(work),
-				struct nvme_fc_ctrl, connect_work);
+				struct nvme_fc_ctrl, ctrl.connect_work);
 
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
@@ -3485,7 +3486,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	kref_init(&ctrl->ref);
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
-	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvme_fc_connect_ctrl_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
@@ -3561,14 +3562,14 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto fail_ctrl;
 	}
 
-	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
+	if (!queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work, 0)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to schedule initial connect\n",
 			ctrl->cnum);
 		goto fail_ctrl;
 	}
 
-	flush_delayed_work(&ctrl->connect_work);
+	flush_delayed_work(&ctrl->ctrl.connect_work);
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
@@ -3580,7 +3581,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 
 	ctrl->ctrl.opts = NULL;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..81ca5dd9b7f9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -343,6 +343,7 @@ struct nvme_ctrl {
 	unsigned long flags;
 #define NVME_CTRL_FAILFAST_EXPIRED	0
 	struct nvmf_ctrl_options *opts;
+	struct delayed_work connect_work;
 
 	struct page *discard_page;
 	unsigned long discard_page_busy;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0498801542eb..fbfa18a47bd8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -110,8 +110,6 @@ struct nvme_rdma_ctrl {
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	struct delayed_work	reconnect_work;
-
 	struct list_head	list;
 
 	struct blk_mq_tag_set	admin_tag_set;
@@ -1078,7 +1076,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		nvme_delete_ctrl(&ctrl->ctrl);
@@ -1166,7 +1164,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, reconnect_work);
+			struct nvme_rdma_ctrl, ctrl.connect_work);
 
 	++ctrl->ctrl.nr_reconnects;
 
@@ -2230,7 +2228,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
+	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
@@ -2358,7 +2356,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->reconnect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3c1c29dd3020..3ace20e39c86 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -127,7 +127,6 @@ struct nvme_tcp_ctrl {
 	struct nvme_ctrl	ctrl;
 
 	struct work_struct	err_work;
-	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
 };
@@ -1983,7 +1982,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 	if (nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
@@ -2066,7 +2065,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
-			struct nvme_tcp_ctrl, connect_work);
+			struct nvme_tcp_ctrl, ctrl.connect_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	++ctrl->nr_reconnects;
@@ -2113,7 +2112,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
 
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
@@ -2513,7 +2512,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->connect_work,
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_tcp_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
-- 
2.18.1


