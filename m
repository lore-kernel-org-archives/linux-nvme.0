Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25555C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gG45IXQWbTTAadhsJMqEPTai+MP6b1yPS7t1tpJDGao=; b=yxXn6FwDzdKzMzaDjRuxRzc66m
	mduFQJapwOniUwcd5yzXV8+cxehC/9pPQWETRvPVT91gBbczj/JetpT194CoF/yvKQc4OWgrfIuNJ
	Z289nx+hwRW34O/4w3ZM9SjvCPrN/yF9JaNn3rbfCrxk8MBwT6TesRSffieXIy+NoC9MNik7Qf4wX
	29Bibui8rsvgaoKNW1Pbsp9TBZRiyptTjTg8TXYccI1Xj3yfuD+SSLl8scTkEL1zbhryhDRz0fTfS
	2s5hjn/AeKM0E3niCHCW6FM4jE6kjd6dmDTnzbtK7/Ac8GZHN94e8YlIk/j5NSBQ5eMMBKrqGiK6P
	B9xfQDMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZX5-00Eotm-72; Mon, 14 Feb 2022 11:28:39 +0000
Received: from mail-mw2nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::62a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYLO-00ER5w-Cu
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:12:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKuJIcJ2t2MLGrF+eSdJRREbHQR6V/4cwdrs4cPWcD7ZpvaQsmanDCV0yo0XHSAUmOMxCYwOOiAC+wRm3ed8xXWhOSLDx2KOm5urRR9WH18xyXa5egyn62fRMW3xSEwcgCZOeyzk6brUMMvVQljMrGvoT35cH7PVkY85Z6+EPA6jIB1hMAvXwsH0hqhR42qEHjJ3+IzzZCnfMUmn6kCI+NhOtegLu40Tp7IRtD7sDAZXlyP9lkzKFLlp8EfsgM5SWlyxW5hmobKjvFO5k5uxQr85zz4PJ9nXBKJ1zWS6gBkox3SlBd1kHqmCkvqxwQ8T08AZlSpW4I9NekrVCvFh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG45IXQWbTTAadhsJMqEPTai+MP6b1yPS7t1tpJDGao=;
 b=NihbPAWy/6FHJLQz1pHmDEyFEt1iwSyCtxPhQPC9uIFJZkLgnQzjHgi0+QTD1Bb1Sup4ln59pm55bMOQY9nNx5cLhc+ZNb7GCIGu+fp98nTci9o2PaAFaeSjh3wkIoG+zDnjiJvHr4TVmAw2VWzs1dsPoJNlAJG6c5TwhzX8Tfwy/KCeYBrCad/4OZ35l0h9fdrMd6mVxOF+le+qBOcyqsTumuXKUgmyprVmcheTArf3OeaIGPOvfPQV8Ab1nncyeDzjtIHO8WeQZnJx69Lhr5BpB20cjCn6UhLxA4W0zQ3dj1GEcN1JU8Y8itWx2I96oHdRBiLVTDRwxktVww9sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG45IXQWbTTAadhsJMqEPTai+MP6b1yPS7t1tpJDGao=;
 b=jNgTHMuTXTbePcEtC9B5jn6oeX6uNWcTG7CUS9YkGUG2u72yVzImPJFAN6IV410XJGIs8rM3vxq/8Y/6B8Wk944iHJob0Jlu2J9mc5mqSwf7sk9KH0FW76LYHNINy5QoHxvneZfat5CxrPyf6cPaGw1dLsVbNaJ/m1f1NYUaZ8nRZlTTFQxDaMMdHDzrmvSeuh98TFmW1UkIzMqKC47naRu3b3eixmp3UxeOiLhche2/G9CtpjdTaREntgaxh1CF8GZiJr0Sk9Kvi5aEE0pDsR29QHi20JXQdLMR0m0vlLmxLWuD5THoZg41j9aFxHCn3XnFvJOPsbwq89fweD65JA==
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Mon, 14 Feb 2022 09:57:36 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::42) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 09:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:57:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:57:35 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:57:35 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 4/6] nvmet-fc: use non-deprecated ida_simple_xxx APIs
Date: Mon, 14 Feb 2022 01:56:37 -0800
Message-ID: <20220214095639.5125-5-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea2d7c9d-105b-48a2-7e74-08d9efa06db7
X-MS-TrafficTypeDiagnostic: MW3PR12MB4538:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4538A60DC2EA799A75FBFE9AA3339@MW3PR12MB4538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:164;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xDN8T0rU83d16atTCC0u0ypP6gtR5fTaC33V17N5zvTD0QCgROf+IKLjlPNmBTCDTLUfsq+06H0nPSQPHh/yo0F8c1Fhuk/63B8ejozh3/maoyitDTYgV9MoCnX3poQOfFUDQ1IDa3Ci1jDij5Zm2leHpM2ivDvtQ8FnWN1jFuI7HVY62mmHocOG3KdvWVWGCmOxMe8PdlfrwcRrkiEHupn8kZg4BBw9I5Zt/wnEr5Uw1Y2g2QQHkICnpFpvEdTQTmxwxx4vzDs5lLZ21QS1SKdto1mKunBlkW3N4hwVXLm5Nw3s/tJtOu36uSKtyRU0ARKppDUNDSmQ9MXTxVkD2ORHzoWqYaOSbtMWHAcg8PDQT1yQs/4I+OQaaZKW+s5fYG2PTpJzWhgj0CM0fEi1bqiZMQVev1/PGwRctbUdRVufZQmvrTcTirJguHlVMOODEbGaD2lREnhHRUCEeLuMuRyiEDmHPDeMVslWgcHb+E14TBuC3EqXDaVyhehphBSJNgi7BvBn2zMI33t8xYdjUfDJ0Un9a9ofn/sdDAqc/xa0paVzcKcgnW0CcEFCKpi+AoPqa7eqJRCN7w7BGxkQ4njvdeasTFY6+zvIDUQP9wSwV65FauQljPpPF5xp9Y9j3e+fSzssw1r9AA44rt14zRP3R7ZhKpA9c3vBA/EmxmThn4/UkqliPZzE7UtuhBsC6dJZuhy1el/GH21r348xw==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(1076003)(336012)(426003)(107886003)(16526019)(54906003)(6916009)(26005)(316002)(47076005)(186003)(8936002)(8676002)(70586007)(70206006)(4326008)(2616005)(83380400001)(81166007)(40460700003)(82310400004)(36756003)(2906002)(508600001)(36860700001)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:57:36.2152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2d7c9d-105b-48a2-7e74-08d9efa06db7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_021230_469291_8E304267 
X-CRM114-Status: UNSURE (   8.80  )
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
 drivers/nvme/target/fc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 22b5108168a6..49114a6cea85 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1115,7 +1115,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (!assoc)
 		return NULL;
 
-	idx = ida_simple_get(&tgtport->assoc_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&tgtport->assoc_cnt, GFP_KERNEL);
 	if (idx < 0)
 		goto out_free_assoc;
 
@@ -1157,7 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 out_put:
 	nvmet_fc_tgtport_put(tgtport);
 out_ida:
-	ida_simple_remove(&tgtport->assoc_cnt, idx);
+	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
 	kfree(assoc);
 	return NULL;
@@ -1183,7 +1183,7 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	/* if pending Rcv Disconnect Association LS, send rsp now */
 	if (oldls)
 		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
-	ida_simple_remove(&tgtport->assoc_cnt, assoc->a_id);
+	ida_free(&tgtport->assoc_cnt, assoc->a_id);
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
@@ -1383,7 +1383,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 		goto out_regtgt_failed;
 	}
 
-	idx = ida_simple_get(&nvmet_fc_tgtport_cnt, 0, 0, GFP_KERNEL);
+	idx = ida_alloc(&nvmet_fc_tgtport_cnt, GFP_KERNEL);
 	if (idx < 0) {
 		ret = -ENOSPC;
 		goto out_fail_kfree;
@@ -1433,7 +1433,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 out_free_newrec:
 	put_device(dev);
 out_ida_put:
-	ida_simple_remove(&nvmet_fc_tgtport_cnt, idx);
+	ida_free(&nvmet_fc_tgtport_cnt, idx);
 out_fail_kfree:
 	kfree(newrec);
 out_regtgt_failed:
@@ -1460,8 +1460,7 @@ nvmet_fc_free_tgtport(struct kref *ref)
 	/* let the LLDD know we've finished tearing it down */
 	tgtport->ops->targetport_delete(&tgtport->fc_target_port);
 
-	ida_simple_remove(&nvmet_fc_tgtport_cnt,
-			tgtport->fc_target_port.port_num);
+	ida_free(&nvmet_fc_tgtport_cnt, tgtport->fc_target_port.port_num);
 
 	ida_destroy(&tgtport->assoc_cnt);
 
-- 
2.29.0


