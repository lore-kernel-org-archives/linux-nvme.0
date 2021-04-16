Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C8C43470
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:13:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEAF61184
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEAF61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HS/AyPXE3mAu6CgIFQawzj3GQ+ic6HNZqDAOpV+NQHs=; b=exNN9EUXdo1dRyd0pQgwyVDWM
	s41j8chNTRAyt354NPedTQMgfqvSi/Upk9QXB5A4w8fJb8sekwLUmn3yx7JFyPm44vTgK2A3XPQj0
	fHVbyMY6c0NFf3ILEt5LX4T+76ZLGjnXxWl4felzEuYwdSg7Sgi3MLJxmMKrkjZK9EcaL2e+FvUK0
	1i9H51+O4KCYAFum82Zu8MTvVYu0r+NxFWabrF1oq5pYi7W74mqSNQ4Wy8Rn2iofc/ddXZr9H//uX
	3HIhYOvyZC0zRf7cn34WnhGaWBMunn/w0gJMr+b291CZPzuSAwSjhW5aAcCIA3aKMX2FlOYCmHGrS
	/SM9FFcEw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXIf1-0019bX-9l; Fri, 16 Apr 2021 07:13:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIOE-0017An-Ed
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 06:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MihCFZSu8xPf/bSw7sAaHxX6PHkJxaDWSBA6Gbo5Okg=; b=HRZVTncnev3GznNLzygwuQI25p
 oey4jUQk0qOSGQJKMNl+f0QEsKh2g3wCbKYVB4XoFi4suX6yHJ66IFFoAvSvnEYuyP/HESU1qspy0
 RD5xgr7sqhvuoOD5GvhXnmUX+nG2oSjPTn+1fzXyK4fMvwDJAqBlpSjIS2fL4CcsKubbPN7vFx6TU
 WwsjXBRdXKwzhHooZS0f3chw0KrrxofkmAMO3RHXcXNP8eUMIkjIFbs0qeE2y6LkL/69ZYV8Yvguq
 c4X8g2ewtB+G+6Tu4oXF6WVfHNy1Qodwim6eTUBVF0nZROvHpwiQ8LakbGaZorbnIG4Kv0y4Do/WU
 YPaH0+yw==;
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com
 ([40.107.223.44] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIOB-0098FD-OV
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 06:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM9Q0+8PDVGtwkDGrV7ZPc5sx145D4p4TbQYzL6BmZhqGBk1BzAO54oNSBZCXnN53rXteqsTkj+eptLIFM2SUu03+5waLUz/AH1eJYJVxiiyuld4KrtsgArqkUpnjCt/Ya0tdDD473NDLni08Ly2R6NpahPOzcrto9iRpBiGZgqnzPKOzpYmrfZ6exzYWuhFI6MtUmdrmAd5VshobA8OHCCy6H7qlZQeYFPSQExufBcqima/oL0CLriWNbof6eCj8/r2g1OJ6/NBWY7za/mXBKtFqzxnvPdRF87XuaDpWuGfgwPtc3GJatOy4FI3GCvHSbKTHHOF2vmkVGbrh3MM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MihCFZSu8xPf/bSw7sAaHxX6PHkJxaDWSBA6Gbo5Okg=;
 b=EelXjLcN4Ad+0DXIDPp9LtTZCjKQTJ/twIKoVnTptZspHPWemPkFH5KbuWkh/KLO0iTF8j3ShKFoe/JgxIms5N130aJKKkmjyUEUMIk6PC2r3THWuFXL3kQO255MiUAsAPATcPhF2u0DFm5JTNu84nI7LndmUHhnPTiAAlVjakN6PtKHnwu32EfqEOzrtPoXkfW2JrgOQFnSR7cQZpKO1noNBCMbC4/72+PUWgUfGsEo7IOEJpRfQp6gOn+QFyx69OLH560hth8QEGHh02Frn88YSHLBPzRnVxY9GTF07ZtBqKH0TVoWAIEx7nFgF2/fqNJbW6UommDaRMZJtXP+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MihCFZSu8xPf/bSw7sAaHxX6PHkJxaDWSBA6Gbo5Okg=;
 b=b/lPtxySO3LUjHrVCDVCH5iDD8B053Vgha/FnCGoSCMA5Tg51yc07MJsS/DJ5NuWdnGnq5pSLaALxQXh8xoahf5WKL9qMAQDcpUSuBlnBkfqBzJuKTGgH8ZVKAGmtepVJUmkirJFXDoAs3XcMpxccE2ZIX8Pw+zMj3JPMeyN/nU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 06:55:37 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 06:55:37 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@infradead.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, Alexander.Deucher@amd.com,
 Shyam-sundar.S-k@amd.com, Prike Liang <Prike.Liang@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Date: Fri, 16 Apr 2021 14:54:34 +0800
Message-Id: <1618556075-24589-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618556075-24589-1-git-send-email-Prike.Liang@amd.com>
References: <1618556075-24589-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:203:c8::17) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HKAPR03CA0012.apcprd03.prod.outlook.com (2603:1096:203:c8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.4065.7 via Frontend Transport; Fri, 16 Apr 2021 06:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be372c57-a911-475f-5bb1-08d900a4a3b8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB314197AEFD81E50AA6DFD954FB4C9@BYAPR12MB3141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PJ2BZemtyOQPdGlWkJ/SdX0WIcN1YmRF7Risj45+uokQfEcMLLKrmldnv2sGL40cD2dSll+f4Vjc8bYq+x5anP3zUXeTHWVXyZTQ5RP0X4hcfQeIDFVc+cKzlqgWzDxAxnNCY83A736ujhNgTfKgoXEGhXFadOh1CgO7SjFm2LrAE1Q2T82xwDOwG6jki1WzhAeTIwbAb8NlSLtNgFfZhP/KWQX7yD+N8GJbfcrixDDO6wAW2F9ielQ5cUKO4PiIo4yknZbOR0E9ZRRAcZs5pxhPBI8be3uyxclgINz7d4wb8zeSwSe53bRFZJfksNJZABoKE/NEwElUjrAlJ6jK7SoPrpc1Rh9QyUKhatEwkDAbnQuK7cvnu2Vw4W7d74EtBXJ+Gbkrgmfrv0Hbkmne5fKKDWEcMjo4RNP7N2RlaFyAJcqgjTPH3V8b70YtfQ9J55YNWYPxaD7Run/ZhGgFfQVbvd6tB6tYFl/wLbX0GWElSHz3AyMWWZzeb5SSqX6JH9wPGClk33xFpAokBAzM63OTeOb34XJdZC9wY2SVnCUHo+pqK03MYnZTmWnWc9Y15S8mDcfYSoAyX9nyV6hjFTqLvyQbZXw8XDmFf5RaaLuU+FKKycVHBQPJMru/8UAdFHRJtOPKqfiAmflwix5nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(16526019)(8676002)(186003)(54906003)(83380400001)(2906002)(86362001)(38100700002)(66556008)(4326008)(26005)(5660300002)(8936002)(956004)(36756003)(52116002)(478600001)(316002)(2616005)(6486002)(38350700002)(66476007)(66946007)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9vbIcFSoNWjbY2c0hIBFB+XshLQKPuyZBjrQHLQgY03FR8yJqWSfr4ctAe55?=
 =?us-ascii?Q?IcwQclx0Ia09omAnNOlHJUfea9vTn88o9l9ius7bLEB4YSGQX9EA34PtLQgp?=
 =?us-ascii?Q?jJPDjjSqdi2krtJ9cv5PkTLqL2UIsHfRHPxUufNYuP2JTHYSQtxQzUWFg2Un?=
 =?us-ascii?Q?5IVQfcSpnzE+wtdACTbAew9eDbWIzUiYqdvq9jpuGKdIh6qpT4OFLRpsAYGu?=
 =?us-ascii?Q?AKg9F9CLzCcQu72K0HRS8PASsSir2lYrl3BmnG/RzyDVqJOuw/mGtqMn8d9n?=
 =?us-ascii?Q?icwLTs5O724BLlwHuHr+ddcP+Bbb1fve/xIu2Rpn7DOUqebtdxbEEdXXNlXn?=
 =?us-ascii?Q?ffYnwZ2X7b7y63H5dcq/H7KXtPkYFLzr8m+kXqZQJhhQutYnCrPd4usl6XFG?=
 =?us-ascii?Q?jPF/1V3+qkHdLr277gEQZ6Nqy73H82UqHtWaJUAOBfCjbqNsqvOUTGZe9T9M?=
 =?us-ascii?Q?fswud1ktDpPamX6wQY5hOy+nh8dHZLRc+mGmMXKxqP6peJoXzReYUhfHGzCx?=
 =?us-ascii?Q?KqPCYMiDS35eYOA148fQsMvWDVN3KKH7/T4/pMCkIPDtO8tAfwoB7E/TIaHs?=
 =?us-ascii?Q?qt717+Q/l+rrrWITxNdDiyIkKlfgCNwNvQDEk8V7vXFXIKJoW5UyUILjU8xh?=
 =?us-ascii?Q?aulatOhwxeHUwAx1S8d6JjFQnb/6ZyEORnY/XggjNqmbSt38knPjO85GKt5C?=
 =?us-ascii?Q?RsWqFCjFQ2GlyBaw2vrORWbTb8Eku3qK4bSVAdZ+hV0sM3bpTTNYZ8bOGzsO?=
 =?us-ascii?Q?PsXoRguw2r/X4CHrvJsj4cuXU1Gdl1y2PzydOXwUKdvOyoVco3iVTujjJbmc?=
 =?us-ascii?Q?hDYpaq+rjAHDoJ+yQf5V7XRlMtvrUtP/YQZEgsNJFBexK4I/aOcgCSxccDx/?=
 =?us-ascii?Q?va+fBykvuOYYax1YiUty1yM73ai6tnrH7IZEYXlQfssLrYfuZusCv1h7a6Su?=
 =?us-ascii?Q?UC3A5AR73OTMylsDEJAeNA3D4tpouJCJiE+50E+FoANl+XvCBG9xp2wL2le1?=
 =?us-ascii?Q?mtiXjhaXmDjKezzdxV6HLbJsxlwCpm8Z/rny4JEEZHO9kf1d9TxlbDq2hqSr?=
 =?us-ascii?Q?QKemFJjIlch+AWtqIVOvnU6I+v8MePkGPtzxJrY/2iMYWRuv55LDayOXwPxM?=
 =?us-ascii?Q?S89bE3YcrclTRdKq4HGktke7sOOSWPDTaDiVyJxKl8VeSm7IlVLnI/ZWxAgK?=
 =?us-ascii?Q?udB94poxG4XDku1CxeffH9aCSktoLy7+BgL6b0M51qjsjGGhs/d4U5DW/v42?=
 =?us-ascii?Q?dqn6qnZNGkljqfR5PM6UyjU2Y6rwmZ7J09k3b5cqaBeEwc2rpTFHLap0bqDz?=
 =?us-ascii?Q?wJo0XFAz9+f3RYZ+3xik0f8a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be372c57-a911-475f-5bb1-08d900a4a3b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 06:55:37.2949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RcT0bLxDhcIdjyMAz7TiFSUCTel+fHqwLwI9g2U2A61sI1s+kaWJouC1OjVUo4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_235539_821564_99515CC3 
X-CRM114-Status: GOOD (  16.35  )
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

Cc: <stable@vger.kernel.org> # 5.11+
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
[ck: split patches for nvme and pcie]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
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
