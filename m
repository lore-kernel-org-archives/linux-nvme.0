Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:42:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB37613B3
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BB37613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1QWWEtxcWaiTEyQcISb8Zls+qivK2VDs4vEC1WH6F4U=; b=jFHj8rqxHhmOOW3cfJ4EWQYwkc
	ma4Xii29/YL95Oi2nF4+W1VUyR9lVdLTxKULuHiM4ALGsIZmN6TKRO27tYe2p13LMiUxK1npeZrPS
	B6hQufbiwB6xibHv+fq/rVHfFMFmGqrdTZbGuaU9CFT94FG8QiPX0QlUE4XvuGqzaqGSicvFrd86A
	fLcrOQIT/S4/XLy4eAM+stxL3C8JISxgKfQgrId3PUFKZAyKFOLAXNEt08u4JO0rT/pFFjfNLzdrx
	bzzm7oOostSy6I8f6L/YwVWXJcOMrnb9nReDemDGJ3b4+VjYNM/3IQwm8W24+cDqggXkufuPIOqz/
	grPrF/wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcSuk-00Froa-CM; Mon, 18 Oct 2021 13:42:54 +0000
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com
 ([40.107.244.46] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsf-00Fr4i-R3
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvdZ8nP3HVvM/DV+YBSSHxH+T9gfbYM7XWF+AXRQ0lDAP8vwQ/IWten81sJvNKglXX+7wLIXi6xTAJioWDGsQ2YR/bKm44SiF8Z6P+uectU0b/5r2XxpUF7CBsKGwIU7xgkf+5sdvOK5Qa9Hme69AVIcl3eeUU8saeBou0D08zpJJUjA6vhQ7pDxgrg+Bzy3cRDQ95sRjzsM1ANfRP7Rm893wq/wdGKwwFuZBpaEYIPt8FhUle4O1lxlhvDim5rLw1AWs1PfKbvOvHRlYjRlMSwiJfOR4KghnTgbW78mA9aFtLZEDgtj3OJkTTGfD//iwa7OJsQw3pZp7We0o5cDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QWWEtxcWaiTEyQcISb8Zls+qivK2VDs4vEC1WH6F4U=;
 b=n2iD4XyMnAg2y4/0QGOE5by8op5j1myTd5o8o9ijoznWBWY9ecmZvTtkz6hcDLdzhOaBgvHdnMygud8kc3rz6+58gK2kwUw35SQvmO752aNEM8bWNafVRZw9SToXK2vFgdi1h+NgkyzlaODIk4AEC3+q5t/2qDM5hGSXF7U7QfvEvuNSJNFVQJyicmo8uJWPE2Ydj5cGD7W581YDiT5IDCE+2Y2qAFHcp7gz2vrfX6mLChU/ArqrF82WrvFs9+wYSL1Jy/S7bnh+l5AnZT9atuSkpmbIuik/X6dnT4+O/nhmTCj5Ut1OM5QIOOMyWwb1mCvjrdEv9DqOHmvMs4jGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QWWEtxcWaiTEyQcISb8Zls+qivK2VDs4vEC1WH6F4U=;
 b=hrfHEep/f6/7rHhni1WZ+MGJuF/tV8y2f2cKOniYeji83E56SgyYaoHMMaX/U3HjWzy+8gJlPEC+BmrCeJuikhQKq6iR1aFEW/5jrq0YsQ72aQ3h8M6Cv5UR6WO9bNfhGYcM0UjoYrrgerugwKIVNKvUiWmlvVrvob21MhSDQhHtYbwCR0RDivxvy0OUonrxJ/R7WM3WpVT6Wrp8afn/pIh9NK0Wb7CBZ1ptZJP1k3pcV2caUxGaq6vdq1F6X2mR4AbfutokdH5fsfgW1ZV9hmlpT7+xK+QBReQqTySHYxbJ/Ak03UCuyhKCr4Jdr//ImQEVJYk2Cx2V/8MXf7V+YA==
Received: from CO2PR04CA0097.namprd04.prod.outlook.com (2603:10b6:104:6::23)
 by DM6PR12MB3226.namprd12.prod.outlook.com (2603:10b6:5:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 13:40:42 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::93) by CO2PR04CA0097.outlook.office365.com
 (2603:10b6:104:6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:39 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:39 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:36 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 6/7] nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work API
Date: Mon, 18 Oct 2021 16:40:19 +0300
Message-ID: <20211018134020.33838-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb057f9-e813-44a0-515b-08d9923cdfcd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3226:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32269700B299180AAAE2EDDBDEBC9@DM6PR12MB3226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XTO7ql+JnEXnMQ+VcH3/jy3YOXX8mfov2Kpaip6o0Ojjmf7apLq8J460ODTZkhStnyx+ow66iS+Mrsl5QZ/Dy85G8XsYjPm/TUwIM934jtxP++Z6YNTwtXErdTGxsF/OBi4zxz6GD3GusabzP205wY1jmpapJI8eXRtlhp98mTca9ye/7tcvNU2XEoJkpMyuH29Mftj1yHZM8vpde8+VeliCpNC6+o6RLKT6Zf5/OAoydCy9V/h+Cja5ghVvinP6FfVEpy+DZCScjgcRLqGrBHXa8Th0Shr3FS6Ow98gSyOIMoy/1QQWTxNH5XzQFgDMMLnDwQj6OYLR5JY319L8yuZOTu2DlbE9nDM7AdSelVUimnXJ7aGNJykpCD/RMBmBA66NYt8GXapJXWyugvwpEz0b56uX5w3LMpFc7EQKvSUhqLWz+Ly7oaG6RGCp0DCHHXhVgCEtj1pcIT6g7tQSM+9PlNa1cYF7ChKxCjlFXhUTHprQDCLJS6E0x74+0X6H3U40Yb1mLAR7OzqVjh43b2bnDggmcifY3EmeXpRN/QIUecEgF5tnwdcDrQqwoZKyqPs75aIesnv08dgmD14sBPvS8vlaA7trTvuXXofEif+Nxv2U1pRywEM4byyAGeANTvg3GOwjDSTq0jkJThEdXaZIZ5jxp69hfK81rSPTrErE3UHXYpoG0G86Wk8toSSf7BTNPMm50GUZDwjmVa6xg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(82310400003)(8676002)(47076005)(5660300002)(36756003)(36860700001)(7636003)(107886003)(426003)(2616005)(4326008)(54906003)(2906002)(356005)(86362001)(316002)(70586007)(70206006)(336012)(186003)(26005)(8936002)(508600001)(83380400001)(110136005)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:39.8914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb057f9-e813-44a0-515b-08d9923cdfcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3226
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064045_909848_3B681817 
X-CRM114-Status: GOOD (  13.96  )
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
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 24 ++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 26 ++++----------------------
 drivers/nvme/host/tcp.c     | 27 ++++-----------------------
 5 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 544195369c97..7f76b27ce1f2 100644
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
+	if (ctrl->ops->setup_ctrl(ctrl))
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
index 1573edf6e97f..9ae9594998c3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -497,6 +497,7 @@ struct nvme_ctrl_ops {
 	/* Fabrics only */
 	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl);
 	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl);
+	int (*setup_ctrl)(struct nvme_ctrl *ctrl);
 };
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f4e4ebf673d2..7fb2f434fe0d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1151,27 +1151,9 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
+static int _nvme_rdma_setup_ctrl(struct nvme_ctrl *ctrl)
 {
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
+	return nvme_rdma_setup_ctrl(to_rdma_ctrl(ctrl), false);
 }
 
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
@@ -2242,6 +2224,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address			= nvmf_get_address,
 	.teardown_ctrl_io_queues	= _nvme_rdma_teardown_io_queues,
 	.teardown_ctrl_admin_queue	= _nvme_rdma_teardown_admin_queue,
+	.setup_ctrl			= _nvme_rdma_setup_ctrl,
 };
 
 /*
@@ -2319,8 +2302,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_rdma_reconnect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 14bd16b8d99f..c0e5bb3949b3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2042,28 +2042,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
+static int _nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl)
 {
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
+	return nvme_tcp_setup_ctrl(ctrl, false);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2435,6 +2416,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_address			= nvmf_get_address,
 	.teardown_ctrl_io_queues	= _nvme_tcp_teardown_io_queues,
 	.teardown_ctrl_admin_queue	= _nvme_tcp_teardown_admin_queue,
+	.setup_ctrl			= _nvme_tcp_setup_ctrl,
 };
 
 static bool
@@ -2471,8 +2453,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_tcp_reconnect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work, nvmf_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.18.1


