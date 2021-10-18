Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4096CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:41:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0299061A38
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0299061A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0y8YDEz3LZ22+5OTKzu+ADRxLF6pxfL/m9VtNXExvYI=; b=TeLRrtkIXdJ6v5xu4/XAn2kaDj
	T7ETNkJ5X3j4zPMzggeRbkwCF1JUAxeUVgA0QhspdszeJNtMRq3aMjAvYhNF5/8oVoUgeLzHI+2Md
	JiJPYKwuBU7g0VrO6axiqnLZwJ02ZVjH8rWDPDpriwtKe570Wel3MkrQ3HiFSJ7C1ET1rFhSdF9+q
	VJydK4wj2L+GNawHXDBDv4/gsuK+8RZiBZuj5SxFbc6mkuFqgvT0BdapC5nZQk0Uo1t8Pz/oTu4TK
	u4PyICzpaclltLx0Rk7Up/8JBs1IjeQdoHzPO583qlbXUlAiSuik6Ij3rMpAQ9sW8Z7+l00/QFMZ4
	+sKu087Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcSsv-00FrAw-Tz; Mon, 18 Oct 2021 13:41:02 +0000
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com
 ([40.107.92.45] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsW-00Fr08-RF
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znbu+CW+1aqgl1IUHsCdQD/7tZx7X/pustU62b5Afw7qbLV4JoytHaqr4nwpjlCwGVTxm07JSPp9Inm1PgnUMZTkQs5FZc+7YLt1ExcJJQ/jYXPIeoO24BjSizFeJjnQZ79/aSUR6Kmhz6jQ5xroZ51znmRvsnJxxWsUlFYc5VSCfvSAcfQHywmsxo+zDqo0uF1ApdnKLD8Jm7PqU/M3abFlBGoCf7HvbUAQVsHn6t0o0Nzu4V6pjbXlfCriTWy84uuOOCzXxhdhOo5wYn8kc53Zyxz09u+fhCwbpImmzdS52Jy1b2GPBD/RSOtLcqoKIFuyGAX1II3iEgcoIJVCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y8YDEz3LZ22+5OTKzu+ADRxLF6pxfL/m9VtNXExvYI=;
 b=dejjRmTxuX5lC2GjxDQaKJi7BBzaSlZ8cbJN35pV0/UdgG+81ZkIyZ6Wkth1kFqDqylDMloKLU5L/12Goa9OEV+Ubhf4FEl4fZUCJtcUB+nDp4wkURk0dluQgJfnu915iqU7ACXS8royTVkMgvT6QWCijMIOwmaB3rYptYF/bbE/Dekd1kU+UsP+TLsNRVCozeW4J9uE/JYNXLljMFAXN/5DWR6DqCs0KPhBKskJkgxfu3QY6E+5iX3P3HKKoOWdUXXnQLFIPqTDaM8bvZ2Wwj16aNOeWKha4/RcwgaHfkYj0Pt0oX+LfnfezJxkbMEaXyEObVL62zeYSLs7Jyjcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y8YDEz3LZ22+5OTKzu+ADRxLF6pxfL/m9VtNXExvYI=;
 b=bfhQ55p3wXKFoZfi0eMXpFZGwK3fC5L28sxnJvPSl8r3OfmOW1hT5kCOcDwyr6KuZCOReNVkJ9dnk2ligQiZFz0NUIRhAowXHWuDDQfIVKNm3sn2bJL9KZnXPQDR7Nor8XRmm5TPGHkyJzYncYgR+gAW6jGY8B2OJz7qlf17vz1lUIhT5LNzwVVrU+4IKIRsWSx6Ipy+S31i9YR5Mf9cMd+AMVwm0mMALJ+ajwol/OqCI8krYBPcpXf+RNL1ZzbfLsWzobASjNHXOwulQCtMpjiOkRBrA/Q4Mi7ms715vav6HFjvzMnMXwU05JIdgoJazFbu3PwyOtYqxGhMlfkp6A==
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 13:40:30 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83::4) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:29 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:29 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:26 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Date: Mon, 18 Oct 2021 16:40:15 +0300
Message-ID: <20211018134020.33838-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e10907-4f3c-42fd-bdb0-08d9923cd9b1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:
X-Microsoft-Antispam-PRVS: <DM4PR12MB518172A70D36E564D06ABBD6DEBC9@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8hy/IO09goKDv0ydEuzX3ECUKHktm761JqN4fAloDW+mSyNVsjw/ficEZX5ifNV76HxIKz7gT9s/JR1zE46ioyo5qf/JQ+pwJ1Qiv9/wO+0tam2EaAl6u70rEmCKOhF/OvOeGAoCX4Ulw82jp5ANsyYzq3whSU3JKaUGRXJdLiXvYVvB2/rExzOs5UUrScxhmDIJ+HMW/6z30QMigQtPtaXZUimo3Q7A1YDM2grkh5RXcOdsZNjiEGfFHKLXZkfpXmMpdhsfUN4d+PNVv2m8wLDVp7mQYVvWoL/hElRokm6MapRkF2lHi8wYgRkx9kmni8s4dqsLEgTl57DHi1nEV0AS9kUwDfsOo3yxfaXr3T3cDxRWBxvbfNEXNkWHtkMZQ9csQb+zGrPHfcWlYZsIY9cew5uQEjGW18E4z0ObI1e/0MbeugrNV2f0ggq9FEjjgBTzY8LLMNyNlCzRsLhQmUWwmJ+ce9WsvFOLcfdGr1JQzEpNQHXjz/Z8emdqq42KYAIILQA7unP6sQc6UcuR/YkM+d9lBiX/p88kwNZ+PyMohFHTcXpkawxXqjYO93Y4I8gqG3LUvIKk8nqjPIl9G0Pbc1asXo6yE9TXdZld1qcB3kNdv1Cmqn0fKhUKcImbenlI6sgvBpKWNwfNGrPfKe5MQRM+nInrt5r5Ltx0M/gz+3cg860F66ZwDN3ijHKxvnwToDIBlp22a8A0psMQQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(83380400001)(82310400003)(356005)(426003)(2906002)(47076005)(7636003)(36906005)(26005)(316002)(86362001)(110136005)(8676002)(107886003)(1076003)(336012)(5660300002)(70586007)(36756003)(70206006)(186003)(6666004)(508600001)(2616005)(8936002)(4326008)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:29.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e10907-4f3c-42fd-bdb0-08d9923cd9b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064036_918711_AFB7F741 
X-CRM114-Status: GOOD (  12.95  )
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


