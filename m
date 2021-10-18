Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA621C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:41:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A276261504
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A276261504
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIzzxWdRGp1BYz+khsdov07pWd4Dv0YpSXKvoLcJ6N4=; b=3Q5wK2EU+Vez9O1zSZGI4n8Ipu
	S9B/OLaLWyu3Eu74n2KZIieaDVhOmoBNGbn287ExOyesIDds+xvcy6x1LjKBoQieXHYnnnZDBNJsG
	mGVV6wHaOvMO4sLsXWtoN2LvHrI9HW/OZ7S7dsHaByOkC41JXSwGuByLE4HWOQa2VjPxapsEKTgOW
	c1vZ7mCwKx7epW/mwC9LUjQUrQimsT1IJ9rTwIwVuIe1LarOGhsIMVjYgFiYIlSp/QR6q0HHyVVrv
	EO88pN6W+t68yrA7CrUMTRJJn+Pb0nUEtnzpCzqE5zYP4DZdCmGBF+9CidNK2Eu+3rnPhwLNiFe0i
	cvT+ZvZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcStX-00FrNf-QE; Mon, 18 Oct 2021 13:41:39 +0000
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com
 ([40.107.243.77] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsZ-00Fr1L-Uh
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHtaPt6fniwhdMBUxsqfqgk2eitbPtLoZ6DuDZyiW5QLY2QPub6HhkMnxMJc3pkQQdWJOhoLAQnRA+yUlnim81w5l2fImn0PQ387HrIQYNna4IF2IojNH4KolJonOY2BgERA8oZmn3FuWyxs88m6riVNf2yAiEK+JOdveBvbQwdkZn7ecS6zJUCYet46mcDDLR4L8WWisbQjlbtRxLyD5OUWtE+ADV0IAWApJy3e6eJBlU+smTs8Ya4xPPHx0QrI5SruLBoIvCgxcit3EfyktOn8QbghyO+qXq5hkZSKXvuKahHLUBfNzLtpYBxvmOn+MKLvZLbmbdFGBruFgRiUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIzzxWdRGp1BYz+khsdov07pWd4Dv0YpSXKvoLcJ6N4=;
 b=hd/GAKzvPfGnoZuKsS2PRVWJSTM6oQuTY+siBwiwKJ3dD4hLDzwBHwUSTxfaLfiRfzI5ksO0vYtEbKYaUpq6fdIBh1Ky1lGObvI/Y0X4LXo9sk/jgsZLcYAmRxlhCwBKuDfALHBXN7LLq9VdDvSijtflPRPVftatNxKyUGHIpBfv0GHeGFYbP/6NPt/hYyBwp6nniMqvhUo0IbfQqD6/Vsc2qiuswGcIistg1Elv7OaVY2Zj3VuPOMwqEcDzUxYPBE6jqtWL6OsQXJoc5Xg8CypPUhPjaCKfm4lOfoe8iFDGxlGPKr/32kz8O1HCSRFOsSqwmgzjNrZ+EaxQksvSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIzzxWdRGp1BYz+khsdov07pWd4Dv0YpSXKvoLcJ6N4=;
 b=ULLFdaavumxSGCTjuskmuUlqj9QT8YtkB2ZPrYx5NiqCprmBoG1IllrTFGrcUAm2ek/Sq2sV1UQ/B0ttmPAF7Rkphp/MSDsgKhA6u/NqpnuzWhD4pV5KWg4LD6ehdZw6NLnlmjQ07TYJ6TkkbZe1dJHeJdEqSbbQI2o7HHoLpBsb07v5rGa/r5DQ0hsZLo0U9ggjTjfDLn0WdW2Q+YNyl775klrTHybWMfCOavbwyqKFE0B7RG5uqwEBetEAN81p42peMwm4oM1ARJUwMWdQM7kAyDA5+MuxIls8W3l2qzs9Vjz4YQdrLBJTANULkZ6oW0LGLoeTDnzFeGEK8jU8ZA==
Received: from CO2PR04CA0100.namprd04.prod.outlook.com (2603:10b6:104:6::26)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 13:40:37 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::f9) by CO2PR04CA0100.outlook.office365.com
 (2603:10b6:104:6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:36 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:34 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:31 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 4/7] nvme-fabrics: introduce nvmf_error_recovery API
Date: Mon, 18 Oct 2021 16:40:17 +0300
Message-ID: <20211018134020.33838-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd8d93dd-447a-4427-aff1-08d9923cddf8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1371B750FBDEFDAF3854F5CADEBC9@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocAaT/IxHGt9GzeYpWqfE3Cp3+DgTNC4lQijD4mAVyc/6ixudwmnuJ7r4lMTpq027Go1BIcN+J8o/RMQ/V0YdRjm9ojofSla6EhCuxVtIpdnfuxfThNa7I1r/wVZ1BnICtta8YOOLXzhG1SPWeQkPm7uc6GUenwcgvC9bFf25uDuVvev7+87cPF40UvCJZsQ2tuaQ2Xl3LTk0Yh7YTJa9i+XOMxh4XcwoGmGScHaQmwJijIRBgqtQbBgQ8pOFaGb9zYUvdNphtF7W+yGgq7d1SxKAOBSFYZtR8xDBqMi123vAcHn/9S4ozTnyK/86BItudPz+7QwrDSP1Cdht7Qb+gSXWiyKFUz7fb45WN5ULL6VrzR5uLzbWuoGftxrxDbSuM99FX7x1PZt8zPGUPZ/7ii0lcsh1lRzJ22+WK8nBgDvnyhPuNNfnoQf87p5VQSFYOARpk3mcbChJwAqeNLl6l5abrrtQWDz82HSBavkshJumUsWHnThtYsEL94eRmlrI5DyklWG6A8vqrbVKdcmLHjDZZ8TiVx96ZekeiK2ZB0Qn3KMCaN8wYyNCyH3W4bpsLaFrEh4H+OIVv9gn5k58gN8utgyUx8yfSaiXrotR/0uJ+el+0LrhygHY9Pg68pKzW6989/VnxxppsG18bx9JdVM3hbDEiysyd3B7siJuIDK/roQdnimNLMBRfUWERzv6hZVBb8RpXphIr/1b8HRGQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(4326008)(7636003)(26005)(86362001)(186003)(508600001)(47076005)(82310400003)(8676002)(356005)(107886003)(70586007)(36906005)(70206006)(426003)(110136005)(54906003)(36756003)(336012)(2906002)(83380400001)(6666004)(316002)(36860700001)(1076003)(2616005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:36.8202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8d93dd-447a-4427-aff1-08d9923cddf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064040_066901_A7D1B0DE 
X-CRM114-Status: GOOD (  12.77  )
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


