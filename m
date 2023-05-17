Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBFC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jus4yU0iPREtKu+cfVF/u5RrCMzdLnglx9XRymsgMlc=; b=p95s2iHdggiMxjUquTa4R2IekM
	jkkdxnVZ/GQ5O5+rU8M8U3EypovHm1mTmGUMrzmh7qCrkHxaW0raLTfMMFm+M+rJVH29xqeWYe/pn
	FxE6LzNQHcTLfoGgKzVjuEhzXerkO9h6Bhpxs5rhTCiWzuLdjND3AkBFeoUStSZeVwOhh/4etmTGO
	ccxk/mEKTyXD5Z7tuEVWOpIj5rJldRdUCnrodDwIR/CS9xb22xDD7vS4je4F/J2OTOKFir8wiNn9R
	CqtTpBDXx40ITy84S1ycG1WrGnMOqPDuFvUC5vQeJsygixPpvPzHN/SUedX/GynkgNKwlSHLu2Q17
	bbhELxRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOad-00B5td-2u;
	Wed, 17 May 2023 21:21:43 +0000
Received: from mail-bn7nam10on20607.outbound.protection.outlook.com ([2a01:111:f400:7e8a::607] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOab-00B5t4-0q
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 21:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjAoeDCwfCpJyXz4ciPGEi/57+f4NT5xx+S2eHG3vgTB4Mj3qDC3EfjIqA49c6fAbFKRG7RdOTpDuM8UCnMQhAhiAz4LiIcknfV21rpGaHWaYUw8GPnzAY1r+Jru0VvUQSsgPM6ASEhNMwlBB3ELLpI4hoUbS6BKmJpM191SJ8WqB8ikGmXNh6SLeWkpbsGdo8rTlcyIkzqsGhtKJko3AxhjhOEFEZQO+nu0xOJlv1XAWpEMxJaIbR9aGPzrgHFPUPMDcbK1y9DwWratH1JPdpuhnkBAqedVv45YjfBGJmhy8vsfyU6Amkh9tFW+dXLdb+ixhllI2dAIYrne1oZqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jus4yU0iPREtKu+cfVF/u5RrCMzdLnglx9XRymsgMlc=;
 b=UVPI6DtXHX9L7qDFGUSSHjVeoRIEVu7QVpM5tFEkrZmTWfH5qzDSGcfzWF6IrCJ6YwCvp6ExYQYEN11AO697PC08dBesJ9Y69e0oQzSMeW9IdfYU9l7BvS+vj1iHfy7+KddMCOrsR1VwXSUQBKiQ8N6wms6lF0RCq4Jn6XjFT1MM2vZgwnt/nzeqPXA6kLlzlNLbwtbwpe8qXbQkmuWCXJtN20ZXEkgp8q3ksDyt0KcU7eICx8Pp7H6G7x1+AwtdtBHZG1D8tRT2RQfCToZ1vo4BUI37ebZN6GxvkaEqjLfVN3DGjOjy2TP+Yjyv8O0+OLHVjkv/c77FaKFjEPf5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jus4yU0iPREtKu+cfVF/u5RrCMzdLnglx9XRymsgMlc=;
 b=hfFwi9YI4VUaj3WGE3Hfs7gj19igkXUUaA/5tpo1TC1IbTFF3RUciw9YhBFT7Hsj6cT1HIOJDFzW+CSSnRvTKAJ4o8aIz/75CEitC5y7KjrMhZ8fjbrrGdIQx+489/ZgDazgGsoMg2yClyCvpWUPQ0e+X9o5hgYON7/9SvCHfcCP+l4VFdkzu89mwywNH6H3DlcUjj7M371l5R7s2qOiZ/NwGEJuHRaoWK2fJ61EjxVXi8lg4lH4qbmGObS7r7TDWI1jB1PdH72mULS+XhssOslB1368itkQtigDeMQOrTE9YJy4GnpJV3Z3Ka8bhIJ6XAcaMqcBfa10MTzif6v65g==
Received: from DM5PR07CA0114.namprd07.prod.outlook.com (2603:10b6:4:ae::43) by
 DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Wed, 17 May 2023 21:21:36 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::ac) by DM5PR07CA0114.outlook.office365.com
 (2603:10b6:4:ae::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 21:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 21:21:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 14:21:20 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 14:21:19 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme-pci: Add quirk for Teamgroup MP33 SSD
Date: Wed, 17 May 2023 14:21:13 -0700
Message-ID: <20230517212113.18470-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e2ee67-a9ae-4396-84d9-08db571cb1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	1XlUdWoAmxsoXitZ6lE3cis4DksUr+/3BzDjiBy7x1C2pQOC5qDl0gbCl5scdTkJX7iLA9FC26JSBVGptuf0oohbr0OrR3DOc4qd0AQLxGz2yAWeM02Z03WKll3DmUkEzRWz8yDfJ4ZI7rZcxqlsE4Ui2utz+/kaGBhfF/ypmAapwqeeFHSH94rVZ+KTrf32EB0DLC7LjZm66ypdKIFebfK3N3Um+CbICZdG+lHZymSyJH767MwZqEcQ/VDuOI1pCWB5aVhfO2Q9HDStGH/h2l375xaQ9xIMAIFYG9T7mmA2GJEjxVfBQh2qz5WbAJeJYrBquHFLd1s//CzMG/i2RJdrR/f8vxxy8+mYz2iP6CaBkJbbWyt1klpOFraCtnU488NIdek2KLPA6EYuNm5qYoP8DQnxn6nEDIgUttMYfpGF+s+W/OCKdY81UuVPbXQ4Jny3we0rLKmjwyHVzJ4AMNy1GrKcibwVtFhyVUyIgIqOlCYYyU80rHyIyjgruv0XwqlwlfrmFm4glD/TxizsqBArtdr/nAuzVaIZoxUebTIL71CCnN2Djj5gML79E3PqoGBmkSEyVPKoXAL9VdCJiJwsktq2hnQN6FKieICcL7HPNI108sNsv/UFuxohEVrNATeUH1llbrJkgTZ3zLXrj6GOOOgKE+RdtJ5kFgp5jTkYe/2mvGpJRTfleaG16a0Oz825DxGTZe3yJFUa5xtioLbzEzVicoUPh/qTp9YSCgsHgNM+XvQOEn/DoSfYpJ/s
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(70206006)(70586007)(4326008)(478600001)(54906003)(316002)(6916009)(36756003)(7696005)(47076005)(107886003)(2616005)(1076003)(16526019)(36860700001)(336012)(186003)(26005)(426003)(6666004)(8676002)(41300700001)(4744005)(2906002)(8936002)(82310400005)(40480700001)(5660300002)(7636003)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 21:21:35.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e2ee67-a9ae-4396-84d9-08db571cb1f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_142141_303019_8C7657FE 
X-CRM114-Status: GOOD (  10.48  )
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

Add a quirk for Teamgroup MP33 that reports duplicate ids for disk.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
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


