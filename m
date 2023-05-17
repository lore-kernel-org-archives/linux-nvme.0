Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D93C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 21:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UGOBkmDhpema1wUjFC6ERHME9aB6xhLKqf/9+aiDb6U=; b=hylsbx8vRDajmi+UIWT5pZxPP/
	U1c7OW0B4fkP0P4PQqippY2CFfy/3OYIQxO0o8pIKlKUlevBqtHgOAOTEqjDviFJSfqCoRtI8K0uj
	dc54nYBr9BXOjp2EEsvQzFUiaUbxjBTwV7hzI99Y/uDSpvitgm05LwVBpiEZoPVHTqrI3vlHOrsdD
	BSHQ56pHlOVgKQ96OxlV3CUDUsIMZo6t3vQ1st016zZAiTXhsPqzHrrKxZKGYdCwXxbEgYxJv38O3
	EsY6dVAUQJj1kTRvwGmctUWx+MSO9nvgolfGuVjUKgbJvfdgLZTGExgIqTqpp59XCJWL0BfJ7mLZH
	mqYVJTdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOlc-00B7pL-2f;
	Wed, 17 May 2023 21:33:04 +0000
Received: from mail-mw2nam04on2060c.outbound.protection.outlook.com ([2a01:111:f400:7e8c::60c] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOla-00B7oj-0C
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 21:33:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYllYUTO/j30zjdW/2eMo1Zrirr50OalG74K+VfBOiCwpFhEniVK9vaSHHhpKmCAOLiNwJ0WTsL/TxOT7APATS8esL3rfQuM8ijyZgMtV68+VYEvXwbQWYJD3Vkjl9OscnvkM94KGHz/SQjlZ014awJjdJl1lM4/Dy8t6E4trdxE0aSKzEsmDXGBlEnoHql8cvpHgDL/skCUVhtSQf5a2wyNuNVOofDA80GWmzslqbkAcrKePJP1UGHqbmkxD3K8lQDk7vvoYqJtME5eDKlBYZHR+ng37jFaIF4FZbC23XLrHAD2LFMdM4xGtMRdeiJQIhuZWeR2ogeBmNamZWxI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGOBkmDhpema1wUjFC6ERHME9aB6xhLKqf/9+aiDb6U=;
 b=JdvW4RWjE8ibGn0bg8U/GgeJHxLrjHVr873oYPD/qrkQA5WAo2+8lqdZsRh7pfEDW5wNF02b+XkS6XiS1nGPUKVN414OY4dIXN9j3dC3pfhac9JXZd0EkFi3hRvrfvqTco9rEaKNmiah2jMfs+d83dvUArIloWx10Y3wmsh0YjC4AnqfyXJD/7OXa+oZb2ouU+pq8jHnytQBSH0h6baL2KmPlMjxeFIt5jCmV98YdoS1H0NZ2Z2BcLISfh9UG46xoHyv748Avj+7HDiu/FqHwyBJaNH3W8o5ZFG3DauFPNUFf9r7y+GRcP5rLua/2LC8uEgBETDslbQjmrWPHIWp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ds.gy smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGOBkmDhpema1wUjFC6ERHME9aB6xhLKqf/9+aiDb6U=;
 b=KAoAkJ59I5uX/Fb6YqEXH1LI5U2y6pY6raghmoOcc91E8h/jKt2Ehh6Gx9OtiZUk7yn5Bv0wV+0t22XM4dIE/ZvFxa9onOjkUNU0/476hO++QawLtcodVK7mcPySw5p+Cr9aACkWNNgFL+DkSqV4ZHSeS1OW7DHWDtgkSmHLtLsVoJACUWhapno4uXraRCUqU3NUvl57jf1wldQFYH/BI8I38vUXyz3QVjKW3tTWBLMdbqxwOdh8/GYFKgBoW6RxbtQRX86RE18OT5LNu+5M2RIDcz8MWEfFQixpt3j07wiPJomLX7Ik5Nfqs3DU6fjPeceFCW/8qxzKcY2OPcIcEw==
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Wed, 17 May
 2023 21:32:56 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::ec) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 21:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 21:32:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 14:32:40 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 14:32:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <dansmith@ds.gy>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>, <hch@lst.de>,
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvme-pci: Add quirk for Teamgroup MP33 SSD
Date: Wed, 17 May 2023 14:32:32 -0700
Message-ID: <20230517213232.4977-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca1a499-bb6e-4cbb-9066-08db571e46cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	mh4PU/hnJkSIbSpdjSJD8N5xjAfJtnOhvN4gG7rnGlXla8hwSwhvEJV04nb+P8vmGXvaytsFpiCh+mwXE+g8XbZuCxHYu8KM24RONSWm6FcBw/OHVoPK8NJAoeJfm/1FjuvekA9Z9o032H85RnP3BRmPZe0s+RlphlMGhuucyE478GT+cZ/d25omp7CDHry94+iTgJ6UHxD26oZgJTU8736k2Xb929EdUjqN+h1WpWRsjHc5airyWDjOdgZ3GUDFLqzxRnuSBkbP1/prsbReqch0Hnhiqk7eqMaQQhWUD3i8LuFWJ8+pw9C693jMo/XhVW4hGX3w61u/HBARjYlmlbwUSgeJCdugIYit+IxC6xr79s7xT+sCb+0gFe8Dc/ilCr8mnWYrVaQ26WIGkh3Gli5ximPsSvqVKEQlHrI647mQbVOzRmifZilKHkds8t280elNR82K5UXLHffL0hUhLSy5jlauX5Yu+pkCTqqLHav8Y710b2CfT9igpBtfZq3BHrefzRBdUOEVAwWULY6O28YzLYXoB7CwpIWjQpzB3mf1TFHy9yw75S8s9+9sCHJmgf1VNX74O5IBHlTaNzAU1j93tj07Zo1ZUxdmLw1ViNd+ViaVKUlR2uWZFS9PNKuTorzxnuDqA0d0G4NFWf01grTiG8/anx1oYTN4zyxw7uH4oM7JMLzBvlT0iR6q1WYDLnCU6TqeDiWhzbNbtQ1VMjYMFrailihbv67z0j5JE94=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(8676002)(5660300002)(8936002)(336012)(426003)(356005)(82310400005)(16526019)(186003)(107886003)(47076005)(36860700001)(7636003)(26005)(2616005)(82740400003)(1076003)(40460700003)(7696005)(6666004)(54906003)(41300700001)(478600001)(40480700001)(70206006)(70586007)(6916009)(4326008)(316002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 21:32:55.0138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca1a499-bb6e-4cbb-9066-08db571e46cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_143302_120700_25DE76F7 
X-CRM114-Status: GOOD (  11.85  )
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

From: Daniel Smith <dansmith@ds.gy>

Add a quirk for Teamgroup MP33 that reports duplicate ids for disk.

Signed-off-by: Daniel Smith <dansmith@ds.gy>
[kch: patch formatting]
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
Hi Daniel,

Can you please make sure this patch works as expected on nvme-6.5 ?

I believe you already have the git repo link, above is the right branch.

-ck

V2: add original author.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b027e5e3f4ac..b36c12238f1d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3440,6 +3440,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.40.0


