Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C4C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 12:49:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC07561935
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 12:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC07561935
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+CR3gWYW1lh4HH2CCuQd10moPSTX8JrMZnR2zz7h+YE=; b=kJUPQ8BPBXaKFHiAiW3W7M5MS0
	CK1p8koalBbkFFRHABqkFPGvaGmBFqVqUzt2Da9qNt92iS/CFPUqHz46+Hk+2gpjfvtj9KvnLX1tw
	OGHw2VjNJ1i5Gn7dzwINqCeeUtHM71ciOZxcuRbWg0sLWLBmhLjZuzm71DnJ6zrSK0r9OnhLL2/oT
	9+T/c1I8aDpZl59EG9U+/rqjpQi36BeDyY4zyh6YgJMoTK7ozuPL1lB7SOchC8usob0LEVJrbmxUc
	jRRJTcgAUtU6aQys6n4VV2v7A9IH7khHfplMrEGP23Tvt9FToAJ1fx0SEzD+xocihk3zOqOUbXHTh
	TCRoOvLA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRaHL-006aQ7-Hz; Wed, 31 Mar 2021 12:48:59 +0000
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com
 ([40.107.92.78] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRaHH-006aPa-Ub
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 12:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3UYZuuasUS5/H39fQcaw0vkbCTYgKAsP6OtZ2ijLiLjnom59Ujq0zv1Ef2GiQHaFNvF2EPta/XvWPh5SWdgRdjo+S20vVU70hrmCloq8qU+/KSUy6shiEOV9iIBmHwM8JuAUZgLHYQ9nKFpeaWzNh73HD0CwdlN7pR5ewJFMOJdW9B4moco5/QhZn1TqF3VotXS90m74bd3BwsZhDHNiIgAfO6Z1TRDo6Ss584srmHk1U2vfvmHYBLVbA0bXRFM1UgD/Q/giKQ4YFkCpyHH0f0MKP82/s0GkcnmicobMLmuuDjke4Pf4KZUgrdmgf8Zz5zChoolvKApDfTAAwHTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip4JQcalV647ZTzQXUvFFsHXjyKejZWBmIUv9q5o7CU=;
 b=Mp/G8uzNTZC2fYNw8E/f1njql0pQyuVHclofPwUp4rbyRDsFFOpKtSZHuzoQXykMLDZzoYfZS8htAMEAtSCcABRDM+Phd1uRSsf3Jg81yqHgkA022awgVWhdw6WOUPRdqeq9YroM7FIRt4wLOykvw5Qu8HueFud6zc8xraH1wjbdhkf8GK61ftL6s8/mDjmwJ1srcgdZOsp67h0+8BzFiSXf25I/QGQd/PIJuMPZ4Hds5DT4S0mswWHxTLogobT3DTefTsIyIIlWDd5Pk9lGTStU6dx2pec37Z7eyhxXP0yp7W9t9TyJaLfAJTZcwxBJFPgeyQ21rRMJ5v0gFywYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip4JQcalV647ZTzQXUvFFsHXjyKejZWBmIUv9q5o7CU=;
 b=QCbirR20JY3Y6fVh3fpth6EHbM/KsJiZ1oSnv3A3GTy8CGm3gpAxsOF4lppWGbVYp+hXJHvghvUKJjK+D7CpYh4i084qo5yZUezZbPFNO2r6Kqo28UgrIvmriuUaxK2+1TkK6qEymj8utm4bHsSm/E+/ysGq+uzj0+dHmjW0E7Q=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2599.namprd12.prod.outlook.com (2603:10b6:a03:6b::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Wed, 31 Mar
 2021 12:48:52 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 12:48:46 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Date: Wed, 31 Mar 2021 20:48:05 +0800
Message-Id: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HK2PR02CA0194.apcprd02.prod.outlook.com (2603:1096:201:21::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 12:48:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13ff7d64-ae74-4180-7744-08d8f44352a6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2599:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2599457337A44D38E923F9EBFB7C9@BYAPR12MB2599.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFTVTPZ2Wt6QexZBhft5b1UrCwxmK0+gHqY6Sh4I/emZphbOJvnZBjT9LAdDNL4W+RwSRmZTpVX5yGq3L3LIQvgfc5/V4dlicX4a0p4c5LZbM2WJZcuC2RjXLlbt4XNm0n4gMPAG3ytnBPD5yVfSmGGNq+m0eR5bhSulTSJnBEFhsH/sYRZuBliWi+emGjsRoTDD4xiP2jW0GewA/TJobEkar6CnQC1qXcsSeu1MWfYxfKSgOA2dRVMXAna7rci85Zf/pkVmZsRGmapyzYrgf1KhtwagS+tfB50UB1EQeD0RtR3iwsYkp+D9E1IwE4d77ZgFV26Y+bYDdvcnU9zp3y1w11m4IF2z9dI0Mv1F/EHVNh847eZP17wOgmClv0Z1/amY4ubR++WKZ8fNdqzt1bsQai3fgeY2lZ4+sKFTGlVXQ7R4t2LxqC2SAvU6wYfQGQQoST46kq4xA2w2VGpdhdb0l2SOiP3R0aetqkduY6p5eoiDl3P/rPwrf3MZV/HnZ9EXcDnSjtrFTdD74EKF/5ztmDzC36/5rFvBbDnLUO8jdMwhDe8crbMA7IDyinxmOZwe5wfuYNRC0Q0YFmwVFjGBcvBiTf/qHLUrWXMSBWXP7M+unWpOzaNrm0lHF2cSgaEhCZoq5XkL1UaaPRzACHF7WDPfGkZ1yUn9IXUXES4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(186003)(66556008)(6666004)(26005)(66476007)(15650500001)(16526019)(8676002)(52116002)(66946007)(7696005)(6486002)(2616005)(36756003)(956004)(316002)(83380400001)(2906002)(5660300002)(4326008)(8936002)(478600001)(38100700001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+a/EUv1KiJHENNWbTFvthc2JZ09ESpNzLlb+6Y6YbwCQytyXvdAdUF1NmFeD?=
 =?us-ascii?Q?aQ6kKj0YJEtlt6rR5iXXC0Ft3jeHbIi3xuUtcD23D2td/McNF5FGoqOXYUIA?=
 =?us-ascii?Q?E/USrBRgg/eXpin6HyFydloC51SyxExydq7E1/xpK+4rR/G6EXSH/mzJ8Mjq?=
 =?us-ascii?Q?cuB/s4SQa/sQVDtqhtzznnMb74oqfilIMKoan9mHxQTx/WJI1diYV9R+VGhZ?=
 =?us-ascii?Q?5buUnHLzB989/lc1SXZsUGE0RC50DqBVQ81EYXgTiDl0cVUa6ZqSXemObsnz?=
 =?us-ascii?Q?1iMWMwDyjyopIjWUaMkJ+kg1vhyGz7Zv6kjkuLvp6KU3ctl9GIW8tCAz4Zxx?=
 =?us-ascii?Q?ctLvzJ0pbHY8As8CAJbZ3XmymuseQUyRxeqbpz8sJvIUCkpL3OTo+54jwfYm?=
 =?us-ascii?Q?RovSOwFAO7oxYQM3oAMeAztsbXbRpN5bCAEU0Kd2gJPbH0lfUsGLnV4cRslH?=
 =?us-ascii?Q?q3mtGPLSNZVnd6L3UDR6AvGoMLTfzSUcEnMtcJ4ZQVflN5FJuycMFYjOZ8Dl?=
 =?us-ascii?Q?O0wJWAuys4mmI0AsLiVFYomFmKgKcfbZeWoOoUYiQXldWsOkpYYdu21Op7/N?=
 =?us-ascii?Q?x8nnv1FEGN67IHTXgk65WRP/nCBY2bCOB+fiA36p0xLA9j9K5EwqVImkpo3u?=
 =?us-ascii?Q?GCtdm4ZU3XxJYHhkNeV84TAlTPqT9mR6/vNGwdGhRB/ZLCRKODExnNy1R1ms?=
 =?us-ascii?Q?IVtyZrY4gbhNv1QPu10PTLLzD9wLffc8JfjNiR5ahlTfHtQRDTpUggFOgnHI?=
 =?us-ascii?Q?ScjenjZ5T/iCJknu5m8iFzddtTztLg72Qd0zuc3h6eRsQgLbmP25URvYQQjN?=
 =?us-ascii?Q?dyItzgS4i5ePvrdZFpdyLuTCkB9cdN9MC2sqllKuApbBgSeRvoqVOHqD4epQ?=
 =?us-ascii?Q?bqKRSTflpOQdkmTsr63+m1Fwtf2+rWgmHe91bfLOtaCsx4lXMpuQcPxtuYKZ?=
 =?us-ascii?Q?17OA49ZTeMHI5BVeDDkO8fKU3Ri10V44ZYKAmG46SmRE/jxCk5N5MJSkXeSr?=
 =?us-ascii?Q?5US8MQJlC3ldtR72jsJLCeB+P4kkeT43Klq1D70rl2T5+pBlR7z6DkBTGt/U?=
 =?us-ascii?Q?ZPOOmlBGVJRhJEG8jTgZr0sM2PoUtv0j39oeWFqngLn9gGwfiADvxUMN6iQN?=
 =?us-ascii?Q?L3D2nPyiAFeB5f6+kUlb7ubokO1JOJiwBZCEuZaNadKt42xCc3ha83bgnhti?=
 =?us-ascii?Q?cvxXs2HW3BxvGWIV4Sxd6nRFuiYhIU5u9bmtif7K7IwoQlffbcjTU/eorcq9?=
 =?us-ascii?Q?rfxuPu6zw/+hoy/sQH+T6kqRGJ3OnrZh8FeGaoC9dsLLBF+ZIuJFIWCo3FTt?=
 =?us-ascii?Q?gfuu3qQzWv0jugV3inZQWZbK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff7d64-ae74-4180-7744-08d8f44352a6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 12:48:46.1451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkpOOgzqt3dcXSjcBvIJHI8KPSlhF8BUCw1RSi0WvufoghZZ2SX9djQaUAW7qGGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2599
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_134856_474522_0350083B 
X-CRM114-Status: GOOD (  15.35  )
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
power seting to resume from RTD3 for s2idle.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
Changes in v2:
 Fix the patch format and check chip root complex DID instead of PCIe RP
  to avoid the storage device plugged in internal PCIe RP by USB adaptor.
---
 drivers/nvme/host/pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6bad4d4..1952da1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -42,6 +42,9 @@
 #define NVME_MAX_KB_SZ	4096
 #define NVME_MAX_SEGS	127
 
+#define AMD_PCIE_ID_CZN 0x1630
+#define AMD_PCIE_ID_RN AMD_PCIE_ID_CZN
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -70,6 +73,12 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
+static const struct pci_device_id pcie_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_RN) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_PCIE_ID_CZN) },
+	{ }
+};
+
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int n;
@@ -2832,6 +2841,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
 	struct acpi_device *adev;
 	struct pci_dev *root;
+	struct pci_dev *rdev;
 	acpi_handle handle;
 	acpi_status status;
 	u8 val;
@@ -2845,6 +2855,15 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	if (!root)
 		return false;
 
+	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (rdev && pci_match_id(pcie_ids, rdev)) {
+	/* Detect NVME device which pluged in the Renoir PCIE root port
+	 * then force use quick suspend/resume path for handling the NVME
+	 * timeout during s2idle resume.
+	 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	adev = ACPI_COMPANION(&root->dev);
 	if (!adev)
 		return false;
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
