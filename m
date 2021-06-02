Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF5BC47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:13:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A356E6135D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A356E6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dKGtSuGArS0Arx+hy9dFcBPbtyh/DOVzvKyTXH7DWyM=; b=uPjvzK4SlexbRz
	+80zk3g6U4RcuegIAZVoko9W7rHQ3XQbgY0LklxwOBy1bQnYb4kCE9frKPNGTt4Amg1KSLivFCjnM
	veoy3f7i2OeVTxOOTttyp3xQneX7hI8n+4tMDiSIplA/+u7Kx25cPUQxq4Y5/tfX3dH/IB1XFnuwo
	dY/1Q4Pg9L5eq/nMUuFjf9qvsvE7sxQvVkqDNtp+ug2y05i3o+Frhu/8AprfUSCEP1L4WWakM2jnh
	asn797W6j3cRasapFiHvgBjhHka/58bmBQ/BQlD/M64uNMrMgICx0PcGtyOS0QiWl0JT274S7J7V2
	9zjYkVaoW/vDT93knjag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loOoi-003dq0-Bg; Wed, 02 Jun 2021 11:13:44 +0000
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com
 ([40.107.94.69] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loOmV-003d1A-7t
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 11:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi+qiDfRl0oJixSUzXmSmbs9/Z2Q/4XaeYeLK3koo1RvCGKr/JilhTZeTYLtnK3aeRDWXHX+xKU8kkglCasZFqTs1PRlNv+JX3uR3H5E2cAokJ7nLBJ7Gmy3SjfIVafqLh4Fe0d7Z9PkhcrRriXYlfhm9rjyHs+xzQsekx0K4emiIXeGmBL9o9WkG5vNgopgjUAWSEnm5BvVnfjb+4LV85hG2Nmw8S1LhRHTUsc5kEjq06W8yBoUTgAZef7opGw85bK3lc55bJa93H2RRaNTWrY6+goQ/rZ6Kun/uSaCVLFX691V6wHEpaA7hQamF/PezQf7fFFLEim06+7q7anNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp7IuMpJ9U0NqgShabv/Y0L/CA65SjPXDaobUleRmd8=;
 b=PNEoX/z8gCgE2w665fXWJdJRkf5JwUZ1U4Mmn+Wzvr40pRwCnPmJoY5Il7nDtrrdI6U1QJDHM0RAZn73VYqolv3nBmX6AwIvlK4OfCqdn2CfRO33jZNlq9QiB7oLkJPT/RoVNdT7ZddAXNw5ooF9POUsXGlMG62X7K7A07t1ADR+S4eixm7qazDVHCcJ0sQHIKWRaava6VegHwRsMh0PgH2A1UKz1Xj5++9n5SrAlPPuFj41Yfp/i9T/G+CYIyGg0xMvgP1UD/XmnOxlH47uFVvHWxJQW+o3NzJJi+us2xREf2panhNJHT6d10tUOQZjf3usaAVvbBcepn0tUn25EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp7IuMpJ9U0NqgShabv/Y0L/CA65SjPXDaobUleRmd8=;
 b=eUbN/G1ijeOUp7lPkjk8ei3K73abaSiTZVYiRuaaFpINiVKmoM3jU2kHKlY4A+WGgb2an3ukAKfmZOOxVuHvaWYXlQjH/AxaPWYFsjECpbD6xumUulQtMifsp1EDjcDNIMpKmi6MlcYlgk6u0m+lZMR+Xph1Ce8wYmPpAOWACw33s/ux6oHkbwxgaQT1TEHRmrV5nbS1K6Bhuxrdr83zI6UTKhA47BI6M1bdfoeSWIIzM4ueYPvlRaGdVgiltouWS3vxAEBKdme8LABI1BR6sFZf4esNk8TsmuC6Ta5T9WpBdw1sWyTthZSjA9QsxcIooVZMTpJS7ZSZ7lA/hdecwQ==
Received: from BN0PR04CA0180.namprd04.prod.outlook.com (2603:10b6:408:eb::35)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 11:11:24 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::d6) by BN0PR04CA0180.outlook.office365.com
 (2603:10b6:408:eb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 11:11:23 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 11:11:22 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:15 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
 <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, <david@redhat.com>, <oren@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] nvme-pci: align CMB size according to P2PMEM alignment
Date: Wed, 2 Jun 2021 14:10:55 +0300
Message-ID: <20210602111055.10480-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210602111055.10480-1-mgurtovoy@nvidia.com>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e31bf6c-e93b-49a2-d480-08d925b728a6
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39376F99F0AA4FD431F2D9C9DE3D9@BY5PR12MB3937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9snbFuWg3E52P/OZX2uT0NdJdTK9HAemaXdVFldGDRVjU+lvDbiXff6iPQIanvwBmuB4oo+GifMkH+JWpUalfki+ZNUph4IlqXflR+AdwChWDiqvEDmh92/jAaO9UyMWWUcdCaFEwm+Q/bNQkxFcDSG/q67ZGW/LooUjGUdgkoe4xdUHJq8pvOZo95KZKdX8iUZSXTXc6LmuNQY53foaq8dySBqE6/HCznEWTbzGSJ8ypgybp+n5ZL7ghOgsUU4+dP+VW4dlBmMsZ9LFYHyTGl4c6/aqmkufcgMicnWzXpfOulUu9kZb7yujxiLYTnv5QQKffIxCf8dj+CQy1nV4Sys4Y0pd2qEqHMXMs58McYwG0nkgeTZw/CLU8pJ0YFDL7pwrCT/7UY3rh3yUHwjd/K3E/ZkX9cb3UVt1T/kpKVNKIPMvU7Hy18n9NmHZUToJEFsfesfeWB2vDJzNWPAwcRzyioI/l/VImMK47o8RRl5W2et4e7DGgBEP/ibZMkFezNskgJONfHtha1D4DXv24XETflVL0Gz+cqLW3XV5RPjM8qfcLYPPcWKO800pmYWfZEzVbGVJHblqVj5Rh/3KYx6j/AtYo5N41WD3IAQzcOGr74XNWMDlrW+XdyPkOB6GloLyOJzHW81svqZK7iI0nkM6yKttr/g4AOKAyc0fLVis7C0IoqbqyO03jfZI1+iU
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(47076005)(4326008)(83380400001)(478600001)(186003)(6666004)(107886003)(2906002)(426003)(1076003)(70586007)(316002)(5660300002)(82310400003)(7636003)(26005)(54906003)(110136005)(336012)(86362001)(36906005)(8936002)(356005)(2616005)(70206006)(36860700001)(36756003)(82740400003)(8676002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:11:23.9151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e31bf6c-e93b-49a2-d480-08d925b728a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_041127_334834_CA46E343 
X-CRM114-Status: GOOD (  10.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

P2PMEM is using mhp framework to connect to the memory subsystem. In
case the CMB size is not compatible to mhp alignment, the CMB mapping
will fail. Use pci_p2pdma_align_size to align CMB size in order to
successfully map non-aligned original CMB.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..1197263b4cd0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1817,6 +1817,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	u64 size, offset;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned long nr_pages, min_align;
 	int bar;
 
 	if (dev->cmb_size)
@@ -1856,6 +1857,12 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (size > bar_size - offset)
 		size = bar_size - offset;
 
+	size = pci_p2pdma_align_size(size);
+	if (!size) {
+		dev_warn(dev->ctrl.device, "CMB size is 0 after alignment\n");
+		return;
+	}
+
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
