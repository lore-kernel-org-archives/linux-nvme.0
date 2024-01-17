Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD72C47422
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 04:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JWAABv1RADCtCET4tP/xfhWMlndYHGIadvdvTons3MY=; b=hbIJCiZvNgeEwRi8opjW/soR0n
	hWprtL5D6wNEwytEQfqxbvgPScEb2Zi6nuK/roiMnTLgukthdCoHidxGxtSEw486OugyABc4nouIo
	Tr3OSSMalR5ihqUARKS999rqKtsFcRZbPThdgerTVqSLlo6KOJyYp9TMqOKsIZRc2q0TliK04KLtG
	Z8TaK2B8+rIKRxZgShK2QBEgfOMC3kQJqJw06FsXXVlkEZSD/ZERZ9Pon26jeZveewSDWTzAzYCHT
	dPn21YZPUZp32/6MiAFFuqlfLk/cOlBQVTBzoLs28giXWR3vYJRMJ7Vz24Gv46AgvOTV1LHasfCpJ
	u8ZWHJIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPxn6-00EQ0p-2n;
	Wed, 17 Jan 2024 04:44:40 +0000
Received: from mail-mw2nam04on20627.outbound.protection.outlook.com ([2a01:111:f400:7e8c::627] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPxn4-00EQ0U-2O
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 04:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itspmv+ASTQwd/CJz67fM4F+8Eybpn/QXDn8hjWnedJDRfcl6oPVp1+B2XDFt4BRexbfKtUk2aLvBvpNsDVdAqz/8eRZ1XBqbzyWTrikJFkQ+1DjazDItvOkG5xG3W0bL+S92Ak6krmY4DCKHDf0B2t+Oq4UOHldTusyh+gT2jIiMsuBVTIXhKD2Nzwq4A3iO9IH7Z/jpnzUZJwq/R/ZodP7BBsy1b1liQolI1Bb75eP5VhmmVFoxMY+1WQz0mqBiZLUAl+wd/5BUPMGbymommF4KfsaF4CYmPRStRg20wGUXD6NsnhHQqJuA4TlNz9dfjdjPhKYjAsCUPpEcODmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWAABv1RADCtCET4tP/xfhWMlndYHGIadvdvTons3MY=;
 b=DpVTfJn4EqCqceClNfGjIxzLF9m3o1pmwmRnhRaB2f2SKrzTU1bzGQHEgL+DvRSSCCDRyrgeayNQA9JWFN8m6UI1ojZSn8CCtjLeELsRNSjpQlHS7LQA++QPjfQWMgm2YHtKug5C2C2TeY0roO223NHMBk1CadMxVld/AW0WherRbuRVhGwS+/UivBUfFnxtFASje88Rps10Q5chaubjifT6NQmC54BbaOeCSRYm38zOWdt80XmLRpy6vZG32/v/SjYN0SLhA5Lj8TX49z0jnLHgwkbMb5U15dswkdtbxJpX7r/UNPFteHC/oRVscleDYd0CZ/RMawdQUOc3Q1sGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWAABv1RADCtCET4tP/xfhWMlndYHGIadvdvTons3MY=;
 b=Z1IHNCxt67sZotKIlNyIm8yBTeKYk3rkqT6/HvS1obvATBTTYrmvVDpLRIOR1jAVzHF3aPSz0BqAvlPj1ZbhzNjgtroRzGWfDJeOi5GEWIrEr3DHLZdWjI91UUs/1bC2jeNEmepPiez5FG8ARZO/i/abHc/c4KM8dOIHrr8lsVBTinP7UvNEbBK91gTVJc1W2UFavkEziLbZEfK2Ul4nF6RecUDfex7T72gLQET5cK0oZdVQmPBIeSEgnZ3JrzWAEN972EG+6IGuYgG9s7W2tiKl4d3/F8B0iwBQJqlXskIgyh0uFN8TJDcGa3Mdv8DVPvctykSI0KJRvyXTQl3pYQ==
Received: from SN4PR0501CA0062.namprd05.prod.outlook.com
 (2603:10b6:803:41::39) by CH3PR12MB9023.namprd12.prod.outlook.com
 (2603:10b6:610:17b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 04:44:29 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::c9) by SN4PR0501CA0062.outlook.office365.com
 (2603:10b6:803:41::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 04:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 04:44:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 20:44:16 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 20:44:16 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvmet-fc: remove repeated word from comment
Date: Tue, 16 Jan 2024 20:43:34 -0800
Message-ID: <20240117044334.17224-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e0e275-1aae-4f3f-91a9-08dc1716fe04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQT/jnIrWFNFixrWq209H8bHqBNA8FrBRpxEEVW+NKOhbFl1S0I3BSLokpjjTwLVkUhXqth+jTPwY8JkOgwNI3sCm7Foo52Fa/KzgSC3H12YbXQoScg9vceVSMPtHpGZNoMwW+TLUr6MtyjdmyLDv5kQwl8jVXxRqGmy/Uyz2adLkflZatckh+EaovYtMdyX0jT5D/TtL0ehBIayKDuUkhsnB+MNeIh42zPQI7jgsToszg9+U3n2+QF6fTdXEZ1n3wyMV1dcl+0bf5hefwyrpCzLbFYzchBU28r2+w0tcUM0x5wMAf6CO2yGz7qPs6BHcSJ+Qlm5/ltf1Ar5G24CMKAnmoNPyPKsrodDUd4P3+60iwlGrJoyqudBKpdV8UvRFF3+YeMSldqBAXdSB3d5CvMbCZ8lCb8j4iPzTQCnNWAM4S8TMKX62GY/fIcKW1hK7RFPqMWIBFLMQizeVGXUdpIJauTSf9ldq/9eU9cmpspLZUZAJH/whYJYUSUqsyBDpPOJx0sb40gHAW9kmGQtmNbmXcHIY/bmqWSpaV7bXnfOImgFnEAkHyMgZC0VIGG2Vy8Fmmv2lm+IvYxfKSRvaGIhbSXbM8qQQSNE8Y6Fr4nV9SocSkzS2FNW/zXeC2mnD/trn/2WedZTjcZNXGCTfQ3RVAPBUTVh3TCVH17cY7VLHswWMrkKU5C9Zky9UuQdczPKNbBKaO1gwu6nKDl1X8JWdsrLTFuwlqgpmwrGxF683I7cgCNkCCdscSyOUzfE
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(36840700001)(46966006)(40480700001)(70206006)(70586007)(54906003)(316002)(107886003)(2616005)(6916009)(36756003)(40460700003)(26005)(82740400003)(83380400001)(1076003)(47076005)(426003)(336012)(16526019)(2906002)(478600001)(7696005)(6666004)(356005)(7636003)(4326008)(8676002)(8936002)(41300700001)(5660300002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:44:29.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e0e275-1aae-4f3f-91a9-08dc1716fe04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_204438_807213_00221EC8 
X-CRM114-Status: GOOD (  12.71  )
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

Remove the repeated word "port" from the comment. Also, since there is
an ample space to accommodate more words per line by maintaining
80-char limit use this opportunity to adjust the overall comment.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bda7a3009e85..757a7348a8b0 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1315,12 +1315,11 @@ nvmet_fc_portentry_unbind_tgt(struct nvmet_fc_tgtport *tgtport)
 }
 
 /*
- * called when a new targetport is registered. Looks in the
- * existing nvmet port_entries to see if the nvmet layer is
- * configured for the targetport's wwn's. (the targetport existed,
- * nvmet configured, the lldd unregistered the tgtport, and is now
- * reregistering the same targetport).  If so, set the nvmet port
- * port entry on the targetport.
+ * called when a new targetport is registered. Looks in the existing nvmet
+ * port_entries to see if the nvmet layer is configured for the targetport's
+ * wwn's. (the targetport existed, nvmet configured, the lldd unregistered the
+ * tgtport, and is now reregistering the same targetport).  If so, set the
+ * nvmet port entry on the targetport.
  */
 static void
 nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
-- 
2.40.0


