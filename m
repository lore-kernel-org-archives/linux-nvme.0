Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D43C4708F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 16:22:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C006610CB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 16:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C006610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=phMdDnBkYS133J5x2mmjmsBfu0HaHqpAft8ExgnLH7k=; b=wBDmbAiZzcc5FR
	7vDisKT1uGEWUKzjN4XuECzWaN69omddWk2EwQhafjDEVikMMBfbk4o5e3tVBaM/jjNy2MaJw6wUz
	eClAryMxjb3tx4zbH4whXP0NXv9Uxm84E7e7UsDX8HRx+Ez9VsDhgkfNoZWnq03Jrfud9Uxh9LZ+r
	UPBCFW8g4Qcp+0rZIKHV38urGqfpzMaVm7p03+iiUGp1NA1EmL/E1n7L0z4pwveHXekourQ9BJsJi
	juI//GeboMvakNItFiFoH7A6g72/BhFnxQPPUtpJsDjYElgsSiWgRBCyT0Ensbk0qnSOh/ED1B2Yf
	vRoVsE9/VQtgW37fgLAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo79p-00HUUc-8Z; Tue, 01 Jun 2021 16:22:21 +0000
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com
 ([40.107.244.85] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo79m-00HUTw-Ct
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 16:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjWgdQcXKOIfzJ9htANlmndiGqAJy4NbYjZPn1WhiAfydYWBrNMfdXjXDz/apdCr95mjvlkHXaZvV/T5Jx3IIAJFhyPTJr6h5MCRg1ySW1X3jWrnYby6gEo9lOx4IjetT3gdQrB0IDTbcJkzKg89gOJWdJorqnYT7C3hbnfFk+Ce7CSlz1u6kGdgOnrtR4EICgIcjqXIyzaDsejNFRljhkQ/mS0bp3+Xz1bXp4xX3uPfXIjKxfafR0WNu5a1UapbN09UMZb6/8MmmZMhAlaguKxDyQZ1Q4PNRdi9pjKHjEcTKmyLEMpHzVWAHHtbY3JPLgyoEkA92kSRsLm8uB1Gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYfUfSZ21pKCy1OrBpkSgqGr7iJzHTyf5zeIb/xcQmw=;
 b=K3uRdF51ho6U6lMY+FuAx2/uYicGvymlKWmxmoAo8HAzOXdlvSLm/eSLXOjAvBhec5QVC+hJ7CvaRIEjWyhFJvX6sl/iYl30vnsGRxBLTqjP5tHNmc23rVr1jCzG4aA4UZAormwwtbKpXMwTQCKKxhBrwTzoUSvgPRbsd900U+4RTlPAZUB4Q+PzdFsn2QON/l63T2n068xnXxAfFFOKCrC7UnA6MUwaeTFj22/xrr1lRIjQlLCbATzbX2zRZIG1m96JILaxXNIzQfosAQQ01rAwvX1qtG4K0BrMoaBr3Da8eNwjeFm5dvzXtI7oxqRxx/RVHfkwBvMLEflOATdTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYfUfSZ21pKCy1OrBpkSgqGr7iJzHTyf5zeIb/xcQmw=;
 b=JxsW9O8spDfKiTohY6qa5gwaf7kHGNBr3MSJ5GeGvg8u9Osi2cMSffgdH8c3q7PPrMwN8F74Cxx//Q8LWVKs69GkJlrSB+uzfT5zFaRLM0/FkEXGfcsPn/OhY0/YGdzilyaEXX7J/HhgfoAtPR+0pIsVIx9ByJ/y06Zdp5Arr7VFbENpPLFvtKK8BlkI8lWhywFBOrinKsMznhHoenTXD2QXQcT2DYO9B5IngyFyOdRIR1SKNKuQcaVwWTDEldTS6/wON+RRoOxkjM1g9ISSVLBFoRrfKr8gBMKK4XmRJicn904ZvMPUn6n67lq9fUBn0M0B6HAU/xQ+HXz94qsM0Q==
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by DM6PR12MB2665.namprd12.prod.outlook.com (2603:10b6:5:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.28; Tue, 1 Jun
 2021 16:22:10 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::cf) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Tue, 1 Jun 2021 16:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 16:22:09 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 09:22:08 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 16:22:08 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 16:22:06 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <logang@deltatee.com>, "Max
 Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvmet: fix freeing unallocated p2pmem
Date: Tue, 1 Jun 2021 19:22:05 +0300
Message-ID: <20210601162205.38326-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5946623e-99ed-4f67-c1fd-08d9251967e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2665:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2665C5E03E85FC05715151DADE3E9@DM6PR12MB2665.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUzCGi+Rtwg/5DtwE9TXIgewVh4obvK2ZvbXpGyrC3m2dkUrlKtxLeIkIhXxxfkWiLYhVM6Gc2gzYCGc4yTnZbG36hZBUGkE+Tib2Vpy4XvX8vdtXY9XNNY0Vyrc3Y36dT47LBOc2dOM+K5oWn0caGFOf9kwm8UlliL/7cggFFX24lN1L+RiJbcfZR7ceATBoWuGrxGTHMm1szaEa6T0nueGUt1nlkYQCCIbdRGm8Djc3SrSPgmyW54fXwIElDPrcignH5ejZ8EjVhLSX8pwmzP60nG7DKkrPNi+nIOUw41ZzDxptvpTpbzt0+WINLLiY4P3lfuf2FQ5qp3c+O2oWsloselJifqPlScRzv1z1zJDXthgXAmGE/8kEpJVG3WsHjQZMgfrenzgizXpMEU0k/ELwBSAkOgThlM+W6XGMDy7LSVmxR9bJHflk1Hcr7GzvMeBTPHgIrnXj2p9FsH6XSpdr7KNaPrITk4XRBa5mOilT3AeOC4V2HYsxW9v4/WyG93JQO2a7HkWsi24/AytqaxH/pN5q3OZyncdgUfeWzPyMCANlaxiFI1VyG1hKwI09KzGFr6VkyBC9aEL+rxIIKtRAH2CwZeM9Q4to0bOXv4eQ8ObVlPMYk6Zte4FgHUKVyBBsxKlzsCTkwmuh4gSyPCte6HxeyHaoy++i1rv+1o=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(186003)(356005)(7636003)(83380400001)(36756003)(8676002)(107886003)(5660300002)(82740400003)(70206006)(86362001)(70586007)(47076005)(426003)(2906002)(26005)(36860700001)(336012)(8936002)(478600001)(4326008)(110136005)(54906003)(2616005)(82310400003)(1076003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 16:22:09.5418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5946623e-99ed-4f67-c1fd-08d9251967e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2665
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_092218_524242_51ADD6C8 
X-CRM114-Status: GOOD (  15.12  )
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

In case p2p device was found but the p2p pool is empty, the nvme target
is still trying to free the sgl from the p2p pool instead of the
regular sgl pool and causing a crash (BUG() is called). Instead, assign
the p2p_dev for the request only if it was allocated from p2p pool.

This is the crash that was caused:

[Sun May 30 19:13:53 2021] ------------[ cut here ]------------
[Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
[Sun May 30 19:13:53 2021] invalid opcode: 0000 [#1] SMP PTI
...
[Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
...
[Sun May 30 19:13:53 2021] RIP: 0010:gen_pool_free_owner+0xa8/0xb0
...
[Sun May 30 19:13:53 2021] Call Trace:
[Sun May 30 19:13:53 2021] ------------[ cut here ]------------
[Sun May 30 19:13:53 2021]  pci_free_p2pmem+0x2b/0x70
[Sun May 30 19:13:53 2021]  pci_p2pmem_free_sgl+0x4f/0x80
[Sun May 30 19:13:53 2021]  nvmet_req_free_sgls+0x1e/0x80 [nvmet]
[Sun May 30 19:13:53 2021] kernel BUG at lib/genalloc.c:518!
[Sun May 30 19:13:53 2021]  nvmet_rdma_release_rsp+0x4e/0x1f0 [nvmet_rdma]
[Sun May 30 19:13:53 2021]  nvmet_rdma_send_done+0x1c/0x60 [nvmet_rdma]

Fixes: c6e3f1339812 ("nvmet: add metadata support for block devices")
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4b29a5bac896..8afbb989b828 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1005,19 +1005,23 @@ static unsigned int nvmet_data_transfer_len(struct nvmet_req *req)
 	return req->transfer_len - req->metadata_len;
 }
 
-static int nvmet_req_alloc_p2pmem_sgls(struct nvmet_req *req)
+static int nvmet_req_alloc_p2pmem_sgls(struct pci_dev *p2p_dev,
+		struct nvmet_req *req)
 {
-	req->sg = pci_p2pmem_alloc_sgl(req->p2p_dev, &req->sg_cnt,
+	req->sg = pci_p2pmem_alloc_sgl(p2p_dev, &req->sg_cnt,
 			nvmet_data_transfer_len(req));
 	if (!req->sg)
 		goto out_err;
 
 	if (req->metadata_len) {
-		req->metadata_sg = pci_p2pmem_alloc_sgl(req->p2p_dev,
+		req->metadata_sg = pci_p2pmem_alloc_sgl(p2p_dev,
 				&req->metadata_sg_cnt, req->metadata_len);
 		if (!req->metadata_sg)
 			goto out_free_sg;
 	}
+
+	req->p2p_dev = p2p_dev;
+
 	return 0;
 out_free_sg:
 	pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
@@ -1025,25 +1029,25 @@ static int nvmet_req_alloc_p2pmem_sgls(struct nvmet_req *req)
 	return -ENOMEM;
 }
 
-static bool nvmet_req_find_p2p_dev(struct nvmet_req *req)
+static struct pci_dev *nvmet_req_find_p2p_dev(struct nvmet_req *req)
 {
-	if (!IS_ENABLED(CONFIG_PCI_P2PDMA))
-		return false;
+	struct pci_dev *p2p_dev = NULL;
 
-	if (req->sq->ctrl && req->sq->qid && req->ns) {
-		req->p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
-						 req->ns->nsid);
-		if (req->p2p_dev)
-			return true;
-	}
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA))
+		goto out;
 
-	req->p2p_dev = NULL;
-	return false;
+	if (req->sq->ctrl && req->sq->qid && req->ns)
+		p2p_dev = radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
+					    req->ns->nsid);
+out:
+	return p2p_dev;
 }
 
 int nvmet_req_alloc_sgls(struct nvmet_req *req)
 {
-	if (nvmet_req_find_p2p_dev(req) && !nvmet_req_alloc_p2pmem_sgls(req))
+	struct pci_dev *p2p_dev = nvmet_req_find_p2p_dev(req);
+
+	if (p2p_dev && !nvmet_req_alloc_p2pmem_sgls(p2p_dev, req))
 		return 0;
 
 	req->sg = sgl_alloc(nvmet_data_transfer_len(req), GFP_KERNEL,
@@ -1072,6 +1076,7 @@ void nvmet_req_free_sgls(struct nvmet_req *req)
 		pci_p2pmem_free_sgl(req->p2p_dev, req->sg);
 		if (req->metadata_sg)
 			pci_p2pmem_free_sgl(req->p2p_dev, req->metadata_sg);
+		req->p2p_dev = NULL;
 	} else {
 		sgl_free(req->sg);
 		if (req->metadata_sg)
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
