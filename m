Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F907C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7bu+qhUErBiPIjkmJVSFb8IDWQ6RlFPsskdKG1KrvYo=; b=zdsJaU5KN30q6YUgtxiIhTpCoa
	Euz1d56rsHfOZsAkmZNE4SCMnifgtkuZ64NnkFDVZjRWcPYgtUKlczVKzT3hbQAaOrTBQUeQglHTJ
	d9cR3Gg4sq0F2Os+kdHWcszeUy4zyzp8pzNF0xV5IhGUqNK1B955agPf8ToEcmdRHOd2F0Sd61IyC
	O659hxdag8EnTHOfOjKlUWU7CnwIJInHmcSspSF0uxQLQmSbPnggUYdIqrebXrThLLbBKWWfQu28T
	ODAIkzi7RnayL2FyD/A+Ybx/4tC43t4GqZYGhzRxFGPV+XOkSmIFTis3d1Xa2UWpzkfqDiE8qRKrU
	Dw29alcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkJ-00CVu1-0v;
	Mon, 22 Jan 2024 14:57:55 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkC-00CVnT-2p
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrvV76oL3hKoiYCaesqlobJkNgi+B2PYvh6nwkZXGuYR2k6m/Bx5V8hNZPPxBRMFSmmkqNlP1o2uYlIDlI+LI50p9RxU1rRx1OP8cKYKDaw0+++o6PQ4asDOer6BQkIc1VrGrzrk4I6WCC7fQ1DrwgHUwgkZfAZUMMf6Ll/xcHmIdyCTEheLpA9QFppzptHdKtFRqSekI6xzRVDppLvrSj4MXt+6EcvwydfhY8zQ9Cj5DZLJIADJygIhfU8XRo4efDsEeDAqtZnxxzotu8oK7zfvXnyMAD8+FqsqsrLAL4dpn0+bUOkaLL2RKBYxIBFgXknT2kPSQ1vH6BcCixQByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bu+qhUErBiPIjkmJVSFb8IDWQ6RlFPsskdKG1KrvYo=;
 b=K5055gPy8z0bdejKc+GxwOB/QX2/JguGUuvjiXYGjvgsTispIda+ZEew5VC6jqvl+9BNd1B+SjxfgmyUmZ3GgnVUNrUnUgbQQeH5pEqRjdW191PGH99rvVQpR7tjkEo/a+pjUgyrvTT2NlfEq9SxLuUw9uAOpfuWfObmLcT/hD6vUh5IHeqBZeK6cMUeLyq+2iHJJje646bBF1wyM/pdQJXyXNnplolrRJVS/gEHeXyTv3Yju2NrVV+qJ9HaDzI9JWP+ocKJ1wC1y40cbbLsr9S/3UtVXnIV7Nktc1+EXEikbVwXi4LOIyQDHwH+wRoCmrIbzoupjHKxInf56pw4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bu+qhUErBiPIjkmJVSFb8IDWQ6RlFPsskdKG1KrvYo=;
 b=ZlzlB8NlZI0JREqi7Fib44dr9e+C/Yv+AFmX6Lflg16TAzJvjnKCC7jBC0rTvz7BrMOs6+QpqF+utAGWo66BZEpmO+dwYJZizlt5Op0XK7hiTJG9hFReu9EPBpEYm5d2pBt2As1KMcJqVn1fWMfFc0JotGkuDQu4yo7/S9F/9qi0oo65Gw8+8LCGQvq0D/aTF7nqD+3wl/6lSzXGiidDrqRHrTwksiSk9pSoUkOA7S/7Um0fUcb3Kc9S6/XMt8KPWx/I0+UALZ6Bagf/YUgc3asvU64Hdm31U1rWFA1xreV3LZyEWA1ZYQXBaSvj2ltf/WrzyNaRjHYgO+z2GFvhMQ==
Received: from CY5PR20CA0022.namprd20.prod.outlook.com (2603:10b6:930:3::15)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Mon, 22 Jan
 2024 14:57:39 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::44) by CY5PR20CA0022.outlook.office365.com
 (2603:10b6:930:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:19 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:17 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 6/8] nvme-rdma: Fix transfer length when write_generate/read_verify are 0
Date: Mon, 22 Jan 2024 16:56:57 +0200
Message-ID: <20240122145659.5574-7-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ff0125-67fe-42cd-d5ac-08dc1b5a7a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG8XmKD5K7NqpR2Jx1M63wwA3BgyNlsmxfGrxlbwz+grP/F9wpuabm1XNy3UeEvhi4aWcZMg2KJN4paZNLpzD9u0E42aIvnV9dUwHg6ioLlMPLNy2mrOn7jv5RyC55GVr7sWMmSz4z73HnvZPmwR0Mhq9EMCF3Qpv9W6aa1pT4AjT9tGbbJ4IcNlizypY9c2E7vEVQHFRvzZU/qTNhMhWhtE1k/zj95FF2UZcSzJTR3s5CjpODIfx0YTooUeAwfTeevwNVJybvtCus2bj6EfFlsNmgfJ1iIvlafHmZwbHDZWQpYV8usM3leyqxuZiudn0UdfDWPBTpo0476RqJbnvbAlXv/abnQgimK67OUlNFDhrgUFW0vuwZf7D79jbpyp8cRULrwt3CwFMBSSdEwTR3ZqCAsisjN7Dhi73YJ+qMPVRCgy+pWfFlEXdtN/wAUR5f9ODOMq6t9JUMoIvLdC0YVUemR7QpK+KgYzq7ONMIiet+N699zmt8q4CG5/ZByspc6VSZmivddXi7UnhCLYPNUlILaBKr0PcNitph7qBAv3xPubUh8HZ3hIBPovRtFFIJOMVdhW0HRFONkhEskHDUU5ucgrCMrMek9zlgsJG4bRAnye3OQZyk3bJNJ1i85r6vU7YiY5EoTmPjq5Hrey4ixqcwhbiSUJHZxprzMFlrRuPi4SeYKOMOTIaFJIxX8yuxEERDjD8hfuIhSYz9x8hL1YrcYCwQbe8dPKPd29Wtk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(356005)(7636003)(82740400003)(36756003)(40460700003)(40480700001)(86362001)(1076003)(107886003)(426003)(26005)(2616005)(336012)(36860700001)(478600001)(316002)(8936002)(70586007)(8676002)(70206006)(54906003)(110136005)(6666004)(47076005)(83380400001)(2906002)(4326008)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:38.9535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ff0125-67fe-42cd-d5ac-08dc1b5a7a37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065748_925410_69787B5C 
X-CRM114-Status: GOOD (  13.28  )
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
index 2e77c0f25f71..a380bafbed08 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1405,6 +1405,8 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct bio *bio = rq->bio;
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+	u32 xfer_len;
 	int nr;
 
 	req->mr = ib_mr_pool_get(queue->qp, &queue->qp->sig_mrs);
@@ -1417,8 +1419,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	if (unlikely(nr))
 		goto mr_put;
 
-	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
-				req->mr->sig_attrs, ns->head->pi_type);
+	nvme_rdma_set_sig_attrs(bi, c, req->mr->sig_attrs, ns->head->pi_type);
 	nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
@@ -1436,7 +1437,11 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
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
2.18.1


