Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5734C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A6/QKjgaHqqtkaBotfDVPqgIcwYJDM13yaZG5wpaGKY=; b=1An7218KnNC0rF7EpW4aP6d3U/
	8PvmITNFSfhU/qQFNkQ9Res7Avj10V1/nBPXmEg6gZqGtk8Byo0cmsWtgco23YIyhcumB5Jdkm5+l
	1wt81SMmgUQCGDZNXw2i0+sU6je3m98LahstiAUTydJ9BnQXNaJPtQqxhCdNY4QuUPNu2xZe/5Kxm
	vy5nYAODiCOwF6l7iAOY3SJId82YEofZ3+3uBSNVswBtw6dFtNKv/pasV1axP/cfL7YfQYkKIC/PU
	w1OyEst+sfTF4c56BKqqBXyInL3yjea0dnhqeooaIsagu07R4xatjh3DvwvivrLSOpw9/BgFDIX9C
	npoS4ahw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZFS-00Eifo-V8; Mon, 14 Feb 2022 11:10:27 +0000
Received: from mail-bn8nam08on20626.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::626]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJY7E-00EN4O-QT
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z49QJWphTV+u+Bf87+Bfi5l+AvLEfQgUXJSH52Id3bK/Ft6t0mDt2Goi5riH9/lMIFmZcjD3307JiZ0xeKQbS0wURrlZLcVRxGs3hLG+IhPSlInGTB+wwho7eCNgUE90HwBkxNohTj5qTg5KcbmrEQSGLNjAu/QhkQ8v2V0TWKwbFcra/pqVPVrXQoqUeEjTRgeHXWfkJVb8oub3glHm3bTwDLiiuykXMAbmlp93mLu5R6c91MzUadTriY1eM6+L77sENotITOexMWiq61Ul+7lu5+AuLRWdLSMQhSycdlcfu+y7hDOcsWearZSbbKA+YjY5YBbTPORi3NLjzoAcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6/QKjgaHqqtkaBotfDVPqgIcwYJDM13yaZG5wpaGKY=;
 b=TzVmlLGEIZ4jMaHctrMncPulabLpWuTrXVUaSSKmcP6YNDD1RGcJ534SldSAxwwLXTS68wF/DrIqR4G+oMc8sgDsLzWEI3JzioVISZ7gNxG/JAOFPT9zFsnO23aVGGkvgkLb3oWplqvVy7Qi42+TyYmugA81ogSI/wit7WClFD9bLaBrPILW7n5YOiH5B0a51Rg1hHrbZAOKFO7ddtXo8hA/wdPVrT0iOxEdCoFE8Fjrkk9FX1m4HKk/whtr60ebl9pnj1W/2fDa3P6i9nWtBejoLDk4ofHYde4SB/fjEgB9YRBNcALBo0oTQvy0ue9xf7xwN6zHN/nVhesaZFqm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6/QKjgaHqqtkaBotfDVPqgIcwYJDM13yaZG5wpaGKY=;
 b=GXtUK+Chr1rh7XfEFyNkD+AfaZBwymtpcV7K7OICiFpVCT2rn7+gpV8UaYvBnHwRtn9wR+8QGQwICe7CTqOm9VADdWQlvbMLtWU90EwgSaPhT0eLBjWMHUQEtc2KIwPvUASgxIavxP6Qrk6iRAVk99U48OZik70sVsHmNhbR/g+vOpWazTGxmT2z99sfKLa037mPkYhwJJWg0J7ALWRws+Tdgcv/xX1sHXa1UqE5U3knbuZbRyU8uLklxM4TrRTudYMrqQPZ//GsIs1YeVMZHGhOfJaMznFv8I5ZNtZr4OgP7rIpW/WsXyd3dJ0u+lKnL+9HHk9uJDYKMif6NxQslA==
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 09:57:47 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::6d) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Mon, 14 Feb 2022 09:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:57:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:57:46 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:57:46 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 5/6] nvmet-rdma: use non-deprecated ida_simple_xxx APIs
Date: Mon, 14 Feb 2022 01:56:38 -0800
Message-ID: <20220214095639.5125-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214095639.5125-1-kch@nvidia.com>
References: <20220214095639.5125-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ae60c2-3be7-4533-632f-08d9efa0745c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4533E5A9238A33854F19EC33A3339@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qokfUIgtecp4Twz8av3fzY2EUdsyux0QGUdj7xbMvF3totiQF6cZ0FpcdzG2g0hC2wV6y4xCRYJI9+jO1AcLnlZzl4eOU8XmHqM9BAZbY2Ps4grCjKkikC/fNQZE78po/xNMv9koTk0cEc80OQZ6lqfHnkgTcevl9ccHq/5A65m9nT95p+Dema+FTICSF1axySx8WhP74/ujkyg5xBu9kvquSG7Hwjj4wNibJatd2Hm2EVo0gUaOi7PU5EKAuApBokgAGn8i4GxepOAE8dDOej+J/7bqnHoBAAp2BVnUH/pG07JolYK3B1ls2671uR6pL3qlMYfoE5uzajE3HMK2kyv9pr0MtVtulf0pcma/8vuqfZfwNs2wjwPB3Z0Dfghx3R9pS+u+xjV7Gh1BpvpOGQyIMHOnImUYOxmB2TWUM97paWFwWIdtwWiJrm7MiquGRQ/XZALXQILyevcdTnSzhwgLNFTUVcXWPbDiOVMsanB5SR5eDwmfjeiN934eFX6BFIiSrrvzqkIaptzChim+jgGQ4LjNWr3vuEQdqhb27nEidklEj7QMIxJJ23Yvc1Ecy950AuRi2gDgA/3q2KIlyx4hKUB88BouNIWyYBryxb1aY+gljGvHMCTPbzeM4UBnYkmAYwuQhWVq/I0Kx5JwC81LTXCP5VhZ52WexdF6RLn9ef1o9ET81u/hRRAIEjta3byXi4AdX1jAoRGNoFMBwg==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(1076003)(107886003)(426003)(186003)(336012)(16526019)(6666004)(83380400001)(2906002)(5660300002)(8936002)(47076005)(316002)(356005)(40460700003)(54906003)(6916009)(2616005)(7696005)(508600001)(36756003)(70586007)(70206006)(36860700001)(8676002)(4326008)(81166007)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:57:47.4715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ae60c2-3be7-4533-632f-08d9efa0745c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_015752_910846_363FBD7B 
X-CRM114-Status: UNSURE (   8.88  )
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

As per the documentation present in the file include/linux/idr.h
ida_simple_get() and ida_simple_remove() are deprecated and we should
be using ida_alloc() and ida_free() instead respectively.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1deb4043e242..00656754e331 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1356,7 +1356,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 				!queue->host_qid);
 	}
 	nvmet_rdma_free_rsps(queue);
-	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
+	ida_free(&nvmet_rdma_queue_ida, queue->idx);
 	kfree(queue);
 }
 
@@ -1459,7 +1459,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	spin_lock_init(&queue->rsps_lock);
 	INIT_LIST_HEAD(&queue->queue_list);
 
-	queue->idx = ida_simple_get(&nvmet_rdma_queue_ida, 0, 0, GFP_KERNEL);
+	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = NVME_RDMA_CM_NO_RSC;
 		goto out_destroy_sq;
@@ -1510,7 +1510,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 out_free_responses:
 	nvmet_rdma_free_rsps(queue);
 out_ida_remove:
-	ida_simple_remove(&nvmet_rdma_queue_ida, queue->idx);
+	ida_free(&nvmet_rdma_queue_ida, queue->idx);
 out_destroy_sq:
 	nvmet_sq_destroy(&queue->nvme_sq);
 out_free_queue:
-- 
2.29.0


