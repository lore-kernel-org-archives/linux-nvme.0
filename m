Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B56DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:40:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B352F6128B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B352F6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tCgQi3wn1nT+kAA4iEKBBihxBNiLVTNMLur6T4dT+hs=; b=eFz5Fht+VgElh4vngEE7t6JOFU
	OE5wmc7WiNbMapX+0VhGrWCP0CO+HXOZkdRr1qarlweMKHygZ+r5KsniQsBh2besBzO5x5MnA9Lb9
	PWkgZNlEAkST/cppJYoyOsKYpCujmKj1keb7ObGvtEHfwRj/4CiTMIpR5zpAH/RhvQRFgprBnBoIz
	aPqgzKpzWwLli7h+D01p1Fz406rQS59YnXrR2L6w4pB0VI3NSkBAVrZq0zIWqnlYSgtYV3vFrXRlI
	x3LX/KpMjAeA5n6IjGeyFEMtglGBGqvNCDo8Quz3Tzn+eeU0meqDHSy0IvVsO5jLMoc3t9NyR+Yl7
	LgUHJnwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md90n-0049XI-6H; Wed, 20 Oct 2021 10:39:57 +0000
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com
 ([40.107.243.48] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8zz-0049Ly-J6
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjFxyDSE08wenQyGjXDLLRUVWR3KV8/Eqv+8mtXW97sypNEQSg7Bk/nNvpMJohtliBjAKZFMGWBoiItFN/jiE3ACqJFZpr9NfkUrBDejaQtivkajgQT1pL7LHSzCQzLT0EmQimUd3rTU/LZrBYShXkmWURLzFdyQA0q6JkDZW/t7pxoKoZoA11HFgvlNh96MbaCICQIM693R24FNdOCb5eIkW84BMRzyrFB9iv7o1qmSMajO3vp0V2FXyCasoHyOASa5Wd1GO5y6vlD45TTYkLKwMD2W1vL3ZrmDnOMpbdEc1DT4Td8zon5EtAoCo0QqrlqMx0PuCzyPawzE9o4DjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCgQi3wn1nT+kAA4iEKBBihxBNiLVTNMLur6T4dT+hs=;
 b=aj5AJubEWjLj/s6hZQo0x+oGpD3Y1WIHfLi1XWnuabbkIMn1M1IFu5lMoB00QhxujUO9rMMfwrHx/uYXDbvBpvrq5GteRf+EdNXOxHOOzaoXvTs4WZ79QcF9T3KRS+hpnkR0JvmUF7QpPg1nyukRJolr8RPst/L0GwA+5/IUQb1r1CsPQhlmft9/lcl/uznJvOx2xR0xYhcrqQo0Vvi8SaOn63X2mWn4lsD7+nl+ZIGfLvCLfMwv2pmpdjxrzR3cIZGqYOZ/r+WUvYD6DHEP9/yc5/5iwmXkuWHfuUMPFSs2wdfRCbGVNC/WLM113Lczsa6iKxq86fieRWclZM5uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCgQi3wn1nT+kAA4iEKBBihxBNiLVTNMLur6T4dT+hs=;
 b=B786+9Hn0kzpbMuL/QTUbX7M+imiljfMz0hgazYWLN7iZf68z1ZYL9GPymVEe3uKsyqT2LGmfwPwPyARCJwGiN/a8zNO8nHDjCvyiwWxU5f9Tqa2x4MxoAEXeczentK7HRhippScguhIUDxqlH9UN2a6BojwCGr/qmuHWMAFZR5uTjyA2cdMFfFkMKvomq957NRwDjUutJetGfWHkc2Fagtfpb/+ULg7RXDw6S8IxFlhE3rpCy2NhBavZSYdA5CsiHXeZ8XlUHsWghZS0CjmTPoPiNrAGkTugvno9vyRGHeQg6CSgALwHORb1syEl+3jzBKxxOOl1c9YJol0otfm6w==
Received: from DM3PR08CA0021.namprd08.prod.outlook.com (2603:10b6:0:52::31) by
 BYAPR12MB3061.namprd12.prod.outlook.com (2603:10b6:a03:a8::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Wed, 20 Oct 2021 10:38:59 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::d0) by DM3PR08CA0021.outlook.office365.com
 (2603:10b6:0:52::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:38:59 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:38:58 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:56 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 04/10] nvme-fabrics: introduce nvmf_error_recovery API
Date: Wed, 20 Oct 2021 13:38:38 +0300
Message-ID: <20211020103844.7533-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd852990-b639-4dda-64ec-08d993b5d37a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3061:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30611BF69A572B63476A580FDEBE9@BYAPR12MB3061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4OOq4IO8l3wIYoH1f9C7kg027/EYX/t2jbJhaw8aDZgVIE28K7mw20y3vgvV5WR14CajmB3/3axJb2cS4NBaOPXqqnha+50Obcf6/dUNBYM1RC6jAE2HbqCUpDk6eSok1ubHRQ88f4jiKOSZC1icU8D5DbtMf2rSsusLOub1XGApScg5KN0cMIjW/nPB9ycGSPvYKbDnwIuyEzHFyVwap7SiqVuLedFdmpRCMuaAgsvGVoCSz4orTMWeeQO2DDku8orNvpEsZLa4CQJ6FdmLnh17KP4OUNbud/V2GjtqCNEV9f/ssn8X9xomtengmWsO241VGEOgrQNrfZrF3qyAEHHLMdLXD+f204Vr/bbwpMxXlzdrPw/JoBvMCZ/GHrKBq0EJKva+kaW/PzMDYmSeXBzzQK5EoWiFFO4TAETDZDVkmMug+bRKDNiqykL5sp8XGn7X/GilOLJYBpLQxMNFZ+X35qReATlXDGQwkG9yrfl7L2L8gtPpS2NIwgwMSOos+E9XXvW3kc3lq+QHAzIjPCbu5UdyCSi/iXtFlpN5H0hyB8cZYPYnsucNnBIY/SD9vqz9wxyqL6DzNWMM4tGT8irX5ptd/h3nzg4Wc3W/9rrZXqW5G5KYa6OFQ3EvjKbBLvDGKw7134E+ZV/K5/Ln+aChOfrhGV5ewVtmsAn0r1XP7sUpTtMiLxyNVNYzPnQDJ3bW9ijq8NhvGZWwsGVqA==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(83380400001)(110136005)(54906003)(5660300002)(47076005)(36860700001)(4326008)(2906002)(86362001)(36906005)(356005)(316002)(7636003)(26005)(1076003)(8676002)(36756003)(508600001)(186003)(107886003)(336012)(426003)(70586007)(70206006)(2616005)(6666004)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:38:59.0866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd852990-b639-4dda-64ec-08d993b5d37a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033907_661350_04D6DD7F 
X-CRM114-Status: GOOD (  13.40  )
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

Error recovery mechanism is duplicated in RDMA and TCP transports. Move
this logic to common code.

Also update the RDMA/TCP transport drivers to use this API and remove
the duplicated code.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 10 ++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/rdma.c    | 25 ++++++++-----------------
 drivers/nvme/host/tcp.c     | 19 +++++--------------
 4 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4a1ef67c6fb3..2edd086fa922 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -493,6 +493,16 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
 
+void nvmf_error_recovery(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		return;
+
+	dev_warn(ctrl->device, "starting error recovery\n");
+	queue_work(nvme_reset_wq, &ctrl->err_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery);
+
 /**
  * nvmf_register_transport() - NVMe Fabrics Library registration function.
  * @ops:	Transport ops instance to be registered to the
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index de213ab26977..3d8ec7133fc8 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -189,6 +189,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
+void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da7f61a5fac4..1c57e371af61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1185,15 +1185,6 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvmf_reconnect_or_remove(&ctrl->ctrl);
 }
 
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return;
-
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
-}
-
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 {
 	struct request *rq = blk_mq_rq_from_pdu(req);
@@ -1215,7 +1206,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1715,7 +1706,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad command_id %#x on QP %#x\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -1729,7 +1720,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			dev_err(queue->ctrl->ctrl.device,
 				"Bogus remote invalidation for rkey %#x\n",
 				req->mr ? req->mr->rkey : 0);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 	} else if (req->mr) {
 		int ret;
@@ -1739,7 +1730,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			dev_err(queue->ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, ret);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 		/* the local invalidation completion will end the request */
 		return;
@@ -1766,7 +1757,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(wc->byte_len < len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected nvme completion length(%d)\n", wc->byte_len);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return;
 	}
 
@@ -1936,7 +1927,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"disconnect received - connection closed\n");
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/* device removal is handled via the ib_client API */
@@ -1944,7 +1935,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	}
 
@@ -2000,7 +1991,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 07a9cc4f2274..fe1f2fec457b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -479,15 +479,6 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->ddgst_remaining = 0;
 }
 
-static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
-		return;
-
-	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
-}
-
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -499,7 +490,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad cqe.command_id %#x on queue %d\n",
 			cqe->command_id, nvme_tcp_queue_id(queue));
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return -EINVAL;
 	}
 
@@ -541,7 +532,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x SUCCESS set but not last PDU\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return -EPROTO;
 	}
 
@@ -850,7 +841,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			dev_err(queue->ctrl->ctrl.device,
 				"receive failed:  %d\n", result);
 			queue->rd_enabled = false;
-			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 			return result;
 		}
 	}
@@ -898,7 +889,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 	case TCP_LAST_ACK:
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	default:
 		dev_info(queue->ctrl->ctrl.device,
@@ -2252,7 +2243,7 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_tcp_error_recovery(ctrl);
+	nvmf_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
-- 
2.18.1


