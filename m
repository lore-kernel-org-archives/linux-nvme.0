Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:03:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A67361139
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 08:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A67361139
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQ1nF4BYk0/Ysjh7v993JsAewZn4VuhQkevHOkwZg7k=; b=KEfxYAE/4HjQT9
	lYPBXjVtx1yvZYC/MnDUIt7rle89PL/fTTNKrRwxOf7ouZ9wycQd1A+l6mwSjA9FbHyEdXS9tgI6i
	7ZLtdDp9gmUsmGqxPc3EF2AtlCnGo/deLyjPfKgJcyf/dFwipWj+Jak2ic3Mrn9RcMSem24xipuDo
	xuVB2hY1nBzK433mOL/fogeVi0GPa43xAwIQw4VTMMkdJ/18qZIaeQfO/oH+ekhoiXch9Ph4Ng3s7
	VQqwDpXrKC+i5qA9jPr6gmnvqjHITP4tyQ0FL6LWFGVmeyJW8A3v3rtA68qMDer/YSz7SyGWRpFUU
	GO4NE4gBG0tw+87UgtZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY1tn-00DLIo-KA; Wed, 06 Oct 2021 08:03:35 +0000
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com
 ([40.107.243.64] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY1tc-00DLG3-L3
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 08:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P75mbhMw3iWnKBKisg+Qt5HB5U9DqxpGZA5l3XqE1apJfkCbRUWgWnhwJJT4My05Vq9PUHgHMMHqM/KSKgmVwvt2ir32/+53SJfmJ+5VFJ20g3SuX0xuY0NsRKcU6U1S5WsLhSIVbT6Q320vgj1QMyEqJjYKpYBj/J36SOruEb7DH1ags1EOiQlFfUi5i0CHe+rprdF3JK40GU2ZQgcbYrwWCTQa4e0EbFTmQ8Vv2ErIWFVZ0ZTCuGVSqKIEv53nHMg/fnGwa5E23fnDG6yRZlOuwT6QHKt3E7VzUk0r/Q/+19E2qPeqooS+/2moZ1vTQrHh0vLvlrt35t9Ll34l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=506JCZxILPYzDeMV5AVXhLZMZf5HlmFSXvkwuTxrAXo=;
 b=UV/C+RyiVlHj8u3PE2EX73Ei8W/PnaRtjcvZtRHH2gBIpl+ipJcyuXqnMYJCs6nhS+jX5tJ3hWJQIwAQ2asCTwySjCzESzZRxK4cNYHpmLOJb10VIhJC0BlUD5RZCCiZWfuHpvOKrZCC+SOmkaHw4dsFq4aS/DDR60eLbvG7aONstsPvlOtiKr7XA6K5yHoeUKOdGvgW7MMgE9brWRdNjyfq6FMC0eZolnH55jJN+wIoTq/2/scgjGBDNfBbr4iqiSIAgA4YSDOJPQuvajYUfKg6BxJQwdg8wfcY1ucL8xilDZdvosj6/NOeavYyVmQWjeeZ5ARhkpaCgYjFzSBuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=506JCZxILPYzDeMV5AVXhLZMZf5HlmFSXvkwuTxrAXo=;
 b=HGqltjQON3qKyhyt4wajF0cfbzbEVEzhnUHC+g6G1HODG53KupjPQ5iLMZvZS7VLyb+7I8otdnt7scfjwlSKHdkjrfrUsY4FTsdId0YEzj5nqGTvnIWhNOD1ebrhEd0mHWcEvHzMgtvwrJJcyZAeuAi6unBz/AhOLHy6G8FcdlakdqhsmxI+bPZ0Hem/b+7AGo0D349Udeh1YRBAEF2Wxyak9Elwxf58RaKB+NN8p2u4SnSzhftQeETDXHpSBZmzJ+RaCOws4RGELWyOhG/NZzbfW/qzHQ1a140XlZr8e46maN0DeiiQQ9ZNiiuGGsK52ijhtmLYH9vJYuZu0fUoOQ==
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by BN7PR12MB2801.namprd12.prod.outlook.com (2603:10b6:408:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Wed, 6 Oct
 2021 08:03:18 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::b6) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 08:03:17 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Oct
 2021 01:03:17 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 6 Oct
 2021 08:03:16 +0000
Received: from rsws47.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 6 Oct 2021 08:03:15 +0000
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] nvmet_rdma: Fix use-after-free when a port is removed
Date: Wed, 6 Oct 2021 08:09:44 +0000
Message-ID: <1633507785-10319-3-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
References: <1633507785-10319-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a01538-2d48-4c44-7abe-08d9889fc19a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2801:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2801BC3FD2BDB9779FFCE5ECDAB09@BN7PR12MB2801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9adW4tIc7rpz6+pZ2zZfsXrkBIF8JfQjjlYHmt4CBGv0wBnc0kCX9ue8idckJ5rYNA+ImdRheSTa9f/ThG7MIeFDmAJ4EhXFBIwADPiQI9SrtkZHXUSxOOCC7ORSRRVegGwbSqpgd4JiMKa660NESnoimq+1+M8LvKnoBsnfi5YjQmCaG25CE0EWA3nrcT9v/qtT/p6Xc0Q8hX+ewn3MIT4Apss91jb7ajr9JN0y16oqdWcmPgofvqfbFBtITyb5wOdaQZyAp9c2ySRGOBLF33FHJgXAPR8T+AjVFNN78CsJqqekCN5lskdpRUH9CcSxDXcyHhPsaq4rxDoVcqwaNMuwDoVgjVaiJKoX5ZZ4smEMbhmRO3IaLVKOm3BSETOZRnFV1jYTr9gro0jo7ZTUi58J7Aaa6bMFMVj3s9eJU2hiX4R8iTGCsISzeriMRTUlYHyagHsBTl6icU+1w+RS1p86bEWCLKEc8lu9Abh16jsKUFImOslveVb572RRAyT6X122dgi7qNRqUL/2Dno4NxBsx2iOXzWVH1NL6HU2SKtLJhoFoCDBbyAQSP9F6xk3O9zUXw6D7u6pq2tFWimLI6a6ya2KszZTvjWPxgDISbtEwIAVfjyHleYfLhQ3zilXgEiP2rLjFw2Fs+9RdBtbl1Abp8JXZflvPxjQJfw1Es8KfwmAKeUNhF6PHKLPRmW9l0RpCPc/Y9E7h4sxWA0mA==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(426003)(107886003)(47076005)(508600001)(5660300002)(6666004)(86362001)(8936002)(2616005)(83380400001)(26005)(2906002)(70206006)(70586007)(186003)(8676002)(316002)(4326008)(336012)(54906003)(7636003)(110136005)(82310400003)(356005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:03:17.7850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a01538-2d48-4c44-7abe-08d9889fc19a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2801
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_010324_744418_2A50F670 
X-CRM114-Status: GOOD (  11.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When removing a port, all its controllers are being removed, but there
are queues on the port that doesn't belong to any controller (during
connection time). This causes a use-after-free bug for any command
that dereferences req->port (like in nvmet_alloc_ctrl). Those queues
should be destroyed before freeing the port via configfs. Destroy the
remaining queues after the RDMA-CM was destroyed guarantees that no
new queue will be created.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 891174ccd44b..f1eedbf493d5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1818,12 +1818,36 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
 
+static void nvmet_rdma_destroy_port_queues(struct nvmet_rdma_port *port)
+{
+	struct nvmet_rdma_queue *queue, *tmp;
+	struct nvmet_port *nport = port->nport;
+
+	mutex_lock(&nvmet_rdma_queue_mutex);
+	list_for_each_entry_safe(queue, tmp, &nvmet_rdma_queue_list,
+				 queue_list) {
+		if (queue->port != nport)
+			continue;
+
+		list_del_init(&queue->queue_list);
+		__nvmet_rdma_queue_disconnect(queue);
+	}
+	mutex_unlock(&nvmet_rdma_queue_mutex);
+}
+
 static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
 {
 	struct rdma_cm_id *cm_id = xchg(&port->cm_id, NULL);
 
 	if (cm_id)
 		rdma_destroy_id(cm_id);
+
+	/*
+	 * Destroy the remaining queues, which are not belong to any
+	 * controller yet. Do it here after the RDMA-CM was destroyed
+	 * guarantees that no new queue will be created.
+	 */
+	nvmet_rdma_destroy_port_queues(port);
 }
 
 static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
-- 
2.16.3


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
