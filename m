Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A9C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 02:26:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0417961263
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 02:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0417961263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gcP5DtEom/hxOlg1q4yVsM9TVtHS9RR3buRBqxh7c5w=; b=HI15Sqh3bjy7e88y6h/m2ZbOF
	6PLOmvsbW0mU55aU07g93nRd6fqOAXcOjo3O5jrkTNYZtxvDshFqV+sNNA5ukbu+OVGKMJoslWvMy
	ZDCTr3RcqenmNnsdXSce33LOv1WnfdQTjaMiKy52L+Yn2j33i7WYsvUZ/VvrngI8ubtS6cXvp0WdH
	289ttw8nNP4kLHGLGWH/x9BkPtI6IYFzmAxNmaZg99R38EQcA7EpBT+78yF1mXBtu1hNTE8Bk3hP2
	135yt1U++Bks2uPMBfdf6lZ+QDg7xEXbXWi/1fB/suTvC/BLTrh0hBWfIyl7/51vtKDgeUoWJpke+
	uAsYkaYqw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lipQb-00Gjt0-M3; Tue, 18 May 2021 02:25:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lipQG-00Gjq3-LP
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 02:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BWncXXwH6G1UOyXKgg+0sAQp/8KYVF8utZLKFfh0cLA=; b=l3+7ip/O5n0tqpSlhIwrWufi4S
 MJl0sAkl9p5CFt7+ac4tse74m6NBdxz4AZSIH0zApD19D/+NJQHJ8t033vFuuR8zCf462EX/yGgJX
 CpzB7J6X8ZK/uQG5uprwTuvld9Iuv0GmufOy70kfdTNRRxN/pU8Mte05DOUVdit3/7JbHkRGKVov8
 4rFBu7PvtzNctf6WIzX6FKuFHBvloCp6xhSCYWQta1JonIGUFSvJlqxQjy9LzNGlv6cId+u8tQlZC
 01Ly9ehJ8kd/l7xMBgYqDoCx4RFBrpIMbsmEaftqr+wqEhsFf3IrMta5PfmndpxEOb1h8ZkgCDGXN
 BBq9ewcg==;
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com
 ([40.107.243.63] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lipQD-00EGm5-RD
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 02:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLOF40ZJ9JF1pgpI6R04/ElgHVhncXbtZHxZ4CwZW9XWsh3qJP0BJnR1lQYYENdOCw5kTLDLhf874UUfc5nwhQj1QGULGWYdFKIiv3I2OaiTplPJcNPU8AYtNkBZlS1oRjlcijrDjroiM6gbzn0i/siPQSQPTIC3vOYhMAXy2+FOo9eAWbuDuc11x9yt7zh3NYfYPh0beB5vf2pcwrs2ex23pUrixjjqe2rJ7Qnou5hGg+Tncza3SWroje9I4det23I4uWfmfZI2yZDRH63eGjYD2LBdjwIDACTGqxACHI+0XCwNCEEvAhrMvpHK3BAEaybtlRKlC8PfNZZW3TFLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWncXXwH6G1UOyXKgg+0sAQp/8KYVF8utZLKFfh0cLA=;
 b=OpZ7486H0OwPEM0lTWbvPCA/UIV6CojrFb/q7WdQ33Rie5MuX+xydiPnVjMPnI5MPGKXpGv/ujBdDR0pYfHpT6V24Pwn09dNRAW2C1P4Zt/UO2B5j3JHChT9Na2VrG7uAuTtltgzbhSvbcc/xB9yf5W77D0jbnmbv1KrpR+A3ETqFQ25qyR0uEguzVIXA7asKpH7GAw+zBrfCKFq0yUYLC15Tb503dCeIyE76Rehera4qsxMVXX8nrXaqgsUBgKtdsqZyEtiILEcZQWBEqcqXmpDGmvHTl0Q/8qBGLgAeqZvDUenIftTXZLS8Jc5rVBQlN1PpaYHD17svWd6NlBnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWncXXwH6G1UOyXKgg+0sAQp/8KYVF8utZLKFfh0cLA=;
 b=PN/oWzj7y6DyJ+VYY6o02JcGzHUYGYaR1IurobbDGyRB6rV7N5AnJpcl6xXn1pdwZIOTrcRWxUV1179I3ZGkjY/edXrFqhVu8aMRyKt7lLAHXZCkPO650RBVgSD2AstfjeQd175ckpow0W+CGTC6VDaRoG9BpTp3cyPeWsNyICE=
Received: from DM6PR02CA0102.namprd02.prod.outlook.com (2603:10b6:5:1f4::43)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 02:25:21 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::a4) by DM6PR02CA0102.outlook.office365.com
 (2603:10b6:5:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 02:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 02:25:21 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 21:25:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <helgaas@kernel.org>, <linux-pci@vger.kernel.org>, <kbusch@kernel.org>,
 <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>
CC: <Alexander.Deucher@amd.com>, <stable@vger.kernel.org>,
 <Shyam-sundar.S-k@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Chaitanya
 Kulkarni" <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v5 2/2] nvme-pci: add AMD PCIe quirk for simple suspend/resume
Date: Tue, 18 May 2021 10:24:35 +0800
Message-ID: <1621304675-17874-3-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621304675-17874-1-git-send-email-Prike.Liang@amd.com>
References: <1621304675-17874-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24abe5d5-b294-4dd0-ebe5-08d919a42f73
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47583638F4F8C93D20D6EBE5FB2C9@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK8C5EwPxglcM79XvfEydkDLRYMyZoy2txbTWtZCgG0gzCUAHG9F28aru0plGqadJtCP6Cryh+0wLa3KUR/4oMK2omIN0arnS+Q/M7RChS4MhZiKSB6xb4t7j0GCCYsng9N9tibkUr72wq2TNY1IESow9jw/HeqjcLzSIr3w++v3sidNarBohDeZByxifiPRAkz4fmAhsFEC7LEC3Ff/iq2Mygg+PpPiMUlbLjZEde6O4CblgTPUL6Tc28lJuvxlW0PVRN8/9Y97pIA3n87dMEShJVHxihNPMvDGRZ7kfbqx7FxfWl3evW1KWyhhVDS+tN+31pTY3hBtw/bT4aK3sqw4FjK4c8XiMRicFf1Dd6qcXOaGIqKOJ6uwcOKu39AoQr/DY2q6AK5O0c55Z2WASdyWcJWOMAcY0m3UsZdqsoVW8iweGPJT8OARYLGK8CvWb9Ln1Q6H0qy+S+KWgscikOdM6ea8pm2qnFmSwsV4MH/3sPmpNydTNDTER2+xC1FjFP/ZOJdYf55Z/HgRPdIHq5eFr5H+YpeohiDC4vlx3QmDH70psK+Fd8cgUkfPiOV6DjMc1wVogjtl+Gqx0qYGsknAFP4IU48ZNkaafAG/Ojah82mgRmQHolniKQkDB6HR4VqNdLmCwmX3kLS8b9gsczNY4he/uZoRqx1gtc7v2ZXkOnMtAwQAqYsBqV/cTvaL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(426003)(4326008)(36860700001)(83380400001)(2616005)(7696005)(86362001)(70586007)(8936002)(70206006)(478600001)(54906003)(8676002)(15650500001)(81166007)(186003)(82740400003)(5660300002)(6666004)(356005)(82310400003)(47076005)(336012)(2906002)(26005)(36756003)(110136005)(16526019)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 02:25:21.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24abe5d5-b294-4dd0-ebe5-08d919a42f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_192525_904358_6C6C9E97 
X-CRM114-Status: GOOD (  16.12  )
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

In the NVMe controller default suspend-resume seems only save/restore the
NVMe link state by APST opt and the NVMe remains in D0 during this time.
Then the NVMe device will be shutdown by SMU firmware in the s2idle entry
and then will lost the NVMe power context during s2idle resume.Finally,
the NVMe command queue request will be processed abnormally and result
in access timeout.This issue can be settled by using PCIe power set with
simple suspend-resume process path instead of APST get/set opt.

This patch is updating the nvme_acpi_storage_d3() with previously
added quirk.

Cc: <stable@vger.kernel.org> # 5.10+
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
[ck: split patches for nvme and pcie]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Suggested-by: Keith Busch <kbusch@kernel.org>
Acked-by: Keith Busch <kbusch@kernel.org>
---
Changes in v2:
Fix the patch format and check chip root complex DID instead of PCIe RP
to avoid the storage device plugged in internal PCIe RP by USB adaptor.

Changes in v3:
According to Christoph Hellwig do NVME PCIe related identify opt better in
PCIe quirk driver rather than in NVME module.

Changes in v4:
Split the fix to PCIe and NVMe part and then call the pci_dev_put() put
the device reference count and finally refine the commit info.

Changes in v5:
According to Christoph Hellwig and Keith Busch better use a passthrough device(bus)
gloable flag to identify the NVMe shutdown opt rather than look up the device BDF.
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..617256e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2836,6 +2836,8 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	acpi_status status;
 	u8 val;
 
+	if (dev->bus->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
+		return true;
 	/*
 	 * Look for _DSD property specifying that the storage device on the port
 	 * must use D3 to support deep platform power savings during
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
