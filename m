Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B0BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:41:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060EE61391
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 13:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 060EE61391
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1EcYQVoHkf+EU8hcdK2sW2gbdZ1e9nQue24gPiG1ifk=; b=IGCsTN8uLSNBkDxhkaalyq/b6j
	rDUgCv1tdYmOQidb7giqt6gDordmsnm5HNwX5SXF8T8taLf2nJn42wBeadFSKiKgqnECUEVtR6FyN
	EU91q76l1cZsD9TikFLIe4P4oLXT+Hs1LBHPBG0ZpH2pPEzp7JV0FPJe8+TpvdFzjv6gWYZexYGqo
	s3/7SDXiYdoB1wV6hWjS751dFHmMJPE//9bs7y4vaxky/jRLTOAMvZT39/70phTUyXElgnCl4c8c3
	gQzjK77YwCvTf6RdiyRzFWQhxw7blKxkt3JmxuZ6A9K65RfOBm4MBdWGHEIvzytt7EhBh5zztYfyn
	ri2qrhMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcStA-00FrG8-N7; Mon, 18 Oct 2021 13:41:16 +0000
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com
 ([40.107.223.55] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcSsZ-00Fr1A-Os
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 13:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm55sk1ohBstF0rrXwwbSWxgG1agzCHGJB/XSVDALWIZij+iir2v+VYCLdHXhvN3okS7lJC+XUGUh+CIffLQ9tJkSy7cxJ8claHDswczgC40VcdZBPuSAmfwowkSySmIV5Y/95skdq0U6MglHfrUD/xv9ssbLEOXQA5kwgbzTrLw2xwE5MamXly3I59L0Jf/0DZ0a2RmS/I/eqQ11FoFLx0tVIcTOchONaHyzonVOYMGBN51BhszdGM27UK6q8j1ydWxDyinvg4ZdKojslue023I3Uh/68flWoM6U7f4GuXB5ioRuqOyStB4nDk7iPPz4B7ErXnsMZ8t0ZO7/ROU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EcYQVoHkf+EU8hcdK2sW2gbdZ1e9nQue24gPiG1ifk=;
 b=dsLIGQmAcWpj7fxA2Ux3jvDexoBE521/w922sKtC5/lvsoi74RPJn3akOGac9ZmLwJBQiEuuUzIkwTxJslHl2vmHDBaNfTm7iiN/WThXrwV/mCQ50GxwTL3O5oy1mr4gLDzq55xzptM8lWZqO/Ms7ojD1M8rtejEsRmBUqFCjP0fNoE0kxncAG9dF2OuqJb6NTSZJw8+fstzq3xq4VSzyTMJdRLDkDRLvFG1olGD0/2lnSClLjXQfIRRUz03ijs6YpA4vLl6TCzb0koZ+S0HSNLM96Ct69s377khwHuBmVKNx+2fmle42pFEAbLi1hJG9edhe7/ibNhN4zN0rk1jpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EcYQVoHkf+EU8hcdK2sW2gbdZ1e9nQue24gPiG1ifk=;
 b=NiGBs30UqdaZVKtsSbY2wOuW6EPOfUbJEdScaWpJ3oISWLyn+OGmKqT5eQ//0ixsG0rYmuifucegpBsvWdhmq5upaUn/GByBPokL6rBOKMnJRaWQwgQkEVCIXatK05VUZbZMLA7tVEIPdTwvaDgfVuVTtWt8KJdpLjCX+I3U+aH5X9+ZZZJ8QAJlafHfhQvJppmVEgsgIouCSovidoXQsgZeTkhdQLgtcFEj1oDH/TTS8LsV4GftL/55QRMJ51cZJHMsayvS0wpryGQOtwE0hfOcICEopIQYe97/U/g/5YEZlIcTXH5DyRGldH8u7cUKH3TYVlPpKcVxVNTuzmSYSw==
Received: from MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17) by
 MN2PR12MB3167.namprd12.prod.outlook.com (2603:10b6:208:a9::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Mon, 18 Oct 2021 13:40:32 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::b) by MWHPR10CA0007.outlook.office365.com
 (2603:10b6:301::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 13:40:32 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 13:40:31 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 13:40:29 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/7] nvme: add err_work attribute to nvme ctrl
Date: Mon, 18 Oct 2021 16:40:16 +0300
Message-ID: <20211018134020.33838-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211018134020.33838-1-mgurtovoy@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf177ef-9eee-484e-5952-08d9923cdb26
X-MS-TrafficTypeDiagnostic: MN2PR12MB3167:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3167809874832C6A140BEC15DEBC9@MN2PR12MB3167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz8Vpz9+hgKX+wjfp+oifbrQRcurtQF7PRHO/r/L+MiV/OXbT2FOHVyPp0pr/LLh6QEV4AUwtzhsRwFIGUTusmffbZ98gPAIL7mrMDXtX6hS89FV94QTEEsGQEnCrkLObyJGq+BerWjthpp+vZomF3jvg8fASIDV8lrGQh6cvelDOjrpT6Pd7lhk9aiuaMo+2DYJRIZkzmtAq9os0rzp9DuGLYM25MTACkluyRqlyPow86VwnsvM4JAmyR3kDWeP5YUF7woHhEj1jWpDMQhWhJ7sP7UjdteJvNBWhW0hZQ06Jo31lsCLYWsbE73zOvbmS72hTNfSEUsrlXp10Q7m3ox/mX450p+ESN9mySrZLKlA1qTyeT1eVLw4lC8Pw9KApHehZ17a9SHpSq2CK5CmvvoVxeqrh89Tsq0SQhYWwWUBYDcimjXOQqEj4MHyGaOXDGRPUX+JFRqL17g2MWLA0OJV+EONzPI99ITcTkh2fb7mWQ67AU3rM9ye+t1buDknJRosYEfrYcx8OVQfQmAnCijz3Jm2FlfBjEpWlRmklyD5lttNFuSCGtYd8PXFwTsU/8rI8bdSu6kAC/b4l/i6B3iYhZizhnvdSXCYfzl4NAdKNC+1cQKF5fWjBP8XKCRUuei0YvaJ2bphEM6h/E9VJYD56MSvTDnBCGz8Rx0JYwGB4OhdQqAzYpvZlvtmNEZJmIL+ZXXYtxcHgBoteyVhdA==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(2906002)(2616005)(508600001)(336012)(426003)(356005)(107886003)(36756003)(36906005)(70206006)(5660300002)(70586007)(316002)(8676002)(8936002)(186003)(6666004)(54906003)(110136005)(36860700001)(4326008)(83380400001)(47076005)(26005)(1076003)(7636003)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:40:32.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf177ef-9eee-484e-5952-08d9923cdb26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3167
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_064039_852775_F6A8FEF5 
X-CRM114-Status: GOOD (  12.50  )
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


