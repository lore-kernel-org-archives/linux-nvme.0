Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73045C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMw36jRWiCysAvE5x+UdzjZ2BQBCv+zkvivYsnEIf9Y=; b=VhFCqNFnuiynUjgphog6pBjr8i
	F2ABzS7apb48x9mBDpzVswdBTw1aNCBQPf30QmjtvR3RHDc0A//TnRNZyHSNf+qO+c/S0fGx6+000
	x3lFADAPeg26+kmq+23YR+eiSCBWIpfOb4HbVELQZ/QB+WDCWTiCw6IgcxTxyOg+/9GgmsOCpZIK3
	WffWSSym8kphlAKG1abeZObtXvcZim0OZCRpTbwyi/QlA9EMD5Mjub2xb0Y6GMyRKXIkD3I+sVWHS
	wK3XJ78ZXnLMosSKfHYLU6GiqV9A042PDWN/G7Ii91EwxaItSYSkKlGNAtTW0kF+rrbrPzfk4f0gE
	rK/C6+3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Nv-00Ep90-27;
	Mon, 05 Jun 2023 09:20:19 +0000
Received: from mail-dm6nam10on20616.outbound.protection.outlook.com ([2a01:111:f400:7e88::616] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q66Ns-00Ep74-0n
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 09:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGLCG52jh2q48YgzSmsQE/MNI7MZCx4maFDycqKrczy7KuHZ6LYPz9z/gp20imBLCrqKDU99wnpxCIQLYL98Mlx1ZThDZQqGhVhk+N1patJMu+79qp163dE5TTicL6asylTrMq41F+ZTCtpPurIa3awlZNT0cng+FyKmO/ke3G1MUj40oYxViKoRvCHxNTQRYyREaYZWAsuFHou9Kcrk2wFq76J5YhTFHrfIdsWYuOkgYON1ALzqzPGvnSUHL1E4qz+xQ6BSGycIL9U8mJ1vZ9XtG1ZAwWin0p13nJej0NyJKWY7bRGR1TdHBV8c97ywVCqC15Do1DZGdhXElvMJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMw36jRWiCysAvE5x+UdzjZ2BQBCv+zkvivYsnEIf9Y=;
 b=ZkPk6e3AwftHyzQGa0hlQi7j0ku1eBxhAB+w7E++LT0gUgs58WkUCW2Vkpki32J7JOcAhDkO4DMG3vAP5MMcDb6k8mVs30/OQHbfgPSOl1W9ctcFfgRF7J85rsY4ubEnaHFftYTHqxnr7b9A7EUb/Nws0YNw3GspkTxVi84MBZUjJKpizDbIwIwHwKnHYhJlvLL5M35tCFxHmQMMVd0WpOWc8RqTaBi1rOKL3daiYgT1B3LOV+sT5G0EWh6MCaPXurJEXtOiXw4RK+LOyZTEWuiQ0GlvCD4oR3iShxJp8YCOvJGhI2L2/h3vGohrAQEsiOEGCBCrXb2P+tkf1aNkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMw36jRWiCysAvE5x+UdzjZ2BQBCv+zkvivYsnEIf9Y=;
 b=Z0pMVeh1A5C9f5ZWpws6x6228eGXGV4BtxGUyohl+f/+3b90OLISy06zLUADf84BgSUs+20bMxMWMZXhS/yL7W5qUirVs9TQ+gDfZ39BagqnDspxvywXvCbXObmK9uLHXQvKvWflaOI0FVLQ0BFxjGuyDS0Lst3gmRm6AHvmkG5QHLiKNRfu+b64aO1pf8WWE2EMHxPeaKsd/ALeTuMyBVttX/TcyaHxNLdjdYPYgbFvjgYsEUNJgd2MT3A0MbvfpFBnaOE25fskRlCfoNiYp2614iOsfeKwVOQu2PLPaWyBSTwuThZGms2Wp4fUGkdXlWYR9NPoKF2S+7r6BGRq/g==
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:20:06 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::b5) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 09:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 09:20:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 02:19:51 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 02:19:51 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3 2/3] nvmet_auth: use common helper for buffer alloc
Date: Mon, 5 Jun 2023 02:19:19 -0700
Message-ID: <20230605091920.34253-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605091920.34253-1-kch@nvidia.com>
References: <20230605091920.34253-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b095f6a-c7e6-43f8-0fa5-08db65a60d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA27i3rzRGpz8bCtKydLKcApyAXAuHrrHS4FzC43+jLko68R/iejKGB5MOg5R/FBEwe4p6/5s6EqZS7pY237fJRW+8CY6XdqT3YL04IF5j5+FoWm+fBJsD0//Oyw7cLIHQ7Qf8krfEJm0+jgUPC8NoTA/VpyIdMHeK8F7CRD23sODXNCFZCHtkawWz+2CPqWH6lbEIDxrjcErZvKHfIhKVpA2LQksPohe5A3dYThTKl4N/rDx5EyvYX7BTivybxaNnQTs/Qtsh8g4Z9A3MVj5evfEL5I/82JMNcC84ND5UH/E72ixbihlFSJjMyhCOpJiZDxEo9QZUKgz4qEpRhIusRPBTtvkk7cvE4g1AWBRrQLkPGDKgU/Rcve94jdn8n1rafyV3ku8UoozWnfSrqbdg7FNKXtwMsmYDl5fjFMdRw8YN7Vv0AMrUh12xyFpLtxGBacyWls98hD1PbAcl3dem6t8WEbfQfbzDfKyPk4TqSwr2dg3BKppk9I+Hs/fnYBb4afpTum8XOwLQ07pe1ia8Fz6NgX6gSBZypIkTZoYo8rnKzaa2OtDylmyMZ6TQNT2dGNfxfIqq+JQUuzc3eJQsNCiRKfgbnxw0rIU3UyN9zDuP4XPOsItManfL5MQtsqwcSoct4/H+ESNEwzdTbPpJJ2UkRq3PiTGP63LQjLO9dPxP7RmJppeR8eNdYHpkKIlklBrgXbWpnjA0QSYApiJtaQ8EShLQemODmHWLFRcs6WqMFjlpHOcuIZ+8Gssp8U
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(8676002)(107886003)(478600001)(54906003)(7696005)(41300700001)(5660300002)(6666004)(316002)(1076003)(16526019)(26005)(186003)(70206006)(70586007)(4326008)(6916009)(2616005)(83380400001)(40460700003)(2906002)(47076005)(336012)(426003)(7636003)(356005)(82740400003)(40480700001)(36860700001)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 09:20:05.9506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b095f6a-c7e6-43f8-0fa5-08db65a60d07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_022016_286046_AC20D102 
X-CRM114-Status: GOOD (  13.68  )
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

Add a common helper to factor out buffer allocation in
nvmet_execute_auth_send() and nvmet_execute_auth_receive() and call it
from nvmet_auth_common_prep() once we done with the secp/spsp0/spsp1
check.

Only functional change in this patch is transfer buffer allocation is
moved before nvmet_check_transfer_len() and it is freed if when
nvmet_check_transfer_len() fails. But similar allocation and free is
used in error unwind path in nvme code and it is not in fast path, so
it shuold be fine.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 847aa12d2915..dbcae93bd25c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -12,7 +12,20 @@
 #include <crypto/kpp.h>
 #include "nvmet.h"
 
-static u16 nvmet_auth_common_prep(struct nvmet_req *req)
+static u16 nvmet_auth_alloc_transfer_buffer(struct nvmet_req *req, void **buf,
+					    u32 *len)
+{
+	*len = le32_to_cpu(req->cmd->auth_receive.al);
+	if (!*len) {
+		req->error_loc = offsetof(struct nvmf_auth_receive_command, al);
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+	}
+	*buf = kmalloc(*len, GFP_KERNEL);
+	return *buf ? NVME_SC_SUCCESS : NVME_SC_INTERNAL;
+}
+
+static u16 nvmet_auth_common_prep(struct nvmet_req *req, void **buf,
+				  u32 *len)
 {
 	if (req->cmd->auth_send.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
 		req->error_loc = offsetof(struct nvmf_auth_send_command, secp);
@@ -26,7 +39,8 @@ static u16 nvmet_auth_common_prep(struct nvmet_req *req)
 		req->error_loc = offsetof(struct nvmf_auth_send_command, spsp1);
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 	}
-	return NVME_SC_SUCCESS;
+
+	return nvmet_auth_alloc_transfer_buffer(req, buf, len);
 }
 
 static void nvmet_auth_expired_work(struct work_struct *work)
@@ -204,28 +218,16 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	u32 tl;
 	u16 status;
 
-	status = nvmet_auth_common_prep(req);
+	status = nvmet_auth_common_prep(req, &d, &tl);
 	if (status)
 		goto done;
 
-	tl = le32_to_cpu(req->cmd->auth_send.tl);
-	if (!tl) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_send_command, tl);
-		goto done;
-	}
 	if (!nvmet_check_transfer_len(req, tl)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, tl);
+		kfree(d);
 		return;
 	}
 
-	d = kmalloc(tl, GFP_KERNEL);
-	if (!d) {
-		status = NVME_SC_INTERNAL;
-		goto done;
-	}
-
 	status = nvmet_copy_from_sgl(req, 0, d, tl);
 	if (status)
 		goto done_kfree;
@@ -437,7 +439,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	u32 al;
 	u16 status;
 
-	status = nvmet_auth_common_prep(req);
+	status = nvmet_auth_common_prep(req, &d, &al);
 	if (status)
 		goto done;
 	al = le32_to_cpu(req->cmd->auth_receive.al);
@@ -449,6 +451,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	}
 	if (!nvmet_check_transfer_len(req, al)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, al);
+		kfree(d);
 		return;
 	}
 
-- 
2.40.0


