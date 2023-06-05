Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C2EC7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 06:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThfIUbgUXKNetE3jov0A0ogRhKyXMzWDgvEooH+leQg=; b=KayFSbWeI9aZoWFhJpeeTa70kO
	ve7lWral2JvLAjKPtYeSOGLwMMDLx47O/yrykDhhAHUJK2UVBfd6mQx4HbhA4X6EA8pr0L6tPwXdi
	a5lepB1YP/MCxngMaCd7PMC8l6WaXPPQtW1HHzaqOBaInFTVjbS/+Rg9OaR1U2plI21WL8FEUvRZt
	N6vPnRakI+L5jeugr/HtRaxCZOE6TFRGuBxScCSkoWznBL8cHxeXaKAgJUY5/ckr2t6JYlbuh5EQL
	PuSdjv0l7pi7jeI54ZL3pnyKYaul2EZFjLUJMVxnymoqF/UuTRd8DutvtOysnqryhvKeFpBvhSamj
	ln90kaWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q63yJ-00EQEF-0d;
	Mon, 05 Jun 2023 06:45:43 +0000
Received: from mail-bn8nam12on20623.outbound.protection.outlook.com ([2a01:111:f400:fe5b::623] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q63yG-00EQCm-0J
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 06:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbKN+fuFSc+1b6lOZSsigrdqh+HnMucFvU2+ccZsFjc7JhLeNOsD5+GCHy8AnZftr5Nv7d9oZcUSp5S9FKQsdLgFvGKZq+A4N419uqQXZdGIgNt1JqvMzkXYJ7s6E1y8CDf2ZyMyEduCIh6p64wvF5+J7oKLOsjnC83PXTHU3j7dQld/EcJi16IaTZpfzvAPhjnTUl1J+Wk1qq2AdJS0cUAqhfQ8P/YoMmk3cvTepnxI24flM4qqk9iRSTfTuDzqdBupsMoG2hvDlVBCslHymio5aX4DNiwJp/0p1ZC5oLuiZ3FPsiCEeUpLZgrwv9+2Ax1PrlYMAqA39PBBm1lBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThfIUbgUXKNetE3jov0A0ogRhKyXMzWDgvEooH+leQg=;
 b=WJYKO9qiweLzOcSccSyUb9fiE3nKXA37THEQAu4CEhy47+fwVjmUYCexxF2X8jGOcLvxxiFRiwGYVmE0bOt8fqOJSxIZTT009trDEDePOP2s+OyYtFztwdajLfj3aOXcWPFWMv9gNl+8zSVyUefIxHe7k7dTN6Jr0jzDvYZQmLjRFo43ltup8KWX44OkOboUpLFQ0Mo5Qs8oW7hUyKKR0CJ9eCikeuCct6ncppXuuRdMM2eE23dkQ4uPLSIJPEBFHZJinkp16IutNR81zFSzxxfC3jjSlSJvwWM956oCmtzjq4tG79KF737dPm9irbIlWtRw3DYnobHLIaaUFAVF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThfIUbgUXKNetE3jov0A0ogRhKyXMzWDgvEooH+leQg=;
 b=Hu5xA7K8ciBSDuJanWxIwWKVKwEKZyfZua67QLF/7U1MC9bpZBPDPB9Auurpqvhe5frdbd/pPkWMxN0Qhdx4SsfdxlRQGIAZV7nZy8vrHoKHdJPsMPTxrafy0Z9awmlyHY9paGV2PldMPNhuQN8qS7pLX0LLPpKC7DP2mIxm2BRlmJxtaMUnU5AqA0GDSa4DQ8dl+lVbDGR956CZdJG/U8y3Eg2Ysh+pOyZGFTS5daq7LrdKXV4Bc9QcUNJtDWAfq5U3G351mvQY0Tkm4eSbFTwXDL+22vmMORoxZ7Xu7geZqyMO5ncuHGCxohoNvpOcLM+lSMS/aWp2VW0RvC1n4g==
Received: from BN7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:408:34::27)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:45:35 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::68) by BN7PR06CA0050.outlook.office365.com
 (2603:10b6:408:34::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 06:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 06:45:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 4 Jun 2023
 23:45:18 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 4 Jun 2023
 23:45:17 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 3/4] nvmet-auth: use helper for auth send/recv cmd prep
Date: Sun, 4 Jun 2023 23:44:33 -0700
Message-ID: <20230605064434.45233-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a3ca58-3b6a-44ab-a074-08db659076fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iiNvY1a2xLZkddcCdebr3WPDSAsNbsjphXLEa4S0RQFsu6OnYgoBGZfcgH39rgei/IMI+mb2eoQiNNS1eQWFLRA8PCwjz14ooTaHwyKsOGAdSqTPJboge4nvnAsNX/NVFLI6jRkKX36cX+mHZhfe1VHQs/IH2WfMxJeo+NB5hR903yIqXo+4q6kI1ffzZlfKeK7o0NjAeWDVGUtY+6l0B3yKVvv/T4/X689Oms9s6+fIG0n9WYiic54c1rRkC8BPwnDNouIPWABJMRgFHbH2ScDYRMzDP2OnlbE8ftij70YbaXOkw9da7NH/uqCVRZvZ4tURoDEDd5QZne67l9VCe0w9+4VidCiIKjjM1N8BtN+QtnCKSt+TRGsc/HC5Ej846KJRRsMly+M4Pkrym+BSap1678tc+LuVfC4mYA4XuqCYcwhdCHNdhS5mhC4QW6QXcQwS6sYpBlO6xFkaPeL/wWOCFaZuVLIt26+tDIpgrmHvK9qpF7DgocMNnRaJmhX9lUgfCNxn+slIsvIlF1H/YEXnkTd6Gr4Jkr5q6EGt3Sb9aH3FQaQWZh+kqsaC1w27/9Pq/Eumv8qJbFyrRWY9bDtu4684uSA3J2WMPT2jK1GYNOUoYJseIrLqJMsdyt4DpSHeWbxe22l6Wqcp8+97zu3yJLSI/eToKQ4Iw2y0y3JgmrVsUXMFdG1da9ASX3VfB6IQXAjw3FsT6Xu8/GtEl8XGqw7YRkK2gL/b12MUH5QCvSQ9n6HwbdI9H+X7eiD
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(2906002)(36756003)(40460700003)(40480700001)(82310400005)(356005)(7636003)(82740400003)(54906003)(7696005)(478600001)(6666004)(8936002)(5660300002)(8676002)(4326008)(70586007)(70206006)(6916009)(41300700001)(316002)(83380400001)(336012)(426003)(2616005)(36860700001)(47076005)(107886003)(1076003)(16526019)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:45:34.6924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a3ca58-3b6a-44ab-a074-08db659076fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230604_234540_140548_0DCCAA94 
X-CRM114-Status: UNSURE (   9.87  )
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

Add a common helper to factor out secp/spsp values check and transfer
buffer allocation in nvmet_execute_auth_send() and
nvmet_execute_auth_receive().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 778961e231a3..d331c22ed26e 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -41,6 +41,15 @@ static u16 nvmet_auth_alloc_transfer_buffer(struct nvmet_req *req, void **buf,
 	return *buf ? NVME_SC_SUCCESS : NVME_SC_INTERNAL;
 }
 
+static u16 nvmet_auth_common_prep(struct nvmet_req *req, void **buf, u32 *len)
+{
+	u16 status = nvmet_auth_check_secp_spsp(req);
+
+	if (status)
+		return status;
+	return nvmet_auth_alloc_transfer_buffer(req, buf, len);
+}
+
 static void nvmet_auth_expired_work(struct work_struct *work)
 {
 	struct nvmet_sq *sq = container_of(to_delayed_work(work),
@@ -216,10 +225,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	u32 tl;
 	u16 status;
 
-	status = nvmet_auth_check_secp_spsp(req);
-	if (status)
-		goto done;
-	status = nvmet_auth_alloc_transfer_buffer(req, &d, &tl);
+	status = nvmet_auth_common_prep(req, &d, &tl);
 	if (status)
 		goto done;
 
@@ -440,10 +446,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	u32 al;
 	u16 status;
 
-	status = nvmet_auth_check_secp_spsp(req);
-	if (status)
-		goto done;
-	status = nvmet_auth_alloc_transfer_buffer(req, &d, &al);
+	status = nvmet_auth_common_prep(req, &d, &al);
 	if (status)
 		goto done;
 	if (!nvmet_check_transfer_len(req, al)) {
-- 
2.40.0


