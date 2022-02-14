Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C132C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q7HGuicNMnqx7fyQXfFjb95xggj3/IZVbSIYZHCqQhc=; b=tGFPy6pfuQck9gXrf+Qu8+6Koa
	0XFeeNFmPOf5ODf6yQtYzL2QGqjOD6dV/XgkDJW5E43zQs7Lx1KhWXh4bHzXVp4D5Hhmvaje9wY5n
	AW4wks/uIDQpgyg1zTTenPGJuSCv3KDRSIpUoKYZBPoQBYc8HQC1IzGsL93j2X15dbhq0KTBPl2jj
	FZWdMj86aBUYdAkfZ0umapJYo3kXC0aKxdjhNl6YizBnekl+clzWsh33nfh/y/lPkGS8HPJWSs8Bo
	TJcWFax1ZrLb5ry6Q/IpntTZkZSXkbEfIhfixaPiJ1H5gz61zj875ubUETzXjr8+zvtQTVOartPj/
	Z1xpL9Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZBl-00EhNX-Ks; Mon, 14 Feb 2022 11:06:38 +0000
Received: from mail-bn7nam10on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::61d]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJY6j-00EMvc-PF
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOokzn/QaM3zSQ7IfcJQEl6io2VZ2bmAIxpkQG4RepzTRxWydKlpocn0U3h+e0M5ww/GBqISSD642WQmgi/HB5E4RAtxAPdTa0Cx5Bn5cF0l58lJ8EyLWyShEMyfwnLHCVHWRijNTrcWhUKQpaCVSAZn9i+V19thgrSXfbDQPQq/Dip0EbMnhe+D5yaPDbCu6n8DfDbDPTs8BZoUfI0yMHRN+WOVGdn+JxVrPHi5TqxLwmaZcoX2K7bp3Rf1ZN+QNHyROVPtps1Vt6zVXzdM91QVnZ7kox0uQ7POw0CdHMpTNlSQyNib3AWhBYN12kD6LUrFFxXk+hgUDbPbY+xTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7HGuicNMnqx7fyQXfFjb95xggj3/IZVbSIYZHCqQhc=;
 b=JgVvwAXDiGRZCY8F8o7l5o1tXZGqgURuFJA2ctXrwn1GJDpwQUdSb2kCGUHvQL+PJR+hLYYoJLC+mFgxpW+XPaR16Nimfx67rS5BE/UrLLT6dPi8NJXZPwD3s/XsmHlk4eJc0dNt6FCDykItPmFSElcIeQekHljsbQwYGjwWk7NE94JvEjGD1ujBNFWtp/P0T3oSGkoJ4X57j5rmuloxCoDgHAuK74B7ZdmUkYTLjg3zYrewzo8gsOd4T2mPjplEbGeOIeSbgnsJaU0kUFgcr23KqpgdL05m74mHUE1291PG5D2XrrHZld9J0c4TLLt7e/vH6T/h/pdtyL60UTFo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7HGuicNMnqx7fyQXfFjb95xggj3/IZVbSIYZHCqQhc=;
 b=rmr0rdRqLyixS/uy5zCBhXI2CDPlyN84bui62uwONLdydEBk/zQzmwwif5g58usbxAWVeNO3q2pP6BsXsk0Vi9G9iFALxYyHORx+pfWnM1OZ3NuFTLYYWXOFuD1PBB5j6PX1llqCC3q04d12vzO4fpZiu6bpgvgSobO77x/yJcNef5GiaP8K7gXleFzf5xI0/YLtAqPCZwcjUcvM4fi2ecNz3/9z1plrRmAlHLmGUQMe5q25J7strHgu2MoMBoZbyZs1tVs/CCzVtA5rCGevU29k4rfXj5R4fLvYpmF83nzdKcMoMug4NDF1qyIlLqrSrDqUbrST53pOXvhvlkcATA==
Received: from MW2PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:302:1::21)
 by CH0PR12MB5187.namprd12.prod.outlook.com (2603:10b6:610:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 09:57:15 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::86) by MW2PR2101CA0008.outlook.office365.com
 (2603:10b6:302:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8 via Frontend
 Transport; Mon, 14 Feb 2022 09:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:57:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:57:13 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:57:12 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 2/6] nvme-fc: use non-deprecated ida_simple_xxx APIs
Date: Mon, 14 Feb 2022 01:56:35 -0800
Message-ID: <20220214095639.5125-3-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea85d02c-8e6d-48e5-fb0e-08d9efa060bf
X-MS-TrafficTypeDiagnostic: CH0PR12MB5187:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5187C61BDDEBCC52ADA5E599A3339@CH0PR12MB5187.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjkdhFl7B9w8zoEtrEijQQQybAdTD6BrpqkWiY52PwhMSz3jXN5h03p247KyeuAH6UokqPOTVrLXzMOh++QQ0UdDwbdr4GB3u1vXtV4t/QQEgsCDPUyZpn0EtAzJfT0hRIRxOKERIrpwLhyIfwtXXwFvlPSt6eozTQeq3y9YNSR9zhU+j6va/exFYmjDcofvE18FifrJslKLBnp7P9/MTJmpwWE87fcOv8wGffvpardywSdpj3R/6l2RVplddKIILCgcKwapCSdBtAhFE7hmjRDT5PRJP+OxY4dHmlPhgQv6hPYD/gQymUv1jUtXzXfYr0I0vZVhKqtcLTULDdwtChEpqPWg3SqQJnMp6Y0Ls4sd7qxw03fkPMDSrn/W6tV0pBdYoCghgSQGhwhMohktH2b+1nrVQW+1kDxKY4YXb9OCrAHFXasR4rV19lcC9kf9c1L1HURDjjASeZw+EEw1OmsRmcuUN8xwm+WOUUceqnwFREe9DesVIVI43U8n/LOjhLBLVlJ+U2wMPZlABzQK2zigRhqULBUqnN+ZRaDQpxQFB8TYjI4DvSCVE6DtdkrlJx1H5sZEHwfzj51FGyEljASRCVut3n1DFN7eD2PdofAdaug6ImGIFiDjCt6srNGkQkclGuzLTFSVub5I0j+6zvCXpCHsosHxPJZLniaVufWqIv0zB7J/seIIa74kysQaplw8mvbXO/YUEWlgMC2srQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(54906003)(6916009)(47076005)(316002)(356005)(36756003)(8676002)(4326008)(81166007)(82310400004)(70586007)(70206006)(36860700001)(2616005)(7696005)(508600001)(6666004)(83380400001)(26005)(1076003)(107886003)(16526019)(336012)(426003)(186003)(8936002)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:57:14.5542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea85d02c-8e6d-48e5-fb0e-08d9efa060bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5187
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_015721_874687_D178620F 
X-CRM114-Status: UNSURE (   8.23  )
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
 drivers/nvme/host/fc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 23c896a138a3..080f85f4105f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -259,7 +259,7 @@ nvme_fc_free_lport(struct kref *ref)
 		complete(&nvme_fc_unload_proceed);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
-	ida_simple_remove(&nvme_fc_local_port_cnt, lport->localport.port_num);
+	ida_free(&nvme_fc_local_port_cnt, lport->localport.port_num);
 	ida_destroy(&lport->endp_cnt);
 
 	put_device(lport->dev);
@@ -399,7 +399,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 		goto out_reghost_failed;
 	}
 
-	idx = ida_simple_get(&nvme_fc_local_port_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&nvme_fc_local_port_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_fail_kfree;
@@ -439,7 +439,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	return 0;
 
 out_ida_put:
-	ida_simple_remove(&nvme_fc_local_port_cnt, idx);
+	ida_free(&nvme_fc_local_port_cnt, idx);
 out_fail_kfree:
 	kfree(newrec);
 out_reghost_failed:
@@ -535,7 +535,7 @@ nvme_fc_free_rport(struct kref *ref)
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	WARN_ON(!list_empty(&rport->disc_list));
-	ida_simple_remove(&lport->endp_cnt, rport->remoteport.port_num);
+	ida_free(&lport->endp_cnt, rport->remoteport.port_num);
 
 	kfree(rport);
 
@@ -713,7 +713,7 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 		goto out_lport_put;
 	}
 
-	idx = ida_simple_get(&lport->endp_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&lport->endp_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_kfree_rport;
@@ -2393,7 +2393,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	put_device(ctrl->dev);
 	nvme_fc_rport_put(ctrl->rport);
 
-	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
 	if (ctrl->ctrl.opts)
 		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
@@ -3470,7 +3470,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		goto out_fail;
 	}
 
-	idx = ida_simple_get(&nvme_fc_ctrl_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&nvme_fc_ctrl_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_free_ctrl;
@@ -3633,7 +3633,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	kfree(ctrl->queues);
 out_free_ida:
 	put_device(ctrl->dev);
-	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
+	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
 out_free_ctrl:
 	kfree(ctrl);
 out_fail:
-- 
2.29.0


