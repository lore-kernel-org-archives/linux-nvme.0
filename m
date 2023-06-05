Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFC8C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8gIllnqL13i3019HsqhpEN0Y0KgFMM/mnWVcKWXR+g=; b=3XredtG15k9UnDHCr0xvR+o65E
	CxTo9CmMeY3Tt5gftykl0GCKuqrKyrlxMxCtMotdZnh4/iocF6bVRa3oqsJiUHrkxQyDsf6rZs9/t
	chHHXDdSfibXmj3wn4c/s1DP7QLLVIMoyAc8YW3gmPv/uu7rZWER1+FqiCq9mvOKEZJs/fG+OwTgb
	PL+WDsHNUnyaffL3K3ALAKHPOc2dMox5BAt6GvNugJ3NYdPFBu/l1BlAkIl6HI2OmVKPXxC6niM7q
	9huhHP1TyEB/mR3NpVSGfYVjeHrZ2RzH6GzEJj+1egv3O9aFuBpkc5xqNXrPekm3kpLnl8ddNMd5y
	Ae1l1plQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q63y6-00EQ9Z-0F;
	Mon, 05 Jun 2023 06:45:30 +0000
Received: from mail-dm6nam12on2062f.outbound.protection.outlook.com ([2a01:111:f400:fe59::62f] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q63y2-00EQ7Z-34
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCxfvn8r/KAhRENsmHw1M98p6WRwIdNmvzOk7VvUPaaPL0BsKBs75M1yhN+dqv5aSf5OQ+47LQKku/1NBXU+e9qZvUltnKPuFegjLxuDHmd4pPywjis5k7t0SHhuwebwtK4sPjdbBgVsufNRWIMivFVzyDF3Y/Q3U1f+MpbNIjG1eKCC+ohuNfroOCO+e8ti25X3haKeIgCS54zvb8xvINnEAPN06FleBYknyPbj00UGWyrnBuNFrhZ2wheInFJeiwMiTOJEcKpUhjUGw9ZcuYGPnEAz869dS7cAFQwbdS1TUDJe8J0roikZCjEzgEAcIHE42OYhxDzZ+Pn58iALOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8gIllnqL13i3019HsqhpEN0Y0KgFMM/mnWVcKWXR+g=;
 b=Q3ZOpdfCRIWWx9CdomHkP/v2Io9U914mhasgOtEvGl+10E3lzcrn1FWB6Jq0QBIQrkLVYT7v1xir2YhlpWbgy8GUe4UJixl6ijL3NkcLlPzPS2BoKx81WGMlkS7QbE5AfscvrpJUQkeiJFGF8I+LHcDC44ICRLUa/oLhdI5KjR0wCwqNuhRDnlINKN5ewR5WmZ7Mp8+hx0w2tsaFfkA48lGv4hxKEedQFIXF5JFTgd/BeoZCLki3mX3LTwYQrBUUjP1ZXXhMqynxNwpZLsBLJ+RPFF14MSVkIZQ94AG+5zDNwvRYmNDc2dVcHfKtpG84TyOdL4RTHXZQ7Dfthr0HZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8gIllnqL13i3019HsqhpEN0Y0KgFMM/mnWVcKWXR+g=;
 b=lI3sVFL+eViiOVn2M/HQB6op2u9OUp1Ru0cOLTufwiMBcRDhcR8IaVS0urXUIhuWwcPMLVFfEKGdvBqWl0qIPN2/99l4THQkgm89yDfHmNl2Z/XIwgX0En7bsmWJua+8/Y0h13CGSVjc9CVI+1C5LpkcqYIWZYBJxQjpck8ToLo2iYDJNYmwblBa71CoJJgv/LGP6pxXNnnKuUVTNSbxJgYNYDXkggCBmI1inKXxd1H8ERNwTM0GB3QoZugarhywZighIS3gaG1SwwWIC6CY/VfhI/y+Bh7ZGHbP82ZheLBLNiahHt/DiksZFteHSBSiDvamo87f7zsoJITRb5+xfQ==
Received: from MW4PR03CA0309.namprd03.prod.outlook.com (2603:10b6:303:dd::14)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:45:20 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e4) by MW4PR03CA0309.outlook.office365.com
 (2603:10b6:303:dd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 06:45:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:45:07 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:45:06 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 2/4] nvmet_auth: use common helper for buffer alloc
Date: Sun, 4 Jun 2023 23:44:32 -0700
Message-ID: <20230605064434.45233-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230605064434.45233-1-kch@nvidia.com>
References: <20230605064434.45233-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: e720e46d-87ab-47ef-6301-08db65906dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUEhuaifx2Xcdx4NsdyXJwDXaBy5fScMp9i9CfJNTxiWn+fc59GvuUeIZm7EZn4fynK2/Ypzb/kz84AJqLF3zjdLAMxCW/ZOLSKTDVWvXFCRPDjlitgDpPCy4Qm3dIZURvcYKBIq9QbJsuXPirZof9oAVa51kiuSrL59FcCj3YR36ackqmEGDeuQLvhpvsoXLlqgge+llABenpsOjr/IJrJbV4VlW7cRce2gSiNfEVEpnSWo0ypQaG0Y6C9T5492b419zym7Jb27Ps1d0E6tDz74qukl6tbrdqSbmczIHxn/J2P3uptYrp1ckE2hhV8UxYMI+HFWEtwsrYGgvIW3vTHZGatGfA3AM/7aKnJQuOYU2DcQCgAi4FJU+IBuwCd9uX81ngCnHuGJ/Q1JueW1lWe/qW4ZUHZB6fh2KN9L6S5eq/XaQu+qAoP2bYWOycQVY4H3ABVsmr8CfzlmnEMVAAubjGPso+wK3VB9mkQOXZtUEjhWkbtWcuazotDA/Go9kqJKPa0gksSHDdxWqimlPQbIBfHdK4WUR0fszilvo0FrB76N+JTvLEiLUWDgGYCI4/t1ZPFUUmIhRhykrOnXq3Ctk6y81coKiX12MaKzoTDf0xBE4TTSAghALB+HNylYDQJXPGaEL8q4kxPPOe9ChNCxdNDei2DZzuBLFDpYdVAqoaAeb3QMVPhYpJqA5h2iQXAffAYs0W06IPXOLINiE8ZXuzHufcsFye5BmNM3o1GEaU5EOcqiV6wbj+EFui82
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(107886003)(40460700003)(1076003)(26005)(36860700001)(36756003)(47076005)(83380400001)(426003)(336012)(82310400005)(356005)(82740400003)(16526019)(186003)(2616005)(40480700001)(7636003)(54906003)(5660300002)(2906002)(478600001)(316002)(41300700001)(4326008)(6916009)(70206006)(70586007)(8936002)(8676002)(6666004)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:45:19.5530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e720e46d-87ab-47ef-6301-08db65906dee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_234526_988488_29CF9D30 
X-CRM114-Status: GOOD (  13.01  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 43 ++++++++++++--------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 42594e086de7..778961e231a3 100644
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


