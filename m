Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:39:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8548D61260
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8548D61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7yRPYEbeOYUXqNwzavGIimoHEMh3os/vUh8BYo7R2WU=; b=us9FXbPvZmuLF3ikLpgjSaKJdX
	O8sejFJ4HkjEoYLNO5zF29gMM3s4Blf45lxgog3pJ2IdyRRaDsxr4Sk5KRDFOVT0qr0+YrehTNZSA
	0AZnDlHeqr3iwUNrofP4bLafPX8tBs1HYyqXYFHjbbgoViZ6I+/79nI+hOWRbBGmDi2B9UERUcrTT
	rDhc9zXDnJuv2XBIpF9D39HPcL0aYuXRsZbZxFXLM6gaX/kkmUXOL3iY06ShnJOfQwH589OkA51kX
	8zTb8Iwd0DPpn34OyXLgLKbuWnkHjdgag5r8NOsOapNO+dr2hIe0YDxKmrsJ1RS+OeyFQfHZ2OjDq
	rXuZTsbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md90V-0049Sz-HM; Wed, 20 Oct 2021 10:39:39 +0000
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com
 ([40.107.92.82] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md8zw-0049LX-HW
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQkREnge4HeYWmJysFQKlHuyRVDYuPRo8Xc61JByeb9YgYQ95DD4uVALAje6hiS2++A3085FtN5JWyGD+L6OVBmTNi1RyVcdhmpua2oGC8s0Od3vpIU3eyUTLoMAe2kvO2IdPcXU8AmELrhf4/JkE/d5bCjrTPve7PAYKVskNCFzuEGRMPQBfOmXhl+H2GrkM+bltx5BGxQbCvT8Oew+YYyD7APxTxpqiqu5BkMkcGqjJrX8W7RRJsVZFWUdB3YesMYgaiPppT3RZCeoPIkey0kmv0MeSj5cQHroMWv/LrLF0VAeRufZjHNzFpDRsEuDMSaP94dJlrI/DDEmQODB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yRPYEbeOYUXqNwzavGIimoHEMh3os/vUh8BYo7R2WU=;
 b=Pvpuymr+jw65jWu9m1s1PKqN2f/VsZK18N5MWmlfYWrS1ydau3ynFmwjBYbBbpxCu4JIen5vjuXahEYs54Kg5tDDc06ubBYkFaxMKvO8Kc14IRFXPpmd0l31fwxBGUnPJrgVfstvfXxCCaryooXn/Qn6izQ6aH5f0Nny7Zco3u0ch7bJRG3djwtIX9tsyopVd6NSyscI/9Ggz3AgpjT4Bl61rjxhHWClFYKocIq2JFGuf1Q+6i3EYocuRA5I/IvCHyA+I5KWqgXWIwJnnJkxZG2o19HDZL9N4Im77skcs+p0fWmV2tGSKJlFtVsIH1oargwXzIpsILhBRYf05p9gcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yRPYEbeOYUXqNwzavGIimoHEMh3os/vUh8BYo7R2WU=;
 b=Wnvw+kIncsLejeZoC4oNgXpH2bAh0eHwFEBsjhGuA1l9hVaXIV31/JjtpCRmhEW28Qt9mxFt18CcDH7rnn/31LhabdpGhXSytOGCbjvt3R/Ufqwz2GQv1FDrB7cMYkgBsjndYAYX5nvY0ZJyumm+pM1yGayTk9r9bEHi5uBFZKnGQd9ZSsYCOAJENJrdszt/NL4fh15TorKVFBlAHhGXD6/oqNnKfm7dTJg/I/GMOXrrr4yyJjMA3LR4RnV4kwHVcpwg/63w8hWPH1Zqf+eFI/gZ7eiWRnm+tCCHN7Fx1Pd8uOpdiKKVlt2LuEewaibOxN2t8QD61bTK0+KNSPEvRQ==
Received: from DM5PR19CA0032.namprd19.prod.outlook.com (2603:10b6:3:9a::18) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Wed, 20 Oct 2021 10:38:58 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::7b) by DM5PR19CA0032.outlook.office365.com
 (2603:10b6:3:9a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:38:57 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 03:38:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:38:55 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:38:53 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 03/10] nvme: add err_work attribute to nvme ctrl
Date: Wed, 20 Oct 2021 13:38:37 +0300
Message-ID: <20211020103844.7533-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e900ff09-5e1e-45e8-732c-08d993b5d23e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687201CC20FF3B5EDF51DE2DEBE9@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zO+ETLHD/I+N+p7wy1FiUgmWCukCwW74EUKp/SfaerEUCfa9nmMm5aXI59CI7llKFjnvLGS5OpLGtBNitUcbU2KarBonjFxZH+0ji1/BhPc1bq8nD7EJu3F+HZoG19XJ/DvQK16ulIjPvz0yHQ9dw73VBo0tGYDtKaSmBcC1M8JPg0xAdPdsISMsWYa2pVlsc9G82Feot1LWcShsqoYfxabsq5bo2/4PVyuKzBxUonakCII15BtEOzmJja891oupzyqrE7APHvC9uyb1fPGK6BCtNEb2CepD4id7nj/hx85e4YkPEs9sK785Ss5/aMPNuAlwW7z/NVXdBsDZJliZdKMs/a13PpKjcvOaJT5RNmtbpDK/eKKKLViKND6HrOkH0BRnEPjk0NfYDbBmWpPGJTvCVYNboiSJ+ru80MFvKSS2/yHqd/dF/zKGeA/NDSPXb+OuUOLGfTh6aj2CqhzCwuQNwuELW5+XekT9uAdRyoCJRbLxANWq9AOptW9bxuszMBCFVWAvgDFIxiFwo4mFLaNn55bjhDswehLibHy1n082+t59xoplRfyidk6wU6aVkmBQUeWMX9tYRiKNF04SvNdoWyfslT5WcYZXjxGp8mcyoIc7TKNpsZBezlD92z08oIjGwQ06Q3W0y/wOB5pmXnSsicC3wPNxMi8Y4whFjTsuR+AshTmWR1QePlnuPPC2tJSUM6FZPjMEdbs/IHi56g==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(107886003)(83380400001)(47076005)(36860700001)(426003)(82310400003)(36756003)(2616005)(508600001)(5660300002)(4326008)(110136005)(8936002)(70206006)(186003)(2906002)(336012)(1076003)(356005)(54906003)(26005)(86362001)(316002)(8676002)(7636003)(6666004)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:38:57.0100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e900ff09-5e1e-45e8-732c-08d993b5d23e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033904_617674_CD52B659 
X-CRM114-Status: GOOD (  13.54  )
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

This structure is duplicated for RDMA/TCP fabric controllers. Move it to
common code.

FC controllers might use this attribute in the future instead of a local
ioerr_work attribute.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  9 ++++-----
 drivers/nvme/host/tcp.c  | 12 +++++-------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 81ca5dd9b7f9..f9e1ce93d61d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -344,6 +344,7 @@ struct nvme_ctrl {
 #define NVME_CTRL_FAILFAST_EXPIRED	0
 	struct nvmf_ctrl_options *opts;
 	struct delayed_work connect_work;
+	struct work_struct err_work;
 
 	struct page *discard_page;
 	unsigned long discard_page_busy;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f31a56d8fd73..da7f61a5fac4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,7 +106,6 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
@@ -1168,7 +1167,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
-			struct nvme_rdma_ctrl, err_work);
+			struct nvme_rdma_ctrl, ctrl.err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1192,7 +1191,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
+	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
 }
 
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
@@ -2208,7 +2207,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&ctrl->err_work);
+	cancel_work_sync(&ctrl->ctrl.err_work);
 	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
 
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
@@ -2339,7 +2338,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 530ff76d4ac9..07a9cc4f2274 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -126,7 +126,6 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
-	struct work_struct	err_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
 };
@@ -486,7 +485,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 		return;
 
 	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
@@ -2068,9 +2067,8 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
-				struct nvme_tcp_ctrl, err_work);
-	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, err_work);
 
 	nvme_stop_keep_alive(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl, false);
@@ -2091,7 +2089,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
+	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
@@ -2494,7 +2492,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.18.1


