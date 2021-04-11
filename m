Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED94BC433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 04:24:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39766611C2
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 04:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39766611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B9cJt9ueYjzEz/KjD3ANzhM1E5SU+Idvn9Ga9Khka6U=; b=orQ2IeZ9HfEcsUszS5F+P4YMH+
	x2GaiIjKIZIeO6NLVODHGIGbBDsHWyQ+wMLPbzl3lHXp61ZlJH2rG4sPGw/RRZroPXaR/ZQoEfcgt
	ma30p8H3CI8NQg7O4zMR6GMSaKhlN6EJ2uggXfuBkqw3uIQGBh0xB3mriLD7JcHrvKyUSWcdETW+D
	wFQG1GlSpus3g73Hdsp1ubsrb/VMEPMRhJRiUSnRh8ErhSzwKfgneUUoxT0WxF8F9YODOk7DzQTgB
	kyprAMLFpmBS5Mxj6oWFeP3e1pzYk8C4kCJDhGTfTr2ccr2dfO9yEnGJ+UmjLc4zt+C0eqlPeRM4X
	5RjKcq5w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVReH-003vS2-4N; Sun, 11 Apr 2021 04:24:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVReF-003vRw-DI
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 04:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=+kF+cY58pYFpwZpBcePaoPw7c3Z0+FkUcRmb+WUHJMY=; b=yVAYpk3h6N2ISnQK9d4HfVAya/
 EgIZatZ31UBOCnsYVAU972VExh49RK8PtHgIBzPH1DMk0miZmvKLR9QVMEN8jef7/NYswLz8ZjjoS
 m77eDPb9lzjjCIXluIe5gXfjZGaKw11uqwc2WwpZuDE1YBlCrsKX7ecV785ZF199lFlGiTcqufR8o
 gS2usahBkd6uMu2kpnTYl8pLCJhd4xKgXlLjFYEUTE3Zn2Vl9Qtg9hsTivOpX1sFJqstO/GReTHBQ
 XxJLQUVh7Unio/FWfWj1xm7a18tM8cAYsn52DPtsRpQIpzByMLiKS3EShrqsB2hzlOXEoAetFCmQs
 2wVvoguQ==;
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com
 ([40.107.236.43] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVReA-005MP1-BJ
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 04:24:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAijphe9UKsHnsU57f41rijLTF9g+WIE3QlalW1MxVicO7GkZfeogpoVKXNrdXd/V3/mJmHFzqE8OHaqrtPF9SpWVExRBVjJqwpVCMFeRROf8zT6OVxBIBirn8jZTwxbRUsWNKfIdNgFRoiNh9SZshoQ3wglnnU91PXj3swF6bYInoZvvM9itmECt1HeqWdJxKQOqrntD4BCn1pOKM+cJkx0SRGhC18ZTqU0kcNoqjrU7kouyNPbZwjgucssUm+RTTS9uUpUAT1uiRgS+8YZnpUAfDe0xr5P1GNpiecFXlgl96dDWPch7TJxfgZ8EBeSlhO2hrYEo85Q5zYQZdnFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kF+cY58pYFpwZpBcePaoPw7c3Z0+FkUcRmb+WUHJMY=;
 b=XVqUsn1OusfEu3oBkljwVvb5V3xWBHNbByIJ6s420iVsB/jQeMaD0eE10G85qEM4XoWXVXQdyOu5xuz1DY+bVzf9AJn3f+niGvRWYEULqCh97UpxlBK1ecTlbIaspZZGkIV4ofI2bEPKcHr7snDi3GjPvjYVev5xqKeexbPyOr4UMT6XAm968pF9jG0cF6zLHheEhvpcRb5f6W3FcY9IodDT9L/DLg2FpiEQm8AdGdPAf1ogNfyp7wnj+iO88jHpPxH3lAaphVbPegBrG8N9paU4+LoayTxxhGUa4K5cpa4DFaNPOgcn0Vyb3z2ZGYGLJ+4w/0pNT+Rb8YkTOFAjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kF+cY58pYFpwZpBcePaoPw7c3Z0+FkUcRmb+WUHJMY=;
 b=CChm8sk3JfAJ+WDLkIBULJH0TN/JkVKfU0L8o6eejwYyuJlhNhGeyzM1AlbnTRTuAZaFq5Qtu0Oe+88EZBf0eaqxPs0QJzhz42shQneQ58PpSL7QMSDeSWyAaaz2dz1iDdZvqMgCZobxWcWjg83RR1IvYmScDGuySLYvdGlIdgk=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sun, 11 Apr
 2021 04:24:26 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3999.037; Sun, 11 Apr 2021
 04:24:26 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me, axboe@fb.com, hch@lst.de
Cc: Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Date: Sun, 11 Apr 2021 12:23:35 +0800
Message-Id: <1618115015-8545-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4042.6 via Frontend Transport; Sun, 11 Apr 2021 04:24:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9d38b0-4426-413f-f065-08d8fca1b0aa
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4306612894DC01219885F9A7FB719@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aizltva7gqZL6dQJlkN/PgVfUExW0V+6l/U+DDJW5k3QmIPeBzh9D4YReAmhV3OX5F7hiSzD/lGe7RCEWnUNabHic+q5WUG5aQyTVQMxSWfFxJ9g/nhV0gQp61rey++asCWcgcieGEYFLDfxn23HvfX/5NI/H51hpjPLwAEgwUhswyXBXW3nCK5PcABZeBmjhyDIMk4VBGzTqWbsileEQYUjZficuOTJMVfELBOqpShVKn5uf2zmQxnK60uPNpOwgOWnYA4O6pd+1wGfqfUMmWbGRM7n1EHQD0NWWFf6+CJ+KlL+e75WCQgS/IDF3OZvAXuD3Aa9YFadeJgpt3tfyJ2PNgSVj/3y3S0TrJlxZuS33onqLXqeZ258p+ihJCP708CIIkh0ew6kg+C8aEv91GfT3Cvs3jHi9ePCpvbrTPRa1enZ8lZqdMt2jdn9zVsw2haaXE3JtzZ9m7zR7+0+FA68rJWhfdC4XnIBQCUZ+35Z81yg4VWBZpsisEq7DVdlP6ubBDwxn0kVNQxKzb/RBT7jd3Ig9BtRjsWic0rJMcRwpOoxqa0XOh1hH3/Ooc4PtRKuGe58TmFrfNgsa6in0dyR0SaRK+VKQjZ0i3pj0/P55qISJX/zAC1xl+2DVzyYKO1SS2WEMKVkNz/F+jVSKR7vPpD84zFDQ05LjAnbtKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(83380400001)(186003)(16526019)(26005)(66476007)(8676002)(2616005)(66556008)(38350700002)(956004)(478600001)(66946007)(8936002)(2906002)(36756003)(15650500001)(4326008)(6666004)(86362001)(52116002)(316002)(6486002)(38100700002)(7696005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DaCtoTp1jqBfPgHex5GeWTcAQ7n2sLge44mjPTcpwGMt/fX02ux0t4jtBxd9?=
 =?us-ascii?Q?6Dqtog0fZ20Q6jupsJr8/Lg8kboIEHZASPwpK5s6N4ZWA6xLoyU1pjnlQZE0?=
 =?us-ascii?Q?+QlySFHQ4UlqRP+6hR37mCyvcT6jzskUVWucu/RnUoQV/qBlvqUPRS7P3g0d?=
 =?us-ascii?Q?EHn9CSAEaj2ZaOngzSh/OhsdBL2Ttyw/pVbXYNB13m88arrD6iMbyn+uKo/E?=
 =?us-ascii?Q?iz+kTY8miAqlM3jZgGifqkGOPQYLoFtliPWiUg8RdVvI2xmIGtz0Gs1S/cjt?=
 =?us-ascii?Q?jWkH/7/81rEbAbuyd+WHVjfZRSKjw8lo2CVE10PQ+PY7ZjxrHLQvGioelypa?=
 =?us-ascii?Q?bd1VvaGrbPEffq2vge+36ZGvlVOwcOHyfBPJbloGC7pda+J+F7UVDRkY82Ig?=
 =?us-ascii?Q?ivTt/ANClRWLhBkXJVBUsFuz8yQCnikK9dNEhnXFdHidm+IR81EegvjxRhJh?=
 =?us-ascii?Q?nXZ3cYPuuHEzeFSQq1NKuJYhontY2USIe+GlT4OcO49zk/ci8P6/ntppaE8h?=
 =?us-ascii?Q?5bBEy0jvMg+/zhAhFDV1gs/JdlDJ5OU2qYei4AkpRlIbNDhZi2S1SS45jAyD?=
 =?us-ascii?Q?qIxNCymeAGMWk/d5Kfdg9luSg3YAo33YR0eL5n9FZ7iIvOXeCI+YHq2y0oyt?=
 =?us-ascii?Q?83hZV1Mj31V65DZV3WWoTAEt2EroZet0UbSbwxFM/70RAIhc1j5k+1QaswLu?=
 =?us-ascii?Q?hYB5PNxAs4cGsk3kYrXfj1dV2E9mA0vliwIhUjfs6hPLnzmgT8RCt+Fx5ar0?=
 =?us-ascii?Q?2V2Utc2jom3zH55WtYB+/GwbewHqpFiMIK9Dlf1uJ4aywXGsHjg9NYMZBd3A?=
 =?us-ascii?Q?WRT2FGpOqzqKhfjh7ecG/ufP/bz33TJFujkQ9UN8TMxinAolICzZRSaMDDUX?=
 =?us-ascii?Q?AMS+njGWGnEy1FTc5dFlZLvpLvbHgFd7I8IIHBLzRv3f2YzojJt+K5mGh7uU?=
 =?us-ascii?Q?Ups/tiDpfa+u034lnU5gcSLX1liP6X4NsN6B2EQbgtJiDxlfppUXL81nOxBI?=
 =?us-ascii?Q?mLA1Iq2tqIIw9Jk9E0oVy+MvDuV0JctqE5OAE1AfbfT2R+C+6dcHR6ORDNvW?=
 =?us-ascii?Q?We60rcKDB23xqRLn1m1lTXd7/ptRDxd66AdTStfx4eomh6TmISa08HbZg1nR?=
 =?us-ascii?Q?I/H5OGMC3q0WBMWSOzoBYJDMJCLFS3KLVjC957wCAgbBcnqfBZ6tuSGbbb7q?=
 =?us-ascii?Q?peQoCKgGdexHXj6drczJGpD+C0K9+GWJ+dV0wQ/i77QkilrURGAhgMHp57Od?=
 =?us-ascii?Q?Gt0/hOmiIgF2O1kMQXdEu9jI7NYLxgI9k/bqDPbc5WwkNWeI1sm/stggGFR6?=
 =?us-ascii?Q?3bH3GnGEdsOp+XG0vyDKORVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9d38b0-4426-413f-f065-08d8fca1b0aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 04:24:25.8641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdSKKbQKQXQWuuyIJizF5mE5rOacwNUzIjgVCS5p+Ap+L1NwudC9hhupjC8dwe/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_212430_497141_732F32BE 
X-CRM114-Status: GOOD (  12.59  )
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

The NVME device pluged in some AMD PCIE root port will resume timeout
from s2idle which caused by NVME power CFG lost in the SMU FW restore.
This issue can be workaround by using PCIe power set with simple
suspend/resume process path instead of APST. In the onwards ASIC will
try do the NVME shutdown save and restore in the BIOS and still need PCIe
power setting to resume from RTD3 for s2idle.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
Changes in v2:
 Fix the patch format and check chip root complex DID instead of PCIe RP
 to avoid the storage device plugged in internal PCIe RP by USB adaptor.

Changes in v3:
 According to Christoph Hellwig do NVME PCIe related identify 
 opt better in PCIe quirk driver rather than in NVME module.
---
drivers/nvme/host/pci.c |  5 +++++
 drivers/pci/quirks.c    | 11 +++++++++++
 include/linux/pci.h     |  2 ++
 include/linux/pci_ids.h |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..dd46d9e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2832,6 +2832,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
 	struct acpi_device *adev;
 	struct pci_dev *root;
+	struct pci_dev *rdev;
 	acpi_handle handle;
 	acpi_status status;
 	u8 val;
@@ -2845,6 +2846,10 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	if (!root)
 		return false;
 
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (rdev->dev_flags & PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND)
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+
 	adev = ACPI_COMPANION(&root->dev);
 	if (!adev)
 		return false;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3..b7e19bb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -312,6 +312,17 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
+static void quirk_amd_nvme_fixup(struct pci_dev *dev)
+{
+	struct pci_dev *rdev;
+
+	dev->dev_flags |= PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND;
+	pci_info(dev, "AMD simple suspend opt enabled\n");
+
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CZN_RP, quirk_amd_nvme_fixup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_RN_RP, quirk_amd_nvme_fixup);
+
 /* Triton requires workarounds to be used by the drivers */
 static void quirk_triton(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 53f4904..a6e1b1b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -227,6 +227,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
 	/* Don't use Relaxed Ordering for TLPs directed at this device */
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
+	/* AMD simple suspend opt quirk */
+	PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND = (__force pci_dev_flags_t) (1 << 12),
 };
 
 enum pci_irq_reroute_variant {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d8156a5..7f6340c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -602,6 +602,8 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
+#define PCI_DEVICE_ID_AMD_CZN_RP	0x1630
+#define PCI_DEVICE_ID_AMD_RN_RP		PCI_DEVICE_ID_AMD_CZN_RP
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
