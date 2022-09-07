Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F2AC38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=copC5HG4Ch0HIA8UVLVLZEdftzJdxrw2gJhHLyDIszw=; b=MpsSZSidXgTp9ONqulH29m+7Zc
	yiVs9LPh2TJq+ec80w+uNBeJ8CC6xKrj2Xva7N1/WdC44aW+2OVx13DyfvJCIWMChJAa7GaPwmGJt
	ngseDQp6QZJvjwOhd8sRjNvGcCM5mnQ6pOWYfTZFNE7/15vUQ7QJZwANB12FF34RH7vrDjaFBrPYA
	Pbzcy8JcreBlWC/TwsX2uVbIGSY7aJEwCEPb82FcHy2ByDMj735teiNRcddfL2uH8rHujJJpGvtXb
	HtOuzKdLg/ZodLyJvOJfzedrT5XGa2Jd44ProED00jiZM7+BVSVtVw96CqEPIOyA4XRjObJas1DUw
	3o3EAhkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVtOr-005lt3-5D; Wed, 07 Sep 2022 11:39:21 +0000
Received: from mail-sn1anam02on2055.outbound.protection.outlook.com ([40.107.96.55] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVtOX-005lgl-IA
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 11:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT/Nw8Yvg8De7H5jM2i5uUz6dSenV7DQrXsD7g2hOC9H3TkPt2g0H3P1TEPn7YZvPJjyJX5B7a3/lfSpmmWPYZvJI3EQZxYKo77DuI3f+VWEodFsXh80lA2jR2GnG8ybs76cpN0pwfT2Xfzx2x6O55t3K0bmuXJ/N8UeXlESX0c/DBfFkXi3OQ3/xdihk8OVZoiZn6pwrKUsxUDb/3a1loL1jVKoCzYihb81oDYCGJkjr234I6nUTrxuw0pauGNtJ0WWibgo4w79DjHIAi1PRNXCd+7V3dEtKJKqZsN7UL5T0TIDe3QBQ0UhUVbTyxBlCAq3BvV9pJ0ZQO+tZfDPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=copC5HG4Ch0HIA8UVLVLZEdftzJdxrw2gJhHLyDIszw=;
 b=JWpJr0YFBP4D9UKJaXkzF0XTvd/jMVyjpRMqlKTcrMEozzGvYXST5jQE4tvTE1oztuJRHShT1zMCrtqCnEpoZe1clS4TQW5vRzD5UtlsNv8e2PknDcwvID1s4LqlOhcr6fm4osUD9z/8sXAAZrwtdBqSpdXQr3VlRVtqEYQzCIoXTvUalwT6y6pIdWOzOMNdTWZzbABk12f4F8lLFqP+x+EZrRFB0LcLGAiDqJR0MmrtHqnJeEWNmSBhqVoEcgEod9AFN/5NVuGhJzL5JeB01UxIEU8duYEEzLmC2ZtnIpVpFqH6oz7jw3vdTaz4MW2SoB8BVMtShixAQ60vmQWWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=copC5HG4Ch0HIA8UVLVLZEdftzJdxrw2gJhHLyDIszw=;
 b=gz0ou2/b2FN1Xkv577B+GY2nTE0WGHCrG9kKcLLuibygkbBV9vG5xUmT72yzc695OsKrAXreqqccvLTeyForrUU6SoZbo394p9dqkmjvFg/HrUqM0uaZgyZeFXxT8Zcy/8BduGMwPn5jOzDdTn4mJTpEdswhtWdM8tjZk5ENYSc29tdWqyPeAZgAWQSflW3abmjlwJ6DO9jPFUaYaaBWI1UA1pBsMgz19470vqODqW1vRVZklfBEo+LzgdDusP3yLLuu+JSSUgRjwDMxsotRF1De7QFdwkJ1V11J/XMPMFcZVlAXp0C8dYm/hVbWvk/nFORqMhC4zgSi/70Yb3PaEQ==
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 11:38:57 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::c2) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 11:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 11:38:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Wed, 7 Sep
 2022 11:38:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 04:38:54 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Wed, 7 Sep
 2022 04:38:52 -0700
From: Patrisious Haddad <phaddad@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
	Michael Guralnik <michaelgur@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP moves to an error state
Date: Wed, 7 Sep 2022 14:38:00 +0300
Message-ID: <20220907113800.22182-5-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20220907113800.22182-1-phaddad@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfd96da-e701-4e55-7499-08da90c58c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	P0LCv9ku/AtENOf0UdtlNhtIEQUT8BEC/a0YSMTWjtKKFowSDpowgEQa9Xg/aIGgb41HKozj2UFlX64qoaxFYuQM5dfze1QIc+jCIh/pJUvlNFbiU1EFvyDGGMl32xydfudMP0pEX7PdeBKR0sxLpv0qkLQLM4Ud6r0qMgY+dQomW26XCHIdpDHtwkCYIwaQfK1imhnrJTByD5IBlM+FEyAO0AtoOHF8AomhnTRjNFiWo7s4xS4r5Q7OtkA+/Ux9+MsoaAWvpF0L/1WNzlpTaDkSmwQbLMR6+4UNEUVwX9wTSAfZy3c+yC4TDDzPbOOVl0/KxeGSuDFBdk94WOeXeGc/XBQ2MlQOdXEVOqvS+x23WiJ9V/DYGjb2MjFFbAAhJSsDaJXzNCzL/an/rkzyYUXB/BedxCzeD8TTzefnsHqkrJKIKkYDhoY+/T4AuhMhpsaKhjUdTKe2sRnwzleeL4se5PAlik7gWPo9SDTc/fUCxPHrgqeL7YD0v99ggiiMWut+KhGUaKM+M6hwxYg8xG+5vYq/Zd2/TPhlRk9/XJBYLVA7+Q8nBf0bNJDNtphivWn9lrUauam0ezfQpWfj9j9G/PbfelxWO4uTw+zMBsUE/Rwo85pNBcSUwj3tfGIMqCzTI1FaFoeoA5r2svxj6VNLPabRDECFW+mbOr9TKTYIpZZ4en1cZ6b2TaIUXBZ1QmrP9nfFBclS7i13cDYLmC+Qg8greisUlq8gG3s4AfBDqp6bkk8J+B30ZHPcTgfZXbRYvAM69dNTsPTF8xADoS3Wt6HSZPwnMxSq72SStLHfheIJlXdaBuNx33uCtt4L
X-Forefront-Antispam-Report: 	CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(36840700001)(46966006)(70206006)(8676002)(83380400001)(186003)(4326008)(316002)(107886003)(82310400005)(6666004)(54906003)(41300700001)(110136005)(86362001)(36756003)(47076005)(1076003)(426003)(2616005)(70586007)(336012)(26005)(36860700001)(81166007)(5660300002)(2906002)(40480700001)(356005)(7696005)(8936002)(478600001)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 11:38:56.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfd96da-e701-4e55-7499-08da90c58c46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_043901_635835_157EAFC4 
X-CRM114-Status: GOOD (  13.46  )
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

From: Israel Rukshin <israelr@nvidia.com>

Add debug prints for fatal QP events that are helpful for finding the
root cause of the errors. The ib_get_qp_err_syndrome is called at
a work queue since the QP event callback is running on an
interrupt context that can't sleep.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/rdma.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..7e56c0dbe8ea 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -99,6 +99,7 @@ struct nvme_rdma_queue {
 	bool			pi_support;
 	int			cq_size;
 	struct mutex		queue_lock;
+	struct work_struct	qp_err_work;
 };
 
 struct nvme_rdma_ctrl {
@@ -237,11 +238,31 @@ static struct nvme_rdma_qe *nvme_rdma_alloc_ring(struct ib_device *ibdev,
 	return NULL;
 }
 
+static void nvme_rdma_qp_error_work(struct work_struct *work)
+{
+	struct nvme_rdma_queue *queue = container_of(work,
+			struct nvme_rdma_queue, qp_err_work);
+	int ret;
+	char err[IB_ERR_SYNDROME_LENGTH];
+
+	ret = ib_get_qp_err_syndrome(queue->qp, err);
+	if (ret)
+		return;
+
+	pr_err("Queue %d got QP error syndrome %s\n",
+	       nvme_rdma_queue_idx(queue), err);
+}
+
 static void nvme_rdma_qp_event(struct ib_event *event, void *context)
 {
+	struct nvme_rdma_queue *queue = context;
+
 	pr_debug("QP event %s (%d)\n",
 		 ib_event_msg(event->event), event->event);
 
+	if (event->event == IB_EVENT_QP_FATAL ||
+	    event->event == IB_EVENT_QP_ACCESS_ERR)
+		queue_work(nvme_wq, &queue->qp_err_work);
 }
 
 static int nvme_rdma_wait_for_cm(struct nvme_rdma_queue *queue)
@@ -261,7 +282,9 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
 	struct ib_qp_init_attr init_attr;
 	int ret;
 
+	INIT_WORK(&queue->qp_err_work, nvme_rdma_qp_error_work);
 	memset(&init_attr, 0, sizeof(init_attr));
+	init_attr.qp_context = queue;
 	init_attr.event_handler = nvme_rdma_qp_event;
 	/* +1 for drain */
 	init_attr.cap.max_send_wr = factor * queue->queue_size + 1;
@@ -434,6 +457,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 		ib_mr_pool_destroy(queue->qp, &queue->qp->sig_mrs);
 	ib_mr_pool_destroy(queue->qp, &queue->qp->rdma_mrs);
 
+	flush_work(&queue->qp_err_work);
 	/*
 	 * The cm_id object might have been destroyed during RDMA connection
 	 * establishment error flow to avoid getting other cma events, thus
-- 
2.18.1


