Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65245C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 09:03:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF87E610CE
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 09:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF87E610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=57AYwBdHUIqtTQp0P5rTg0azp780+aJ1f4Zx4WIaiSg=; b=bhoDBNRld37AZqHQHgufYARfm2
	5Gv/Aep5iGQLD+gp4BiFbL9R3ayC/T7BPCU3JOs+Db8XtdPCuYRZ5XR7Qa0svel6vYjkR5bSDXIG/
	L2UhGlt3jx0rAqj25v8hjQsNqtdgvaG58kDOknttZiFL0G1pErEmKwhfViGoTxE+/KjNvklS7MFLv
	mjeo/dhdJNB5c9q5qnjmGF6Zyw89L9qfBACVQRH1m/UkVrOyJy4xekVlQibjZO3CTjxpidSbfAgf1
	BLAGGemDOsKWfGlyCyd+Pw5HfgzvIUE0UrdY1t8XrYpmbmw5xdONLJzl/Yog8LiO3n7+OR/aKt1LL
	GBzJCMRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWEx0-008dho-2q; Tue, 13 Apr 2021 09:03:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWEva-008d8f-FK
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 09:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=n/JHGO+JyktAqOvo9z41Dy/O5juODxWZa80jAen8gnE=; b=iOv1T/DmNGg60LZo1IZmm3ONqm
 G6h+djDSSaEyspgIRcDTLq6R0BkYXI89CAJIM7XVHkwnPzeQlyP28u/0/y+9gz/o+8US24zaMcerd
 7U0cTAGvv3x8jJKMgrWN0GN55iCRI7oUo8bGYn3E/aD8SlMff6l36soCs0h8naI8/hzvt9Hf5P94Q
 XZyeaVWriKI9gz39IC3M7oKQ7V5FfRtWqOd0xWzdH81ReS12EtpZ5I5WkdYJ+t5v2P8UXCwGHVDhm
 cBz+ZC7meCbavtkyI9nNKi5NB6BRSFQkQPlO9rPSpp6tXsW2f23Lcptcxm72uQPlqAaWSdSls9aj1
 ksIfNsMw==;
Received: from mail-eopbgr760083.outbound.protection.outlook.com
 ([40.107.76.83] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWEvX-006r2d-0U
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 09:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RryejOPahWrxr5Bmue/fowWsyzlYtMBX7fsZZDWVOiFFGYFjZLd+eDDVFmNhbBiFirqdaK0Gm66JGOt9deME7g2WMdVitN1rnD4Lx/9HXSpohVCdtban3s19iH17r5XgiluVf5OAMWwBWW+AftSRthfQj1heJGNFLPKKQaUdDAkujK44mZzYrb6RQDHZYb5i9vN62FMYnFfO9FXAuQZCVQ6ecjNQul+Yhr5BwRdVfI3J8Heq2xok78eEpXTkPOGE0aAWEFH2CNGc9c8ZVkLBIFJRphU1fh1x/9FkKV5tIulf7sM2/dBgiGV7nKvLI0QIxpC95EZyCgP5JCWMPoY6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/JHGO+JyktAqOvo9z41Dy/O5juODxWZa80jAen8gnE=;
 b=OFw1nfHMe+DY7iJZ939ZiKwMgNsprQBao1TtZfSo4kROdv2SdkIzldhFIqPdf79tg9CSItmpI19Y3Jmu3nhDcK4fsNMt2anGuvd8ASfF4tSR0065KpRr/UOyI3NjkmJ91MS/Q2X2Zoctit/VUTXx/wwf+q9GoQgjmiqsy5RlgoSSNQrB3hr2PNhCJF3b5GPGmyQ7El7wOE/8IG4Dmn9TVhDZvtY5vYZPLltoVMUai9WE1PZekPLMx3BhzPsmFUo5UqIvdw+N56fEEWnxqUTK6fS2aTsHBux7KrJ5AC7o5QVMBee4LYXS7PeQW3bg3jZhB61d6mvt3sHIPl1JFmLN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/JHGO+JyktAqOvo9z41Dy/O5juODxWZa80jAen8gnE=;
 b=MuNeycu/OLJr/0F8bY64JsGNqJX9HDHTGk7qf9NMTxJ1DYKxgFpVUyQIYIvcc/vMxGI4VSxoXtXTSaKhAeQcfxEEbJ674rzzsaRUJjUQr7Ps5IgM23f1+G9Smz6T9Nh1bmY3ElqXieKyJM/tvJBXxw+o02/ogw5GS8D5kxd3+jk=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 09:01:36 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 09:01:36 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 gregkh@linuxfoundation.org, Chaitanya.Kulkarni@wdc.com
Cc: stable@vger.kernel.org, Shyam-sundar.S-k@amd.com,
 Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Date: Tue, 13 Apr 2021 17:00:41 +0800
Message-Id: <1618304441-12550-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 09:01:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c5bcbb-ecb3-4a55-73e0-08d8fe5abdba
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2679D5F9B778AD4B757FD99BFB4F9@BYAPR12MB2679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 222HkApMjSIogGwjwUu4K/krB2XftvnpSz+keC/EiWv3qAy1K6a3l45y8rQ8RkwIdgkjkaTcV/CdL2AYdM5uzH/+QZ6moeq4Rvnlm+oZsvKv2/oCTGKaQB8tM2221O+kkP2DCaXy5jWdzWe/RnlQlJi8mRMwrsOcxVui0cX+5+vlJnqyABCic7rUnewCGUbMob0r3DFk3WvUALH1bFvnXLrsleJtiGv4JfjXzh4FIYJA6iGCciA25s73NGcydEByMvsyCp2KyXUh4SngTx43OcN6MU7AQPuHDcV9VT3Jg9ggbabLJML5g2t9q8zUNCQP7fDhUntmOvbsgio5W0NiCd4gGJ2zHX4H/KR98+S2OX315udMh19NA/tuuZWYLahBjji2N5RBp304OQ6+I73S1EsmJ4FdZroVSyYX718izFhX0Pafkp/6dJrzq9C554z7yBdZbNl8kTkZIRUo668MhknPUhIozFGY7Xn+gq8iInUE4ZkP+Do5N9EgIn2+yH+xIkSdIpeRh9060YypL+4bAEbAjTZ4UJwg+lkjx/bSEM48oFA+X+PKtBy13GPtXO0enWKWddodt5lHIJTH9Hb1LI9mpqXKCxoTM5TtkwS4FFRuMq+JElFyT/yWrhN2g8G3pmk/wK6TDO+Rx+/RVzFrWMjiurAGSGp5+UzVLi+RoWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(8936002)(83380400001)(36756003)(26005)(66946007)(7696005)(86362001)(52116002)(4326008)(16526019)(2616005)(38350700002)(956004)(66476007)(15650500001)(8676002)(66556008)(186003)(6666004)(5660300002)(6486002)(478600001)(316002)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?toGAXAovbNj8OqapENUBpZs3Z9c5b3dVGyp1QXmVqoZg5YI7chReJzy2Ds2y?=
 =?us-ascii?Q?mGSnYFSDcnlV11eDkdYTSaPI8IFHLydpt7+RJsY9m8LNMw4tHouXJaKvDZan?=
 =?us-ascii?Q?L+v9I40cm2+uvfpiM3lb+UbuxF+9qYilXiRFTMBT3AyCkl1w0yoeK3lLczAW?=
 =?us-ascii?Q?sTXuufyA6S9PCwXVKwsBS55ij3evXP2F/31fJZm6O/SF5CkbBwBdcKLlZuqt?=
 =?us-ascii?Q?Q+dJOA+RCJhwwywltH2M3omXz3w5GttLrIsWQpu9EfdE3rU+hDKAq85kcEG6?=
 =?us-ascii?Q?R8kdmglxuu5D9cjw0FLqbIpPYD64LxspBMP9VfjsJlXRthkmWx2YNAGBPhr/?=
 =?us-ascii?Q?GREfETYCT1QeHr4wDAK4G6QR07V4mbDjJkPjzIIz/maU2nqJSI8ak+6QSenN?=
 =?us-ascii?Q?KnsQMhVZh/g1zMvEY+ynyXeyuR0hlBy+4rARbpzRHC3pF6bs700q8X4YVaOS?=
 =?us-ascii?Q?ekRoEjXOIWljatsmzpO/NOqUCWT1D2uDLdOQB+vFE4QKIOu0/C6CgbwXBCaw?=
 =?us-ascii?Q?dwSQ8pYJQRUezCak8DZXqBSD/Nf84dMHpPHXI2PzLWCS+ZwCjC1CN9uq59iW?=
 =?us-ascii?Q?zn4WGdAhlXhH/s+rSjabUyUjGeYsadp4pp7GwPAt+4Iid7GvKiCFc6u++Gfu?=
 =?us-ascii?Q?hHtp5YgeGzBjZkAREPwyTdE71i/yX3CbOLaoRnOrdEGGAYpF0kI4tFFgUJ6x?=
 =?us-ascii?Q?6GTtRCVDKvybmixR1w2siFDzZKO1wusu4EgsJzzsCYZvIO28zhgtx3QUt4kK?=
 =?us-ascii?Q?YnqCpa7hwVYcCAamUhRKKesMXRR+TcPQ9JlZ8xYdIo6+8O38NszVQTXvueux?=
 =?us-ascii?Q?5Ex1258hCKw70uY35dW4a3IUIA/lMYAG/yfPw5uZAm924aRvYTh7/xRsDPi1?=
 =?us-ascii?Q?uUDeBPK4RqH6iMKwidjXmB/ljgyTbkfukF7NzffM03+haVkZarFS8KGu63d/?=
 =?us-ascii?Q?PtvXBKsHzJiiMSFZjua09ZyQWiZnxhdwAQkUQrFS4Y6fAUM/hrgwmP8YH9Ls?=
 =?us-ascii?Q?HNpmKtRvbc84CfrF1Y8kHwjEj5J2zzHlPriHnJHG05lk7MKJtFWv19T5J/MK?=
 =?us-ascii?Q?/2EDweDBnT7WjLz94JQAoo75eBEmbFmZ2A9mfT2KjS1HCtdC86KganOM5MhY?=
 =?us-ascii?Q?ya70v7M2lXTe7vA/QmxxD3w9fWmsbPbEi1UdbplNiZ/PqRPF7aJkIC8e57Cy?=
 =?us-ascii?Q?WePWoBYn8otiuAHcPBUffUMWBfsLhwlGpfSjUpgBiT4quuuFZbrZC/JBNO6d?=
 =?us-ascii?Q?p4ESrrIOqN8wd0gFI5AgAJ4da4vhH/pUkIKwJZhqq5ITSGmg8ImSM5bUQ1be?=
 =?us-ascii?Q?8tBS2c3Kxpyj/uZzkdqLiBRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c5bcbb-ecb3-4a55-73e0-08d8fe5abdba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 09:01:35.9758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WwwB4SJokwYBHeORRLnm3K4UKZs6Cz+UCYFw1yKtZg0bbO27IiBuHaWpDaSbPvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_020143_398939_3BD17DBB 
X-CRM114-Status: GOOD (  12.49  )
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
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: <stable@vger.kernel.org> # 5.11+
---
 drivers/nvme/host/pci.c |  5 +++++
 drivers/pci/quirks.c    | 10 ++++++++++
 include/linux/pci.h     |  2 ++
 include/linux/pci_ids.h |  1 +
 4 files changed, 18 insertions(+)

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
index 653660e3..0b175ce 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -312,6 +312,16 @@ static void quirk_nopciamd(struct pci_dev *dev)
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
index d8156a5..a82443f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -602,6 +602,7 @@
 #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
 #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
 #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
+#define PCI_DEVICE_ID_AMD_CZN_RP	0x1630
 
 #define PCI_VENDOR_ID_TRIDENT		0x1023
 #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
