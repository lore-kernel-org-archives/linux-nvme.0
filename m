Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83928C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ftpkiRbYJhYy156Owpysm49zaZUW1dhX0qGheELCyC0=; b=G+LSYdnTLb4rAKQwoprppc75/c
	BvTy+4EFTG2fx/HC7wKGUFtOamifleR6KXx2Oc5Xx2iXpyPOerl8nJs7p955rUy8LfyEhEBtjJGge
	kMrQpq4EpfXLTZH+8MiJdKVK7dIbPIRlQX4OD5WSiMAtvQVG7dgI7DmsNT5EJvQFOuF6BnTQwKz8g
	KzV/5cjmFZ7udpNmIJ8OWG2zq8Ao/PQnYs5mO/E/qt+63h8eW+tecPUCoJ5qrt/54Atec17ypOge0
	RVIPunWSfxszOI3WibzQu04rVqXSSp7U+j4pv1l6OUDi7LxftNX8Ojjhl7o3q+5DewhrmpgOUIbig
	6fAhHULQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6UIU-001Lvz-0R;
	Tue, 06 Jun 2023 10:52:18 +0000
Received: from mail-dm6nam10on20603.outbound.protection.outlook.com ([2a01:111:f400:7e88::603] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6UIR-001LvN-0l
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 10:52:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjfOMpboaJRHKPDe+QShLg7JqMtYNu/asZzNQf5J5KUwP3N5QAqiTTTIoDoFXGJUY732KOGFIvQi9JQ0jF7LBJywFm8lMak23Q49PJgSXK+1/03orcQGSVh2ghZ9BUI58bhNB2be2tKJdKpFki2Kgp6FvfnQrR1z0gO/5Js34kx9ckx/4oBgYKs2E4glGJ7+dxd0Wfmx0c5cTGjhCfOoWPHHj0kbXFJO5pWMYnxznMWJnH/F7gBTZYNGeRfpplW3B89BbyWGv0xKOEX2BbCHn5o1FXl3IdUiiQ6OyOdMrhaxDXGKYQLTJCKaueP4QlVaVM3337X3U5/9o5IhDQ1H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftpkiRbYJhYy156Owpysm49zaZUW1dhX0qGheELCyC0=;
 b=WMlneXa72G2UvUjelTCB6qSPH2rJm1FKHsuUnywo2FHRSAkIPKxCbnmWOth9V3RFKpBDO9UHa5HJYGdN3QEoIvrWG5YOffi/6UdcanereDeCtKYAP1ZClYU6bi1Groq5m7P2Zq0avFdLgcqpCysKqbwYKlxDf2CCeLuv/lZeEQcjy221kLLkdzM2DAZVZjT1ucdijAf4PisHGnvNbgoH1fWDYbnLt9BbPIG1b2gWdQO0UpaV7bQxG/OGuBkgoOt29FOMByfeSQBcid9cxhj9W1wMzMGYyplq10AXLbfyVsausvBGpcq9mYARsN5x7b+C1cyIMWTYJ3ecu4JI2qNOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftpkiRbYJhYy156Owpysm49zaZUW1dhX0qGheELCyC0=;
 b=gSa6yc4NGdmRdJEKAu2yT7VrC2Eu2LndplWp4a6Ue1q+nZ52uYKUtTithzBax1T9mXAG5aFFwxErW4YxYNbjbXOoG+7/lnbofCf4I28eRHMPRAmT/YZ7dvzED8htk/F7+Q0nDdzc0qONNJq8T/YX1nozXHhV4Sp7970Af3lpEO4tvdPeuPc9VbNTOFrRw3S0DuHB/PSdfPS9yKnSod/n0pIEg49l92GU/rLWfvnElIY/dvU8d8oBWeoGupCrW9p4lj8N4NVcV6yF5AghQGSr9pC9g/yl2bNw2s+t/0zlfFp6N86MxrEPokf8KTe9oz8AswSgSDevwxo6L7xITHk/7g==
Received: from DM6PR06CA0076.namprd06.prod.outlook.com (2603:10b6:5:336::9) by
 MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:52:09 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::7a) by DM6PR06CA0076.outlook.office365.com
 (2603:10b6:5:336::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Tue, 6 Jun 2023 10:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 10:52:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 03:51:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 03:51:49 -0700
Received: from rsws50.mtr.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 03:51:48 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] nvme-rdma: Fix T10-PI when SW doesn't generate/verify metadata
Date: Tue, 6 Jun 2023 13:51:30 +0300
Message-ID: <1686048690-374365-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: e2dff3d6-927b-4f7e-e6ef-08db667c1364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAPNp9Kz0tWudpBtgvOeUnGg0fqBYiM8ilY96J2simrIuyQSnSZWRakL5n8Y5EEE6GDzedWYwqfzb9AMaoWe49xQYSuF7el13sN5IfKdY4cKmsesy1UBMw3nquRGavvQQ90hVGO93HQgLpefIUHhJ9GMKqLdmMxUo4014xcrdVJmNTu+3aIEK5d72vcNrUoRKwDBl04STadnhz7hbJSLgMoZ3cx4bjLiOTDNyg5m4AZiOsFXOCWs+2cT0jGELVH5hJol6KQUwViieIPGpbh2Ds6lGPyNx3WMBFkqZfUc593AGW/0TYEbkpZTpf3ZV54y/DPs1WGCmumFZ3Iip81BsGpzKL8DNQZSFhIX5nW0WFnhdqC8R+Rwm01tKrq3lfAi04kXU1O84t4F/odGLS5XpkGMT8hhe0jV3xTCSFoVv8of3ef2fepprceYdPRXf+CIXOlV2Fb40v+bNT1QlbeEex5Qw90Lr5lu+k1RCgR0oAlEyXicmFUUliy8Rua8eedTGKNNdW6LTvxO8C0xY3GW7sWUnQ9d7KHRsJXF9/mLe+TkFUKVp05AY3CTL1nIFrWkkl5DP7aGhDsuwBIuwtCfxkc39gH8XE7vdKWPJBA14o15gsmpnyzUDRnGocPWWzgqpkY0c+sBocqbahJfKwfuZtL+Ti4ud0mh2gwNhbJEmCYb8wdYUgfMThnysIk+45IuncI+ve0VX8abLTK8NX2NqXj7oiGiCow3yChAY0IIukE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(110136005)(40460700003)(40480700001)(478600001)(8936002)(8676002)(2906002)(36756003)(15650500001)(86362001)(5660300002)(82310400005)(4326008)(316002)(70206006)(70586007)(7636003)(356005)(82740400003)(2616005)(41300700001)(107886003)(26005)(47076005)(36860700001)(83380400001)(186003)(6666004)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:52:08.9008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dff3d6-927b-4f7e-e6ef-08db667c1364
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_035215_340342_4DED1183 
X-CRM114-Status: GOOD (  12.14  )
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

When the SW doesn't generate/verify metadata, the SG length is
smaller than the transfer length. This is because the SG length
doesn't include the metadata length that is added by the HW on
the wire. The target failes those commands with "Data SGL Length
Invalid" by comparing the transfer length and the SG length. The
commit fixes it by adding the metadata length to the transfer
length when there is no metadata SGL. The bug reproduces when
setting read_verify/write_generate to 0 at the child multipath
device or at the primary device when multipath is disabled. Note
that setting those to 0 on the multipath device doesn't have any
impact on the I/Os.

Fixes: 5ec5d3bddc6b ("nvme-rdma: add metadata/T10-PI support")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..8bbf38918dd3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1435,6 +1435,8 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct bio *bio = rq->bio;
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	u32 xfer_len;
 	int nr;
 
 	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
@@ -1447,8 +1449,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	if (unlikely(nr))
 		goto mr_put;
 
-	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
-				req->mr->sig_attrs, ns->pi_type);
+	nvme_rdma_set_sig_attrs(bi, c, req->mr->sig_attrs, ns->pi_type);
 	nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
@@ -1466,7 +1467,11 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 		     IB_ACCESS_REMOTE_WRITE;
 
 	sg->addr = cpu_to_le64(req->mr->iova);
-	put_unaligned_le24(req->mr->length, sg->length);
+	xfer_len = req->mr->length;
+	/* Check if PI is added by the HW */
+	if (!pi_count)
+		xfer_len += (xfer_len >> bi->interval_exp) * ns->pi_size;
+	put_unaligned_le24(xfer_len, sg->length);
 	put_unaligned_le32(req->mr->rkey, sg->key);
 	sg->type = NVME_KEY_SGL_FMT_DATA_DESC << 4;
 
-- 
2.18.2


