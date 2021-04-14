Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB41C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:21:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3E461139
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3E461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uUE9+r6t+1pjhlpC5kWn1HxneA/ZQdJWE5BseSznKBg=; b=h9o5hRUKM2BdjQBK/4Wt1CwYz+
	9CC7JJtRCkdYPLK/tpZ/1Cq4FHbliGNZC1U2Zux6WdbXs67bShLNfMUIc8iQys7Tmoqov2cnJMRcS
	D7UiRzV9SLjHyvj5OXc/fzvOC8SxSOdxrjc+/BWcGpLU5NtcEczai4RsYQ97q7rtjG8Hu/aixhbnp
	euqrHfDWYyjtdq4E40E9KIn5ZlXFdeQ+FHWGMcri+9J1h3ugu3hykJ3chFOpg3XUfUro7SYzCPwWL
	W+a7cqpky2DLFFqxaVCeJKoKfa1Bc9UDMa4+zgYcpbTDBHI8ySYJNpMwT3oEFIjXWsu1K0mWqWkUM
	GZDBs/mg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWYtk-00Bf7F-CV; Wed, 14 Apr 2021 06:21:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYtb-00Bf5h-1e
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 06:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=q0+GenC9OVs7q+KYOPFveEXUaSzADoNXDa3fm0o2HaI=; b=2nCn+ilhd35N39tsaF/g4EA9c6
 eFonRnI/sC5wPxhSzGwn4mQ6G+6B00kRwL2oTF4J6ybvayDH+qGlXOsr67wfPfchsEcSCqwV+7HMg
 hePOWmOMVXfX7ccL4zHFFdJ7JHNpDYzZ8/G2ZfQTTNNVB9YRx/NRMJmWzZkf67SVei1fhdDy89gbb
 3IzuDik3xakcF0a4gwQ9l18j/hcGonaEdPOL70Kbat0zB5EwdG2IHcCXeP7lU98rWluWJ+4k3wVaV
 CDrCJM0G69mjq6xddFVfo8pWVB0wiJLWaxddSZigbgnL4UvEMPqLUbubKFbDNqwwuqcKsZ6OzxcPe
 QjObXZJg==;
Received: from mail-dm6nam08on2048.outbound.protection.outlook.com
 ([40.107.102.48] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWYtY-007WeE-4W
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 06:21:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLZ52URw+UQsy95gNu7rDQuBeB0GNuFzNT6+kbi68qNF/2i3rhNVCnYypyv47i+g1RB7nUlTNoCN1/Ql4b9La461th7l36aFOdMHX0tJSKC3k2wpNxwcK43O9T4W5AkNjUh9kPF8/rRE9hwlVk04brnNWv6WfSpbGQJIBPjNV8cikG/qQtOBRXsNuYb22pMH8BOm5EtVSQDYx/Gxx2QqjUOLMQX7/8DiGpx+JcuI6/Iu/oQ4yb5z5XW5etiFfrYemMTi6uKgAgbQEuyO2DPR1kM+7pgdnC5w4UI7/RPYNVcDwZf4tLqiZsviX0TWQFKx6T5DyKxZxRXI3sLutdtTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+GenC9OVs7q+KYOPFveEXUaSzADoNXDa3fm0o2HaI=;
 b=mERrpkHqfTFzJTrH0+C2hk7Gz0wXVO/t0c4feMHufhgqQCMQbaMT/KOA/Twd2/kQiW9CEtkwq6PQs39B+LeWqPW61B+8fOfcn1iLDiQMG2Hc3abLufD0edfLjBbyjoARAjA6YKxsdr6cx1mwq8PZ8bOm+pt6r3Ze5+/84NF3bgRDdOU3TNBB/daq8c0Ogb5QMBEoTVG0ugi8DaImCzj8jziYFO91rGDb66RDUzaDGui+mD4LEOKHZY8Up6QO+WkfTQBYhf9MVl1URjnalAY+VNWAT27cfmetRFIM2gys1SDEABszf1bo9Uxfw6yvuatCTDQn7BJOi205NYp0KBjPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0+GenC9OVs7q+KYOPFveEXUaSzADoNXDa3fm0o2HaI=;
 b=zQJHL2TjLU81s5m5xbxoc92LbH9vjwMsKAgIk8FgpasNYJsYtNrKOu/8R24ftjIXac2us6mx5p9LBS1h4CT7JEBNuXGdZaq5xBXRgZ/eH6GEDQ8NimgdvYMNPqYEOssuWooFDXO5MiC75P8Np8zBf1WEvb5bdJLYFtwym+j41cA=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4801.namprd12.prod.outlook.com (2603:10b6:a03:1b1::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 06:20:57 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 06:20:57 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, hch@infradead.org, gregkh@linuxfoundation.org
Cc: Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
 Prike Liang <Prike.Liang@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "# 5 . 11+" <stable@vger.kernel.org>
Subject: [PATCH 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Date: Wed, 14 Apr 2021 14:19:59 +0800
Message-Id: <1618381200-14856-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:c9::8) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HKAPR03CA0021.apcprd03.prod.outlook.com (2603:1096:203:c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 06:20:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 893c5fbe-dd12-4e96-9a83-08d8ff0d76d7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4801:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4801513B154087DDD6AF31E3FB4E9@BY5PR12MB4801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c89RedqZIzXY4mALzhsZUuLKbgIXM0beiWDAyIt1RVA4xPSjTMyCf0ocGnKKHN4At6AGPclqYGz6g8K5/+XdFUYEy76DPU/i1o2P7wwLrehyOjGtPU3L1JlntWQwWCiYi5fygE4Mn4IVdKURsrLMvHILIZmKVeVtrutQnZ9J+qtKr8iUQcTJHG4ErUcr4w1bEsrxLZaWSN5L87rAxJvVjKq89HiZqbN2PoWahfAckJ6z9TXbyXlsYMqMHEbijbsJgFjaSQJKL9pt1cp+lZKdoZvxckbyX9Gd1zvx7rsS7F1rqorHsFEhKdFDLHdzyoLKutpOLAg4IejWKdRqgW7XkI+opt24UxXyEE5heFn2vFa2N4mekMIF4SfoN4xfxNJmOdfJe4H0yJdBztmRgdTazClD+jX5HNd2ghXzYQypoDkObZtHtDTytTPMLutFvEbwsJiq8R0P55PkIWrVoh12Tag/62dn65nu/ALawJwfOzgIUUuHQaYxlBHBfIK8JsFwcFVukhXp+Pb+ddNqocF8hedHhyLLhrSNb6YblkpMUnmSsWRAuw0u65y0nRRARduneFEHGkJxY6oOv1Va40isYhIn4cYt9KbsrcOBZaHvFxNuOc0OX2XbNlN6ne5ONmzG6Utu+S+KOkDoWCSr2GWNbRCYNQLd/U1nXUy/cRsIswk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(7696005)(16526019)(6486002)(52116002)(316002)(2616005)(478600001)(36756003)(26005)(4326008)(54906003)(5660300002)(38350700002)(186003)(83380400001)(38100700002)(8936002)(66946007)(86362001)(66556008)(2906002)(66476007)(956004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YMbiuB8Tgxzok3Nqvkb/DjyiKJz20vPtDMlXc+k9RgSNqpyyTw+myz/HQe52?=
 =?us-ascii?Q?2W2RgS5pngaHJPfNTDlKTzQEn0UXIYEnxztZN3xO/yCnZTFw3GL3dlB2CYOu?=
 =?us-ascii?Q?3mHHEGV3mvC1HcdWtAl7RT+IR98pC08KR5VtT0ASbpsDk+qi6tZbrwkgbQ17?=
 =?us-ascii?Q?vs2sITGeG6a92vLNlSkRI5Xu9LX0h3zRsKEBELjjJRdx1q7oW9AF/vtT4tSs?=
 =?us-ascii?Q?SnmLOrEFvwzJZhaxtG4TuKwsQzqS1hs9d5ajW/dmenC17Ywe5UvlFe5ZJonF?=
 =?us-ascii?Q?/Qe2H5pcbx/v0Jchsx5XpPl+il3XPzWz1YQavo84/0UES8nV0whM8sEyP4Ks?=
 =?us-ascii?Q?D2M1qTkxuJws3hyQJvJKC+4eaBOaGNkREQOltpq6MxzY6/PtheQaK1f9FRv2?=
 =?us-ascii?Q?c1qRdNOTflpPgsnzIangvWfr3KnpVmn2lct9CVsajUQuoYM42ihFGXMqCXoi?=
 =?us-ascii?Q?4e0u0E7ts+8StAG7J2iBTiPN1XJbneoX6CRdi/v47pD43aCOwyGWcmh687hl?=
 =?us-ascii?Q?PfQ+/px9MCfpoFetj+cw4SgV3Ny/DN6FgWc2eSPHWw1JVyxeZSMrLHF/oQ0h?=
 =?us-ascii?Q?85v2PFueVosBU/FJoMwxtypMfyoqm1xDgDqq7NhvOsDzADgbL4Aetm2C5357?=
 =?us-ascii?Q?O8vlFUEb+4ggVsMIn5ZNEH+rQrvxHGthgIXlARqu7yaVVPBU7QIg9AY8Nc+V?=
 =?us-ascii?Q?P2JRiGw24cn4pt7RkrQNHD8CDqIZXAohj6yX9OpBARcOVJgywuTwumdl1Rsb?=
 =?us-ascii?Q?2BznBSgpcfKzWAVSUjgeWP/Rb83twl9WYXX7jspc19mIRunTGQnM6DAWHkKy?=
 =?us-ascii?Q?p8fy5twEjSBxf2fGD9i4KKiTA3Gsor8qG6r2CLbKl+NYOkuHOcONWzRmfpzY?=
 =?us-ascii?Q?sRBnjrzewKuvr4imKxVAUR4ow7V1ZvvT7QA9AdWv/WC+OWDZisBvmTplhZMM?=
 =?us-ascii?Q?Lwt2NiW4iOXI9a7+rJ8LS7mW+r5RhC746UG11GOpCTmUrYf9rHy2QJu/sfxR?=
 =?us-ascii?Q?lcByBmKrbxSDzRFAgC9dkMt06fVmx3319iP3Gz3a8LUjz7aWHBjo4XXQw2Y+?=
 =?us-ascii?Q?6xhzUkENvVuIjqveQTQJF/2E0DMqEfIC/iFppjDJokp3Kdo6w2FtF5Zhsgf3?=
 =?us-ascii?Q?RE0oetddfuNHk18hyIcH3XBaBw8JPXlVk0GGvlsLUFFK1gJPWndRRQZtGNbd?=
 =?us-ascii?Q?ZrlSu2U2K/hk8WwXOC7OS2Mvl308MWqU+JBYF+zTX+i/g1xZ4pY527RpF4s/?=
 =?us-ascii?Q?WQA9eI6Km/Z1+o2oKeqRaUmETTL/63GE1HvfCn+IrTTqs6T51goGylK7eBFi?=
 =?us-ascii?Q?ooot+0abSTtTOVfa69PsD4EQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893c5fbe-dd12-4e96-9a83-08d8ff0d76d7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 06:20:56.8762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRPv7hPoAxF9T3lsud3YPckq1UMmBa64EBSgvwBAw2G5+FrVPJmjFT0tU99Y07Ev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4801
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_232100_190992_71518D78 
X-CRM114-Status: GOOD (  10.94  )
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

In this preparation patch add a PCIe quirk for the AMD.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[ck: split patches for nvme and pcie]
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: <stable@vger.kernel.org> # 5.11+
---
 drivers/pci/quirks.c | 10 ++++++++++
 include/linux/pci.h  |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3..f95c8b2 100644
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
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1630, quirk_amd_nvme_fixup);
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
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
