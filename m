Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F53C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:43:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BA0610EA
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 10:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4BA0610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xWEiPhiRArCayeEVzFqU3Hy2KLV2RR0WXbUMLtQIcTI=; b=wKTicUGKyYIsHdxNfAqB1pXsyb
	o37DM/bd5BQ3fEa04BreMYOzxvFdpfVcEK/KhOOXgrlQVrHHml674YH9J7I1NWsShV109/cxspTlU
	FPsiBXn7WfU/+Xq+a5rTCkI5NvQUG0XbyXi8AxNdWjXGtP3bbttBYpaDr6yxRoSOmwRWsLi8pv+pe
	RjkKxzkpWMS/nLE/vpYeZfa7zP8kRWGjjWX1bVWaU9gmARo+Utag76NaKq2xsM9mDgn00Vk88tkSQ
	VeeCQ0UKH0ICA8QijMFIJywlVNkQyJ3fx2MfLBdRC7QysvuvXQY0WYTayAK/se+KNjIobgkQEfqJF
	W26e+VFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md93u-004AF9-4Z; Wed, 20 Oct 2021 10:43:10 +0000
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com
 ([40.107.101.89] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md90D-0049O8-P5
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 10:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipjew93rA2y0wJGM59HgtoIBcsc+O5SLUhK/WYsQY4pik1SRxQTbQCGbV1OBKjnbUndTCc2Nm6Faxi9StZz6H0StIuq+/vCcIiCrWyMiSa/rqvP4PQTlhURkpErXueyEbm5apdjZMqbpPm4/KuGpKX/mZnYkMilFXN6tk0qTLR59NzKnENPdsh/OdN2TOYvwpurHQAb5ryisbjkX0XxnrXRMYX/KPLfk9h6WotAJc00iwNzimZXHGQEE9xZ4BMkr2/TnLoOMHtq8ZeByNqcwFcIEXye08nFhyi0bVuOWBgn3Awp0wwFsaMfmM7LyYAPUuadqEVxhznnp/jLXyKdjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWEiPhiRArCayeEVzFqU3Hy2KLV2RR0WXbUMLtQIcTI=;
 b=OA7hgukByJ2NvT4eZ87O82r232bWxK3LicsI5bQ4fmXIIB3JDdcCm20ynOWq+VqlQSdJ8RIRrLEyI/MnEiDV652K62P/HBSwIT+rzU003Cd+S9KyIrLkobkzGQBbtOLZqn424jrBBu2obef4W1fczMbYE25uHcPv0ur0zvO3jbbVl9S4hRU3RukZK2Q2CHXOsWEri73LyIe+3QxEIbSVw48YeGPQxe+EcCMPOwd0ZsA6LzlrfujE+YRYz3YlhHKulYhwWpCVXF7wWOUePzon6Ve8safZ8zYHMK/VFoxMrThN2HR2eBGHj6l10vWXHsrMFfnIBQU7WoT3Cj22kUoArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWEiPhiRArCayeEVzFqU3Hy2KLV2RR0WXbUMLtQIcTI=;
 b=M2Puc1eBPEe0PItBUV+0F2soYXKtCpmmiHyl2rWx0KRYrCuBh+7gBvR+t5b1X0GVXHzAhZMlqUcdfM4y4qoOu+KH+cjEU+DBND83bCg7Sx448Phd5vqbjBZCPnx8wyrY0oCuFs1KyL9o+N4CiPlRdKIUcRpCj51zE//aE+HS4pKyvqhRwR4Kpd145OSPlsETh3v0tkbX++Qd1xGOD1eGzFhF6GQc5SFx2j0h4oCEgsx5nyonHaXacJZcy2X0Wgqt85Ja7R0ffSIjC6OOAWhqYKw10J6cKR/DBs34DQoK1PQlEjRQGs5Ky/IG+hNL3umvP0JUC4gox/QvzRH4pBNaZQ==
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 10:39:15 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::b2) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 10:39:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 20 Oct
 2021 10:39:14 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 20 Oct 2021 10:39:12 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <hare@suse.de>, <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 10/10] nvme-fabrics: set common attributes during
 nvmf_init_ctrl
Date: Wed, 20 Oct 2021 13:38:44 +0300
Message-ID: <20211020103844.7533-11-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211020103844.7533-1-mgurtovoy@nvidia.com>
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e27afd0f-2cd8-4009-a753-08d993b5dce0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4312:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4312C81CC3B845AF01D576D2DEBE9@CH2PR12MB4312.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Sb4qPjX3sLfD1rQ+gfpUJcaQ9ARGRvQSyhmrbg2a8ZX1m41GnMy4wWZmuEIV4N908Wut9GbKvYiHdIENZS8hIYo1hdKTM9ZGwaup5GhuJQrxZw9Z9dQcqjkRf3VO4Ue9dyU0Q4jNXHRAJ4joxbZ5E6FiiXpNPVV0NT7qb8Ymtbqvvo/gw9b+vCfS1yzhoJ7dyeh3Khtv9G/rP1TsjMawsbZked55YyiYLRQWAmcysLAfPH4N6cEvdbZyBQv4v9ffX4pvSnocWwzn3AuR1SYGRgDRRytBx3t+O7Cx8vXL3BvosatYQi5NuEuhNZrpAUgmC4eKeCTIiD4t/fQw9b5Hj99pilM4EyFCVkfaFKuulIFC0GNYP5OUZdOFwZ9JUsooRk88ZA8l6ac8Ck8AKuPFJZx9wVfWv1eOVLbcMJ5USWLuyqID5c+0Zfu6vJ7rwi6Ckni5XpT/ZaYoqk/hGwYUSgRQPZl5p6snhyY8F83ptMxSKjko8KLFDwJv0n+FJMUaIpAWjYUY7Td7uB+/UaqXSse7pmtjQK7hwBzZxHR/d59iP2tuaPczcDm/GCM5gt/bi0DMb8vyPhHlWpxqnAcaNcf/1wiSK+aUBfIAbIvb3QLKYWl5tpEMcn2+rq3Otgw3gweFSLfSzkJ6yCd8XBrabKJZrHyn9ATTXWQkYyVrX/hODhVm7CyRWUjr1jxoiDLcxpeDoZoy7MadY3Yjaoddg==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(2906002)(26005)(2616005)(86362001)(6666004)(426003)(8936002)(356005)(8676002)(7636003)(54906003)(70206006)(36756003)(110136005)(83380400001)(70586007)(1076003)(82310400003)(47076005)(336012)(316002)(36860700001)(4326008)(5660300002)(508600001)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 10:39:15.2030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27afd0f-2cd8-4009-a753-08d993b5dce0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_033921_846075_B5FCE30A 
X-CRM114-Status: GOOD (  10.89  )
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

Move common logic for setting opts, queue_count, sqsize and kato from
RDMA/TCP drivers to the fabrics driver.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/fabrics.c |  8 +++++++-
 drivers/nvme/host/fabrics.h |  2 +-
 drivers/nvme/host/rdma.c    | 10 ++--------
 drivers/nvme/host/tcp.c     |  8 +-------
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index e13891619de0..335fef227baf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -572,8 +572,14 @@ void nvmf_reset_ctrl_work(struct work_struct *work)
 	nvmf_reconnect_or_remove(ctrl);
 }
 
-void nvmf_init_ctrl(struct nvme_ctrl *ctrl)
+void nvmf_init_ctrl(struct nvme_ctrl *ctrl, struct nvmf_ctrl_options *opts)
 {
+	ctrl->opts = opts;
+	ctrl->queue_count = opts->nr_io_queues + opts->nr_write_queues +
+			    opts->nr_poll_queues + 1;
+	ctrl->sqsize = opts->queue_size - 1;
+	ctrl->kato = opts->kato;
+
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvmf_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvmf_error_recovery_work);
 	INIT_WORK(&ctrl->reset_work, nvmf_reset_ctrl_work);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index ca405ecf90dc..0a694fd3b01e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -189,7 +189,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts);
 int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 void nvmf_error_recovery(struct nvme_ctrl *ctrl);
-void nvmf_init_ctrl(struct nvme_ctrl *ctrl);
+void nvmf_init_ctrl(struct nvme_ctrl *ctrl, struct nvmf_ctrl_options *opts);
 void nvmf_uninit_ctrl(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c49ad0b3ffdf..04d741075376 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2231,8 +2231,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
-	ctrl->ctrl.opts = opts;
+
 	INIT_LIST_HEAD(&ctrl->list);
+	nvmf_init_ctrl(&ctrl->ctrl, opts);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
@@ -2267,13 +2268,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	nvmf_init_ctrl(&ctrl->ctrl);
-
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
-	ctrl->ctrl.kato = opts->kato;
-
 	ret = -ENOMEM;
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e65bdd0db4d5..5b9a876291f4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2406,13 +2406,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&ctrl->list);
-	ctrl->ctrl.opts = opts;
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
-	ctrl->ctrl.kato = opts->kato;
-
-	nvmf_init_ctrl(&ctrl->ctrl);
+	nvmf_init_ctrl(&ctrl->ctrl, opts);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.18.1


