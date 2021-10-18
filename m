Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EFC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7184261439
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7184261439
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8hrOaLFADNwaX0h3ShgrDBD09GYrrdICfX2WdseXQk=; b=wl/pozH2wcoTpd1OkNlJw7g5PQ
	UVUmwZvvoQtbeXKJOv+Z8Gz81joWPlE6PCm3vzf4z3cmIFbVeZbY2CmwetV/Lg5zQYp7K89RxubiH
	lzB1HbM16wJXmO264ihc3Skzv9HW3pQAePI61hhCCdgtcdGUQWAfQ1Tq+aS1FXQnPwus+MKX+YEG9
	Er87YUQmibVvFUujSM13VPFLqe1yWtCAhWQCTs4caoSP3nLkONi10Zy3eViX970TBHcrbGY4LNdIn
	3wfAXcKjFMqNWcKMpKOFaQoKKSNRPlX4pZp+e3b7ck/Ghn2aLmhFEGCrnmHv6aDXmkqkirJYHFieW
	EQXrmscw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcSu0-00FrXw-A6; Mon, 18 Oct 2021 13:42:08 +0000
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com
 ([40.107.243.77] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsd-00Fr1L-Ex
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkEQ3JNfKbtGDoTE1INMpDhNjJn8LwaFMLAIrIqs/WqfNug/8mAQCnX6t8pZGMSIvO6kdM5kDwVWLe2hgFvpFxgTRBr3hBP19SiIDRvgaR0x3KXWRcQdK5I85oHPQ23zLa/mwJi2LmJTUA8ZYII8HRRIB2MQour/ePj1LQLakHCDYiNCMOlR3Me9MOS5JWpejyornoGbjbX6dH/jHBD2yJHDLmjsR04U4UkJruw0byy6t6ueLrd3O6za0R4fRDvL+56Z6jQwLx9kHz7erfL4b+2tQTvglBt4kbnnXb7ay43EWc3VlKpocLdWhyTtXAcxpJuAVVo80kV4xWOB9sNbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8hrOaLFADNwaX0h3ShgrDBD09GYrrdICfX2WdseXQk=;
 b=dijaKHR00uFQulIx7KZH/krDakmI3NKZcdrzkHsJ1mdaWyxqALGaNgW91pBpfQTRw4PdQpJZt9d349yIbGPwuOCC/J2drJOs/hTFv8qcSVR8k33BRrDDAdMz3w7aDryrUBhLH/Nrofxsc79HI5Gae5Tsa1+gVhbV6/SqaU6jYJfIoXC8/Tw9xNDpHl3LNhFBQSYNJm/nsTv0qCXMM+dr47vR6FEagZlgw8MXfAhYX9IFLbVYfC5LFCsJq1Neb3iYADMUbvVMGvJ7ASr/b7qdwyDw4Tg59+ui2kXwPINvglakHuE3ELLmAA8WvFHWbVcblGMR4fQe5Yw8uW3mybpAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8hrOaLFADNwaX0h3ShgrDBD09GYrrdICfX2WdseXQk=;
 b=NPtN8eWKnH6OAj2jIlRpLDGqjTeTPuPpdNkmsJwAtfGd5WelW7XO9Fifw2nLgLIpPnqOyq8i9Et1Sjqcph1NTTJUK9i8RSM+emAtIIOH6Q7HSbWULq2xJmN1DFMiDvY+73si4BF13E0axu5Tv73QHQtFJwOEPpLNWXyYFnFTWe/gUBlZXU68sMcu1/D/1x81uiHktJDJvFjIko6TKVfTeRt75dZyuqGNjQ+I/Jc3xAm1liWfzerhlKwJLT6MKwEcMVVMEnUSFqL5YEKXeosttIKuFr+feEnw4zto5huupgfJW3TI0EI21nyJzkiFkamLQp7i51bhGknSib48CJCD6A==
Received: from CO2PR04CA0100.namprd04.prod.outlook.com (2603:10b6:104:6::26)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 13:40:38 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::56) by CO2PR04CA0100.outlook.office365.com
 (2603:10b6:104:6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:38 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:36 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:34 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 5/7] nvme/nvme-fabrics: introduce nvmf_error_recovery_work API
Date: Mon, 18 Oct 2021 16:40:18 +0300
Message-ID: <20211018134020.33838-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3910c8ea-fa34-45f7-ad24-08d9923cded3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1371F58B458C8179467C1842DEBC9@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrsQb9DOEihmksoJzwDQw9zWo9p5hMUNe2jLly7rDFfXPTUvs2dQYPZ+d1TuNOFsxgFzg7WBqRbfiX7ywilY4um/c8xzsDYIUEAnYaybxEGL12+i5T225/WJOZVxL7lmzlkFBfcC7B0ZQjGtYSvGHuRPHYmfXK4H2u9k9EFM3LfFAGYYNOlsdEPjpI7evGCBDPW3Yjd9TZoOZXA72DXgOIXZN6vZBZh18DUJWckQPXXpNXP+riC/6tc5ppdPi6+NBsHbV7L54OKVJx4zEv7LLyWftSUVYljvHAWFh9tiAOX1pa8WDlYRiOvMKQ+XtCt2khzadwFjAL3xrFUXbTIo7QF6wMzQTwuCrbAFP5BhImjhBF1qpMX1n/6isZwOwCxdg12qOIEeL049IWsaE+NRzVmrw2p5+tOELE5lDIl9gPZsFDp+eDcwAQ/3J/QbZczJM68UPxlNhwFq/leFab09oBVjdWtqY800qd454jjvkY10l9c046BY0wSmX4OvfaWR7+DkEi8AoX7PaZ2xDAlx6wBCZFCpVl+Sfrrp1jdEk6sRnF2xrCK2/l+NLNhRTA29KxHC8UOYHQsnh7Lf1ecatLISbj0FP11DviKTC690az6OHPuBsE6tXz9toRz1JGb/o87/CVal19mRTCT07FvGhCdEJB8cqNgNNBmdUG25wrA5RPpp4rzIHIjXdCUKvOdUboe1SugdSFA7lY9vCQzLdQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(4326008)(7636003)(26005)(86362001)(186003)(508600001)(47076005)(82310400003)(8676002)(356005)(107886003)(70586007)(36906005)(70206006)(426003)(110136005)(54906003)(36756003)(336012)(2906002)(83380400001)(6666004)(316002)(36860700001)(1076003)(2616005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:38.2573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3910c8ea-fa34-45f7-ad24-08d9923cded3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064043_546262_3FEBC3B1 
X-CRM114-Status: GOOD (  14.68  )
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
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 23 +++++++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/nvme.h    |  4 +++
 drivers/nvme/host/rdma.c    | 56 ++++++++++++++++---------------------
 drivers/nvme/host/tcp.c     | 56 +++++++++++++++----------------------
 5 files changed, 75 insertions(+), 65 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2edd086fa922..544195369c97 100644
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
+	ctrl->ops->teardown_ctrl_io_queues(ctrl);
+	/* unquiesce to fail fast pending requests */
+	nvme_start_queues(ctrl);
+	ctrl->ops->teardown_ctrl_admin_queue(ctrl);
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
index f9e1ce93d61d..1573edf6e97f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,10 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+
+	/* Fabrics only */
+	void (*teardown_ctrl_io_queues)(struct nvme_ctrl *ctrl);
+	void (*teardown_ctrl_admin_queue)(struct nvme_ctrl *ctrl);
 };
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1c57e371af61..f4e4ebf673d2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1031,6 +1031,11 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
 }
 
+static void _nvme_rdma_teardown_admin_queue(struct nvme_ctrl *ctrl)
+{
+	nvme_rdma_teardown_admin_queue(to_rdma_ctrl(ctrl), false);
+}
+
 static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
@@ -1046,6 +1051,11 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	}
 }
 
+static void _nvme_rdma_teardown_io_queues(struct nvme_ctrl *ctrl)
+{
+	nvme_rdma_teardown_io_queues(to_rdma_ctrl(ctrl), false);
+}
+
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -1164,27 +1174,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
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
@@ -2240,16 +2229,19 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
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
+	.teardown_ctrl_io_queues	= _nvme_rdma_teardown_io_queues,
+	.teardown_ctrl_admin_queue	= _nvme_rdma_teardown_admin_queue,
 };
 
 /*
@@ -2329,7 +2321,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fe1f2fec457b..14bd16b8d99f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1944,6 +1944,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
 
+static void _nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
+{
+	nvme_tcp_teardown_admin_queue(ctrl, false);
+}
+
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
@@ -1960,6 +1965,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
+static void _nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+{
+	nvme_tcp_teardown_io_queues(ctrl, false);
+}
+
 static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 {
 	struct nvmf_ctrl_options *opts = ctrl->opts;
@@ -2056,28 +2066,6 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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
@@ -2435,16 +2423,18 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
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
+	.teardown_ctrl_io_queues	= _nvme_tcp_teardown_io_queues,
+	.teardown_ctrl_admin_queue	= _nvme_tcp_teardown_admin_queue,
 };
 
 static bool
@@ -2483,7 +2473,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.18.1


