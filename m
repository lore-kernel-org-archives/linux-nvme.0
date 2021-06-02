Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E02C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:13:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC67F61159
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 11:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC67F61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RidoNko5M+cD3p6LlcD1TnfCW48wxPpFmrVKBZwk03Y=; b=XDtcs3j/rkarZL
	MwqSWicZjYGTNdJpRakCv6rMM3fN13U98r8NqTRsncMRleuhb5YqyeseLevdNqe+7FRv0tnUw5jwW
	/6Fm3xLrJdSsC737CCebIRfnjsdtQDIAWUe0H+SoJIBs7/VBMxtDFdCi3wFd1MO2PdKJpSdRqGiqa
	53D8ugdcLs4wxRl78xIIEX37bq8U0Id+IC3Nl9194lOAvYudibcCol5i5bi8Gv6NpFHfd10D3hMMx
	Nk/dY3MyUFyw/xaHaw7lQxA8Wht6YF5EYl/kiaBKsMI0Ot1Uzw8By9hOIcDj+wpQ5Pla2CgfQeVfu
	whg9i0TbyQkjwKSGwMUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loOo6-003dXF-Rv; Wed, 02 Jun 2021 11:13:06 +0000
Received: from mail-co1nam11on2072.outbound.protection.outlook.com
 ([40.107.220.72] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loOmQ-003cyN-NH
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 11:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJFhpHkFDwBzFGUkJd8h6wpxgkfeIlu5qJvld0Q7JREOZQmDRECU1IeFmjb+WJkXPdsio2KFq7pTspcOjc1tg6bdESqT3cmJt43Q98g7M5X8IsPIO1kcq9MmlmCLJ/HQed8Go0QNUXKpJKzY3vick6IEd0nGbg9SPy+7TcNG6lZpNe8R6L70xBmbbeipjdzX0i+tXOuYm0bw302UpNglp8F7y1lri7GWV0Tbr9XnpPCYQEzQ4jKS7Nz59Ev5J/YZYVUjUUFlxtSuVsQVUOh3KZje5sYQ18irrUiMGlRLsgqu/PXza+NPN2zrJEfbUufXD030y1iTZi4fgNwMQiO9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0StqHEnUe14CXfF6TtO6H+7gFUFJm82sX1CYxYpDh/Y=;
 b=PFNHIJGFwNDFCnu+cVg/vOuR0kjVvcREsnI8RWNfLEnhLo1b9qho+B6wcBBqaAqgAoNGlwIn9kpUm99rsgEvEtvt8oOB1/xQDgDbWzrKnvJHDtc76nqlkamtAhSu7qzOeKNvOqYjMyY6BVFb6fCKDUe87nlBXkEuKWWb3eTRNpHNRcrwl9KjaO+L5h63+n9aqCNrrJ4BHJKewrkGx5BANvxwlhyGAw4ELTarQRoFcX0Q32hEDV+OFJB2n34TEhTUZfJjSVLOSDAqSbknv/h2ZZz5IDB2BXuRaD5qwJOh9y7IXMbc4rAg2PWGhj8b87TzB/AO7wYsvvOUPtVHL+qxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0StqHEnUe14CXfF6TtO6H+7gFUFJm82sX1CYxYpDh/Y=;
 b=SELfwH8iMHv0oR1x/PJNePwhrbDCLRzE9dCT6FIe9RAY5Osv+OWe1v3N//InsYgCxcteF0Qr/JwkzAX9cslxXIiGepxncZbfxETZf6pC7bDLJgHLv8Md4XQQIW5h77cX+bbyzlZvo5lL2aGfivQ2c3fC6Eo12rJwQ3Mpn0gL+PjM7Ts92D3eap1wmy2tom1IVMrPWxFl52qs7I4N/nnO/T7ZiTWGZkAkzkkzuPMRBBRDD+AM1H2kz5MYLbGdu3SLjr2QzJIGc6Ttp+nUTF+ky/Sk19EfAHBmldJ+seVcfX0q+vXmc+wpwnsIm/orHpUUYqZqN+uYVWy8s0wBg2k/6g==
Received: from DM6PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:40::26) by
 DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27; Wed, 2 Jun 2021 11:11:15 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::57) by DM6PR03CA0013.outlook.office365.com
 (2603:10b6:5:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 11:11:15 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 11:11:15 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Jun 2021 11:11:08 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
 <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, <david@redhat.com>, <oren@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
Subject: [PATCH 2/3] PCI/P2PMEM: introduce pci_p2pdma_align_size API
Date: Wed, 2 Jun 2021 14:10:54 +0300
Message-ID: <20210602111055.10480-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210602111055.10480-1-mgurtovoy@nvidia.com>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c7314b-72fd-4ecf-405b-08d925b723bb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:
X-Microsoft-Antispam-PRVS: <DM5PR12MB256693B3C069D89ABDDCD10BDE3D9@DM5PR12MB2566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FZwKIdPcbLoWeu1MRi3mChqBsqR8lxVebJUx3OC29ThwQf2JPbI9qO3L00xCdCJ/RcePmFhOVrpmI/+o57kU8q3ojk/q/qwwdU4RpjevCaaV+5TzebTb69x/PcNTzLcwyUNXz0LDCCk36p/aKQnKmycZ63kAExKIpmTs2ubC05JY7EIRKvaYCXDZYl+WRDBtsm0L2lF7Q859C8HDTIRtUew7gbVgsWxYULP3C5PKNqm8amG9W4bkqiuAElG5HjJJSoAIBKzknsOw6VDtSurLXyWaLrGCro4vD4xg6HbUQJ8p9ofY757zwP4u9EnId5MVOHNFyj9+Y82/JBsyBw2mABtqkY1rmGBAFa4DlhGeaeDSq9K0bv9DjXCUbxEeQOYjvEEvg6pAwslwzZhyYmIQyuIJ6z6YGXesfT7wtWPeGX3Y5lWBNPJn/KhhBNyMDGmSMPQcyVk63I7taXJcGLHrVcNt3eOQsjrphaIXuFA8al7HYMAUuwtn13rBZwBc7Bb5uxOGGANtIHPTViGD09byNRWVmQCYP6pEgma4SsaylwMxBBiP4fqeUWxk/jhvebjDw7DbHMBnVw41kEBmysmCVBloPn5TxNlUEllQ3il/1sKYP1LmPWDDFqkeMAB1to+Cs88zX1gAiWUxPETDJa5R/NAPElUNgKPHmQcQSoFO5IzrQCwB5DJger5J6AKQd6+
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(36756003)(6666004)(2616005)(54906003)(110136005)(478600001)(82310400003)(4326008)(186003)(8936002)(426003)(7636003)(2906002)(83380400001)(336012)(356005)(82740400003)(36860700001)(5660300002)(1076003)(26005)(107886003)(47076005)(316002)(36906005)(86362001)(70206006)(8676002)(70586007)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:11:15.7373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c7314b-72fd-4ecf-405b-08d925b723bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_041122_797974_E059FF44 
X-CRM114-Status: GOOD (  12.85  )
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

The mhp layer has alignment restrictions that may cause a failure in
adding a large P2PMEM that has non-aligned number of pages. The new API
pci_p2pdma_align_size will align the P2PMEM size to be inline with the
mhp restrictions.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/pci/p2pdma.c       | 23 +++++++++++++++++++++++
 include/linux/pci-p2pdma.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..d232bc4ada2b 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -220,6 +220,29 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
 
+/**
+ * pci_p2pdma_align_size - align p2p memory size
+ * @size: size of the initial memory to align before adding.
+ *
+ * The size will be aligned according to mph alignment rules. This function
+ * should be called before adding new p2pdma resource since non-aligned memory
+ * will not be added.
+ */
+size_t pci_p2pdma_align_size(size_t size)
+{
+	unsigned int min_align, nr_pages;
+
+	min_align = mhp_get_min_align();
+	nr_pages = size >> PAGE_SHIFT;
+	if (!IS_ALIGNED(nr_pages, min_align)) {
+		nr_pages = ALIGN_DOWN(nr_pages, min_align);
+		size = nr_pages << PAGE_SHIFT;
+	}
+
+	return size;
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_align_size);
+
 /*
  * Note this function returns the parent PCI device with a
  * reference taken. It is the caller's responsibility to drop
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..33a8fce52bec 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -38,6 +38,7 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 			       bool use_p2pdma);
+size_t pci_p2pdma_align_size(size_t size);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -105,6 +106,10 @@ static inline ssize_t pci_p2pdma_enable_show(char *page,
 {
 	return sprintf(page, "none\n");
 }
+static inline size_t pci_p2pdma_align_size(size_t size)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
