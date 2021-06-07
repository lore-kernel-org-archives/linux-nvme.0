Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1244C47095
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 17:34:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658B161090
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 17:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658B161090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DxfsC/MQ7xXgWmlPInFxyb2OXZP4BQeTW+SJ0M+EJxE=; b=Ld0f8OYhPRZwCo
	az6fgFbiMNq/Gg+bd76j92Tql/+oFyK2mgBehBXjnvkHAUWYbdCrOgI4JdHrOaKqcfLaC1SzKac1n
	lk7Zo7rBzEfIO8ZXKllLIz9sDEhMQ/+ZlXR5yySBzNCBGn7c8wHDgrpyevlQqkeG6jk0Yh2a3bq/A
	j4y041Hbhr83/6sCgkRF5isoCg5ZrLa5OWvcb5Er0D33D/HmyU6+9CMF8IxhRvAdIhulv6+X7Uze6
	26j/IuakWrbe91DBrOSls8EJgQwunU/U/z44jg666GlmQ/ftmuVOAoxdey6llUlFBkk7Wu+Yz2kkI
	7yDJnpc3X/HECM0lBqTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqJ8T-004pwv-Fy; Mon, 07 Jun 2021 17:34:02 +0000
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqJ6j-004pFQ-Su
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 17:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV5gRlzvNMSLepLpW6iwAeNRfIHhK4c1fN3OyOSIgcODNM+dvwaIU8tC0fULl7VFo4/ZvpC9ABAVudl9eT8Vu82IjGfkeep3n90S8FHh2IOiJdSTHsJlruv5hlH9Ry5B2MGHtrAS02dbmIpVzZd7o+ntfCpgSMkfTqL5dU10qcQGnaLhWc8o/WW+N0VL/1VfCTlZutnwtUBj8QUO8ny/77tflJFwqpI9Je1mKUFDFJDPFtgJm83HEA0apnX/A5h/Ado4hMV99eF5aoaLwxA+HZ9hH/pB2XPNTmhzWXKZBRdrCgBHGz4b1yt0q871rIhRyiTjq7OlFcEvxERgaujBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBprqBEisAm8e+59Dep1e/1Sn3f5I7vZQ89JahzIwu8=;
 b=QNDfgo11VkrFftCecp9C4nDz+vS0jFy+VLDil/gksfiOB+/RJiS9OIdGD7kZOlinnWpG27UeEOXlqZqiOZK8R1VhD6sfR9IRQjF65hmuxxnm78fVHeynmxdakiVKNhRTzFACI0pN8okPXC4Bv7gRCx7OqbyebfsEh/VB0EebqQDplNtEBgnY1ul0P713L0/Af+fDXhkdnO4Vc4RYVV71shX5C/EwE+dwV7Tnofk5QiXlwQfthA7KMWiGF75AEfR81OnVlrCcD5KnT87IBmudSnRUXrY0ttLmgIMNrqWSG6a+z3AInaljptu0t6+Ve/lGQ/+UzRbeGKQrh46cGBH/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBprqBEisAm8e+59Dep1e/1Sn3f5I7vZQ89JahzIwu8=;
 b=GTH/dkKzjfIAC9Nov7VZnkw3BwIkXLIsjV6jD6NltYz6TUot4ilYJwo209cg5RC1qq/Y9VwLlpc4vCGLj3v0PYl9n0ioFjqZbc87yzyp5RoTBRunO4VbRqx4nWLfuKe2EOZRHZx3R0KHVSwWouTf7JAoab/OsUCTIPC+k6ydLHQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 17:32:08 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 17:32:08 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Julian Sikorski <belegdol@gmail.com>
Subject: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force
 the D3 hint
Date: Mon,  7 Jun 2021 12:31:56 -0500
Message-Id: <20210607173156.5548-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607173156.5548-1-mario.limonciello@amd.com>
References: <20210607173156.5548-1-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11cbf6e6-e413-471d-4993-08d929da2cdc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451082BFDA0D13A5E40030A8E2389@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2F4K789mD6MhpBnOWN6QJXRe7S2YrBSdYPh090AnxIgLkIs8hE7FF4jHnHh11+qc9DPuY2zDP+EoIXqrzG/ejZBO20qZ6k71Z7Ie4KQUr1QRnD6v6aEJKdXdmuBFfWFYMYrtpKqImg7pZ4R7/a10XGleGC/idxnijSvmgCXBSi6ty6dASzDHOvKwryS7E9D8aGs5vuV3C53xOKvjhAkftmgppuRxkvZry/oL71gsG5da6n989UQSwN7fokEZQPePQzS/TS97L8lOk/ylKp4SHMAkAqrXrCNtr3EScgFwtLuQj1kN3zcR866cq3OI+kzkD/qb0OJqpgdzfnCeKLTYGuTFC5nHLr1rMIhEQpqSm9AfOG1m+RckxeFltFgOq2xKQKn+flsaPmtKrVoIk6fuS8UZUkiS+FKFuvf1jlqlSwnzVZ7i5hnUB2PqyzliSEWXaFwZmQyRfEgAQDrALwwjES6GUGFRwD9xmIZiEGpO/OHpOee5bLnTTTWjBSKlNp0A6Z5F66bL+2y0K7agcEqHLPl2uzOpHrkCcgDKIUQfww5DXaHMbHsJ55FxcoclkLUpXgdT5tnel/px3RlF80OpWtzb4FV+ACKy1MkU8w76Bhj9DpS0Lz5h/8F4w9JnSwSbkDfUZVr1KfCve8Nt98Xe+ady9+xbqAuw6yAuIqXdRFFoCU4YuygKGpKzGJsiqXpCFCPtV0MDQA9QnjF/0gABBjyUlRyxjyU9/fNy/XlA6UpNFteKVoBZTL0njVLlQgClP4xal2uPUmXHHvaLxdvehA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(2616005)(54906003)(44832011)(8676002)(956004)(45080400002)(966005)(8936002)(2906002)(6486002)(52116002)(4326008)(7416002)(86362001)(1076003)(110136005)(36756003)(16526019)(83380400001)(66476007)(6666004)(66556008)(66946007)(26005)(478600001)(38350700002)(38100700002)(186003)(7696005)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/km2VIkzTbuyIAe71QCVPwIlGBxz/YWbUHCm8D0VCU/m7ooiVOfJhxzTlAVe?=
 =?us-ascii?Q?22uoZkki7j0IXkKzADFJluukXHKh4V8jqzHTveqWK+ZTonQD+aDSsrEuZkX7?=
 =?us-ascii?Q?/Y3R19pFe77rVK0XY/ts0MsbLTVUWQZF4HmcV2h4g8i6D/NRu6RNZnaARKbk?=
 =?us-ascii?Q?X+ObVcIHpxu+a8ecTp2vwvVXNHYtS6zRVfuqaHMCcw54e9momR6MGb8U9Pu6?=
 =?us-ascii?Q?Kq4Z8Or4roBsfbM9yZe0Ky1aPNzhM2iHQjrXP5Nx6rl5moTdXDgIEuckoXxn?=
 =?us-ascii?Q?9cclw+95vp+qiR8X1hlwxpLz3vKiH18HB6NL1v4yHFtbDr1xnh5/FwyTT5Tx?=
 =?us-ascii?Q?DJwMSYdQm0HWfBtRTKAgyNVhXPjLWrKDGoHQilp5Ak9YnB79gKfxlG4zfBn4?=
 =?us-ascii?Q?FNw7EggzPNxrwreVCYqob6T9EkrUSx3SFOWY2gGxhHnjiCu9jMNsKyFi34b/?=
 =?us-ascii?Q?DsN0jST8jCaZVsewlLROkW91zcQwZH7imxpWyPCZ8oucxkjVACaBW0i+tFvc?=
 =?us-ascii?Q?8Jn80qtdhzH3vlO0WhHCVHlEKtTcwqvRJ4ovDs6hTL6BMYpk1zWA9eZF22vI?=
 =?us-ascii?Q?CdY63rzl9GSzRCOo1ibte+vcrnqgpfXvrcAt+2UDaDv6s/5CO/mNFsvdCWt5?=
 =?us-ascii?Q?luyDtCqNTJlJgjWL5le6KpFfRnvL0GDvxJl+Y4SMga+6KcPbkrAsYMWg0XAP?=
 =?us-ascii?Q?A8ZiZqnp7deS/CoUCxEphLKklPrDYh6dzyUfTog8KLAS5mZUA0ugtap3fQBf?=
 =?us-ascii?Q?PIO14ILKNXykeHxvW5OfuDf1/W/Uofo1rlKC8VlYNtYlRriQtcickXzllfuN?=
 =?us-ascii?Q?NHghOReEiV/E3kSFQCh55fp/dKOiIzDOyp7HEHd8CME98yWm0brrKJGpQxRq?=
 =?us-ascii?Q?vrl+h3DG1ZYuaKx7CNG88MUF2Z+DA0xH76ew26XavL+BwVk3Q53I7gMxpnWr?=
 =?us-ascii?Q?EaeYeD30RvmyebpHX4Fqh7caImKS2fivd+HRqQyg8RprCvd2XwCDGEanW0n/?=
 =?us-ascii?Q?8kq/2X1TQotDiAjBAsTHuK4TifPbypp7LhSog4QHxC7E1kz7u4PnNw4KpS+E?=
 =?us-ascii?Q?HFbA35sMrZQMRI10wCn70AEkmu8O3SUuUngEZzhT+i4NLCyHzhYug/eK5QG6?=
 =?us-ascii?Q?rVRClQDE0mc6NwbgBYoQthcdPfD82LD4XO937s8RhGXBIuK8At8Jdgrqiliw?=
 =?us-ascii?Q?gFGEOKboIm8LlsFi6fRWs4CPmzSNNDxVeWfSkx3IEY8DLHGaHOWaUPDkp8XE?=
 =?us-ascii?Q?hIIXimE0vBE6sT8YZ3gnq/NP9Dro1nl+nLkT6NMlb0+mwCNHdVtF0NGv7/Z7?=
 =?us-ascii?Q?mPDoDGdScrxdXPMjg/yi/rCP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cbf6e6-e413-471d-4993-08d929da2cdc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 17:32:08.3223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0vYdpObkqlE7CWc+m9SbXHPu6VLzd/U3hry06HkVi0F91mEkrWB8Q5l8JBy9oF2UAKWM2yQSqtWwouysHEMUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_103213_986295_E68F6BC7 
X-CRM114-Status: GOOD (  17.97  )
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

AMD systems from Renoir and Lucienne require that the NVME controller
is put into D3 over a Modern Standby / suspend-to-idle
cycle.  This is "typically" accomplished using the `StorageD3Enable`
property in the _DSD, but this property was introduced after many
of these systems launched and most OEM systems don't have it in
their BIOS.

On AMD Renoir without these drives going into D3 over suspend-to-idle
the resume will fail with the NVME controller being reset and a trace
like this in the kernel logs:
```
[   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
[   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
[   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
[   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
[   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
[   95.332843] nvme nvme0: Abort status: 0x371
[   95.332852] nvme nvme0: Abort status: 0x371
[   95.332856] nvme nvme0: Abort status: 0x371
[   95.332859] nvme nvme0: Abort status: 0x371
[   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
[   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
```

The Microsoft documentation for StorageD3Enable mentioned that Windows has
a hardcoded allowlist for D3 support, which was used for these platforms.
Introduce quirks to hardcode them for Linux as well.

As this property is now "standardized", OEM systems using AMD Cezanne and
newer APU's have adopted this property, and quirks like this should not be
necessary.

CC: Julian Sikorski <belegdol@gmail.com>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/device_pm.c |  3 +++
 drivers/acpi/x86/utils.c | 27 +++++++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  5 +++++
 3 files changed, 35 insertions(+)

Changes from v4->v5:
 * Add this patch back in as it's been made apparent that the
   system needs to be hardcoded for these.
   Changes:
   - Drop Cezanne - it's now covered by StorageD3Enable
   - Rebase ontop of acpi_storage_d3 outside of NVME
Changes from v5->v6:
 * Move the quirk check into drivers/acpi/x86/ as suggested by
   Rafael.

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 1edb68d00b8e..985c17384192 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1356,6 +1356,9 @@ bool acpi_storage_d3(struct device *dev)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	u8 val;
 
+	if (force_storage_d3())
+		return true;
+
 	if (!adev)
 		return false;
 	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index bdc1ba00aee9..2b8d5b3c876f 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -135,3 +135,30 @@ bool acpi_device_always_present(struct acpi_device *adev)
 
 	return ret;
 }
+
+/*
+ * AMD systems from Renoir and Lucienne *require* that the NVME controller
+ * is put into D3 over a Modern Standby / suspend-to-idle cycle.
+ *
+ * This is "typically" accomplished using the `StorageD3Enable`
+ * property in the _DSD that is checked via the `acpi_storage_d3` function
+ * but this property was introduced after many of these systems launched
+ * and most OEM systems don't have it in their BIOS.
+ *
+ * The Microsoft documentation for StorageD3Enable mentioned that Windows has
+ * a hardcoded allowlist for D3 support, which was used for these platforms.
+ *
+ * This allows quirking on Linux in a similar fashion.
+ */
+const struct x86_cpu_id storage_d3_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
+	{}
+};
+
+bool force_storage_d3(void)
+{
+	if (x86_match_cpu(storage_d3_cpu_ids))
+		return true;
+	return false;
+}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a82faac5767..9b0ddbae5617 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -607,11 +607,16 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
 #ifdef CONFIG_X86
 bool acpi_device_always_present(struct acpi_device *adev);
+bool force_storage_d3(void);
 #else
 static inline bool acpi_device_always_present(struct acpi_device *adev)
 {
 	return false;
 }
+static inline bool force_storage_d3(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_PM
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
