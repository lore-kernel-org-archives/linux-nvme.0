Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07798C77B73
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 08:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FlgbmVZsXEExaMQ7PLLz+vCuTzleyQdLI7dKmnrKbG4=; b=CGhHzZzUTDtG2RPJLFwL/i7rB2
	/rz3FcD00hehiTnE1q/DNvFge0m6V/pBfXiyNKK4ZtP7TY1zrSB/w4lJc72ZUJ1lAIrDzTReJElZT
	mMpiIZ3el7o9dUCVPjnRp/yxXAtalWts3lWHKqz4UapIp5T7qHtPqcHwXP8wE+Aat7ySXrV4Kw8O+
	cnaWpYY5B1wpdwfkJKCTyQmsGWmJZSKAHE1Mapc8c7R5JncUSQr5BnKHTRFIoOWMXSRhD/bwqQU9m
	P9CP2wThswEMUDSna3vp9Ziix6nLADrzvfgq5QvnN5m9gPxQ8Pgi/bJ0iYFBhDwTYCOhRArq5/bR4
	F0B44XBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q113d-005mF5-2j;
	Mon, 22 May 2023 08:38:21 +0000
Received: from mail-dm6nam10on2062f.outbound.protection.outlook.com ([2a01:111:f400:7e88::62f] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q113V-005mB4-27
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 08:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ZS3bkljEoMtDKaaCoV02S0U5MSDTuIjSXaMg+S8QFmudhNDaRbnS8NwUYKt/7Ou0dSKQZhQO4PYgZEL/VPKr/P+V+dRyf472EASmyzZNZhu0lqDqmgxLbVdp734GO5CnG9aI75VMLGIk6xpDWZbhTKz2xGg7i4LE881Sh8Om2+CaXELtWAokYLmd1oq95KZ9mC1rT0QGV9gJIuODZEEN29W/MPu1ircvMtj/XJKDPWfWp/bQUT9BOlnPjBDacyxiW1YUzaYTgO7mbrgdTagY1gkac0hNCalWF7QqlmPy1ki4VvTuLrc5LX6JqE6N+N68VrX8HcEe6hgcihOMddoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlgbmVZsXEExaMQ7PLLz+vCuTzleyQdLI7dKmnrKbG4=;
 b=CyLGNpFuWFhaSRjZPOSVRTzgg2egk5/ic+hDi4cSZ8ISdQws39yrfCMgoOrRrWetjkEpeMV58DhyAlSOHSzamHmQja/uStZBGFqCvYFQeA4wZLqkHDA7C5GdpvMle7lEGa7jnY+Ub8BdwSlNDydHU3FPYQ+1qtJj6pjsQejGO+rC25G+zBGptDuIlj2DyeUPct1ysgfhENRyXb5vdn5mcA9vIJzYTcfnsAIG5i2aWxhdFHyFs6foNGBkEGNVudwYd4C9/GFWmRq0p7CNLRJ1eUdENDgXmtTSC5DPiZpp6/l6Qt7CQOCUcS8XuiGQGV/yZEOl7yfLBSU+OJJkhkhbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlgbmVZsXEExaMQ7PLLz+vCuTzleyQdLI7dKmnrKbG4=;
 b=rXTH7j9CuG0qhXEbM5CQ3v25RrSM2meuFrUlDLhFKcjBn2qTlDapKwcqh5J/zSvYBQizyuNQRpikx58L66DBvGEgdvdHnLy9uOgnqax4hE21ZYEoxgfAYX1Iqhy9tblkFz0TJjDnFocLoD2rpAg7uOY3ozsZrCmjXGAjmoq0eKlMW9AkqRnvLWF0khrOTzQ5Le8YePXhQaDkVP2cUe8JBUvkHDyYrC4z2Y5ssU27yYyRSod0Ycb9eKu39NwO3DzmAP2SfWPQOWUol9WJT1HThq0opqwS4ONo7ZJEw0mIdr1Mzuw6NVUcTpBr7GCt3JkIuRIH9ulu6cWw4sZb3FGBgA==
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:38:09 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::ac) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 08:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 08:38:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 01:37:53 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 01:37:52 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvmet-auth: use helper for auth send/recv cmd prep
Date: Mon, 22 May 2023 01:37:13 -0700
Message-ID: <20230522083713.107001-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230522083713.107001-1-kch@nvidia.com>
References: <20230522083713.107001-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 85174baf-9e44-4f2c-7513-08db5a9fdf78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	AVbDWicTOj6fFj2jrnpIrxswLvEMkZoFOPgp9myuzc6OmbM5EUCFGRlBuC2XxNM46XQWbIIBRs7SqN2AeI1XpPCdgq1Rx115HRgKdomGmWrO7saDN/UOtuik7htzOntlr+zy6RjlKNh/eP9OIvsYCsYk6dLCNYWWR7t8WhC47piX9YrN79BXUR7pn1tV70uK/SLS/JzUq1OnjY2CoItCBuDWh8hbLOL2kQG9vuP/ferHkUQZ2HKaqf9jtBk/lefR5Scqeh+MlWuajolcQqG3iA/H7C7ejorg2e6C0I4H0/6YxlqgHUcT40bqdTWAMKJswcKyMiWb+yG96g1o9g9WW2UhI39batH8gvYie6H0GI+WZH546YllU+uc+zlNhO18DnkmsmvBlPn3ic04Wnf77AKQH/g/blWuzmrsBjaL3vTDDgeqJSAXaIo55yP0lyKccekiwkykpd71kBv74F5Vk95BmCTh22eZ1hfyCryy7lBMvEP2jM8RM1PdcfEmAHlVwqdpC1vi3QUTc4bnSDEA+oxpBxzDGaRSX36ii2ZKu/+ryaD9b3XX3wN4TQmgkwgDVL9EVeglZoQeF1FUDHIq2wB7yUqwsj+BAMNgu3BQqPsL58mx7IwqCrBibi2uTyY/MSMD3aZ+oZTXWWIh09K7NiS+pnSgjB+5vYQvzoyEBlY10PNnhvK83+30ostQsP2o3G4yXZ1oN9YpaepwGtzWdXxLrZNBeggFW0pSGDy7cX30C61sHjSGQVoIo74UATJx
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(5660300002)(36860700001)(47076005)(82310400005)(186003)(16526019)(26005)(1076003)(336012)(426003)(83380400001)(2616005)(7636003)(356005)(82740400003)(107886003)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(6916009)(36756003)(4326008)(478600001)(54906003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:38:09.6695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85174baf-9e44-4f2c-7513-08db5a9fdf78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_013813_699952_9CA27226 
X-CRM114-Status: GOOD (  10.61  )
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
 drivers/nvme/target/fabrics-cmd-auth.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index ad8e914ae56f..8200265734e1 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -41,6 +41,13 @@ static u16 nvmet_auth_alloc_transfer_buffer(struct nvmet_req *req, void **buf,
 	return *buf ? NVME_SC_SUCCESS : NVME_SC_INTERNAL;
 }
 
+static u16 nvmet_auth_common_prep(struct nvmet_req *req, void **buf, u32 *len)
+{
+	u16 sts = nvmet_auth_check_secp_spsp(req);
+
+	return sts ? sts : nvmet_auth_alloc_transfer_buffer(req, buf, len);
+}
+
 static void nvmet_auth_expired_work(struct work_struct *work)
 {
 	struct nvmet_sq *sq = container_of(to_delayed_work(work),
@@ -216,10 +223,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	u32 tl;
 	u16 status;
 
-	status = nvmet_auth_check_secp_spsp(req);
-	if (status)
-		goto done;
-	status = nvmet_auth_alloc_transfer_buffer(req, &d, &tl);
+	status = nvmet_auth_common_prep(req, &d, &tl);
 	if (status)
 		goto done;
 
@@ -440,10 +444,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
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


