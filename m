Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D1C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 03:49:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A411361417
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 03:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A411361417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IkreOKKHvsDN3100MyZoGHrq28/BnbMGj//q38IZjR8=; b=KzLr7t/H4h7BNx
	kgZREQeFP4l9Xuv6SDmCNqyDMoAYqvdEbiXMJcwhS2TQE5TIfT/sqHH2e58hwYvQPKlpAyWC3/vb4
	FSakh578W89WOgH82ZJEQc0mNy4dpKshjJmqvPwPGLkgVXS78r3BfBWcAXZTWH1IuTu94TtxikpYI
	RqCYZBFHDrOdfUYhPw+EHqAhiiahbj2rxtnWu0JrF/RbQvIAVUU59QLTBO78k6PrZYh3w/+t8gqS2
	rh8mPGgXjwY/UrenW2dlgNQeTlKIOmCMNv0KV9sQIKr2de+Xal2iSH3Vc/iGo7gXfoMnoBRAUkKT2
	+cKM7IWVS6MD8AwnUJyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llO4B-003D7n-Ii; Tue, 25 May 2021 03:49:15 +0000
Received: from mail-sn1anam02on2052.outbound.protection.outlook.com
 ([40.107.96.52] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llN8k-002zxb-IN
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 02:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIpt5rVYZBM4tbwsJxFp9Qhf9pqDB6XDL/Wg1atSHkmrTFu32nO30/scln3KKb3KOtX6pFJ6qMtWtUPp+aL23oxpULWsR+ReYAaBkc9wsAOyPXWBm2j+wIKJ8cBhr31o/r4c0Iu81OjE3b6jnT8PZpfax6VUVpy+Y/X0gXEkKXfhKChAjo0fj4Y9Sx0c0R2cPv4OiguRl2E6/UFAa7wP/eR/f3isjeWb1xNWCkTR6KDZBlv9NIr4y56pnZNtqdPiUTPucipbhZtsrvNzpTGl61KCFl/EHANdL6LGIBaICryJJxaHQWsLPfMpL4pexF7xDV7zR8HmKUo21hH7+PdMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ylHhJ5ceX4SRE2Ty0n1OrkGNE0PabZCVpvNYmvyByk=;
 b=Zyn6DvQbsjJhzKZtvzs/ooZ7Arn2mMpaZ1igmdJuWXnKo2XTKCX26o3xp6lwgwWUHQ02AHuKdyg9hOhHxy+UDxs3Zm/EYlXwyFptHLxZZStQV41CIHMp5ERqSYVoKN4ECkIeSWeFfNE6cStR2Cga7uMHmq5t8916iPMuDECVyeNH/hlcfHWpQB40F0ZDLJzG1s75vwv5NC+byGlN5Lrc7o57XXS7s6i9j6/JDMNuHGyCR6bexIOKyE7R74EzSe7F3iVNbT0Al0uT+AdI8bJDB6WryEXxziWfPigLu4wcSPjKTRJk/+8ApBW18QwfmNOXo/TjBSmYsCT0ai6dU3vWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ylHhJ5ceX4SRE2Ty0n1OrkGNE0PabZCVpvNYmvyByk=;
 b=MxufXJGY1WOv5t8GDnLqqaVxdDW5pOUgNL8wifg3XOIRphVdeW/+D7uT+AEMeXh9ShN/ibZqBhLK4XmbscB7YvXtgbjORR0fNpJFY2GQt8qBHOs5oL7INj3KZzbD5VmDEH4WGW3mGVMIdnPmwgr5w8BqL5peyxTUC6roqbbKxYg=
Received: from BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46)
 by BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 02:49:49 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::6c) by BN8PR03CA0033.outlook.office365.com
 (2603:10b6:408:94::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Tue, 25 May 2021 02:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 02:49:48 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 May
 2021 21:49:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>
CC: <Alexander.Deucher@amd.com>, <Shyam-sundar.S-k@amd.com>,
 <Mario.Limonciello@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to D3
 for s2idle
Date: Tue, 25 May 2021 10:48:59 +0800
Message-ID: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9fe43f-787a-4589-9cdb-08d91f27c311
X-MS-TrafficTypeDiagnostic: BYAPR12MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3080A5FE1CA1C8E399C1F42DFB259@BYAPR12MB3080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWTkAeN6i6VKy1LpvNqCrXSEVe70Xc4BC+GeApouLQmYa6TN7stF4jZNgPpXrnEElCxf3Unwp2oKWzB6ui4ro7Gz8a2mXoVzkmz1d6X56TLn7DQjFGkOnNgaWWFQVbcr2RdvcAkryLgjt/0/yqdqrUv7aDdSP8TecZFQ67JSt2k5xZnpIwU8t3/YFDjmxgs8HE/L0VwLhUZQ9yt3J4972lwaXSkCwVq3behMIsM/DUykrpd8u3IUoE9u+RQXDtfrAM3H+di9PMAYCscUTze7wC54HvrRbRe8Bw91Km4taZv/3DsXto+sA9S6XVfdKyvb9QvEYYSNlnVGYmp5QAbINCmUWGHNeKaxoE8skghcErdWliKV/ACQmZeHVWXUNbRBLujjyM8S06cM5/cufW8YXDxlD2tqoYfNv3FJ52C8hF5HlhRU2UtyiZpN1ymeNeg8SMwkBl8RvopjoSv+ic6v7647flXmpFgwupBrIL6wuG9V3xyq3XjKhmhBv0M6sxdY7xqDxlsJWNUgGQ5iSRUl3ts0UUSTB+T5NtgFSMiplQpk7kzB/V4QbA6MDBw9GCursiU3lZu6ARxLzR/zuWL6iKPral+5rPSuGnMCz+BF6lm5zwLqal4W32e0fSJkFTSQe2vKbCKoXBNIRRAesYHG6u2upeydohoE62SCuQ7L86KiGozuuTBPuBTlbl/kbl5fPzsqZ41ckCxykRobeevkx0cQxNDTXe8jyU1JWHges51OLCdk4nU3MsyEEoUwW4v0a36jcr6+1/PifPV3lkoUym80SeRJfZDeK0SjerWZMbLozEi1mq0PH5AleYjnZESe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(54906003)(4326008)(7696005)(26005)(36756003)(16526019)(186003)(8936002)(82310400003)(426003)(6666004)(316002)(86362001)(2906002)(81166007)(83380400001)(478600001)(36860700001)(5660300002)(110136005)(2616005)(47076005)(336012)(70586007)(70206006)(356005)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 02:49:48.6083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9fe43f-787a-4589-9cdb-08d91f27c311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_194954_816091_73300B28 
X-CRM114-Status: GOOD (  15.16  )
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

In the NVMe controller default suspend mode use APST do the power state
suspend and resume and the NVMe remains in D0 during s2idle entry.Then the
NVMe device will be shutdown by firmware in the s0ix entry and will not
restore the third-party NVMe device power context in the firmware s0ix
resume. Finally,the NVMe will lost the power state during s2idle resume
and result in request queue timeout. So far,this issue only found on the
Renoir/Lucienne/Cezanne series and can be addressed by shutdown the NVMe
device in the s2idle entry.

Link:https://lore.kernel.org/stable/20210416155653.GA31818@redsun51.ssa.fujisawa.hgst.com/T/

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/nvme/host/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..49cd24e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -26,6 +26,9 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#endif
 
 #include "trace.h"
 #include "nvme.h"
@@ -2828,6 +2831,16 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 }
 
 #ifdef CONFIG_ACPI
+
+#ifdef CONFIG_X86
+static const struct x86_cpu_id storage_d3_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL), /*Cezanne*/
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL), /*Renoir*/
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),/*Lucienne*/
+	{}
+};
+#endif
+
 static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
 	struct acpi_device *adev;
@@ -2836,6 +2849,13 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	acpi_status status;
 	u8 val;
 
+#ifdef CONFIG_X86
+	/*
+	 *  Set the NVMe on the target platform to D3 directly by kernel power management.
+	 */
+	if (x86_match_cpu(storage_d3_cpu_ids) && pm_suspend_default_s2idle())
+		return true;
+#endif
 	/*
 	 * Look for _DSD property specifying that the storage device on the port
 	 * must use D3 to support deep platform power savings during
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
