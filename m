Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD8DC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 15 May 2022 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=abPSoMCd386KNIj4JDd460e2OWn2Lm/Td5exGFIivK0=; b=vNYc8ryF+/vL9W+/BMLO6EyD90
	7sFkCiuieHGsiG68cibEo6vV9Wl11BDu3VUQAL8M28qoo2PShEtfCSCsiHVC2of0UXrSe6PfsKaWw
	JDSfcyCK7RjRaQW2XBWNPyOE4gmee5cDp+B7L9qpZ0GwYUXjDQ1mSICnQiXoYwvYuFB/sOs5q02vF
	63mqqCGYiXN5wioOMLwClr8xiaKbPS02ZPZ10kmGenoGmtai0UBHdjYMkiofkVWxhN+h2IAEnAqaE
	cKAb6tJgd084B2HO0u65+nzxYI7bCWeJFqwU0xrZaID8JQ8tQtCeD9O3uZPybIsWUCSCa/Pq0tB66
	FjCC+CrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqFo1-004Gbd-As; Sun, 15 May 2022 15:05:13 +0000
Received: from mail-bn8nam08on20612.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::612]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqFnu-004Gax-4w
 for linux-nvme@lists.infradead.org; Sun, 15 May 2022 15:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOf0/AJ/dhgo+w3ohwReHV2ESGHdDzYfbjz/eF6Soi7dNP+gt/EwPw9JA7XxoRVP6x8JZrZWihUwIu4UGQWBRfQ41Qm7Qp28ElAnDqF7TOAcvf2214lMfKOGnaoxUVzUGsiSTITszfIjKNlA/XhrhQuwE5zAJBKS4ZqUue8nzXsJ09ZlTszKEeD39c6L0vX2vHy6cc9OM/9rIw2z5yadyot7Kie+SUsx9cAnYlpHlRlk2qS8mNovNgOlivNdiNzodPOaCL8ATpUwpMjPIQOjUKRPSsQCMJ2V49YePjquqww1JgDeY/HJx9trxQfJsqmLeWkN0+bjshSMxHLWOmfWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abPSoMCd386KNIj4JDd460e2OWn2Lm/Td5exGFIivK0=;
 b=cIpe5roT1gbPebfGeGpSIE20e2lir+Y7LQcsWKvBh0J8l+KWuYaMzndIC1geGH4bYvNLgMXcsaPZtH3Mz5zF7XHL6CtIM9DEZf1v/+FBqldGm9Tyh72O9Ef8IGw70gKewGV42UK5JzvPQRr5hgmim2b31WVD93BLET3ac6gx9JgKDgya0fNEvKdX7BhtZqfSAL1jyohZdjFAst42ua+H+iLqEwaav8/k9OB/xkx9bu3Ff4lsV/czquyR0NyPFsy/Fggm2anCclklDuzAxolBwHk6LJSMdPP61eX2iM7Aumg+a/Z9CuRpZbTftqQuqEfx8sk4ObNNJYXQgp27aDzM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abPSoMCd386KNIj4JDd460e2OWn2Lm/Td5exGFIivK0=;
 b=lRcWRWLyop3X7Ozk3f03xYh65CeBPbf0qB+3rLbq+uCyOaacQF1MOlDNYE+1VXPYeAyzk+UfmSWheucKNR6eXSlOp0VIw2kjh/TVqtof+in6JYH8CN1r/mIVepp1TrMhaO8c6paCh/sqlSvFxxFiNfMYeG6qzMlM0qPI3RnNvh55v6CwSy40r97Npfa9QCwfxvhoCqXmXG7gsKddfQOlh96my6EUn3BuRnPrZ3ayzFb6l1QdsgVmDg7xcg3IreYZuI/QJoIRhsRE63TxLkesWIxThOt+MZF2vFe8Qe/yF/71iBl/C0pHnUb8OBzJlN7CL0p3V3ODzSCvkDE7vG/Hgg==
Received: from DS7PR03CA0090.namprd03.prod.outlook.com (2603:10b6:5:3bb::35)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Sun, 15 May
 2022 15:04:59 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::f5) by DS7PR03CA0090.outlook.office365.com
 (2603:10b6:5:3bb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Sun, 15 May 2022 15:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Sun, 15 May 2022 15:04:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Sun, 15 May 2022 15:04:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 15 May
 2022 08:04:57 -0700
Received: from rsws50.mtr.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 15 May 2022 08:04:55 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] nvme-rdma: Remove timeout for getting RDMA-CM established
 event
Date: Sun, 15 May 2022 18:04:40 +0300
Message-ID: <1652627080-42045-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 689599cd-fcdd-4597-b30e-08da368447b1
X-MS-TrafficTypeDiagnostic: DS7PR12MB5791:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB579156F0500798E38A5F52C2DACC9@DS7PR12MB5791.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pKCHDxiK6/xQq7VFsbkkY4HKEGXKe6ImymYn5f2NQgE6dLZAtHcKCYmx5ii9Z/nnjnlUxdntC0a9SRte/Ja+yVTeRF+gl/P43VNTVf6uq7VAnP5ylUVPti2HGOytQ5OZoJUQ8CUhd16VLI/YU4pyvCa0dM6o6oPAAb6OefwYOPWLNPyZpwbD6qSHDQPbgnwEKD3N/9m07/QRmRcWuszcy5N4Ow19oCISsyGdywTHFbLn9X4vmL7oK63qDLPctxH2av/Mf4Wf2B4avJ1cbGFptRJpjMlB4D/UoyGOt6Yz5mqz+2RSKKpakSH6z5DKaIPX1/m8CfKxKk7E6/zs4yIBJwVb46WyFZ8BwA9OgHMiACvvfN7HYj0ScfG/gbVpwzhg+j78bPkX+GxSAY6NmvbWsIas4L1C5dl/QHBStvPKCpgf5nxw9qQnXlpmIkkIgrQcjFm8vx73pF9EVwpoTaH9jjxWrkmySBXoGVNJk91WSSSOGTfGWwWAyr4KUI73i5GD3q0mVPrTdAFuGGE4XUFx5fuZjtAutjfY9sWbeAHMSHzhSN+c4wfqc1/lAfaJW6iSg3nLiL5kJVJwkv9hVdBtvHuqgcPcncGTKfDRf07O5/qKvZy5h4T/necTkILZfKkeGaabjoD7hXO2DmIvFt4KmM+5efpCF/4stFiD2EGjHpqlRRAzNPIXr7L4UBGAwTJjS5S69QDIObFiH8kfZD0BA==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(8936002)(26005)(5660300002)(4326008)(54906003)(8676002)(47076005)(186003)(110136005)(336012)(426003)(2616005)(6666004)(82310400005)(86362001)(2906002)(316002)(40460700003)(508600001)(36860700001)(83380400001)(107886003)(356005)(70206006)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 15:04:59.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689599cd-fcdd-4597-b30e-08da368447b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220515_080506_236477_927D0427 
X-CRM114-Status: GOOD (  14.32  )
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

In case many controllers start error recovery at the same time (i.e.,
when port is down and up), they may never succeed to reconnect again.
This is because the target can't handle all the connect requests at
three seconds (the arbitrary value set today). Even if some of the
connections are established, when a single queue fails to connect,
all the controller's queues are destroyed as well. So, on the
following reconnection attempts the number of connect requests may
remain the same. To fix this, remove the timeout and wait for RDMA-CM
event to abort/complete the connect request. RDMA-CM sends unreachable
event when a timeout of ~90 seconds is expired. This approach is used
at other RDMA-CM users like SRP and iSER at blocking mode. The commit
also renames NVME_RDMA_CONNECT_TIMEOUT_MS to NVME_RDMA_CM_TIMEOUT_MS.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d9f19d901313..0ccd8f65b50b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -29,7 +29,7 @@
 #include "fabrics.h"
 
 
-#define NVME_RDMA_CONNECT_TIMEOUT_MS	3000		/* 3 second */
+#define NVME_RDMA_CM_TIMEOUT_MS		3000		/* 3 second */
 
 #define NVME_RDMA_MAX_SEGMENTS		256
 
@@ -248,12 +248,9 @@ static int nvme_rdma_wait_for_cm(struct nvme_rdma_queue *queue)
 {
 	int ret;
 
-	ret = wait_for_completion_interruptible_timeout(&queue->cm_done,
-			msecs_to_jiffies(NVME_RDMA_CONNECT_TIMEOUT_MS) + 1);
-	if (ret < 0)
+	ret = wait_for_completion_interruptible(&queue->cm_done);
+	if (ret)
 		return ret;
-	if (ret == 0)
-		return -ETIMEDOUT;
 	WARN_ON_ONCE(queue->cm_error > 0);
 	return queue->cm_error;
 }
@@ -612,7 +609,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	queue->cm_error = -ETIMEDOUT;
 	ret = rdma_resolve_addr(queue->cm_id, src_addr,
 			(struct sockaddr *)&ctrl->addr,
-			NVME_RDMA_CONNECT_TIMEOUT_MS);
+			NVME_RDMA_CM_TIMEOUT_MS);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
 			"rdma_resolve_addr failed (%d).\n", ret);
@@ -1886,7 +1883,7 @@ static int nvme_rdma_addr_resolved(struct nvme_rdma_queue *queue)
 
 	if (ctrl->opts->tos >= 0)
 		rdma_set_service_type(queue->cm_id, ctrl->opts->tos);
-	ret = rdma_resolve_route(queue->cm_id, NVME_RDMA_CONNECT_TIMEOUT_MS);
+	ret = rdma_resolve_route(queue->cm_id, NVME_RDMA_CM_TIMEOUT_MS);
 	if (ret) {
 		dev_err(ctrl->device, "rdma_resolve_route failed (%d).\n",
 			queue->cm_error);
-- 
2.18.2


