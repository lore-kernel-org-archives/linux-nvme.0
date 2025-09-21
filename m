Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988A8CAC59A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ut7Kv8RzOp/cLsp8bB3JICodCpxa8H6gtJFQMf39Eog=; b=jHIuJZqdfwxyv3R6/PS3MFWL02
	uFsZNBKgMaUpZ9JjRRV8Y9kHHPPWGXkByb89c3pKuoU/qN1dYiNtrxtMqyj3nXpsMio1aDl42B4jY
	JLH6QVBDee9cRSAArrYLVRfjUHXM3pidr9h0ooVlM9rXymXn5TItZBOVzHAk2lzCWl92wK2LYJ2+x
	1pFcX+0AJeSttx0Za9sd8qumq3hrh3e8FHKJwO6Y3cKp8UPcIDKrDgadUWQ5OvPwqrOblXXqq3ndI
	J7W94swc1VVh5N1WsrPS/74FSIq02QWgD8Vu/0/0FFk8Yf9eqf7oRxNr4x19D5MlLJo1GPHE6wqVm
	VmqPYNwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0JQm-00000007TQL-0WZR;
	Sun, 21 Sep 2025 12:44:40 +0000
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0JQc-00000007TPw-0Ie6
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 12:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jwuxn2OWAx+kkEL3UkjIchxDcu2zMFggE6weDa4GyuoQvpI2KGd/AOpfWuWwKdtKAowLKO62rI6Vyq7culLZQZSfdAtCQjJzNaB8gejZVHdkpt1ABZzzKM2Z+4iZPLHwnK3NRxCVz8rLPH3CoFCU6LYGy+OTyYcUqoz4B0ffRk3MWzhk0QG6jWj0N1dmnjCOURsR9iDm0eHVSv3zAceA7Gu2ZSpwEXfI1GOGqerOzyu3N9x5leB3gFJglyZEZeSiD54ZrxfUri52kzRgXehgzr0HG4PHkui9pYqquCxODXAkMmo4SeZbmv+DF84Q03yJCDXwzPQEbyDqMalbOnB9Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut7Kv8RzOp/cLsp8bB3JICodCpxa8H6gtJFQMf39Eog=;
 b=Gfh168n2ex3exVOVp3MESfc1cRdBnPWifhoQvGRuK7mQbCcgKkrN6uHNkGvwVz+JM3GY0RsDGNyw5V3WQhkEu4rRL8tmeTNwlVqtt6FMDCJG8iSPe28EoymqoLmD/5er510/lTBfSOSa0Hmmifi/s70JCj/895ttvn5xUtBm9Znnh8P5snyGpsZ6fWC6g4E3uTPyyEHTvhZFbdCcYn4rf3WeOEMrO557hN8QG/jDcaNx48p/nYt+Ar/9HCgJgEzDUSQfNaSYMzX56NW/zNJp6EY/gMDRCEV/EKHaSpy6EukhxZAGExPj1gAz/9WyXjCipmTidUbIL4wM7ZvHziqVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut7Kv8RzOp/cLsp8bB3JICodCpxa8H6gtJFQMf39Eog=;
 b=Rwp8BqaKVbFevZ3slr1fYuETc1SnMwFeiIBNpFpHMLshNdKJiFuQX7qxpOsPNnyNvbuptxDbCCpa3PkDKbooR0r8l7fr60WVK4p+1XUTGq5k/oazBJut+XxOuCZulvoor5T27jY9pqkd1nwya0jZX7wcIL4wug8cYBlX3tJUECzoghPPycnYXDosPEABUVSECpcWZx7LD+/5l7R2xt5EhiIEsizQrzs+KkvUgRCXP2okeXuSLbbqUnOK10azhzRFaTYdDdr6Ayzj/nDxPnoXVXVBpMGsKfFy2US4gGhT8fQVuRHxX0YRSN8g2FWEFEs3nSfGneLwW13csv/LDv9f3g==
Received: from MN0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::13)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sun, 21 Sep
 2025 12:44:21 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::f2) by MN0P221CA0030.outlook.office365.com
 (2603:10b6:208:52a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Sun,
 21 Sep 2025 12:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 12:44:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 05:44:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 05:44:08 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 21 Sep 2025 05:44:06 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/1] nvmet: add safety check for subsys lock
Date: Sun, 21 Sep 2025 15:44:05 +0300
Message-ID: <20250921124405.30432-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: dedda51f-527b-43de-36c1-08ddf90c95f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mGoZlhK+e5PZ2s4uStoFVHl3av07syWic0ookxghwQVYogNCfpoPWilmcbbN?=
 =?us-ascii?Q?m6TZZ3pm2djyUh8jxjA5oA8XlRX0n4m6lenpaEandfNF+hP5YbU6Osffpu4j?=
 =?us-ascii?Q?03aB0fVGaxFkgIJUQDWbmM93lFwJVgVHw1Z9X90HutfoPQddfVlXrogVYG8d?=
 =?us-ascii?Q?CaBbxYtvqRBcb1DYmzYvKBzG4cL51RnuhuSHnHSjlbO4dM9uZbHNqz0gDuU7?=
 =?us-ascii?Q?ogjGYjpkHZchkERlPqhxyRgJK5E6UE6tRV6cdYPAeEhC5XvKpuLz9kxlg/fw?=
 =?us-ascii?Q?HefezI0bKgUUjQjFp4BesC3fifuyrTRTQz4ACh8oFpJhBkdKsjmS9Y1DvWhF?=
 =?us-ascii?Q?H3yBVAldf4t4gxL2rwTivbhQ1GigHiGxXxatkC2e0d7X4Ah3HYEz0Vuk+Aw7?=
 =?us-ascii?Q?xVZYFH8BGv0bNRfks1t5AGRcURAtePnP5FpoFApOSTEkBnOn5drVVy2UQTOI?=
 =?us-ascii?Q?D1DoG9X308tTyqt5crn7IsvcObel2tmI5Hv/8n8nrx3nDl96m6+taQJAp4q9?=
 =?us-ascii?Q?l4wAlT4H8Qwa0vd+zk2W+r9CzVRX3Fljmu3+Hi8+zWlPg579hxsfos99MI25?=
 =?us-ascii?Q?y2FsnQC0GW2hEL41x0hJttmCxeT1W0NvXPjeNugsdx1leXL70uNL6MQ+DcIb?=
 =?us-ascii?Q?qCqDFV2SBshRk5L+J9165qSYkwnEIHHn4Th2de7QEvGCZu8oeDzUpKW4AMgU?=
 =?us-ascii?Q?YiiYtAo3QcOArXj95ZIhseMGo8JNW05XUTdwo5j5g2w7a9sln2Juy565RYCb?=
 =?us-ascii?Q?H9s5TaMJaaMYQee185mRvdS2VzAXTZ9aYpTv/TQtYetdo/7QAYQ/mXNGiabC?=
 =?us-ascii?Q?hJBHOB5qfciJ0qmb959nHB7XMDKtLCTeEMlmgRKvWVLNR32i2EQnnZvjfnny?=
 =?us-ascii?Q?Zi0277lFuErhrd1ckOhHfsUg6igMzKc6Wr+TYEwm3/Wfa10f7A234sV+dU7+?=
 =?us-ascii?Q?BiybbuWHefvr6bcfMhpQd4zuAshGGzjUtHiuuTgqtuMzhh1np/rkJLgtVWzJ?=
 =?us-ascii?Q?XCCO0BFXNbGz9Schv37BOwJmLnWmiicivoJbPnGGRy1C+09Lo1lM7/ndI+y4?=
 =?us-ascii?Q?fJedw9oT2i/fQ5MKUNg7vbHl+N4sYCsnnW1Fe/rawHkbFlqWpkH08rZstapn?=
 =?us-ascii?Q?E70plJu3mdCMP/jS72ZVAEnreVdSfSEQiPl6mydXOd7Qys2KBITgpeDwelS3?=
 =?us-ascii?Q?+ryoVHh7DTiNINK18C88L+C0kULMC4xfB/OGFw4XcxoG7BDHkf2J3sZVVPCc?=
 =?us-ascii?Q?oYwMVxsjVm0kOAsr0Y/eXJioSL98s/57NT5Xy5YXCVyPvJXZ3MrNH5S2wMbK?=
 =?us-ascii?Q?X02BooSyszXsHPxrUhvumDkAM4pgMycldivlr+vhqhP8Alo3tSfkPhnxQWXr?=
 =?us-ascii?Q?KhAXmiV+qsaECyD8X+gn/OvOgxo00OC3Hh2Kyso7T7TJw87D7w9NTqjzwqEb?=
 =?us-ascii?Q?be66ciVN/wnj5qZPC52txvp3q6CIAUEOckFXt817u89HQA+e7OPq/btfOY32?=
 =?us-ascii?Q?1vpOS2pidgiOAUwfIgcaUmWiiDqlBM/wtU0x?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 12:44:20.6013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedda51f-527b-43de-36c1-08ddf90c95f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_054430_300582_B8EF9A81 
X-CRM114-Status: GOOD (  10.70  )
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

Replace comment about required lock with a lockdep_assert_held()
check in the following functions:
 - nvmet_p2pmem_ns_add_p2p()
 - nvmet_setup_p2p_ns_map()
 - nvmet_release_p2p_ns_map()

This ensures the subsystem lock is held at runtime.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v1:
 - modified subject name from " nvmet: add safety check for subsys lock during nvmet_p2pmem_ns_add_p2p
 - added checks in nvmet_setup_p2p_ns_map()/nvmet_release_p2p_ns_map()

---
 drivers/nvme/target/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7ee12819e2b5..e297b402d80d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -541,9 +541,6 @@ static int nvmet_p2pmem_ns_enable(struct nvmet_ns *ns)
 	return 0;
 }
 
-/*
- * Note: ctrl->subsys->lock should be held when calling this function
- */
 static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 				    struct nvmet_ns *ns)
 {
@@ -551,6 +548,8 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 	struct pci_dev *p2p_dev;
 	int ret;
 
+	lockdep_assert_held(&ctrl->subsys->lock);
+
 	if (!ctrl->p2p_client || !ns->use_p2pmem)
 		return;
 
@@ -1567,15 +1566,14 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 	return false;
 }
 
-/*
- * Note: ctrl->subsys->lock should be held when calling this function
- */
 static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 		struct device *p2p_client)
 {
 	struct nvmet_ns *ns;
 	unsigned long idx;
 
+	lockdep_assert_held(&ctrl->subsys->lock);
+
 	if (!p2p_client)
 		return;
 
@@ -1585,14 +1583,13 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
-/*
- * Note: ctrl->subsys->lock should be held when calling this function
- */
 static void nvmet_release_p2p_ns_map(struct nvmet_ctrl *ctrl)
 {
 	struct radix_tree_iter iter;
 	void __rcu **slot;
 
+	lockdep_assert_held(&ctrl->subsys->lock);
+
 	radix_tree_for_each_slot(slot, &ctrl->p2p_ns_map, &iter, 0)
 		pci_dev_put(radix_tree_deref_slot(slot));
 
-- 
2.18.1


