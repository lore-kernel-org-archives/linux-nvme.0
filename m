Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BACC7EE26
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAGl7IImkN71DwLozh/szShbQxnTJZJpKLsse5WVk9o=; b=kHmXJHc92x65oPcDlnG3CY1lAx
	WD6/HsqkdFvAtKb8Py8pxHR9KPWC7BiCH9gEU+/9+cP4D69fQdj5dsLhnavLQ8sBbCaE5d7z4g9jx
	XLd0VPGDWMcm9jQH+xQ8H/t6ioo+oX0OyNHnn9S0/yP4S8/BmzeKfkskznrtmRHT0JkxVvf7SgJSn
	/zozZVfk1IpY85IFzmFQglAgY9k2khg+352eSSqT6/OGYMegcXVZrZNusF4MhI5SwejV/4CLu3HgE
	+zDfqZbYQqQlYzn2iRRd4CRkDcAR0i4CNo7GRxCV3riAH8PHVqmD9J93A4UBTpU+h1YQjSwLS8ZuO
	9Xzq9rbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q113Z-005mDP-34;
	Mon, 22 May 2023 08:38:17 +0000
Received: from mail-bn7nam10on20621.outbound.protection.outlook.com ([2a01:111:f400:7e8a::621] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q113U-005m7s-1E
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 08:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzUTBRM517TqAQUaxTpaqYlHOOOBoQXcFCK+CFeayU1eMmcJl7wTZSXVh9mlNnRmfKkUJR3ADY6rk/M2kMmtqSLs45VUOxwJoU3a491Cb/+XZJTCTX1Vd+hDvytUoNTFfrwaA8FrUWtZc/OEU/+5g5DL+CLMGchqN09jQYlr8vagdROojZPA0hUAUBDvGGVDqKn/mYYSef4CtVKXUmSUq/HFCi0mlMDNwxINWa+gNJDhXChJJPnGReBfW+ZJRXMN+4AiKH7GCItTXnkLz4c6Ff6e0CBhwqQWtFHxeFfthsUqodCrmtV0hPacoR7P6TyQmypFR+WzholAZQBEBKKG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAGl7IImkN71DwLozh/szShbQxnTJZJpKLsse5WVk9o=;
 b=EnxKQr68ShpyMqcswb3q5nP4VYvo2xDDBLqJ+/z7iqreB1NJHi/lavHCem1UVyP/0BccSogQFMRq8Ftww5z7ND1UftTxzoACbY2AkBawxahayY8tWTeWHY6TwkE41djN76n3bnkrT/oMwCcUdfr8KpKpknoX1ylwQ/yHVY7nYa5kVNFKj0WCDQIOObtd1nWd2v2lfmOK0tgZtsIZTnpVgf8EyeKrR9/uk0iM+6mFanDtFPSYhhw6cY+0JEJannFNubH+aay8oyIoGEmo5FWMhan9cVNxVKkaqVWdWtSy3GO6TkEytwGWmggyph+ZRw2ZZiP8N4HUutGk1MINgHKKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAGl7IImkN71DwLozh/szShbQxnTJZJpKLsse5WVk9o=;
 b=DUrn86CrAcgR5T4s0IHMtJYFUy1/XDgVsZnf5S9IoN2cfpyYN9G7/huivT3EITE3tKT+iCKVQwyh0swPbizdkbWbYNSFEuH+Cu/vlPzFnvlWwoz2aUEtklWJXl9F3OAgttS7wWaXxoVOt2dk6Nyam2qtpIA9fkwQZkP1aPqNbOypWetJ8VdXNQFpbg1TjAETG+xwgF2jkGh5uY+2hHD5FRotEiaIPtJDnUz6OcwTquIuNBEr26PUSDXpT8vL53+5nRe0IIquNr9Z3dDaOLzmiVHAslAijrKZOJMRqlgNOtOUVTx2S46SysH7eGS0V3soAj294BnauJ+7jRRPDOpAIA==
Received: from BN8PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:d4::37)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:37:57 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::c5) by BN8PR04CA0063.outlook.office365.com
 (2603:10b6:408:d4::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 08:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 08:37:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 01:37:42 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 01:37:41 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvmet_auth: use common helper for buffer alloc
Date: Mon, 22 May 2023 01:37:12 -0700
Message-ID: <20230522083713.107001-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230522083713.107001-1-kch@nvidia.com>
References: <20230522083713.107001-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: df513e52-2244-4cb4-2f22-08db5a9fd7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Ns6xRGKzluC5+WzDZjfL8uMfcLbTlSwruPeQE5cTIQskizAInCqXKUqI+HMPhoVC9CXzHkhHjjReSc4lj2cSXbrVeKQWiQE/XfhyOrm2WLeQjLVhrXaR8T+eyzNb0CgQ4BblFPOtFlyGaxtf4HkzrqH+dYf+voFti5tXArpt+69Yj/FOwddnHAfxPbS8T6uYOY/RJBG0bkKJvkZzCLYUnM7Z33ozt6bwuc9FNad30SYkC0XE8+/6gtqXew5vo5lZw+3tiTh5fGQ8wvrd2UFUse21CLX6vXoi3Z98Wr2zWiOBfqkjw7AHl7TQlaQvFlp8DfVPnFmv/Z7iDKo8T/OrzZsVIEzPv8tGsJSiwwdgkhAX4z6e4FlowhRIDZtzHKtv/bN76QiaMqEU4Z0JW1YDMDTMv00XvFJl85PMAveqKXffcro+uzR39hmqPHLLjTFRSo20rev4MyT9+OkucA6C6P/R+q+5+PrXo+p6sr9KXpYq69XEW2G+mbU6vMi8u9BMwBXqIxrxA3BcwYce7BLwBFNT0O/2TI92/hQLneg7Q44TuEeymjz7JXdiJNDjaeX4VJVdZzYgh9+nNi2OCU/DxyEaxZhoY0K7HkeQj52wmZcrq5y/tEC8atGdLybX0F00cYrbBVGmQYuUs6qjBS5jhF91nQalHxxgkUNh7sdJbykyYlDroCST0D5lVH1O57CAt34hOWRwknNMi3+p+KHpko8hHaI0DqnuDbsrm1iNCblm8G89hGbbo9+o+V3QSwUa
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(316002)(478600001)(1076003)(26005)(54906003)(41300700001)(6916009)(4326008)(7696005)(70586007)(70206006)(40460700003)(8676002)(8936002)(5660300002)(82310400005)(40480700001)(107886003)(2906002)(83380400001)(47076005)(36860700001)(82740400003)(7636003)(16526019)(186003)(356005)(2616005)(36756003)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:37:56.7571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df513e52-2244-4cb4-2f22-08db5a9fd7c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_013812_427601_974E038E 
X-CRM114-Status: GOOD (  13.98  )
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
nvmet_execute_auth_send() and nvmet_execute_auth_receive().

Only functional change in this patch is transfer buffer allocation is
moved before nvmet_check_transfer_len() and it is freed if when
nvmet_check_transfer_len() fails. But similar allocation and free is
used in error unwind path in nvme code and it is not in fast path, so
it shuold be fine.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 43 ++++++++++++--------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 6ad322b3d0a9..ad8e914ae56f 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -29,6 +29,18 @@ static u16 nvmet_auth_check_secp_spsp(struct nvmet_req *req)
 	return NVME_SC_SUCCESS;
 }
 
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
 static void nvmet_auth_expired_work(struct work_struct *work)
 {
 	struct nvmet_sq *sq = container_of(to_delayed_work(work),
@@ -207,25 +219,16 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	status = nvmet_auth_check_secp_spsp(req);
 	if (status)
 		goto done;
-
-	tl = le32_to_cpu(req->cmd->auth_send.tl);
-	if (!tl) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_send_command, tl);
+	status = nvmet_auth_alloc_transfer_buffer(req, &d, &tl);
+	if (status)
 		goto done;
-	}
+
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
@@ -440,23 +443,15 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_auth_check_secp_spsp(req);
 	if (status)
 		goto done;
-	al = le32_to_cpu(req->cmd->auth_receive.al);
-	if (!al) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-		req->error_loc =
-			offsetof(struct nvmf_auth_receive_command, al);
+	status = nvmet_auth_alloc_transfer_buffer(req, &d, &al);
+	if (status)
 		goto done;
-	}
 	if (!nvmet_check_transfer_len(req, al)) {
 		pr_debug("%s: transfer length mismatch (%u)\n", __func__, al);
+		kfree(d);
 		return;
 	}
 
-	d = kmalloc(al, GFP_KERNEL);
-	if (!d) {
-		status = NVME_SC_INTERNAL;
-		goto done;
-	}
 	pr_debug("%s: ctrl %d qid %d step %x\n", __func__,
 		 ctrl->cntlid, req->sq->qid, req->sq->dhchap_step);
 	switch (req->sq->dhchap_step) {
-- 
2.40.0


