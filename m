Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27781C2B9F7
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 16:03:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17F2611AB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 16:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17F2611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OxixASI3Jd/fBRPc8ZuideaIYdscOlafQjC6ZR0cFUM=; b=cpT8ichgUUfYFV
	CxNEYmlJglxuoqJCq03ltkCVQThtkqDO+rwwODCoLAbqL8RwQf5XZp4VYayBL2lve8NrjaMuAFXGm
	mYK7tJhbIz7MSeC28YkMsJo5dvz5yrAn9+ncF24lokx+31XrxZBb5EYxKoAyPbGxhvShzFPd/ie5E
	setEx5913MDD5CS7cCVgTgdWcvxG7+jWP36G0PGVAN8HQak+K9Q3q9z3JNFFdgxQpMxyi4FacTztM
	BoUNrBH7Cr3tsqkyHu6AKwtQx5OITtOdzATNBACB01GSkItdZ2emNV+16oLGgGDjANUhNzqASt+pp
	cSehNMXoAhVSwb5diXOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmewx-00Gnwu-7L; Fri, 28 May 2021 16:03:03 +0000
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com
 ([40.107.94.49] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmewt-00Gnux-R5
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 16:03:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVqlfZKC4ZtTfJMO5hFB24fjzG/Es31TCpks7ttKV5fDFLyYpMoLcVVNExAcIJZTqT4z6tzgTIz9E+XGiqHHEr7NUH9Te6qTUCzz9T/sHozW8JcXa6OMpZfsCkgHfVtew/A39R2linZiQk1CmKcdxqi73HfUheHFw80V+flq6PX1okOb3fXZtnPT7HOiXKKa5xLQ2tk02PewDY1t2fKEnBbZ3K4bcz+HjIX0KrUDHAusDG788D6Aa6/Ao0Owo2nX5/dbxfvA09b/MPOO+ILTKPAejQ1/QQRouNByJdWvF6f7lJG9QDpzOSBWYxCkIC3ErOn0G9eIHj2e+WdpHA4rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2/drGdHYQf93hCDzStqeWiblY5i4h2Q8o+pCCw4iQc=;
 b=LFxmZ8IMf6u0cmy78xk+LFc6cmQ7oVdMycmsiJWq/+icHWhf+ugDC/+6uuYT/WKh97iMRxO0zGmrYBzD8dFk9idamRo0Cm6UJ5Zi0++tINDfnNmxu69ayW8PBzipf9S5t3udUK05uDqU/ebDdgGwZ1IGlTJA63OaBlo5XO65YYXh69y1wcOhbHRIwVbtwFzvQD1T+fTD+Kkh33ikhVq9f9pi41r1wKhoi3OCHfuREbfoCNNR/bCivzJy4CnbGDxeGX4XGtdOxI/T288LrtO5NSMZCl/t9FOgQvWfl2V8rrcymRk9DdghweMRQZcFBYXFb2DDHb3yPosLhaaVMy5tzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2/drGdHYQf93hCDzStqeWiblY5i4h2Q8o+pCCw4iQc=;
 b=XC0iX1et0fOzZMTHKtL/pgZB9SnrT3fSkVLJK5x2xgn/ceLVwhSAM60aKXEPA3yB2HPcOt7nZ6MmDizSzbIeCijBa+0hn1ahKqTYloHHq5J2aA7IcRFbx8v/2rck3XrWp79Z2NWk7IPhp+D8c/O8OHDGUD9CLaOKRRgUTo6fxEY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB3558.namprd12.prod.outlook.com (2603:10b6:a03:aa::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 16:02:57 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.032; Fri, 28 May 2021
 16:02:57 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, prike.liang@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/2] acpi: Move check for _DSD StorageD3Enable property to
 acpi
Date: Fri, 28 May 2021 11:02:53 -0500
Message-Id: <20210528160253.9492-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN1PR12CA0101.namprd12.prod.outlook.com
 (2603:10b6:802:21::36) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by
 SN1PR12CA0101.namprd12.prod.outlook.com (2603:10b6:802:21::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 16:02:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7930ee9-d7c4-4575-5b24-08d921f20f14
X-MS-TrafficTypeDiagnostic: BYAPR12MB3558:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3558A7A47203A67C33AEB466E2229@BYAPR12MB3558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMSeKNMzSSrC3zIpL4MTTSbZlZI31Dut/axycWFUDecthSwV4cLD+889abvA4NaKcrhkk6F4nL+aurdcmz7xeigf7BtNPsju3269OcDbt/a4UisKSXkbBjHXNVTsx15m2KKRIDAf2CeBOGrDx+DcFC0wGOcb05X44Vl0KyhoY9TJGcDhE+FRhz2qToxN3K2NEzB4vm+iIeEeN2nbG3H9O31iwnThZJuH+hZ7XOgtegUVad7kYjZZOsojMWYlUHZO2pcfn2R3hrKyUJamXoeq9WTnIDbAYxY+qs3UIAOVHKeZHML5S+JyNq3DErQPfNmmCotqK38TKcWN8flgBT6CgTPD2Qi/lyIOA67A9gj23FfiBURyrdS6cX4M/ONPTosi+eQVIhd5AOShW7Z9WGlK9CkHB7khKFobBHfK/igxTMjCbJp3ctVIpyUgWjn2a5wD3AmQnFSJvZfTlkir69DMtQ1dnTlxDFG8wHGSwJUV5mkywvzh0ArZS+AxQQiZAjoa/7DLe3SwjKQ9jmkvW3565hCEayAW4JoO12sFE6yz5jqzO0DQg5qqjD4wMAPTH1ul3KpZhEX9ajZIozuDHOfhCKCOVnmgq91bKpr4X37A8QHONBCyCKSf8aAqfyauvLogPzJjlaDJtwRXdtV5A1/pcXuZ+MQ2qgttXUOO+B/y4vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(186003)(16526019)(8676002)(44832011)(26005)(38350700002)(36756003)(52116002)(8936002)(38100700002)(6666004)(86362001)(7696005)(66556008)(2616005)(956004)(2906002)(478600001)(83380400001)(66946007)(316002)(66476007)(4326008)(110136005)(5660300002)(1076003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jOzQ2O0YcfhEsmCpmidpOPQ8JKpeWG6SckQE6ojzPwCJ4jRRSygrB4tM0jzx?=
 =?us-ascii?Q?qwBYZn8ohwtzuaFOi2ZiowSxJGo8YHMxKpkyqs6QDvmRwB2T0cH1lt1Na1A+?=
 =?us-ascii?Q?SBt1SktwqXSW+uuPZu1qoee3lW61v2nmSU3OoMPvo1GJnkwjtteeqT63MELn?=
 =?us-ascii?Q?TE2p4iYCGn0qeEGHioR9cD7y0LmAfeHpKLNsNkUFh+rfCIaG4CE8CDwyGrZA?=
 =?us-ascii?Q?fjxZbo24H5axW+Lv0kX8ehmQXsLI8uH8FY11F/0a68Ub9AutrpMRf4KL8JnU?=
 =?us-ascii?Q?v3dtrx0HJZiZEGr2V2lsC+OT85fHX8WmUz6HFqVaZUfi2ob6Ay+DonrfwhCv?=
 =?us-ascii?Q?iBwmGoltwnh57SYPfFXyVcmZq3ehx0Ls6rp79uhIcW4oiW5WvOeLYmDAw52D?=
 =?us-ascii?Q?JU+zHPC2ESQB6u769S5XTU+kDnP8snwNCpfN6d6aS+vhaKC/+mFlQtJ/jlNm?=
 =?us-ascii?Q?XrSP/JL2+u+wBNmFJfMUc3VfoLjI02UVlh4BFEILjw6mpPJvpV913TTiwmsE?=
 =?us-ascii?Q?iaIae2Zt6TzCTsWhaHZUREG5jZiW2P1+pwItzx5QI1E16k4pqtvQuZTbZ08S?=
 =?us-ascii?Q?HnVheKGYcBHmwqW97p3XQyZYjcH/n+fWs2G1gRzbvQuPENsTUGbHtyfaWVXC?=
 =?us-ascii?Q?Iw2hx0gMeApl8ti8rk6XqFvfcjTE6ZHM5vUVCdlwUxYUE+/B7JNAmAw2UDkH?=
 =?us-ascii?Q?pp8tTfHURjj26II2R6+oY4OO/3bUCZFjQOp66W/kc7HeFpqmEDNLRzeLTb+o?=
 =?us-ascii?Q?I/5gJK4BxLIQ8Nqo503dP3Z/NKWX/tbjVhH5Y8N5HPUelU+YB1lmtoeIqVJG?=
 =?us-ascii?Q?VtZDquHotgFHlcD329sgb+yrWy1071sZcye5ysqikHPoD5aaexOrK04DTSoN?=
 =?us-ascii?Q?GoWlBwsijFRtExZDK7vhqzLLnPsamWS0V+USC0qrwno2vFToei2MD9DydgRy?=
 =?us-ascii?Q?XrpUbyejcXTrv8s7SClLv2M0PAf6100OcoI4qJJzyYA0hsFk3upki7cMI5oo?=
 =?us-ascii?Q?RSUS6Bt+RDEHt3WV3E/yuZRaLPk15a8mP9V8aDj2sc5iQqbD4KOI1i19G+dI?=
 =?us-ascii?Q?vVq6ib/VzhnLdnsjnynhd7vBOaMyc1Yu7fdDFpl86BHRmAy5fkK1+hpK0Ow5?=
 =?us-ascii?Q?KFiNCu8I2Q7VExBTsVkSwYtgeDYxxIdY8BA2uIdq2fvKm9ZZOzqI74o596Ny?=
 =?us-ascii?Q?NVh3YKXlDCtZvvQfWPBHR5mCv07J3xHofDONoX5AhfUdrPdi6kiN60syrLnT?=
 =?us-ascii?Q?72sqIYgk38gom8NmmBZS2j0gWHUDcWVhzxigRizbQC9xLjCeSjgtCoNU1i5r?=
 =?us-ascii?Q?DU2mjojWrR6bDTckDainLmcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7930ee9-d7c4-4575-5b24-08d921f20f14
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:02:56.9799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wuc/2eXOtqctCNXNkUv5sIQak4LBZjO7YAIB+PlzUqVY7rm4qJIeV46o2ykjojHwLc2wV3rHdklxT/6zLeuhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3558
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_090259_913963_BB7A7979 
X-CRM114-Status: GOOD (  16.94  )
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
other drivers as well.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/device_pm.c | 24 ++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 28 +---------------------------
 include/linux/acpi.h     |  5 +++++
 3 files changed, 30 insertions(+), 27 deletions(-)

Changes from v2->v3:
 * New patch suggested by Keith on the mailing list.
 * Rebase on variable initialization optimization in first patch
 * Add kernel doc to his patch

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..b959fa54f478 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,28 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if a storage device should use D3.
+ * @dev: Device to check
+ *
+ * Look for a _DSD property specifying that the storage device
+ * should use D3 to support deep platform power savings during
+ * suspend-to-idle.
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
