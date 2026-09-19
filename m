Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF20BC982DA
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BoTUNB59fFYd//wdGP+XX5GyozvgvzHndErNK1a2I7I=; b=ByVd8r9rRBQ1FZWMT5r+72gCQU
	DlA2D5pFOXzVGx7eWJnM9cIkTUPP8tMAR/3pJVkwaDEfe3RyGRRsX8Eqy8/z4RFE5jMdI/cthecMb
	5DlwMlRwfAgMFxp/VhCke5OiAgSdmHxjX9LRk19qxIbiYbvRbHxp8kddVsPa0lffzREeqoGzkw55V
	O84NbZowDGZXs/+JiVi9+eXBMPaRQ/LFi5H/1OfOh+6XHW1ijaBytzG2F9A2/NGTBD1HHKyH0J1gD
	0IyhB/joAgKGNfdvygbqzRb0ZIxdSWP4Ze8raT3IK1JWR+N0fCOJuC7xUyXQpnKPxGTr0jhI6DQ3O
	KWUxF0Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7uqJ-0000000GIzX-2K3x;
	Sat, 19 Sep 2026 13:10:59 +0000
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7uqG-0000000GIz0-1xOt
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 13:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI+WfinUt0X/iuPPaEdBxVv++n+lhkmj247nUx76LXJdfyjXZWeEf7vF97xuERvoV9kH8dBqvjh3SxFR2t6a4HPUHeCw5VRLRjDUnzR/IRs4RdHCAy8UyJFOrD2nti3uwGdFEFAUr+c3FyxteDZvdCyayiNEhvIOMkv6htMN1CKXNoVM1gQuMg7ELpoadfhDKfkorh2NOwTHjsrc5JpcrW0f7lO71E2cZHb5KoIhuDAVNQoh4CPl1NMIshpqpPTIHhg+JmNZxJmanVQwHJqjtVANkHoNr+5YbpRe7uCCHURtt8NNKL0Is3JnSgzCy6vVOJYrDzrvooH4UpqVjL1Hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoTUNB59fFYd//wdGP+XX5GyozvgvzHndErNK1a2I7I=;
 b=MoXp7tPRoxIMusHsERYZNuFVncGgFbYKFQZP8hc9lue4Cn1Pg2cumQrWF/d3CNLb9fYHR9QzFVrB0CufaVac+HSoyZs++NmFT+3swRK1MJXxAcO4ogJ1hMMLlxR+PYXRIehFskUYnqpvfn6krYqbgFjuXZmhnniAYc67okNeP7XqbupCmPEjtb3iL2W077QuRXZ/Je4E2GT1AJOV5LdWj1ddvu3gg5ZCDUG+CGadf8UKQWQ8xIgKl9i99+N6UvvS78YFM5GRpm37jzCxyaRwuSop2g5XLwjMHbD1C0l0b4buAzYfQ1NZPR4xORQmY03N1e4daKQXM9hLu5fVVslTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoTUNB59fFYd//wdGP+XX5GyozvgvzHndErNK1a2I7I=;
 b=b1RaYGpCAF61s2Gdsd/oSvph5fbeszqv1RmkeQNzM7NQrKLChI1WY+db7N/BfV/YhaKqBqu5h7dU8jiUL6hOUfdmBb3/3tueWO2FaSkl+Y7Xg2dhOaBfkTElT4MPTdl/XZOxmje17Vw2JnFDOaMo3z88z+OfhYoxwC22IkS5gSd+QRMAYeyjOJNVr2sYWJYVivQj3i3dgIws3tEj9QOt1bRpyqSXTRSNEVPA6bKGwcZa998UmVgH3isyulilTcRZflALo/1LMvcu+0ZhArqrtBbNeek2ViXsVegSjPxvPiR9dJNgoRt3z/NzMKKVW/cDxlT2Zb/M9uKs31SWQAdA5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 13:10:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 13:10:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: use assign_bit() where applicable
Date: Sat, 19 Sep 2026 21:08:19 +0800
Message-ID: <20260919130820.3041544-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: da2a3626-88d5-48e4-3388-08df164f6d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 12YKGDCCHjMKu+PRz0P2O3rFHI+OazhnNyeo+hSXkg3+pWyO/jv+qH+PyWlYItO0owCIdYUWZ0VcLy6/mQxKRG8nNpfJD9YwyPZdxmYGVQrQ/9GeBg7wiqWObL7hATg81d1uWiHxP1D40pGT8rXH755aVWslCl/wdvAEY1TMCE36rVnZ62Tx60G8gEniE2kSCSVNWJDYrXHNPpzuKgHXFsY8LE1jt2inREMJa/GaqsQdTYcTIm7rFVKohZikfrnx32+qJsGvcKrASOOFY/ctvz4mG3QHkGEodEdH9h9OSPcN1LSgU27/B08kPmaW2HYkizS8rF8lWJzJ7anoEosYofTE+2A+KVhkNMYvVJeXzNPU3+a0a9KmFj/8jvGjP7vcj7PX++w11/ztE8RGSsJ7FaRGVxm5TDtm/OCQnzMtSaa8IR95w+YYRATmbZE4ceGglbxhwHm/x0eCsF+vlkOSgxxJT1Du4WLSxjDRgOdkdVTxARSVAJPG8zgq/6UDwuejiD/dw0hPQOMM0fl72GOMFvIoZeciaOi5l1BAfcF2mzKAk+cafNldrOghy/DHXSS1rjWU0kz5rmjOIlW/O/p9AX1Dg8NppkeVTAszlNEKwTsuSIr1orwsHZhQN3PKXhnJd/cl9apZANmFzmSeM2AAtn3v74A9J4wuc4JZI4+p5Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kt7yzgRB5iXDYoMvauxtM0lZZKsY7nwsgg58h+PGJR0425KI+UOLKEbleAFn?=
 =?us-ascii?Q?C3j0NUA3ePZabqE8tnRwmJXs8WEh/nMGLPTWcBTtCqQWnjz76NKuA2SKtP+X?=
 =?us-ascii?Q?M8dnNe/1Aml/Z4vpYtyoScgILtgRYHfNCX+yUN3+XsbSyfFN3JPBlqJFGiNB?=
 =?us-ascii?Q?Hpajei56IS8GPFvtywzsAiEWMHCal6IV8I8xTW0DD6ntTd99I1N80kiU4xD8?=
 =?us-ascii?Q?+bLyVF7vAT8juFaBmCk7VfikqOxsTI2BiAX1eqC18tbxeJFuLMqjPZ+55C1B?=
 =?us-ascii?Q?4taOoS/Zt/wo1WmLZOMsz+geKObI1GSqJfMtp6RtlWXD74DuPy2VLXtwtuy0?=
 =?us-ascii?Q?CJWxRM/W0OeUaS84WFwheo9M4tNhAXqEgQMU8/TmgqrEAz4dRjQ7VMn3SMVZ?=
 =?us-ascii?Q?LvqqqRoqdPlFsBTLIWK3hVjM+9ouXmR93ZcOTTwkgDWdwuyQxGHIaRMFlk0e?=
 =?us-ascii?Q?BO5syuCQIfdgAO904V8lWoBvQ3YAFZXZ5qeETTgPQr7XNh9YEtpo7YIVv/rb?=
 =?us-ascii?Q?vKMYTX1XLX+5YI55jgFWaTSlTbU1EdjnOnIrAITCA6QMNbRCyJN8phnTrdTR?=
 =?us-ascii?Q?2Bf3CYScARUowU487WlV6CoMQ1WSoWHBg7Zsy8+pQJ+kKFJzp1esEwDBLQ5B?=
 =?us-ascii?Q?OrBUHONXTNvphRvFI4N3QitU+B5N7bv3twc3K0Uj8hcFFadhjEmJXJ6K2RzU?=
 =?us-ascii?Q?BZxB6KVb/JuOn3v98l/6D3N56yC6me5+77YQ37jag4KXlWFaLZ9GWDBoyn9/?=
 =?us-ascii?Q?qZgmOxqSrX3mqc2F5y10O79w0XPEtL6bQ/IRp21ZDS7cGC1vzQvLG2r3YFCf?=
 =?us-ascii?Q?VMq+RiGtsGU/3Irj1otSDG4Rn+pGS2U9Tes57Am9VfSF1MPFQ2jC6Udq0jpe?=
 =?us-ascii?Q?y1PkOa4bsZPuaxVFpgub64AZ80X1P0NCpdlmfHGji+n2lwNvU0aBs0HICeBS?=
 =?us-ascii?Q?Lv8wRwxkZR0slHfIeiFdgsnB5YraQo8lUzhMOIpjfFP9tKWrCvP7gSDuaNWl?=
 =?us-ascii?Q?Fhdt4BPBidj3DY42tmPnA0SDieIQ5f+YnYVLJoNYJr8sdL4c/DnpPk1oRiz9?=
 =?us-ascii?Q?o0T1BY2xR7q5/8JG5ORQ/FoNlPLFzWYpuxvB83bjFIEwnphonocLCzX/m+C+?=
 =?us-ascii?Q?49rT6YD/yfI9ROrQH5U3mM7nFvkVLtT0y/nwyq1vwJ7PPxw4HPVW8qdtKMqe?=
 =?us-ascii?Q?EhJEKkm9rXdhh+VkBf3ibfOScV63rVzeK7WhiHcHrCMYL/+NOn0ty9mighAq?=
 =?us-ascii?Q?17WjqSMxydcWK+y58GsvpiZQIR5KYSXAUojhhhRrqJJsQCjAXLuO+zcoGKPe?=
 =?us-ascii?Q?2KEXwaV0g8LbYOgHhH8H2ohbGhPfIydyw+v6c9hJB7bKh0grwbshl5Z3pNHK?=
 =?us-ascii?Q?zByIUJN5sd5rRccMR/U2QVTnYZDJ8uH32fmk80wzZ9dI3/IGP97VOQnrDx/2?=
 =?us-ascii?Q?y3MjsXua+VRSjJWGhNH3CKxuHYC9u4b/1UFGFFOj9HmJfMDwi3ekGnnMEhNM?=
 =?us-ascii?Q?O/2i4FPD2jGsIz7kj+SeuNXkw5f4/4rYbtT9flB1UO7Zk7rUNDd5KuCKF45i?=
 =?us-ascii?Q?1IhCeXv8yD7Mqfe/2bhz/B2NYUotgsCiCqhjEoeWkp1hnQQ7ES+6BhBLzvF5?=
 =?us-ascii?Q?EgAbOU5a/uGwEbMMI150TJogWkfMGQqRxw9WDIqvNLKZhmZOvHyCUtR0WvO9?=
 =?us-ascii?Q?Dnf3QLelPpcMnB/mlFMULdo3VYK91FuVGYMY2azCJaE2GNt0frOu7nkV55LF?=
 =?us-ascii?Q?EEPpIxJsqRGywGMVNPj4tIdenOtpK8OrQpL18f7SByf16k3cKwqj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a3626-88d5-48e4-3388-08df164f6d94
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 13:10:50.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7orI9gfbBKV3AMaCBiOiVYagnt6BSDQZEaW3NxJ2DeHy6zbdVwJuMEcxUyxbSaRW9K4e/lEqmftuan5/GhRBoAaR/eUCoRv9e7VwxfwaPonnXKBQZxZ8ZcsXEIYgfHZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_061056_530411_7229E0D4 
X-CRM114-Status: GOOD (  10.51  )
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

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvme/host/multipath.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..98b167df61f4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1167,10 +1167,7 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 	mutex_lock(&head->subsys->lock);
 	head->delayed_removal_secs = sec;
-	if (sec)
-		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
-	else
-		clear_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	assign_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags, sec);
 	mutex_unlock(&head->subsys->lock);
 	/*
 	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
-- 
2.51.0


