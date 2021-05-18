Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC901C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 02:26:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257E461263
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 02:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257E461263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SKv9uPDniwvCHlAPegbRSbNFF0X7z61hJ1Fqbn/SPIY=; b=cPMYoAtv1v5oVOi9rql0vvqml
	Febwem8RgpEMydwzBqGPtpo/q9eBzhqn4a7PO9BFdUJF7oHD4sXSRSEtoZmlSm1apgWlwsoxsldKk
	Lrar160vkUeFuxSBmjjl8vCdSJ+iiY0bEG9MLx58Tt0cepTNO50TbkqlN5NvvhKUsWsjbdkKddSAC
	pMsiRr89kgUsutT4Q6i+MC45Y6pWqm3BfV/zris4/swTYG/Act3RYxZe/uEPn4LgeucBIJ6V5vzlB
	lAQ9MmgYDUOW00F+FNErqbVtEDv3ahkMX6mskUmb2OMAvxo3lieUmLo3+X3OOa76DhNHt3nDy33T1
	aJ+3TAHbA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lipQO-00Gjr0-9T; Tue, 18 May 2021 02:25:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lipQB-00GjpB-I2
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 02:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=s183yfy7xin+VA89uiIhMS4RtC9SO2mLh2+h/QaVISk=; b=sOKR1JJbkVJ3DAX8C+5OG1FT/A
 zguqDUh1xNRcVk23FTVVrp6a9VMaZjfPVDA2Rub58vTQC1g15jZdyNfRvZBSyY4e9RqBQsZpK9zGC
 vO90KRX+Ul/6GS/Yr+F13qOgANj280vvN7kJWL/oL7pK/yNUWzfFPyfaff7oH14FQEBKEcZ4YHzYv
 kh90BrjpicA6aGOLZaSVKX2HG24L3fepfSHftfZbh1xgLDk9veza0gtUS6dE1vjDv2Cn0yFsZ6TNQ
 rmyBLMdO8SU+n6n47Dy2WhtvemMEeP7R445TPMjKrydUSrMsKMKh72SKcCcgEPgQyB/XBwQbtWhUd
 xLYDLc+w==;
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com
 ([40.107.93.76] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lipQ8-00EGlS-IZ
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 02:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmqdnXpr1lRR36BDuJ7satSlKY5QPr6utELvNvHYgQktR1EmXotvh78thSHpabfFHdOi02AwVCO9ftwGBEC3x8JyLP3Vc/fs4C2AfjLWtCVsbHkx0SNWtMpx+Nan7+pqjruuVxk8nj1NYQZPTs47W2Z0OUkIYzT2BU2ZmX3ysELrzCKZhPkp/ZLMXiCMqlG+msCBXdoRgFVis+VkYAFmjHVNJdnEAcPXkuJOmBKbhHvVL+H2gnbjHGZjxNZfrFQKJeN+7KTd0WWkmog5X1qKC5HknXtmz+zsvSF4m9PEHScmYc0XP31cYWjRd1j6dCNiX3i485IoSVALPaUc57ibXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s183yfy7xin+VA89uiIhMS4RtC9SO2mLh2+h/QaVISk=;
 b=ZraPsbtWjKBNzmYhK5EkCEGfe7k+FrJYEtFAhNMcirm2kjm5jw7j6nDrbYv1pX57P1fvngTMZBULPx2WwGxgsZkDiaY208oGhaKfZGIKDiut+pf0gbgsb12BSSJemHtIXUdMdIk9ePfbWM1FxY1d/vHkaQWDTlGwHy8tIw0uZ6rF4FRBFToO07Pw2R0eKZlofCfcdyopn4uO5x/IfMvnZ5aGohDbEe7feShBdAXn2n15N83H1RkOXaiPjtpZvwT86bk89GmpCGztGrWxQWCFdwRkNdw4VhVEsyMVWYZqkEenSc4TnIlOhqYwc+K9pBOI/8355Z+T67EfDoF2/4AfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s183yfy7xin+VA89uiIhMS4RtC9SO2mLh2+h/QaVISk=;
 b=KOGNq6ztx/6y4rJDn3u1vVxGU8xnu2xbKo0XaGFhEaaVEoQUYlmxgVCvI8fwFTASkc2BOrTr13OP9rl/ZFS8xZWlfVDajjmO+NZ8dLE2eCRwwSiMIvFA2DmSsFrF/TBG719VrjgS5BiMVB/iGXPGu7xd7V8aj25lewDU1NaivmY=
Received: from DM5PR13CA0063.namprd13.prod.outlook.com (2603:10b6:3:117::25)
 by DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 02:25:17 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::54) by DM5PR13CA0063.outlook.office365.com
 (2603:10b6:3:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Tue, 18 May 2021 02:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 02:25:17 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 21:25:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <helgaas@kernel.org>, <linux-pci@vger.kernel.org>, <kbusch@kernel.org>,
 <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>
CC: <Alexander.Deucher@amd.com>, <stable@vger.kernel.org>,
 <Shyam-sundar.S-k@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Chaitanya
 Kulkarni" <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Date: Tue, 18 May 2021 10:24:34 +0800
Message-ID: <1621304675-17874-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621304675-17874-1-git-send-email-Prike.Liang@amd.com>
References: <1621304675-17874-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37309e36-814d-4b8c-ed1d-08d919a42d73
X-MS-TrafficTypeDiagnostic: DM6PR12MB3867:
X-Microsoft-Antispam-PRVS: <DM6PR12MB386718156AF63D58FBC2C10EFB2C9@DM6PR12MB3867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ap6CQ+qGYUN7DHPjnk72HoGiuurBHjeovwRKiatsrROGLreBLSdGklLbBZMBncADc8ke3sR0fPS6gGQ+5W3D6QcXYy40TGaQ4KoZWury+NKtiJ9jI2fMWxHHELK6eHo5H1fIVR2w8wpXpyh2ccaGyKnYepDXv4E396e8FWGKHjcVchk7CD6F+v2Pfrm5F9FWHRum5cUCdL6fdBlvGfYupEaWoJdXBGcprqTqCTUwuVvNsJXa+Jmxhe5EHMqhc8uzoWT0XJ3UCGTIgRT1aGdfJhu3XOhQSFHQ4UL2f7rNDBeCaPxeMlJZqkpa8v5cXnVn/1nm1WOdE4mB4ac8QhYLScYJ47l8GFN0u5KQhnDT2oovlFMO+Q9EZfiCdkvCJB132AxQkiD3hvAbhBb1PKSXaD0JJqKbO9yQ7nxdFB79Z/Y5jXA7sSmGDY3hoN6SoODKnIDkrelFA8LHmeYtEPPeupsQVnq0lYGpCrjGjULwJ+2QdH8RC3sddmC4O/EFz27+d0nNK0/i4vpkwjU7CbVvv67Dzz53yDWMSwlYx9uIy3cz5KZFv43C0AHqg4iSpYo1o7yWTYUY7cjzI8g60eyQxz2YG+RkXxS/vLg1eHX7pjU/xM7elDcE8ZIlTleSEl5vWzP9zdSEU5ACHe5IIsaY9W/Sr9Wmx1CRngU/aagtw9DMuVwhYsuA2WhxLjA/KaIm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(16526019)(4326008)(2906002)(426003)(5660300002)(2616005)(36860700001)(54906003)(83380400001)(316002)(8676002)(110136005)(86362001)(356005)(70586007)(70206006)(47076005)(8936002)(26005)(36756003)(82740400003)(82310400003)(7696005)(6666004)(336012)(186003)(478600001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 02:25:17.6159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37309e36-814d-4b8c-ed1d-08d919a42d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_192520_636972_D089F495 
X-CRM114-Status: GOOD (  18.46  )
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

In this patch prepare a PCIe RC bus flag to identify the platform whether
need the quirk.

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
 drivers/pci/probe.c  | 5 ++++-
 drivers/pci/quirks.c | 7 +++++++
 include/linux/pci.h  | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15a..34ba691e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	INIT_LIST_HEAD(&b->resources);
 	b->max_bus_speed = PCI_SPEED_UNKNOWN;
 	b->cur_bus_speed = PCI_SPEED_UNKNOWN;
+	if (parent) {
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	if (parent)
 		b->domain_nr = parent->domain_nr;
 #endif
+		if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
+			b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
+	}
 	return b;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3..7c4bb8e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -312,6 +312,13 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
+static void quirk_amd_s2i_fixup(struct pci_dev *dev)
+{
+	dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
+	pci_info(dev, "AMD simple suspend opt enabled\n");
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630, quirk_amd_s2i_fixup);
+
 /* Triton requires workarounds to be used by the drivers */
 static void quirk_triton(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 53f4904..dc65219 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -240,6 +240,8 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
 	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
 	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
+	/* Driver must pci_disable_device() for suspend-to-idle */
+	PCI_BUS_FLAGS_DISABLE_ON_S2I	= (__force pci_bus_flags_t) 16,
 };
 
 /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
