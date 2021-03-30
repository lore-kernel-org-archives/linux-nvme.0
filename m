Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4AEC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 12:55:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84435619B4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 12:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84435619B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GWlBBJeBnaZADF0SzBBU0WbdKTsC/Pv6Oy2eqEiFzvo=; b=b2OkAppR9nEun4sFPtpfnH88G5
	kD2rywMB//xZ5F2jkEd8uWsOmpgsvu32oo7LMFO52LV1m+B+RRUmR2sMZDePYVg8rEOnUpqMFqnBB
	DezFhsIQ91GKzNmnutFTp0TN3Yzyc92mIGYbq+AnoD5ueCaIOCke4tZC5dBG5j71nWZBp/EyYFwpS
	feZUnNw540zdcPjBNhUNQt4XWUkhHVVd79BtdTiSjrxfSnvL33nyxpglsncyXh3Ghak7zEV1r29/t
	LeZkFGAE6F93d8KCvSfZuRsvNTsqrSb9L9y9T3TpCXKErIGXS+/zU19ew3PvYxb36fkZsqKLrmDIt
	3q+xIL8w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRDtW-003kbU-WE; Tue, 30 Mar 2021 12:54:55 +0000
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com
 ([40.107.93.61] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRDtR-003kZy-Q5
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 12:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEY6sB6Ok+ThKNdFuEpeWX+mVdsGYARnDY5BC/T8hOWLeiEbGNzV8ty4j0oZ9MjUz/3k82/j+cSUAtgSF/zDkhGycxecad66pFNRpjIXpj972+5geGEOms1X7t/4wOY8OEDG4TkjUtukjoIyCqB8tMZIRvXN8dt3m96B6KMqi+lKsFOPpGn9G1D9kZlmyoiuqJoNFXye3CNNQvWGtpk14VJDJXsZlDUzO2T3ZoFOCi89rG0ZKcdYW7A0pwYZnw/bWEizhoyKEVza8yXWEjB0CeWj0aOPXzXmavTVAa47n1sc5wCYxuyAfxhfFMkA1pbrRMR/Ek/TDd5Lp1D4ts7G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR/UOLe1j7aeeg0G0FWbp4xgDrnZu9BvCyPyFV1t3eo=;
 b=mK47wZOszryH6EikjvT9vhMWOvTkVn+BWO/sBE+YURsoSFHfXp4V/PPI7L+QW/xmf1CY39oiGLD1yKw5Bud0FPTsoUmO3lLqgqI+VUzGD8ShcG/CI9PgYV/CmWR5SWz2TaiVCxNXR7e2VxmopdnH/CKmrqYcK6HnG8YR91Pr7wjI/5JZ3i5YNkz1a3FErUDSjvPn2b+/Sqw8WB4SIkT91AjIsRNJv0r0gB1ofWvgJbYUVHiWBL5sJirhjRHg8TgAmexMSFpTC5uo5R27Me9QbWm4w/Nr8IvkiHIFO/yWe8tMZGn3duiFZHz0zDlwR8utoxzSX82CI10Euuqdogx9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR/UOLe1j7aeeg0G0FWbp4xgDrnZu9BvCyPyFV1t3eo=;
 b=fI5AEL87spNOSOZadutyTRXErl6sv/RKzc6huWaCzWAH8OYKZl5jBs5L8O81y87mO32hVp0NXxcaMBFLcgBLBfLjuwWSHBo3kJ7/uDanM3ba0mBXGCXYfiGL4EM733Po4d09VUHD+gfSzxSl92N3piKyQjcCqfXqZUZCNLQ0nzI=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 12:54:44 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 12:54:44 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me
Cc: Alexander.Deucher@amd.com, Shyam-sundar.S-k@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Date: Tue, 30 Mar 2021 20:54:04 +0800
Message-Id: <1617108844-30110-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3999.15 via Frontend Transport; Tue, 30 Mar 2021 12:54:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 048f4ad0-ccea-4d4f-7f41-08d8f37afda4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4130654F7401F7C615BF44CBFB7D9@BY5PR12MB4130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sU7YL+X7gXk/zsYWfL7djSEviojCKMRi3wAoS6I9TgXikoi+icj9x/kt4CEj4Nn0dai7YfCPlK4RB3A5XRdr2h6zuvlC32lQQcECy01Hkw98dSRdkdckxdxZbsW3cY1vyS3+f3JcPyx7lCCcJ7V9zyokJJ+RyZpq0yj+Y80Qob0MkjgbcEoYYKlIpcLse09PVhfYz7TDQF4RAxD3VXlIW0KeRZiNoN3qMmAgHLwVmCbmFy+ARQ+et32cEgzZ30B22sTpmmpzilZ4J3ddbAQhqF3QEsoTdTGg4kNC7f038bkWystjfOnyTkm+wioZDrjt+XJzaHCIa6x5XvUgpUxHD94VE3MyAEmPby7YWiEp4S0jnd4qgZWCNM7M3nL5/ZHPCtoSie4n3E6vHMasmXzCfnTkfMZYDLIz2Re+NnI7geFY48SPz2S5x59IY8Hnfthn9Tr6owwzW0jVZIXxEliOHwSg6oU3xMtJ/Zg3bzo3K78cok4AnygOKKBW0XOd3SkiQeIf/kkk+nScZSl38UAo0uWhbf4VgvTCRekfTOyR9Ags1N4k430fSi7voRBQTfxTkNpCdCAwhFg5wEX9UWiIK/PartGuASH6syDzAGCaiiFHaOts8wPpvtlIEd0ZNKFtxGpx2B143ISUrJnjThajxSs7MX9fgGttyZlHoS3G2dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(6666004)(4326008)(5660300002)(956004)(15650500001)(2616005)(8936002)(38100700001)(316002)(7696005)(478600001)(8676002)(66556008)(16526019)(186003)(2906002)(52116002)(26005)(66476007)(83380400001)(66946007)(6486002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cvdSJ2rNUfYTmsk7LIFRnR/YRzTv6DGRmA917PeaZmH1mRn4oN35e2s1O0dI?=
 =?us-ascii?Q?zch3enCjQRftuFR0D8evDpFc+hYvfJE+UHgnPCoKAkn1xzHQeXfa2zdSNNNk?=
 =?us-ascii?Q?N97mIT/5QIDpZjXHvTSR4X4PZlYSX31f6/LL9tUw6ec9AIscC30M7NTlK96g?=
 =?us-ascii?Q?QdXw7Od2vFGU3sK30JBudOdFlCypWcGDIxZNaNpBzdyF3AH/4RjO5yMnobrf?=
 =?us-ascii?Q?EUB7QAUo27MjCj2D/aEjUvRVyXHkHp0KZH0Y5jFVN6xsDb5uQtFIlY5eiYB6?=
 =?us-ascii?Q?Apa7oE87WQsZwEHSccpsalunI4qYiwyiKIFGqsznWQW7K4/UbRtqyk6PI3y6?=
 =?us-ascii?Q?KgUfyu8aMkL9NmFiZZePlX++/Qzz9zqPUEiib7acflYT10cKfv5yhhbuJb2J?=
 =?us-ascii?Q?2G9BcyKvRZR8NZx+fbbeC1BdEv90hbgT04F+2leTq+JsKUOyrvECAP1kcpsY?=
 =?us-ascii?Q?QKNyPq8BFMJ/5W1rBNVvLOsyPF1txilHij723AeYp+kDG2R0kiaKi33/FkAI?=
 =?us-ascii?Q?xzgOXHYwiWtJnajB6R0sk/bmAaeWkBM4h5gbJhGhHJS154kMXrx6dglY4O+O?=
 =?us-ascii?Q?FiufU6LsEnl8Uc2igPamYXLRQeBrRKGmt6q1t21rVv2HD1gAJ9I43+EUpoGT?=
 =?us-ascii?Q?MiWMAtlvtVj7hIToVEHYQd0cVXDrmMCept9wS0We6fZsNfix50nIeDrV3406?=
 =?us-ascii?Q?42G3GVcZgfH0J/f7BviTw+DXTm7PU/mueyYvRRsBKE87fM0Edya+SS3ydKCs?=
 =?us-ascii?Q?s9WLcpkwyoIDx2WrscAeCmbV/ltUrF5Ou/ZvntrjxafrCexACvrNcQAIbO8w?=
 =?us-ascii?Q?JOf3EMj2Cb42D9ZdZ5nWn223LkWrWRiYTKwiUtXxt1MJOg5W+MVk9pBe4aMg?=
 =?us-ascii?Q?1u+Ew3BSYkjAvHow9sSb2unHziyYPm+gjJAT+zkXKCjSJo2p16Dbq6LyswBx?=
 =?us-ascii?Q?PAbKDvp0E/jX9kHnjdfjq84EIpquP6LGODnAZjaeR8KejGDKCRcW6hpwFuWw?=
 =?us-ascii?Q?Aj086biXr4cwnBQWNqEvuJx0EJtLepDSIDnry4Ma1oijUwgxTWas86dUzwQ+?=
 =?us-ascii?Q?9b2F2Br0vw+36hb406xUL0XOi8zLOx9uUmTVtZ+rkq7ojKtMxAIS3GNJf/xR?=
 =?us-ascii?Q?B1HCiypLiuj47jd/LjNBO2bLMLbigOHOMjZm+OeCuZ10W+Ja9INljVJyn+3r?=
 =?us-ascii?Q?yVUIpED8z1uc5EN8l0151+eCpJECJUOufwB7QBR9ajl+ehoAO824UOBM8Z9H?=
 =?us-ascii?Q?QPzGyTntU9pTQGCVoTN4qs8acb28cHw4F9lXQ0T2+l4r36v44nTdkrWupsD7?=
 =?us-ascii?Q?VO3xvdhYy2JiiupEhSsetUzT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f4ad0-ccea-4d4f-7f41-08d8f37afda4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 12:54:44.3119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8FbAc86qYtsNzHSb3NNKCuqtHi3E/j9maQAb2BZbJ1DKHp61bmsQnQFTe1jmcrF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_135450_149142_739FDA0E 
X-CRM114-Status: GOOD (  15.65  )
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

The NVME device pluged in some AMD PCIE root port will resume timeout from s2idle which
caused by NVME power CFG lost in the SMU FW restore.This issue can be workaround by using
PCIe power set with simple suspend/resume process path. In the onwards ASIC will try do
the NVME shutdown save and restore in the SMU FW instead of PCIe power set in the driver.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/nvme/host/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..33c48ee 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -42,6 +42,8 @@
 #define NVME_MAX_KB_SZ	4096
 #define NVME_MAX_SEGS	127
 
+#define AMD_PCIE_ID_CZN 0x1634
+#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -70,6 +72,12 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
+static const struct pci_device_id pcie_rp_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
+	{ }
+};
+
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int n;
@@ -2786,6 +2794,9 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
 static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 {
+	struct pci_dev *root;
+	root = pcie_find_root_port(pdev);
+
 	if (pdev->vendor == 0x144d && pdev->device == 0xa802) {
 		/*
 		 * Several Samsung devices seem to drop off the PCIe bus
@@ -2822,6 +2833,12 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (root && pci_match_id(pcie_rp_ids, root)) {
+			/* Detect NVME device which pluged in the Renoir PCIE root port
+			 * then force use quick suspend/resume path for workaround the resume
+			 * timeout for s0ix.
+			 */
+			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
 	return 0;
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
