Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1542CC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 17:33:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D592561090
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 17:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D592561090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pzyFcCsOsR/1abimvBM4DwIKa4w7rilnQlUYr+UEZuY=; b=k7+OjFxzAlmFb+
	a5VqVtB576NUgD440Bw2f6oBHNOBTKe2f0magxN4oIyNJHIbeSgQU1Nw8LeDmqxoQTN+jfC9NDjaj
	9z1zKOXx+wUqlcU+IQ3eDvJByE4vba1TpetJLOnXQ97fEMByPLFfOgx3rs9hALuA4wMiirOSpx35d
	dEVRk3umsYwC4eTVZUQveJ5MjpZ5eVqezqdGA0F4K1RUE92x1wPyELThZ+t7JTsT3K+Fk21NPx28s
	lUAzZ6wrCLLUwVlDpcC9Kb0yyqbd8b+aeLCCUaMK3Or67quMywHhFkghn9EwnRrXLDA0966FjUUav
	yYor32fnA4hqrelDNM+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqJ7J-004pV6-ST; Mon, 07 Jun 2021 17:32:49 +0000
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqJ6g-004pFQ-Rb
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 17:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUIRBVLneFqKpVvrQZaT53v289baCbQR94Gh0S6IOz+mMuRU9qjTbZHOgfOHJ2p7Dj78qwtTdPQMnBxFTfg88CMHZnziy0c/Rt8Gli/kdisj+Hg7RwwZ2GO7DrU9Sd7jQxxE5VTowY2ojz/lS5qqj8gTe/AuGuYa+7sS7WPuaD7crDCuNz5HpSj5UFaKglkn/QZZckwuu0CODFGh19lAOT0AyEwyqsBKGuXFlbp75txPCRPanpbhemsUr2Zrv1KaN9EqLVmKOWVW98pWmtUrz0BufbRJU1u/Hcpnprl85s7zPTOvNqYZCzy6VXc4Jj+fCA3Ykmn/cnUO3lM0jr6EUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlv/RKo+x4jY8pvYX5XJhmkvCd+iacq32Lrp5XHzJ9A=;
 b=kf+Qd+GB+MX7zxk7enrgUhyGl1fbKCIQCJA7gOaMwgnZ/PA/zms1Sfmr8wcvaUJlc4nLK4Vn1ZTYtS0IplRNx51hWMxYUXN6w37xaGDjCVAii+ibs2t8gAdJBrDwz/9HfaIJWgAf+c+BBfUQQrBDP0K5FaXV67BCMYX/M+e0sv8PuctJsQ0F+0ehDfZNf83NxkCsVJbZv4sovDyll7cKukihRxCoEQpbhty3eS1xSxTw8eaPgW0fQyl4dM5WLp8Ork2yijsq5PpyEWBfEmy1UGtSR2w0AoVHXdLODRIQL/wXGfFMY4xXguKaO12BKJKn0r092zb7iDeJA+2l18viCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlv/RKo+x4jY8pvYX5XJhmkvCd+iacq32Lrp5XHzJ9A=;
 b=D+wzFHGI4njErfGLUu2OLX6YqcMIaYmwDMMd9n1y4YUzUnbVVg8G3vMiOgSswQ4TRLFK2oQpmnQH/H3uKTdZqC9HF/mcXTMVdxvYxI9KB3tLNPFVPoJ9+mzAOgWU+9XQJLfBpyFTOCBPxUB5vnElVnn++QlJYGfMVav2mcb14ZA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 17:32:07 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 17:32:07 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable property to
 acpi
Date: Mon,  7 Jun 2021 12:31:55 -0500
Message-Id: <20210607173156.5548-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.77.1) by
 SN7PR04CA0162.namprd04.prod.outlook.com (2603:10b6:806:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 17:32:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a262a90d-41e2-482f-8c4a-08d929da2c66
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4510E2A9C03321D455C5980AE2389@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a14Xwqe20HjF0OCtNanh/WV6WNDMgT7z4OZdrqDtfZxiCROw5Z2+xk582DEI1LvxMZ076QHV9wimG/6E15N7/mwPFjs70JuQvRqXfKnQ09j77/U5T8nqbJ8UW6tP7VcThzMBvq9xvBWMHKgw5zPdxuFIH25PZSvWZk/x6vNUF8EivrCpjIqk4Vj5XPNb7pGxNP8F91hRLEjOrSmM0zTrVm+nvu78oMCDp12U4uQvVMwVar3GFaSYgkvuMS318YjcwuX3XNOLLnMwOstct2xL52EzkO98SUs5TIxQU9Bw7dHVZt+kW7lxe0T/+XLBLkINraPOHD7EcMNAd3p7hqFOYOA4Z+G+bIK1PUmTaN2Bm8PmXWcRiTa9QHwKRCUNr9vBNEp0MJF6K+Hja/yA4VZmaPOnjXGtyI0Q3MwGsE+IFGwCQU/LLx1qR802nlp+mfUTVf7f9bdZa/ChUnMDW7lVqN3jfT1UX12TdpkfSP/4AcRmeKn3LacrQCWp2CTqDhJv0v2eDvROdOaUZzoYY4rPXvjCFYJk1sy+rvsFwI9vN4hiCielp2gyzV+4EuNX+X0x6KfbSKDOARZX/IQxt1Gqxk6aTqIyRMWW1b+VLeu+QJUTqyb4qf0ipSvydk/0zsG8O5f3I+QVKNcfYQkisKXXvQCbrlZ7Yw4PmnRL/eDRbRvwkUcqGvQl0dQ3ek6S/3YvAYAGi0XogN0IHOpYFGnFcSEPCy4LcefgZyLaZ7/YdLolCWllInpJ6PAQFJV/VV2F2OcdKdIzmV3AjZaRgK4yLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(2616005)(54906003)(44832011)(8676002)(956004)(45080400002)(966005)(8936002)(2906002)(6486002)(52116002)(4326008)(7416002)(86362001)(1076003)(110136005)(36756003)(16526019)(83380400001)(66476007)(6666004)(66556008)(66946007)(26005)(478600001)(38350700002)(38100700002)(186003)(7696005)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rjXquWW5EhwrqlX439TBSqNFWpv7/GcXVE+lai8v8NU3Y8a/AnBXMoNdK0Z+?=
 =?us-ascii?Q?EKXHiDc7lc76iMg3Se8gAFxJLUopOHjXqWhqG9ezQeCxolKHO3vkWNaXgPtl?=
 =?us-ascii?Q?ZRatrlkzfu18BT9AH9mndIZcgsSZXtS5spPBoMwq8kYfK/msW/c26DA70LPA?=
 =?us-ascii?Q?0MRiNdJKXxFBh/Llo+R12qhrjrw3bNeXLu/RDwR3KIzokn0F/yx8TIDSJAzk?=
 =?us-ascii?Q?dsmfsZ+lV7UBP5H1dL7idI18Tghj8CMYNXoFTIWifQ5xLXJ8E+j3I1q2IQwK?=
 =?us-ascii?Q?z8gWStM9QxQGqhaJKRf11mYiu2Yp7VQR8YbXDTT8EoxjT+MqSiMF2/S/wEBQ?=
 =?us-ascii?Q?WGxHLQiAmU+gatiEV1vnNcOmeL5bkv1yr6lOtoHaYteoWPGZ9p3eLLNhCPeZ?=
 =?us-ascii?Q?oMDpXZt4m5MmWD5SasaVTIkGMM9Pi3N9lAyKYsYiu51rOYF3F8NyBqDNU1Bo?=
 =?us-ascii?Q?OLX3ehSsjmIqX4qfpolA6MsulTyr6Qz0uSI5fP6CBiXumkLXLs23NudZIxgW?=
 =?us-ascii?Q?sHSGuQZewOxLKkd5utvtipKaHYdg0ymYnn/n8atowtLo5Gr139VCl0+/FICK?=
 =?us-ascii?Q?85cySCiVg4h9QMLbXeqlq7mb1H/ooNxTteZEwxSIPUinp7YevMnQXuJRhYFh?=
 =?us-ascii?Q?1ufCgDtteH12vA2U/VX6nUV2vYi/tYLVgDg78HudqRLj2ZHu9MxEkzrtPI97?=
 =?us-ascii?Q?s86Gd29YPMYrdQqMBL+efHkv4dWtPFpja7X2NwzIzgFvtfkVLbjuW3LIsRXx?=
 =?us-ascii?Q?wBjURty7jOcDWPtL+nzJWq2cva8ZaMlISTrorjez+FBukAkso8nW2v14Oj2W?=
 =?us-ascii?Q?5mZxN4nz+AUvmUhrGSjiaPSDCWSNtkUvv66SFXHNwryF7msfMp+9kjvAgzZC?=
 =?us-ascii?Q?76kMMy3kggoPYr4MWr1v95MbJPXeAHEY8+sYbyzY3OdU3hRCmiDYJ9wGpRah?=
 =?us-ascii?Q?MJuyJbpI4BCk4HkFD+cEQjDb9dfLTDF3YeiRzoiAiXzL4bEWMEvW6zCRB+8c?=
 =?us-ascii?Q?TNURKQXoJQhAf5uC5pv7i5EF3UTqBIQRNBcbKXyIlSq/NlsibuTdLydvt0R4?=
 =?us-ascii?Q?t/N3fNlWtVOVAIXBewW/SqvX2q9RL0do3NuwrXIpsOOEIbvfi3iwovlzk1oN?=
 =?us-ascii?Q?xCl8m9ugjBkhSB3nu26eCxvvUyZs7kSMyniz1g7Z7WxTDFMgxVBt0rxUxPfT?=
 =?us-ascii?Q?OT2ZuuTQlF3PjrMNxqf65jbIfyazeRT/4KcP79XAy/JcOj9gJDwz5mgbxgw/?=
 =?us-ascii?Q?zQJqcqn3+d+dZI+jYc+hXt0n2p3FE024VGJ8QW90WTc8lYQcjxnvnBnqqqQF?=
 =?us-ascii?Q?/MzACCu21ggDrSMXLlJm3W4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a262a90d-41e2-482f-8c4a-08d929da2c66
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 17:32:07.5258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abRjpzpexACv64NIHICFukX7AeyYwQXnsA27xmn7rHeOZRkaqmVRXX8pDY/cUmDzGnxjiFVS+3IqwQYBqoBpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_103211_084093_FE455B1E 
X-CRM114-Status: GOOD (  18.62  )
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

Although first implemented for NVME, this check may be usable by
other drivers as well. Microsoft's specification explicitly mentions
that is may be usable by SATA and AHCI devices.  Google also indicates
that they have used this with SDHCI in a downstream kernel tree that
a user can plug a storage device into.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Keith Busch <kbusch@kernel.org>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 28 +---------------------------
 include/linux/acpi.h     |  5 +++++
 3 files changed, 31 insertions(+), 27 deletions(-)

Changes from v4->v5:
 * Correct extra "Link:" word in commit message
Changes from v5->v6:
 * Add in commit message tags from Raul, Rafael and Keith

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..1edb68d00b8e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if a storage device should use D3.
+ * @dev: Device to check
+ *
+ * Returns %true if @dev should be put into D3 when the ->suspend method is
+ * called, else %false.  The name of this function is somewhat misleading
+ * as it has nothing to do with storage except for the name of the ACPI
+ * property.  On some platforms resume will not work if this hint is ignored.
+ *
+ */
+bool acpi_storage_d3(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	u8 val;
+
+	if (!adev)
+		return false;
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
+			&val))
+		return false;
+	return val == 1;
+}
+EXPORT_SYMBOL_GPL(acpi_storage_d3);
+
 #endif /* CONFIG_PM */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..8fbc4c87a0d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	u8 val;
-
-	/*
-	 * Look for _DSD property specifying that the storage device on the port
-	 * must use D3 to support deep platform power savings during
-	 * suspend-to-idle.
-	 */
-
-	if (!adev)
-		return false;
-	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-			&val))
-		return false;
-	return val == 1;
-}
-#else
-static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..dd0dafd21e33 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_storage_d3(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
@@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_storage_d3(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
