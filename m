Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C844C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Sfqx4Y3RMZZCTLL+1Xbp65vF1xIQPYK6sF2Q+n0vtYM=; b=sBemR0W3NffmMR0djb1WFe5TCC
	tN7rwAhRpsKwuXFSJ/I3iBehcMHPOLTSKOFHfH/K/0H9XwGD/2DbUK4GGz6Ex+5/cmx8/OZHW1WIu
	uiKwCw34+5H5pb8uXwDqHNJn72leypaB4KCTEkZ/BjcN5uguMLaLmrkHyMiLzgYwPi9GHuQ3y4BIZ
	TXibp991u0zovVEArWJhuApu1tUt/i8hcgGmGYfNQH5X2tMSvwMiAAxryFo0PoTySUjLiOvW5E4o6
	IIlN45+2NMHoGNdJ+Vh9Z584Wll0aGl01amd7oyST/by92Cz3019xp5dTsmXHqibQKUyQbnpV1vQZ
	3FBEEu6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHWFt-00FQSE-Ib; Tue, 08 Feb 2022 19:34:25 +0000
Received: from mail-mw2nam08olkn20808.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::808]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHWFq-00FQQ7-IG
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 19:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObHiz1IZq9edYPoX1F9XkyEKCGgvNDkggAWyqXhAd0ohCLvJ9mAOMT8aWqA8dMmRHRa5P5t6CELkfjoQjEKdLA2EoC0ZUUiKAx4tvylB080Gu1Or+x/LwE+5vgZI0uL5U5LcXmNoTNcyswMyU1gd3wHK4RamRA7QZQCPtCfPeBRIn7/bD86EVpZQuhv0krWO4RLrJnvSapF3sH38U/EUhFUDCC4K297NGi1XJM1TeEKZtyUv4fFiY0DLPdP5KA/7oKz7y7JSjqLiBLzw2JPt3qaTTyJoCNnMaLwdv1SIAMjCpX9rlS5lQlI0c8lJKX7qz9eQFzdOG0KSAs/CdkxpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfqx4Y3RMZZCTLL+1Xbp65vF1xIQPYK6sF2Q+n0vtYM=;
 b=K6JKR2IpWMWtT/qNMjznKVWPbfWFk1DKNmNY5orkd33nbWcYIT9a34nqsL+iaHuoRULDy+3NJPxqqNeItrS50yzkzWjGqRcShruKE0z08JVBHUfeV18HkbBiO2z4efbB7JHV9h0sC7epWBsYsIYhoqft0AQA7s0ximv2+oHEKWbwXRdr+nlNhbjw+rPgB4ro3WnTdC8aVgcV1PbPnQiSKBNuTbqcB/gD3VvLJaEvtz7R1fZCc5rDRKbyqYoAI76262nOWCmQGQVWTaJo7FjeSUjIQ7lThqWjEI8TWOF+R/2eH9zT+3k9eJVgLEMUzkoRg2R/Ox1tarCOK6wDXUfT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfqx4Y3RMZZCTLL+1Xbp65vF1xIQPYK6sF2Q+n0vtYM=;
 b=l0ecuZFhMttUS6ekGLe3/ivNswBxt8b9vUdqmiQ05iiywWCIMleU1+R4tUw0ceKj5181rjWunlEbinkYPgtH99mpos4FbldQzhvLvjsp1Hq2xH+QQAPaiVoxhh/fRtuL5GjgN0vlIJh1K4wxRA1kZ8L6yT2doxJPfyDsw1o8pT28zO+vbQAwCy6RAHMAyLHyyn4JkgmrnVLC9uZHwEfu62N9AQoFy4PJTjIHcUhqI37kUoVGpbvSur0PmIa2pBwAXmLSahJpCfBP8JwTIJj4wVJunGnr1LvsrNPjwYULd5zan/ZgqrzciBXTLVpPFV4PBa3Cc04eEZE/oUjbjUFF2g==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by DM6PR13MB2380.namprd13.prod.outlook.com (2603:10b6:5:cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 19:34:18 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4975.010; Tue, 8 Feb 2022
 19:34:18 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCHv3 0/2] nvme: Add TP8010 support
Date: Tue,  8 Feb 2022 14:33:44 -0500
Message-ID: <BL0PR13MB4291E7B303670E7E89365D0F9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Xg3qwXNIxn5sS2QRd74SXdCmbq0ijWSD]
X-ClientProxiedBy: DB6PR07CA0195.eurprd07.prod.outlook.com
 (2603:10a6:6:42::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220208193346.22580-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a72c69-ad2a-41a1-5730-08d9eb39ff32
X-MS-TrafficTypeDiagnostic: DM6PR13MB2380:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0L7k+Q37E/A7/wnO1wpP40+IlxfvOHFAg9N4ktKWWI5Ekhmj+DgtUnwRrizqsiUslqeoBmbtzdONVOarsNpttlO+QHtMmw74Pc6JQKGwklGUGxYV5PkRtgg8Ka08CTBitR1aKASQHZ5t7JvOlwjHjSzcqi8o/ptVJNTadzF4BstrDiv1apoEtqoG6FJom5MnxrS81L7pLkHJGIT7RkEMB1QYu5xVje2GVmqZnd9bz672fzf22YfYviPOtEvyM+WLJirYpWrkHW7tlfIbsxCiVL9JVyKZdS8YXl+4E4TfJjDOgobTleBberh9oLAT5MbDq9vs8KT1CZKXR7yNMDZAxTYWD8ec95Ur9sB7SzXlP/+hmk2Oyna8aSV5ngjpuhvW0TYp6ZlPFoW8z4v5Z/M2iMndJppKZN+/2p1GOsSKnbD/0bADi+dXJFG2hhXqJwFBg1S1D/VAVfpfvNYFSL4rP3J1n6Jn1BGilaBXdyJDH45VYSaFfQ4cfnyTV8jXblDeAiD9LSFoAMMjCtInM8cqPT53sviLxvqca+4rCtjY5YusPZsu/6WYSGXOYXyLn4LC0tL8g5gjCvpZx77QAC3WQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lm9ABbgD2nJORIulwCs92eDBuexyGuD3/lYCFOzhNL6+VUj41wYpeah4bHkz?=
 =?us-ascii?Q?PYO6RtH72/16RPOK03GuvrwyQ7LKzR1aSLfLNCDk8feBGCjNhlRfU5TpXAW+?=
 =?us-ascii?Q?wiv0bhEgd5XxeUHTU8YK9PihZrwTUYnZ00v+/3CB9B5N2/WQm7CCMwVFvX4f?=
 =?us-ascii?Q?HriJREFBLziPowWrKAPaMaSr+PnjbrHSaXFekHa5Ker9DKaMhRI8tGjdIH/0?=
 =?us-ascii?Q?YDzb+NYTJdlk5CDqVLcTm86OdP3Srdr05O7UNFc6iOH8O+U5SkANd3ekDYtq?=
 =?us-ascii?Q?XicmnHYakVZImaDRBEdeqbXJ33b5+gDewE539u/jUtaXz218oj7ET/UCSAnR?=
 =?us-ascii?Q?nlIsHjPaz5XCcCwSfQmL3TdNMFCa50iSWjReLuxMyeX6nRMJJIkTWq38c06O?=
 =?us-ascii?Q?g4tHfCH2V7/Gmk7UlIpRn9mGy8kWJFX6tHPcQOVqeMOAGW55a3y46fIERT6w?=
 =?us-ascii?Q?t3PdcbiGOwokZE34C5We52omNQFh/AEygHGEuuHyi0dxQfTO7WW8VXsTyfUQ?=
 =?us-ascii?Q?vLyvn0yWa3E6syUWEdflheoZiSlIUCYZxnBDdR7Xo/s8P93keqjMA0LJYyKD?=
 =?us-ascii?Q?mGGK7JtX2yhEwjz7QhTS9oo+Jqh/mgW3mCWBi8/wUbkw6fLD5Kc4RImtXqci?=
 =?us-ascii?Q?eIcglewY9dr82CdJHV6oo+EpbXoT1G059Yjr9ymmzt9cqWAFafrXE+zlMXe+?=
 =?us-ascii?Q?7gZS54a0IJ49G27ce8vrReeoNz1D7V6EtAriSLA3HHBmnntiuhooygxU4n2D?=
 =?us-ascii?Q?bq/zwX1KcC6aMc1ZqNAQGSxWKXO4z5Hc5VQEgeRLHcuZfylKRbnhcskYXipB?=
 =?us-ascii?Q?j+RGS9yOJz9kRcXVEqta1dlNsDn985RJEe+V+THOcL/wkaJrjKQkqEe0LPAi?=
 =?us-ascii?Q?B8yuX3Zup2vgri4zJQUvEAYVr5pLXriwahRla5ghET8i2qiqq2pZX6Kubcln?=
 =?us-ascii?Q?3ra7q16By6EuketLNp8TJA=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a72c69-ad2a-41a1-5730-08d9eb39ff32
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 19:34:18.5850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2380
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_113422_697399_797C1C0D 
X-CRM114-Status: UNSURE (   8.68  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Belanger <martin.belanger@dell.com>

TP8010 defines the Central Discovery Controller (CDC). To tell a CDC
apart from a DDC (Direct Discovery Controller), the response to the
Identify command now carries a Discovery Controller Type (dctype)
attribute.

TP8010 also defines a new Discovery Information Management (DIM) PDU
which is used to perform explicit registration with CDCs and DDCs. This
new PDU carries extra information such as the Entity Name (ENAME), the
Entity Version (EVER), the Symbolic Name, etc.

After review from the Linux-nvme community, it was decided that the DIM
PDU would be sent from a user-space application. Since the DIM PDU must
be sent every time connectivity is established with a DC, it was
decided that a new uevent was needed to tell user-space application
when the driver establishes connectivity with a DC.

Martin Belanger (2):
  nvme: send uevent on connection up
  nvme: Expose cntrltype and dctype through sysfs

 drivers/nvme/host/core.c | 48 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     | 10 ++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.34.1


