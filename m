Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B4C47DDF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oURUoq/HFtXsz6QCgnqpvl+rKuCbT0BSvqIQpfSmMQM=; b=FWUE0OoHGdbzbvFf6fBGN2+YPk
	rO2FUgCV4gt/aoLPYEWKZVSAKwg4UVlI39BC3z3ae6T6RQKiI4clI7UNVa453aCbm/Agc+D31Ce3C
	PP9n3mad18+9p+lC9Z0YBE1tV2k9hKDJCfCL0stzMf3kH4bPwfd+KG0YPsAPbs9OLh5OYCsyS21qJ
	cqazBsmrGfNznrvKxlnraPl3RPsAcIpDQ97CQ684JAnF7fOp46oH7WfXQKR/ejRY3TZm54zRx03dD
	RPgvoqBn/YeOZZN/nxcmZM7HZzVuEepqBcicEA0Dbve5beh5Us70GCYJJUOi3TJ15urzpoeitrxak
	1qLm9eng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScCI-003A4d-2z;
	Wed, 24 Jan 2024 12:17:38 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rScCF-003A0D-1D
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 12:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe1Ro1JqHFpSTPa0xHZ8qv08F+CUUkMlr2lmPSfxpPuR8sBZrOgCsRei1HhFlPr5q90T6/NUMlxAW+F++bmW+7LflmpcknEvoqqv/LKNT4FJ1M47GLRiQGFv/qIwg4W9ngQWRTXGY9Mxamy+F4Etpe0wvXldR7i1d45eKMgcmNuYDH0d1x7xxHJcPRWSi+nFnVMV7S+cHrx8brLH9RnrZTomVT0DZlo/wGQDOcXBSSYALvhOD6YCYJELf0+LgnR9qf1FKHxS+GjqO6iSfBzuX7dJ25kIFh+46qjdXyG7Hby/P5GbiABxFpzY18BZ1HagOMgci8cakFKY/6ZF67B6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oURUoq/HFtXsz6QCgnqpvl+rKuCbT0BSvqIQpfSmMQM=;
 b=nlwH7qzGzmimMPe44zLExHe9LN2Etif8IpuK4aU6mjxkO6oDA4bCXQuKqLo7M/pjXkp0Gq+3B5U+/LmWGRvKd6gdc/iqik6rnOiFiHzhi+QQ1d1bFRIzZEJEbObDbdaU1D3GZ4qd//Lff35xr/LJs9sI2kWLRWvn0NejOqJqKB/nxR/4ZcEjLkTgrSc6OZl4DoWQ47n7F1oOqzIlPe62ehyABLhVu2TVjTGcaw518vs8fbNm1IVbW8w80ST3cRharz55JqD5+PgE9hLn3igrcKTTYa0tri+up3PHNBMCdQzy+b+nJy0WMdDvu6zVIEfDSOzfaAkBSXkPGepV91eSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oURUoq/HFtXsz6QCgnqpvl+rKuCbT0BSvqIQpfSmMQM=;
 b=AZlY2GoKit4uEb3znhHe2dp0xnSQi/Z5M1GXONlJVAUGldYhq3BLB1BVxium7n8wvUdayuHJ4iO1nw4xwkWjRxsEAUM2HAaJY4PWcIoAxHJaxLIbqvAjAPs6dBxtLbZXdUDe8QTc71pdHQhzmDqFiJoN5TOMz8lPEXHuylJMu9ABg+5O6q1mm7LQgFhWrt/cfzqJPxU5HBApW7TYSthnBMcMc2OzhATz8CHjM3g1bRzWnVh0slXDfIsljRuEKqX9Uz0uQ3owB46TtLyyNTleFwCnD2kGXP8vbJZdR1P+SNPtPrIn61P6mCuuCK51+huSGeEe/8KFlwZaZ+quV0ADBw==
Received: from SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::11)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 12:17:23 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::45) by SN7P222CA0013.outlook.office365.com
 (2603:10b6:806:124::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 12:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 12:17:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 24 Jan
 2024 04:17:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 24 Jan 2024 04:17:05 -0800
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 24 Jan 2024 04:17:04 -0800
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH] nvme-rdma: Fix transfer length when write_generate/read_verify are 0
Date: Wed, 24 Jan 2024 12:16:27 +0000
Message-ID: <1706098587-20726-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: e86eae86-9a9a-4f9d-763a-08dc1cd66bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iczhVxGFDJIZt+YZlWDxvWREX3W1iCKHD5cl6pAw/Q4WFPlFqVWM14txJFCLja/6Fp+pVWxysgnOe6NcVlb4+4KZye2Oa+sBa21nhn+Z1sdWIFuuxRnyC+2sr8178hXtZYYbDG8fgAtrlEnXE7MoO56iNNUiXWvNGlLkCwuyQYClzP0y664ikthErwWMQGcm/QPTK2aH1cEmzSrC5VI1ihwgM/Icw7NZoXOV6wiMXvOZvlkSAYvNOleYpB6zHQ2kvW2klMJfZ+s9UpGcLE3RqvJo3+3c+SYj8dLG0lXepSCfazTzj8bPC3LOmnEijXA9lbgtGMHehgOHUSgTTJZG4p67mQyyK5llBV7ESfVBSGCUoleQThRLJf6rFA1DWhqC7csNTTZviWdf8oReaEOf5IkxUs9/6SW/PBbK7aOkzpkhg7XpAbvBy9QV55/oy6Xl5MD5EmJxDR3eYszXwekFSPJdO0/oUjTDyrHSHic4FDDCPQokVnllHiQkemmrPgbkWGCxzL7qPN+FYWrBlDaYgJ0ZqxXJqXwCSf35DT/met4qn50C6fSTHBzjNOMwhcoDUAHQPwOXXn7vIaHSO1Y3cmBi971lHogi3zFKdgc5G8dPEZmjdF9/c7Vgmv8OfndS9RB6B6aPwdS7NmMcoVnLXmlqKsI0PZGFIrtE7k46+NAfQyv7mq2lnGOyjEYUb/XHWJKFg1p3pU3djpxW3eCLOlqcFP1Mlx6bw0nCU4h0rFjlJ2xCI+J8b84msfGqgtV
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(26005)(426003)(336012)(47076005)(107886003)(83380400001)(8676002)(7636003)(2616005)(36860700001)(82740400003)(8936002)(5660300002)(316002)(70206006)(41300700001)(478600001)(356005)(4326008)(110136005)(6666004)(70586007)(2906002)(36756003)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 12:17:23.5134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e86eae86-9a9a-4f9d-763a-08dc1cd66bc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_041735_482298_0DE6EF35 
X-CRM114-Status: GOOD (  14.01  )
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

When the block layer doesn't generate/verify metadata, the SG length is
smaller than the transfer length. This is because the SG length doesn't
include the metadata length that is added by the HW on the wire. The
target failes those commands with "Data SGL Length Invalid" by comparing
the transfer length and the SG length. Fix it by adding the metadata
length to the transfer length when there is no metadata SGL. The bug
reproduces when setting read_verify/write_generate configs to 0 at the
child multipath device or at the primary device when NVMe multipath is
disabled.

Note that setting those configs to 0 on the multipath device (ns_head)
doesn't have any impact on the I/Os.

Fixes: 5ec5d3bddc6b ("nvme-rdma: add metadata/T10-PI support")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11dde0d83044..35eefa5bb464 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1410,6 +1410,8 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct bio *bio = rq->bio;
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	u32 xfer_len;
 	int nr;
 
 	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
@@ -1422,8 +1424,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	if (unlikely(nr))
 		goto mr_put;
 
-	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
-				req->mr->sig_attrs, ns->head->pi_type);
+	nvme_rdma_set_sig_attrs(bi, c, req->mr->sig_attrs, ns->head->pi_type);
 	nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
@@ -1441,7 +1442,11 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 		     IB_ACCESS_REMOTE_WRITE;
 
 	sg->addr = cpu_to_le64(req->mr->iova);
-	put_unaligned_le24(req->mr->length, sg->length);
+	xfer_len = req->mr->length;
+	/* Check if PI is added by the HW */
+	if (!pi_count)
+		xfer_len += (xfer_len >> bi->interval_exp) * ns->head->pi_size;
+	put_unaligned_le24(xfer_len, sg->length);
 	put_unaligned_le32(req->mr->rkey, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
 
-- 
2.18.2


