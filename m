Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D22AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A63261260
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A63261260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8J0DWLQsoBNIbH6do1HO7XSpemBjPyikfSHENs80xc=; b=kZNERvqW53KQFWrl+2h9K1mfB0
	EPcD8KvZiV1HvyfW8ivPAjXCyL3BTheP2LSl80z+2Y3hN8BhPX53bMb+/JHaZ0/ORp5MS96ZJ0oC+
	zXib9UDsF/nnrNsSW8bAdrmTkAxzMjhMNLlIi7BBrgZr2xTG3RdVr2TH+eP5rvPK8G3JC96jfQt4r
	E5Qho539sZzMHODpCKjEyJdwECMK7p0kTR4AFSaEOGLp0fH2tDj9ynT254TTrgmW/hVeF8wHv28yN
	2rKECdGNpbWi2n1qn0xVGQTIWugDtMn6uINEkRW99riN/DhERwurqHK8f92lnBiIzv79mkzEgtEaV
	hG8qYY7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md929-0049sO-D3; Wed, 20 Oct 2021 10:41:21 +0000
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com
 ([40.107.244.71] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md906-0049NG-IG
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzdSW0O7Jt1TXJcGHk1vqUj+rSsWhZxUejAmbbgXRyRt5zFDMEyVV213ABk6KGDp1dXZPKkMuA1y+BkJWi7lbNw/8xtrpGtntzUj/BRnih4QV0M7x43iFIbX/rA6iRz0JH0AK5CUsTQHIQzy/YCvukeom+UMsPlSKzGjiEfH60S0slbABDYug8lgY6b/nMPddgdB0FJBdL9iEIM2weyfo5b9UaZaC/HDvEoF6hDN6yj8dF5tZ2DznVxFAM8poFmmbmQ+U8XfcdCmxdUjx0Mzy2Akg5zTg3e0fnP/RoYneR77Pk9A4jRiSwGP81Nm/YZbhSqHO9f4G/hHrVNAf8mBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8J0DWLQsoBNIbH6do1HO7XSpemBjPyikfSHENs80xc=;
 b=n2mIApJjJAlJ/CXzo558uB3glny/ShLqPZhTqvISzX0vETgip0VNxbEisiwvXuzJ6Dwb3D/825RjX37jhkTa5mUvbnjQoOT5Bk+hS35yH293rrO9LcjBhkM4uS5Jq5j+P2dL5Xmn7IVB+Ombx+ZTOrUmYrKVGzIgPanL2PWc1KuyYhz1CFQz9/Cw6xtqIVxcvPMD1zWKJEpmMFOCoMPaF2pj1IXTtaJeF/ocerrXsg8d5Wcb74sEnAPHlRphS2OTgAYHMQZLTuLQV3kYxBqBBFE3eHHKs6y4J4hloGqFCFaPg/BE09koIxmc05hZhQHJGQ/FgYG0MgSQB0X0jM+zQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8J0DWLQsoBNIbH6do1HO7XSpemBjPyikfSHENs80xc=;
 b=FRPAp212KL/9tmqHzZS6Y4TFqy+88eHtW/XPn5SwKmrOhnvHkyvnIZ5irDRZlIx/ILxwOwHBpklm3fK8+NRiyNxU/tprIsMw0EmDHZdF8sUlaBmSycMZMkYaGmC5GkfRj3jr9A0DmIFWClvimGTXSPgEl6lFCGc3BWyz6/Dbo7zYo0ujfA1zbLe1wv2d0/mTgpo/ZK5Zj/rcVepwtb50dIa2+Tu6TUMXlfpQPQ/3cKGjFHQeqUC5lfyN1l378KMV+Nzs6ywVR7jS3T8HUW7DNLbeFuYedCigIdnlExLjkA1AL25IPT8Dg2+V89MDhDJq2OrkazERKka+29mt7XExcg==
Received: from DM3PR08CA0023.namprd08.prod.outlook.com (2603:10b6:0:52::33) by
 BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Wed, 20 Oct 2021 10:39:05 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::11) by DM3PR08CA0023.outlook.office365.com
 (2603:10b6:0:52::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:39:04 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:39:03 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:01 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 06/10] nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work
 API
Date: Wed, 20 Oct 2021 13:38:40 +0300
Message-ID: <20211020103844.7533-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac2d146-8172-4377-230c-08d993b5d696
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2823EBD046808D6F1C5EB2DCDEBE9@BYAPR12MB2823.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4ZHp0i+gwfGbEGgkWVTAijQGkxoOKyjom6ZOcBvmO1rIVOxIWIt0nxMFrHYo02MKNZ44jt5+LZQUbf0D6D+LTzo0sx6MaSvdvNdGdN7mol0W/l4uyN5aeiA4xDj2onc3JiOhcf7uugXkPp3g+PTG5fA9bIM4cKwFCq/TAugRlv+4HrB4k3jSNuU2qkGssAmsn5ySwHGCFWxv/VmONh0421U0fNiakS+2uhEnSQN6QHiEmvGEUjc/4lzXinsQ6lqLxj3zNAZwlMTIKwbud8wSWJYSTFnFGf2R2J7NqBfzLghEB5thOYKie7uGuAKbBUcHKUuhsJEPonHkgobBnM1KJuKh6wQIaDSf0+hi2GumQoPald0tURXwRisXUu7IN+/xed/k5F/nRi2qmlaIdsnk6uVdnsnmHbd9Eet5wDI46d3cipHMhweVa3lZ5sn6MoDKCTP31swxTBtabLa8AkHnvgtRyHlyYuT4DpJsNtwEVqF9lUCX5p3zvWp9+EsweC6w3MVY6EXoqLHRAWBZsoVylISOCfqlPq5jI/59ZXUvVgCa+JS8z2vO1+aItDl3aIl8DCboCBgEfTJt8QRnWR9P86iQf8CVNPeGERil62wWTtftBoSyqexGhTCTF/m1TwB5huEnYcuVmXBg1fcrTwFyogomMXdMhxAbJCtksm+vhqJMwktaRyBuKorFP+R+9KdJSxQGgfKeS4sru9wDJn5hw==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7636003)(110136005)(508600001)(54906003)(36906005)(316002)(356005)(5660300002)(1076003)(47076005)(83380400001)(70206006)(70586007)(8936002)(82310400003)(336012)(36756003)(6666004)(26005)(4326008)(107886003)(36860700001)(186003)(86362001)(2616005)(2906002)(426003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:39:04.3765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac2d146-8172-4377-230c-08d993b5d696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033914_661426_55CB1EA3 
X-CRM114-Status: GOOD (  19.09  )
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

Reconnect work is duplicated in RDMA and TCP transports. Move this logic
to common code. For that, introduce a new ctrl op to setup a ctrl.

Also update the RDMA/TCP transport drivers to use this API and remove
the duplicated code.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 24 +++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 82 ++++++++++++++-----------------------
 drivers/nvme/host/tcp.c     | 28 +------------
 5 files changed, 58 insertions(+), 78 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5a770196eb60..6a2283e09164 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -526,6 +526,30 @@ void nvmf_error_recovery(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_error_recovery);
 
+void nvmf_reconnect_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
+
+	++ctrl->nr_reconnects;
+
+	if (ctrl->ops->setup_ctrl(ctrl, false))
+		goto requeue;
+
+	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
+			ctrl->nr_reconnects);
+
+	ctrl->nr_reconnects = 0;
+
+	return;
+
+requeue:
+	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
+		 ctrl->nr_reconnects);
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
+
 /**
  * nvmf_register_transport() - NVMe Fabrics Library registration function.
  * @ops:	Transport ops instance to be registered to the
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 8655eff74ed0..49c98b69647f 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -191,6 +191,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery_work(struct work_struct *work);
+void nvmf_reconnect_ctrl_work(struct work_struct *work);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5cdf2ec45e9a..e137db2760d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -497,6 +497,7 @@ struct nvme_ctrl_ops {
 	/* Fabrics only */
 	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl, bool remove);
 	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl, bool remove);
+	int (*setup_ctrl)(struct nvme_ctrl *ctrl, bool new);
 };
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4e42f1956181..9c62f3766f49 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1067,8 +1067,9 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
+static int nvme_rdma_setup_ctrl(struct nvme_ctrl *nctrl, bool new)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	int ret;
 	bool changed;
 
@@ -1076,98 +1077,75 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
-	if (ctrl->ctrl.icdoff) {
+	if (nctrl->icdoff) {
 		ret = -EOPNOTSUPP;
-		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
+		dev_err(nctrl->device, "icdoff is not supported!\n");
 		goto destroy_admin;
 	}
 
-	if (!(ctrl->ctrl.sgls & (1 << 2))) {
+	if (!(nctrl->sgls & (1 << 2))) {
 		ret = -EOPNOTSUPP;
-		dev_err(ctrl->ctrl.device,
+		dev_err(nctrl->device,
 			"Mandatory keyed sgls are not supported!\n");
 		goto destroy_admin;
 	}
 
-	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		dev_warn(ctrl->ctrl.device,
+	if (nctrl->opts->queue_size > nctrl->sqsize + 1) {
+		dev_warn(nctrl->device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
+			nctrl->opts->queue_size, nctrl->sqsize + 1);
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
-		dev_warn(ctrl->ctrl.device,
+	if (nctrl->sqsize + 1 > nctrl->maxcmd) {
+		dev_warn(nctrl->device,
 			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
-		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
+			nctrl->sqsize + 1, nctrl->maxcmd);
+		nctrl->sqsize = nctrl->maxcmd - 1;
 	}
 
-	if (ctrl->ctrl.sgls & (1 << 20))
+	if (nctrl->sgls & (1 << 20))
 		ctrl->use_inline_data = true;
 
-	if (ctrl->ctrl.queue_count > 1) {
+	if (nctrl->queue_count > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, new);
 		if (ret)
 			goto destroy_admin;
 	}
 
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
+	changed = nvme_change_ctrl_state(nctrl, NVME_CTRL_LIVE);
 	if (!changed) {
 		/*
 		 * state change failure is ok if we started ctrl delete,
 		 * unless we're during creation of a new controller to
 		 * avoid races with teardown flow.
 		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
+		WARN_ON_ONCE(nctrl->state != NVME_CTRL_DELETING &&
+			     nctrl->state != NVME_CTRL_DELETING_NOIO);
 		WARN_ON_ONCE(new);
 		ret = -EINVAL;
 		goto destroy_io;
 	}
 
-	nvme_start_ctrl(&ctrl->ctrl);
+	nvme_start_ctrl(nctrl);
 	return 0;
 
 destroy_io:
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		nvme_sync_io_queues(&ctrl->ctrl);
+	if (nctrl->queue_count > 1) {
+		nvme_stop_queues(nctrl);
+		nvme_sync_io_queues(nctrl);
 		nvme_rdma_stop_io_queues(ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
+		nvme_cancel_tagset(nctrl);
 		nvme_rdma_destroy_io_queues(ctrl, new);
 	}
 destroy_admin:
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_sync_queue(ctrl->ctrl.admin_q);
+	blk_mq_quiesce_queue(nctrl->admin_q);
+	blk_sync_queue(nctrl->admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
+	nvme_cancel_admin_tagset(nctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, new);
 	return ret;
 }
 
-static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_rdma_ctrl, ctrl.connect_work);
-
-	++ctrl->ctrl.nr_reconnects;
-
-	if (nvme_rdma_setup_ctrl(ctrl, false))
-		goto requeue;
-
-	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
-			ctrl->ctrl.nr_reconnects);
-
-	ctrl->ctrl.nr_reconnects = 0;
-
-	return;
-
-requeue:
-	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.nr_reconnects);
-	nvmf_reconnect_or_remove(&ctrl->ctrl);
-}
-
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 {
 	struct request *rq = blk_mq_rq_from_pdu(req);
@@ -2212,7 +2190,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	if (nvme_rdma_setup_ctrl(&ctrl->ctrl, false))
 		goto out_fail;
 
 	return;
@@ -2236,6 +2214,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address			= nvmf_get_address,
 	.teardown_ctrl_io_queues	= nvme_rdma_teardown_io_queues,
 	.teardown_ctrl_admin_queue	= nvme_rdma_teardown_admin_queue,
+	.setup_ctrl			= nvme_rdma_setup_ctrl,
 };
 
 /*
@@ -2313,8 +2292,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_rdma_reconnect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
@@ -2337,7 +2315,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
 
-	ret = nvme_rdma_setup_ctrl(ctrl, true);
+	ret = nvme_rdma_setup_ctrl(&ctrl->ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 679eb3c2b8fd..e6e8de2dcc8e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2032,30 +2032,6 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
-			struct nvme_tcp_ctrl, ctrl.connect_work);
-	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
-
-	++ctrl->nr_reconnects;
-
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto requeue;
-
-	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
-			ctrl->nr_reconnects);
-
-	ctrl->nr_reconnects = 0;
-
-	return;
-
-requeue:
-	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
-			ctrl->nr_reconnects);
-	nvmf_reconnect_or_remove(ctrl);
-}
-
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	cancel_work_sync(&ctrl->err_work);
@@ -2425,6 +2401,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_address			= nvmf_get_address,
 	.teardown_ctrl_io_queues	= nvme_tcp_teardown_io_queues,
 	.teardown_ctrl_admin_queue	= nvme_tcp_teardown_admin_queue,
+	.setup_ctrl			= nvme_tcp_setup_ctrl,
 };
 
 static bool
@@ -2461,8 +2438,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_tcp_reconnect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.18.1


