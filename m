Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4168AC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bo6gbIMmXwljNs8+XpU79KuJVcFEmLC7YLp5uwPPIVw=; b=VPvuRzyJL6XZoYvd2fKkHmCvrs
	wXuWX07fgk22I1dyNli0rvZpXrZBXpMoIuGPBODizvCzzIueQ2rZE6/ea7KcBh/5AEWwIRG6CXN4Y
	so5COTgBusu/85QFGKUUT5RjfALMVH08Z+lzlGyxfzfWme0XSVpQiWeeBTjBbYPJCLPuI6kEh37ns
	yyHo8qzoxnbeuUePNxm1+aaOyStLS7hzgIOgXW3HTnoQD9QE23ckeSUVSbapP2pLHxmEiEq3r28TK
	1juX7IIYLFv21nZ+YrJZ3lTxOWNrA8TlKRuwm5tOFvYbj4MXULf+WzCOfvfyFKjat96GWijBydtJD
	yvA6YM9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByEU-00EMii-4q; Thu, 14 Jul 2022 12:46:18 +0000
Received: from mail-sn1anam02on2088.outbound.protection.outlook.com ([40.107.96.88] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByBf-00EKcA-O2
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 12:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqXMp/vtE+e21jduXaBJDojeBCQsKvqluR3tpxTSBIck/hOoes4zkb0NPV6vslE4du0gv+PGhXLfzuTFVIWW/1bWnaxLsFFzXw5BAB4GXxryY9eU4LlVs5eGJa/IAisn7mXOhL9lQtRo8UU6cAmmjZi1ZqpDhUoXwf5xV59rTGbbikoaPQk7o7xIJvLKB0SaBP9wpUi9Yiw6Ah8L1akCDm+gRcK+MIV/jjP1zI0mqgY3I9G+ioOoJ8r9vDE1XAUCHyh2CIC+xL1b4v5xw6hb4aQGKJeWt9lK+8JDygS6WcuxVQZNFr0ilwR9ZAyYNgPHTtbZ6WdomBcR00fr3OYbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo6gbIMmXwljNs8+XpU79KuJVcFEmLC7YLp5uwPPIVw=;
 b=oB1jzhx40E00SS8ElXxvswgNrN5scBv17jXyuMx/l37pL7x8L+J0AdOSwUZdM/5yDvdSDgFdENetx4kOkkJ7uKtn0jEb/3B4I7vm5IB8s+py6u0Iqn+gPBorFTJweGig+qjKPuyMYrEUAW7geJw0L4s9ZSvB0Q00Bah+lwOHFclUxsrQIS8O0NtNAyi3gZJnZGs6fuBybL28Q3uRo3t7mNiojUCyRBP4LHJvDFmQLdqFLd6KnnjLFT0+Z8bcaQX7dKFheXC8+szZMQizO7YZ8cVopl4MSQnyvFjuYngzC5DoXmlqoCo4YqX0KOSKyp2SNCPmsZa8FXyL9+Zy83hFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo6gbIMmXwljNs8+XpU79KuJVcFEmLC7YLp5uwPPIVw=;
 b=QWuOF76tPltx2swRwZ5WRf4swPKi1sat6524iz7/7LjmFfGQ5OZwiEteWSMeJpVnIo0EyVo9Y5DdbrxhF6q5lj0Pi5nrAKppjaN/P1qJ1THdNvzfdkuWGDCME/5MWKELFTNDhjqYPA9g9aqBCfnnVK2eF2d2yYEmpt3aynuC6j49h9eBANdyOqK1h+P+V8DEio6HmxUb0wZx+uyNorGOL9PrKJDBJT8aSWHzyeSSZj/nAt14bg4IJUZ96BWa4/IxCP+YKRfvsK/NUv64wHAx/6VY1NWHAx7fuach32A30Vs3UHAFfRfs5/yaeveZhT3CST5OW8mS8u6eK+erA0C6UA==
Received: from BN6PR22CA0055.namprd22.prod.outlook.com (2603:10b6:404:ca::17)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 12:43:17 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::4e) by BN6PR22CA0055.outlook.office365.com
 (2603:10b6:404:ca::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Thu, 14 Jul 2022 12:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 12:43:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 14 Jul 2022 12:42:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 14 Jul 2022 05:42:16 -0700
Received: from rsws47.mtr.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 14 Jul 2022 05:42:15 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
	<sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH] nvme: Fix block device naming collision
Date: Thu, 14 Jul 2022 12:42:10 +0000
Message-ID: <1657802530-364205-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc254c0-834e-4b3e-c2d1-08da65966cd3
X-MS-TrafficTypeDiagnostic: CH0PR12MB5235:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vshHZNun3ehSY1ZFTTUZ5p51xPGqabCYL6y5Tx6P1cokJXU1diiXU10JRYnHDKArZ4u9R27yc8Y4tU1B85Li0aUh2lGygPZxSz7ESyW+tIb0Tu/G9s35+XmOZ3OCNb5QBJt92lt+zBSm0A5jELT1217GEyVZAaXJ58/1Ycu1HJ4gq4vvR7BxT/Q7E4cTcJECQaskoad4dd+WcrYCgsjLburPuzHegFUWMVu4Lb8QfdnDuNmZ2KvTxOV8cSSUKP7XUiIIWWLKHdE/lNF7n3EYLv7ILQOMuE7nZ9VCPrnrkUugRmV+pJbIIxTFJUAL6iwXDrV44DmVh8qw/rH2JiO9vC3B8NXC4Hgv2pI7BTnmmsliTjJ2/oL07rYT50Zezvsdg0O9KY0gYCIJW04L8GhCYs4QoOOh3B1jj2BQbDS+/dNb8rS/qHvrGrZf1p88mFoFWKqFjkrn13cnAJTHdrK5VgxzeXYOvmerm01iF/9S92Vq/k01+7PftD8yCLZoBP556VDSJlybTBrFwbugO1jzQtsYMeXEAVm3qlAWzKaWqWi7fTJNvzS9m46pMNGsPWVqKVUXknmjBjA9XnFUEm+7zY3a87OJw68kodcIhi4o9g+oiqybn8LLKcS5dmsPrg5f1x7A6Aa11N6LJ5FDpSDrgBP6kznpU+8701VA5CQu+7zoXlaqqga43ixwcxvEs4vUnckyXYGlCX4/5JLGWowiu3U4IpcEMcnshbo0S1K3xIItpfqrz7/5O74oMkBSb/2l9Bv9Jh0tyAt0DM039BDetEfaMySbnB6mB/WKSddmqTfWomEXOz7r+IlB9Rk2nCSeFa01PGVvECDewusZxD2YO4MOAiUdxsvj4S+V/mEAmPc=
X-Forefront-Antispam-Report: 	CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(40480700001)(82310400005)(83380400001)(8936002)(26005)(36860700001)(82740400003)(356005)(2906002)(2616005)(54906003)(70206006)(6666004)(478600001)(316002)(47076005)(110136005)(70586007)(41300700001)(86362001)(8676002)(4326008)(81166007)(336012)(426003)(36756003)(186003)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 12:43:17.0101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc254c0-834e-4b3e-c2d1-08da65966cd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_054324_002962_CE44AC4A 
X-CRM114-Status: GOOD (  11.54  )
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

The issue exists when multipath is enabled and the namespace is
shared, but all the other controller checks at nvme_is_unique_nsid()
are false. The reason for this issue is that nvme_is_unique_nsid()
returns false when is called from nvme_mpath_alloc_disk() due to an
uninitialized value of head->shared. The patch fixes it by setting
head->shared before nvme_mpath_alloc_disk() is called.

Fixes: 5974ea7ce0f9 ("nvme: allow duplicate NSIDs for private namespaces")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ec6ac298d8de..6a12a906a11e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3786,7 +3786,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
-		unsigned nsid, struct nvme_ns_ids *ids)
+		unsigned nsid, struct nvme_ns_ids *ids, bool is_shared)
 {
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
@@ -3810,6 +3810,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
 	head->ids = *ids;
+	head->shared = is_shared;
 	kref_init(&head->ref);
 
 	if (head->ids.csi) {
@@ -3891,12 +3892,11 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 				nsid);
 			goto out_unlock;
 		}
-		head = nvme_alloc_ns_head(ctrl, nsid, ids);
+		head = nvme_alloc_ns_head(ctrl, nsid, ids, is_shared);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
-		head->shared = is_shared;
 	} else {
 		ret = -EINVAL;
 		if (!is_shared || !head->shared) {
-- 
2.27.0


