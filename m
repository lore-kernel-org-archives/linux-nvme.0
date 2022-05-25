Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D1Z1/RKx8FP1yB8IIxXDQjIWA2VVo0Pr6QOnt54u2bA=; b=GHGsKNJIMy/OrfXSd75+r57fS5
	3LUicQdHYmEIeHL06TmIbKHCAoRZdppMl27S+099EmTkolrI+G6xw7I+2Yri+webmljeNKYmGbOZt
	jvoiAmmcn5TYNPQMdoSKibazeLvzxWAFS0jNm1KakJRyLyfop/kZM3ukqU9h1tp4ZO8cUGilUlP8T
	mIjOr/Lir1aO1ivOfOItGSq74EL9sEjgPBJQF8ijyE4+HLH9dRnu9rWY9zUhYeHjpI0E5dPqgZ+VP
	KRRmLHORSia0aRz/YBVZ8TVidqBVBCbZGYPb8TWFf2llWjb0IUe370Rh2h48cj4L0fmJiM58eftM5
	hSkL4zTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntsV1-00BUSE-4F; Wed, 25 May 2022 15:00:35 +0000
Received: from mail-bn7nam10on2060d.outbound.protection.outlook.com ([2a01:111:f400:7e8a::60d] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntsUy-00BURF-Nt
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 15:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgtr+UbZNMknGknhGA6b7MAYPq8kNbgj/r0Udnoz/wJHPZ5GYM2/OiooFjrzlIJpSWY1KapWlLE7irOyN7Kar/Pfel6pKpAavrpRtMW9m6tuxkdZY8opMY/beVnvbfkDtJ0thNqtUAaHdp4fqYDGDjii3oQOAEdj3Nz+FtP00eSTKm5iJ/vRADgm0EiDUpFo1ZkWsKkt7paXwS3Lst+hjl2c/d93NMtHkx9Bp+fCz5qDQ8LqnQe0yjnoKAznYDER9zBlfebvK5hJBO5TSuewvW5XfIB+6cEvunJdrxF3aIajLuCeX3NWNHioCe3Yse2GzzNo+b/M0kQ2vCXlObvUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Z1/RKx8FP1yB8IIxXDQjIWA2VVo0Pr6QOnt54u2bA=;
 b=lAegwKLOZ8O1QLnWIkYYjWa66JVGpMuoqdtsfi5/4Hku1IquJqzk0AM5eE73TB7gtJjlQq+xojQeKmKxdcnYMNiTmnMARIIUrltLdatw7dFDe6nMaGKBm96XNyYv9To7sMZtgVtL/MsnI1KLckvb8hhlj3+pV130IwHefrNeqqRk98bQxV+UiFrbl/dITZ8bPeJNPSXAjYSspMKIQK8HNSHnA4nToKDxv0TAEbgTaQJH1fW1VhmQe0WjJZ8nsKCkmUqV9S1A2AjFqbxp0msOI6r2Wcx3DP3E1YuwZuvqdGBXQyVDS1zCMh2ZcJ6WQxjPoz3SLx1RmCp2PJHKskcGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Z1/RKx8FP1yB8IIxXDQjIWA2VVo0Pr6QOnt54u2bA=;
 b=kcbIn+tMo0r6X7nUmqHdMGOdAcTCcrozjYCrIqZX/NxbAMcANbKBqUtLp7ivHTTxAu1JzSI5y2/xmvzfy+mO+P3OH1oeEX0a5cG5UqJGbY8hIcbsI2RgMrNzIKzhUJQfI6f6VsOjhLXWBJOAjr8ZuBmMKq+g03Mi2FsNl/SDUNtB3iI3zXWEikv6JsAsSFxgNR23jGlv/9TDL3OIXoHJusrvyQ+pcCujjKJgqCRZw7++PBDE0TpZmRxDJBG5lQKU42RUY1yH2XcUNc5EI5V7Irh07lshIUEIP9ngW6qasRr/D6KOBpkDRg8LMRo97q+/MtxWcn6fybF93B3ydL8pUQ==
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 15:00:28 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::d3) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 15:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 15:00:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 25 May 2022 15:00:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 08:00:22 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 25 May 2022 08:00:20 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <kbusch@kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvmet-rdma: calculate the drain completion once
Date: Wed, 25 May 2022 18:00:20 +0300
Message-ID: <20220525150020.695-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d99764-f653-4a5a-d97e-08da3e5f4dba
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:EE_
X-Microsoft-Antispam-PRVS: 	<BL0PR12MB4930C50D9BB8280EBCCF20A9DED69@BL0PR12MB4930.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Ud0vXdPFHp9Q9Dkeacylum+ccxcpNjKcIIbnct/Spy6vPZN1pnhDEBs4I9ZrtJ5x0i6sJswB1hFSVTMtRE+BUzYx0jydyb9A93026KT6CM0heJEJIoiscmzZC9FQky7BCFIeUvvE6ecnvoN6nv5BlSjbH6j3cEGMWVH1k9HD1LhMT5KHhZpOGttmq/CU0LUOzNj0KRnWITJRZE81We5GWAdy9SZdPUCpTMgIlTW878MARmg8pkKVpOTuOq014UvDvRRslF7ENutyqedRprJwXUI1sx8ajSagTk48fYWAL2QHj58lylHoYdcCUHstOXV1uFwVzuSyuUVXVvH6gGKuoCqK9wmXL2CtWQ6CIppmntB9qzvHbv/0c1TWWuezJiMP+DYTsb6Q4lh6VRoyJMSTGABynf10l1WpB+jtzMrygYtbP/v16kyZPok1t/6bfypW2KsLmEPm5S8QtvDMtCHaZg30w0I25QUi5frs3+X8au6WPZzgqFZfy645ur7v9WIaXFpB8RbWev7++j7Uv9CFcx7FlFeCEooASS2czpETu6E77Z6QqHxBpEGgW5EA9vnSXIxFwB0Nxxjfwmt/i6w3yt4Fy570XhAOsu8/n0N1hXFy7Hh4ZqzWs8Di7rEaUbnAtGQXMNWJ7GvJersEtWgVIEEMhBYdprDD9j9IVKJx+WK05jLR7wsUXsLQIyKUC10iKSWKY+wVst800cf9EnVLyg==
X-Forefront-Antispam-Report: 	CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(8936002)(81166007)(356005)(47076005)(107886003)(336012)(83380400001)(2616005)(186003)(426003)(1076003)(316002)(36860700001)(54906003)(110136005)(40460700003)(26005)(8676002)(4326008)(70586007)(70206006)(86362001)(36756003)(508600001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 15:00:27.2159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d99764-f653-4a5a-d97e-08da3e5f4dba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_080032_815988_5D135F2D 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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

Keep this calculation at the local variable (nr_cqe) once instead of
adding it separately 3 times in one function.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2fab0b219b25..c572f9eac547 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1263,16 +1263,15 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	int nr_cqe, ret, i, factor;
 
 	/*
-	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE + RDMA_SEND.
+	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE + RDMA_SEND + drain.
 	 */
-	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
+	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size + 1;
 
-	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe,
 				   queue->comp_vector, IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
-		pr_err("failed to create CQ cqe= %d ret= %d\n",
-		       nr_cqe + 1, ret);
+		pr_err("failed to create CQ cqe= %d ret= %d\n", nr_cqe, ret);
 		goto out;
 	}
 
@@ -1329,7 +1328,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 err_destroy_qp:
 	rdma_destroy_qp(queue->cm_id);
 err_destroy_cq:
-	ib_cq_pool_put(queue->cq, nr_cqe + 1);
+	ib_cq_pool_put(queue->cq, nr_cqe);
 	goto out;
 }
 
-- 
2.18.1


