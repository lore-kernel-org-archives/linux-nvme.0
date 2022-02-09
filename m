Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4729BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UMsmTIOvaSaZei9DHmzBuD5lpfBwzHRI4GY0hRu8ycU=; b=4c/5InHZI9T0Sub3JiGTtHonZW
	GonZ7zuho/C+NQ/9hxvEh2+rsrC8DvRo9+WCsO5898zR8eQxVSRtaBXiNEqHT/ckGD8iKpi5ddrEt
	dLI65W7cKG7pV9Ta6OduJdmNbd7nGp0QuHdPpHvQGrOgW1wFiIwiJYNKn5KErdF1U+VroruryHHRM
	gQcqYJaGL0LNb5SQTQqUSerQ1Pn8AtYg5qjmMWNxarXJFfckHJAVbQcGnFaE9Ug4gVbzwI47ofyWy
	XgvK8hvYy3jZH7e5F7vvaZKERnuxFqzFyttu53jWF9lOomdh+8JeMR1lZIEN6Q2tI/3e1nOfhCS/c
	a3uwK/7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHild-00Gl7e-Ms; Wed, 09 Feb 2022 08:56:02 +0000
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHika-00GkTn-If
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 08:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJWAV7k9TV8JqZwToSW6TVFimu2dnomEys6USYbTSQe9RZ7xnnflAAoMKZfh1XTs1SWuT0/7FbAxXrC3tnAdrZWLLL1AmjABit0eaQgX1jIUZ/1Vfdj3sMLg4RY4esuqjFKQRe+VQHEjlcI4C0erAX8HvHUxN0vk3fIjhU3tu/sRHuSWIEUGzcLDW3gsX2mkJRbg+BpefTjPlq3UKOrm0iHTjLedfoJOTZU/CJLmYkTIc8SgV6F0tg0IxCiNn3WJAxx3823qSUaDLSTe/2fBwkNjJH/aM8PLCZ/C11k2EqZpbYvk0nN/VJdaIMFPHUafMVSEgMCjl4J3nzu+19hTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMsmTIOvaSaZei9DHmzBuD5lpfBwzHRI4GY0hRu8ycU=;
 b=VetaRlBT+HkI9tuNDx3DKtvN8zsWdKZ63VIRcu0dr0tiM1/RKC51TBoKcvCG1XoY48RiDiyaiCvt6+YpyMqC3afh+N9GzpM9zDRua0MtDclbG8QzSUqtq5admyVVDdtYWV8ERkRGin2DW2k0LoZfriywkViT2Qy2KFoWxcRjBvGNE2nJarPnfjaKorBlgm9LGCTC4IUuenVpDtHQXQYwq17W/JgW/KOHx07ARhEcSNKeeB31BE4YBMyQCMlX0CE/buAF+tm4jNdsVgXzHdEuLDRc4RSqJIupNM5sY1k5yX+49oU3umah/FhR6PJ+zKppZ/OLR9XUn9PmxJQYQHYB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMsmTIOvaSaZei9DHmzBuD5lpfBwzHRI4GY0hRu8ycU=;
 b=ewKexWVim6IIuR231LI/JsKMxmGpDXd9aJmQLv0c3AFRSppnyIy/oJCauz82wWu0M1lLQpQQY8Riyw06gQbY1ZcE8f2si9HQe9AQFnP2YmHJ9o0lvwPJ1niFAMwQGh0Z+mCSodSQB7cP0cfNUhKEAyJMjtv+SgAT5W704cMxiRUmSmYFSygvEexgy6Klle/f1/zqfdNRu4UaNYK91YnJUrkKF4G1x7wZ6H9eP0zZ+n2cZuuSmU15Eeq5MFuaQJYbQMeB4VNjnoncdCT2wKdwSMoWLKZBEVv/xZ+HUEJZb3QQgB7QmtsShT08swlJYsb036VkYiWpTQCNajquguGPfg==
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 08:54:53 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::40) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 08:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 08:54:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Feb 2022 08:54:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 00:54:51 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 9 Feb 2022 00:54:50 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <oren@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme-rdma: add helpers for mapping/unmapping request
Date: Wed, 9 Feb 2022 10:54:49 +0200
Message-ID: <20220209085449.40773-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1fc62d1-0044-4d71-65cd-08d9eba9d682
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB410185C2257453112EB208EBDE2E9@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0TqBY2oZOFMzg2tFjSw5L6ZOEX35TQ6AYxz6cObIKXfHACSS0k2ryOR0WarWYzYw04Yyk8DdBL7kxLFuJWhqJRQuX7G78NcFZdOEfww44H6MoraGYQZNDmtZ1MVXhEgG+5CUMKbotrmhlspmwg+zObWkHMdWuYXt9hK+PEX0+krUvfxjpPqRPJDUVdF8uRqkOG49hVfXR/L8bQFP7Ee2QJlejYxDhFcMvR5Ia+o1GKXiuLzt42/q14etGKVDEhvmd0xzFK6SnsOrORgHxe1d6EGdONi/+2FDN5Hmyfcylxr78fi+4woQm82BU8TAQYUN1M1CiI3ekQo4YIH+/M3ajQxURLU+hoOSmDrkDHjGHOmogFdYdC+cbgjCQmGSl8YrPWcNT/XJOFEQpV7I2HXK+9G6efqLh5Cp7BG5YV6+cK4+mfUIRLsilCGEG5FkL70jszZBpKHH7DZhc8jnfYn5NJoPq2uNsJVWfzh/0UBRMnw2r6aXYbsUzdOBvE6nUl7ygGfQoxSxNoKE8odQ3Lkdl+y4dCF+uV/jWiWMRf8fw6OXcDkocY+DDytYwzIJCEXm06Cp5mhKD1rIOwYmcdxGQs6YykIXFGQmZBfXbcycw3ZbRwn6T1EXr46eS8NAjcQeFjjZhH20zgIdCbLJEP/9a/fz3uj0O4cjDK1NKHpnT5+y0uUNYUORx6ggnIswKF1NuoY4+idDbnWEnPW2zymnQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(8936002)(4326008)(8676002)(508600001)(70586007)(70206006)(40460700003)(54906003)(110136005)(316002)(107886003)(36860700001)(5660300002)(82310400004)(26005)(2616005)(186003)(1076003)(2906002)(83380400001)(426003)(47076005)(336012)(356005)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:54:52.8631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fc62d1-0044-4d71-65cd-08d9eba9d682
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_005456_676042_0EC453C6 
X-CRM114-Status: GOOD (  14.00  )
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

Introduce nvme_rdma_dma_map_req/nvme_rdma_dma_unmap_req helper functions
to improve code readability and ease on the error flow.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 148 ++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 64 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9c55e4be8a39..993e3a076a41 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1283,37 +1283,6 @@ static int nvme_rdma_inv_rkey(struct nvme_rdma_queue *queue,
 	return ib_post_send(queue->qp, &wr, NULL);
 }
 
-static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
-		struct request *rq)
-{
-	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_rdma_device *dev = queue->device;
-	struct ib_device *ibdev = dev->dev;
-	struct list_head *pool = &queue->qp->rdma_mrs;
-
-	if (!blk_rq_nr_phys_segments(rq))
-		return;
-
-	if (blk_integrity_rq(rq)) {
-		ib_dma_unmap_sg(ibdev, req->metadata_sgl->sg_table.sgl,
-				req->metadata_sgl->nents, rq_dma_dir(rq));
-		sg_free_table_chained(&req->metadata_sgl->sg_table,
-				      NVME_INLINE_METADATA_SG_CNT);
-	}
-
-	if (req->use_sig_mr)
-		pool = &queue->qp->sig_mrs;
-
-	if (req->mr) {
-		ib_mr_pool_put(queue->qp, pool, req->mr);
-		req->mr = NULL;
-	}
-
-	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
-			rq_dma_dir(rq));
-	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
-}
-
 static int nvme_rdma_set_sg_null(struct nvme_command *c)
 {
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
@@ -1522,22 +1491,27 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	return -EINVAL;
 }
 
-static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
-		struct request *rq, struct nvme_command *c)
+static void nvme_rdma_dma_unmap_req(struct ib_device *ibdev, struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_rdma_device *dev = queue->device;
-	struct ib_device *ibdev = dev->dev;
-	int pi_count = 0;
-	int count, ret;
 
-	req->num_sge = 1;
-	refcount_set(&req->ref, 2); /* send and recv completions */
+	if (blk_integrity_rq(rq)) {
+		ib_dma_unmap_sg(ibdev, req->metadata_sgl->sg_table.sgl,
+				req->metadata_sgl->nents, rq_dma_dir(rq));
+		sg_free_table_chained(&req->metadata_sgl->sg_table,
+				      NVME_INLINE_METADATA_SG_CNT);
+	}
 
-	c->common.flags |= NVME_CMD_SGL_METABUF;
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
+			rq_dma_dir(rq));
+	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
+}
 
-	if (!blk_rq_nr_phys_segments(rq))
-		return nvme_rdma_set_sg_null(c);
+static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
+		int *count, int *pi_count)
+{
+	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
 	ret = sg_alloc_table_chained(&req->data_sgl.sg_table,
@@ -1549,9 +1523,9 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	req->data_sgl.nents = blk_rq_map_sg(rq->q, rq,
 					    req->data_sgl.sg_table.sgl);
 
-	count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			      req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(count <= 0)) {
+	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
+			       req->data_sgl.nents, rq_dma_dir(rq));
+	if (unlikely(*count <= 0)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
@@ -1570,16 +1544,73 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq->q,
 				rq->bio, req->metadata_sgl->sg_table.sgl);
-		pi_count = ib_dma_map_sg(ibdev,
-					 req->metadata_sgl->sg_table.sgl,
-					 req->metadata_sgl->nents,
-					 rq_dma_dir(rq));
-		if (unlikely(pi_count <= 0)) {
+		*pi_count = ib_dma_map_sg(ibdev,
+					  req->metadata_sgl->sg_table.sgl,
+					  req->metadata_sgl->nents,
+					  rq_dma_dir(rq));
+		if (unlikely(*pi_count <= 0)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
 	}
 
+	return 0;
+
+out_free_pi_table:
+	sg_free_table_chained(&req->metadata_sgl->sg_table,
+			      NVME_INLINE_METADATA_SG_CNT);
+out_unmap_sg:
+	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
+			rq_dma_dir(rq));
+out_free_table:
+	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
+	return ret;
+}
+
+static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
+		struct request *rq)
+{
+	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_device *dev = queue->device;
+	struct ib_device *ibdev = dev->dev;
+	struct list_head *pool = &queue->qp->rdma_mrs;
+
+	if (!blk_rq_nr_phys_segments(rq))
+		return;
+
+	if (req->use_sig_mr)
+		pool = &queue->qp->sig_mrs;
+
+	if (req->mr) {
+		ib_mr_pool_put(queue->qp, pool, req->mr);
+		req->mr = NULL;
+	}
+
+	nvme_rdma_dma_unmap_req(ibdev, rq);
+}
+
+
+static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
+		struct request *rq, struct nvme_command *c)
+{
+	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_rdma_device *dev = queue->device;
+	struct ib_device *ibdev = dev->dev;
+	int pi_count = 0;
+	int count, ret;
+
+	req->num_sge = 1;
+	refcount_set(&req->ref, 2); /* send and recv completions */
+
+	c->common.flags |= NVME_CMD_SGL_METABUF;
+
+	if (!blk_rq_nr_phys_segments(rq))
+		return nvme_rdma_set_sg_null(c);
+
+	ret = nvme_rdma_dma_map_req(ibdev, rq, &count, &pi_count);
+	if (unlikely(ret))
+		return ret;
+
 	if (req->use_sig_mr) {
 		ret = nvme_rdma_map_sg_pi(queue, req, c, count, pi_count);
 		goto out;
@@ -1603,23 +1634,12 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 	ret = nvme_rdma_map_sg_fr(queue, req, c, count);
 out:
 	if (unlikely(ret))
-		goto out_unmap_pi_sg;
+		goto out_dma_unmap_req;
 
 	return 0;
 
-out_unmap_pi_sg:
-	if (blk_integrity_rq(rq))
-		ib_dma_unmap_sg(ibdev, req->metadata_sgl->sg_table.sgl,
-				req->metadata_sgl->nents, rq_dma_dir(rq));
-out_free_pi_table:
-	if (blk_integrity_rq(rq))
-		sg_free_table_chained(&req->metadata_sgl->sg_table,
-				      NVME_INLINE_METADATA_SG_CNT);
-out_unmap_sg:
-	ib_dma_unmap_sg(ibdev, req->data_sgl.sg_table.sgl, req->data_sgl.nents,
-			rq_dma_dir(rq));
-out_free_table:
-	sg_free_table_chained(&req->data_sgl.sg_table, NVME_INLINE_SG_CNT);
+out_dma_unmap_req:
+	nvme_rdma_dma_unmap_req(ibdev, rq);
 	return ret;
 }
 
-- 
2.18.1


