Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D414DC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 01:20:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0937D61435
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 01:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0937D61435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SKv9uPDniwvCHlAPegbRSbNFF0X7z61hJ1Fqbn/SPIY=; b=CHHh/IxCIRltbnJJPA6I6PC65
	L8t70YroH92A72x4OLysSPLo6u7MhISQV9VDtljivqxjLmNqF5n5BD7n6UDPpRkKTJKRM1R08tCEB
	Q1uv4Y+lpHxucwXrIezhSeNVN7GTTZIfse8lVxuAHJlCRdtSiIjZnL/a8E8Sg7Lnfh/fOfGZd9suf
	Tr9t+e0zWzxxjJftrLmn7ST9FtCRkG73Op6Hc5jVRv2jDSeoRCJ8Fun8J0T3CDfz8Tz+aYwRJqMrc
	P2WJwrw4g9H+vzWf+OHNXYp6iKzrZNLTMSwWk52gNjSFsJ5BZj4ZebBDkTZkJKO8GXjuyG/D2Bvea
	2Ipnjdsow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZO0P-00FWdA-OQ; Thu, 22 Apr 2021 01:19:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZO08-00FWcB-PF
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 01:19:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=s183yfy7xin+VA89uiIhMS4RtC9SO2mLh2+h/QaVISk=; b=SjMyPVkfCuHNjYDFnab+XzPXeS
 PYR01+BY9HQgT/ewy6M0V9h9t8PJfur7Uo0BdxKVG6mBYFeRGR1jWxirS0UCbvYKADZTmigv/wORm
 78n7vr5TBhb7d61OPrcOiYkSv6mr+IsAq/Li7TcC1Xu8TSgJCYK6QjKXh1SlvtyhHe2miJug2bst8
 /iPcH3l+xT1RpUUI94PoiiZqaUcTuu9F38syQ9m/Lt+6AjlkS/BbThZZPif8zYaqdW4TVeSRG3lri
 CWdYUKIG/N2s83SSlc62so4biCm9Iu3TwfV5+VWzL7wO2NoAQXN6B5KpdpyLwmyE/zIDcdMK6UZXY
 ++2RqHhg==;
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com
 ([40.107.93.51] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZO06-00DIzG-4m
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 01:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/G094+R3aDGN2JRLeiYfV4U+WfkhtKBTIEjAHmR/gqzyv/5NvJw3E6YugJ2Yxn1YQIZEFQzaPMb58g69WAigsT1ySbo5wSpGzoTzYIxaAWZ+C5ggQq4BEXXsTnLo7irx38iIraNoBWKFwvjqdEw56PRkB9D3jOZOi7MtaiuUpxTOQWNgbg/5I80r4Sb8vvLTtHT+k3kzMSwarz0gpmUARa0hJg8e2Wvpy3EhrrM+GR3IGnOHt00f42F96I+x7ucKavfTMYPdf99ykCuN6W7eI2eYtHBL87MyCRdxWqZbmyjlRnnrEfSpN8/VKiuYiwlRzBZTczKLt2Y1p6fsmxnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s183yfy7xin+VA89uiIhMS4RtC9SO2mLh2+h/QaVISk=;
 b=FzMhHiRs5rX9VDrep6OX7wjhxIknFAxkv9W8w/Ohe+lpGKxQc4vmLGL0ADfP3dZZ8l1wL0LdjR6nuTYXyfrUgJKjQ1RlXdf/Kd9ZKdZ/mbzzw+y21Jr3LCMfK0x9rv4i1HPIwN6MtrIFEBL9zx69HQuyXFoB5c15F1bH80Ti5GArwy/tV7kSFI8vBiAfo8FTqWbq9woVLk/0qb6kYpJVLlslJaT2GFOe23WRmC0GrwCCkyprv5mJ1hCEMO6l9y68FdK+UMQyVq242cXvarTwtKCrSUc5+MXeM8VzOwVKH1ROMaXQvavsS+j92Ikn1pg64KHXzOcjNA09Jle2HsN+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s183yfy7xin+VA89uiIhMS4RtC9SO2mLh2+h/QaVISk=;
 b=3++YiFW3YH9Qt2THt7GjuknKspIdVNshTrDa9vzRc71bruioZqfN327hIqWB9LduUcS0GOrYoYBiW1B42PM8zKMtewbdeOnWzwswJLR/RJ+1Kyi+7Vhow+b0bvgcek5HnxSQGa5UmVzYLhrMIXG+Tlr3qU+hdKRQT0kamgiZMoI=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB3713.namprd12.prod.outlook.com (2603:10b6:a03:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 01:19:24 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 01:19:24 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@infradead.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam-sundar.S-k@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Date: Thu, 22 Apr 2021 09:19:05 +0800
Message-Id: <1619054346-4566-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619054346-4566-1-git-send-email-Prike.Liang@amd.com>
References: <1619054346-4566-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:c9::7) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HKAPR03CA0020.apcprd03.prod.outlook.com (2603:1096:203:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4087.16 via Frontend Transport; Thu, 22 Apr 2021 01:19:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9708a2-37c0-4620-b12b-08d9052ca9ee
X-MS-TrafficTypeDiagnostic: BY5PR12MB3713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37133F10A76F9A011115D1C8FB469@BY5PR12MB3713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0rmPvjZ5I8SMj46PpXzfSRWn/VErbdu+FtJinUyyBin6sKCj8okbXqGz2zEgVRk0KKScKjc9t/katAqH28Z4W0e7qK6jxOPvIvoYsc4OK0WfN4hLTejaSRcJ3bQQTvU/9u7t1wQy2HsipXw00Y8IVVRxkBtla3BXwOD4uuQLjmRas8F9h9MjE69ncF/ic1iQDDGNtl22h02F9j8B0cKIyjNo8NJv5aPhNR4Kuw/mF/2y0lK0RFNUXH26tjam3evnv2iCLtGsniTl4dDehsP9ydNQl1VTY2lBE+sn6W4CxxBx5ZXLzV7EvHbaCz3T30CL7AzSAOYf7/+5M8ENqeBjwJi67QUhKn152gclp/HiuJB2st15u6FBI9mXhgOTlXkOo6UeG0Z67hI7wyaALR03AzDzg9I+wB5fDZvjzxzHgS6lcbuaZn6S7qvv+rOOgfmMJnm6PH7Z3iJC1psSOa+kiVCHp4sGKCuh3BG2VQOz0bLeY5tkyzSH8fcq7ELQ1crkJWKG53F44tulGI+Fjzb8dmUFjVFR4K/NV9hf3RuZXLvJF/DRezfFYaB5EAIzKEmWtMSnbhfYwmYAZmbr+qU4ARHfjI9eSQpfOd8LvLAxLcqqpNg2LySMqowdkxAZzSk9cQYvHWnIHJLide9EwuufA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(83380400001)(4326008)(8676002)(478600001)(316002)(66946007)(8936002)(2906002)(36756003)(86362001)(54906003)(38100700002)(16526019)(186003)(2616005)(5660300002)(956004)(38350700002)(26005)(6486002)(52116002)(7696005)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qtCOpPE7hc1hdf/NUbx8tfW6UCnCpTomnUu1IVcmeUrEO107967jrvpqIAR5?=
 =?us-ascii?Q?wL4b8bqmExr/RzWDYoiANLY+Sh6sUI5nVHMh86hxhUcmIa7pQisRpBnOozmG?=
 =?us-ascii?Q?PLeqWgGuXRYfT3V5MILNbDslo/frxzXf4yfz43Op4Vh7D8oC535bA79YNDLt?=
 =?us-ascii?Q?RwuyzpPfOSn0t9F8t3sh+zlPH5dySvqyBb/QlNbwwAZy8W+gce+39dwfYEPO?=
 =?us-ascii?Q?WvJNWLfyy3mszDDFZtDJAcBdjGTcrMmZHImmneneGbPBwRlozI2RpgMsvNjP?=
 =?us-ascii?Q?eHHmfxVAEdtNlEf6UbVe0tZ7jVnPqUL5Dr9te2MOFQyRG4h9vS0I9vq8GkpA?=
 =?us-ascii?Q?tvLptus5yeG8JgsmgS34JKrKmEUNFUO6pl/UctXccaWCalr+nysqDiQmH5P4?=
 =?us-ascii?Q?vQyYlOzcZrp+iqmG0n/vs2wxJeSs46qEmK+Jb45Hb8/g5O/OLiKC6mVQ+w9f?=
 =?us-ascii?Q?PvYuwz3xqfU6x5yb6+MYT0Cne7QSPHFIvoAIb7Iwv7HQLumBy5SWoYqpkbAJ?=
 =?us-ascii?Q?W2BQzMYTAHvY7qi55Vg+R3lUQpFf7A9uFvwW83t1TtKluDelzu3F0cRQAoSo?=
 =?us-ascii?Q?+D3L/Ex+3JfHhGhReOJoKQ/MPhI2pT+byKIvFMk07vF3xyY9e37CAL59nNrd?=
 =?us-ascii?Q?4ndiYEFeacY66HY42lbHEAP74vlAgllZwhvLfWw+Ao0YyTqhLQr6t+2wHCcV?=
 =?us-ascii?Q?1jmh3hkhsilxjXOqPYr1XezD9ZGCRrlcrJ0472puSBCFGFfmcFgQ5DJaa2Kf?=
 =?us-ascii?Q?/DMxAwC7dQLG5D8i9axcqCaXPXKI8kkfQzSVeMBk3gV5chN6b0ZPwgTLeU61?=
 =?us-ascii?Q?jvLWLqYdo0XTsqBAHr19UQEQWeHc1j3VVzCOZrp6GPqAbf0C3/+8BRcPULhA?=
 =?us-ascii?Q?LnUlAysuTg410LZKy3hNoLH3TTRCyEHXdBAvT+OJibwq5K+RI5SAsxuMFL38?=
 =?us-ascii?Q?pg/UQsdhB8zHGBiiWXGJBFUcjZ4/JdXKrQjP7UymeyLArK8lUnPKgHypNwVb?=
 =?us-ascii?Q?t/NysP2Ck+nxiJU8DCP8QYZeNtg/18G1OlzCIgY14IWpiPuSX7XB3SATFWoc?=
 =?us-ascii?Q?1Fwb8yro7eb5BvkNTaS98Uo7L2pNXhsyfTz43tyseU/IkHI182E+ibEFbq2f?=
 =?us-ascii?Q?YH8sV6cyg/MBhyOhOUZ/QNfWIid6YpJj8F2SQPDHBfZOjazMvYmnc9uDmCI7?=
 =?us-ascii?Q?j8yfbLY26z5RSuoSHHaMOEogf595YNegQos/AcwBHY0vsDZBgcA4W00Fr/V7?=
 =?us-ascii?Q?16EXwOck+reEBFxInFZKeMRKX4hmiNDrbbhJh2AT7kzbYd/cXP9s+C4M3axO?=
 =?us-ascii?Q?lKn91CjGz6vrfZqyELDS3S8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9708a2-37c0-4620-b12b-08d9052ca9ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 01:19:23.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdsYwaLSVheKoT6GyehMqLxHVCyDhocXnrF6izxj4zzIqGNql8y1Uh1z+mRdNKXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_181926_209907_FDAB6332 
X-CRM114-Status: GOOD (  17.00  )
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
