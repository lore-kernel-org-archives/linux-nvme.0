Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85331C44501
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=; b=qWyfMv7vJnwpHqMHdOaCOw23OH
	CtiniPigIW7Ak2ep1ADGCLsgLEpF9TytQi35056frLVC6tk5YVYWUVjEr+sbiZNFuYPCmxnZk/7+m
	aYEz0W5bS9YbUfnq+L5ms32MBKkMrPiuVRcSLfnyudftAxoa6y4OC+mIdwlKkdToh9UH/amyfV6Cq
	fzmLonlIjqfrj9aYlJ4exuEjybHk/e1upbOyJIeJrd/uBH66soIjE0I022Vcw3LCRwv1TjM4N0mRL
	ZlNP2+i7nVhKJ1GmuyrBG9P4k4Z7Ma6vf1G91T8ihxJqXp4TQpIxffe50NBCskMJq93p03V1yQRxf
	oOA40oyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiEOc-00000005MlP-3uhQ;
	Fri, 10 Jul 2026 16:48:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiEOb-00000005Miy-3bg6
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 Jul 2026 16:48:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=; b=cTbTvuW6Oau6L7oQdZ4c9FAona
	TpO5RzZXoAH5lM5JeZCJpAcDRN6Yu2fC9T6MWxfDESjl7ht3A9Yi7epznwX8EFs8HTg+TtQCU5Ssw
	0XT+UXQtGS2rStzp5wFQXYXKgVGyAaryUNW6TLVkZfoN1TDuriS7iZYl3pt5L4/oK3JPkBhsFoB2C
	/sy8fHHdUwBTDUAHYCMTB031xkI/Yy+kai44HHRKiaT6CqJsOyl8dyajr79tDKNG+nQ9N78IoPgbo
	SIC8DPqSPrZ0XkQ+hcEa+o01Olyp09CqSTAhJgDma1rnsfhtIGRczhdfVeoPUyOmwxR9RLwXgfTZR
	v5SJaHaw==;
Received: from mail-northeuropeazon11010008.outbound.protection.outlook.com ([52.101.84.8] helo=DB3PR0202CU003.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wiEOV-0000000AAvT-0WQh
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 16:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1ZHy7w1VdaRYrtPI5NlCjBkRIbWOuI2iuDZbHh54cMJq/d8aUUkthHVKpLPT6EPQxE692k2E/0HuHr/Nd8yjNWfRJr0jLOB5P248ujq6T5l9ce39ynm0xbTc/5Kgf4flfC7j4nW1l534C4UhQlw6MW4QnsZH+aQg4MJjAG8wHOxC7gjfBgistYElUSAw1UiUOH+RI8FmwdxAnnGGPiGiBvHND/+pOz5eedOrobT/7tz+l0gyWQQRXWDUDTPcQUdopVJG65161djwHq78U3MPetfXCJM0tRS3CBjh/CFDW4gdk8o7Sx9er9LlZTU7aLw3UK6O4vmnKKVKFRWBHG/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=T1CMw90+XDTbd0JY//gt/UrFQWt9EdPcMRLekz8hZ7H6hFdoWKfAdNWXnlZmFwD2GHmgTIz5Vewu0qNiGTYH5f0L44IaEnTmAAFgBsQ045yWaUwmh42fSjjm6YxlKrUZK0JDr1PQQwmRCrFJCzevX+4brovd6XOLChQ0xV8hsDrTNxzbvZu36R4InBOhMnVAzOElEo41TBjLtQAqS445Mi9KCuFMmYwBogABEDUV8m3ZOkOUh6WWpsnZeWS5ypyffYV0l647YIR+9WQ8mW0Uc8jaRkmIIDK3/z5RSMm6fYMFJt731KCHXBKRkB6VL6/Wfdyr6w+Zg/eVO89UTya3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=KGQVE3Kjfzbrg3wOF+zwnLOgn3ZDmSVJU4bDKRzyQCvAPivqKhZB6vpjGeBupiD+j+WGUFuH3My/EwGYeaBc32TDWX1FBCjn44OTm//dpHtYBHbA0klJrr+41ThdYDnKZqmNk/qMVtr5CidMDZiV8KHNQFVKwX6J45GTjQRKiFX+W8zZKa1iGielC/MIKqPzGHKv6+op9x3FEXg5o7A1s0+ASyrShqRwh2iE2S7WBqQUOyQoA2yNEtTWndQqjIUPyLqaC7n8ufwzVw6MjB+YJCuOJ7en5B73hFaU+/bWFp0LsvoAiy5yY910a47dvnYdRFvQEUZ5F6LyGMMMJOYQmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8578.eurprd04.prod.outlook.com (2603:10a6:20b:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 16:48:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:03 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:44 -0400
Subject: [PATCH v6 02/10] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-2-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702066; l=1765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AWFd01V2qiIGFrrfkjJThL7/BfhkdZY8qigjsjdbG8M=;
 b=XiM5uzII9HfBpeB3/GtWPelg9SYjzFdzhiBjg+Lq+uLemkCrmppRmrUGLoLrmRaxD1cVhTHMe
 YfFT56jR8i7A8yTy/GC4OogQpzpX7CyFMtqL/PyhZfyJRqBmo+92ZPI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: fec12ac8-b766-4269-0828-08dedea30229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: t7uRsj5BIppCZetM8DIrE3N6kVtK43KzJga2KIRGcObRSjXBrPHbnWkrQfXAJIUoCcZa5UjQcguAVvNiYy599lS58h0h5x01Jug+Ig4H/f01VlBr6GIqCc9QhepBgp84hX+ZqfcSxPT+eDwzCHHdbyyXTzWmScYiZ+5RLDWHXXkMdF/EunuRlSiqJTWNVQSo9hddOXkrv5A4bMzytmoZ+xypJ1wrA7b4wvtW/Z2fBStI9k4JBolM6GP2yH7sp9Ujd2R/EDBYOnlvyRol9xrSiNcU35C4YgBq8zPvm4IGAYXq5lKJnWScb/FdJZtodcSnD3JUUqn1bDVBfXZITfHJtIUde4OnlTQdUU3PoytCqDYnDrNescKHzsWMkFZQyL5MT6/aFSxm4S+cPDWefrvAT1Vo1MYM749T+a6RH1woM3RxJzmrL9jydnGaeHKhu4vHfPeVZH33acb19G+74KZTcrzlD/0B44GK8rk/+Bkn/swDk+E+a5B8Pbjmy3jjqoriTc+DGadYgKFCZBSjJzacu2QUdn9aVVmMH52JjmR/iv6pI23Vw8pE2u1KTEpKeLSfs2Gf8PRjpC60g0XI3FpEU3CfBCvhZUgcqTRaSxHQlrBw7HtsVMbCKBAFwHrT7kIebYM7wvvny+BhZ+Y0+XGj0JpF9Od/e2c/fMHjbAb1XjFlcSuFTv2VJD495dAwDQrhV175kgua8bTaeX93XDmlkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxvbFZ1T2EwbTNYY2JLc3NwaEhhL3V4UnBDN2NETkdhMXZlYU11SkdRd2s4?=
 =?utf-8?B?ZTVITVBMRnBrZ3BmSGdVYy91Ly8wbUJleGdrMzM3Z2MwTnhaYjhqaEcxS1Yy?=
 =?utf-8?B?YVM3THFQd1N0NzVkRCtBRnVQSVhqd3M2ZEsvaHhPWnhYQ1NSL05LbkJ3SWxr?=
 =?utf-8?B?bXc0d2dtWWdIU0RrR2hCZkxJMHQzeC9EdnRjM1lDYVdZNUtwS2tEaUZsYVVM?=
 =?utf-8?B?WWM5RkNUWE1uampVSHI3Mnd1bXk0dm1xRXMxUDQwbHQ1SDYxcy8vZ0M5SkFo?=
 =?utf-8?B?OUNuUkVlQzdqMGpSSWlpU3Vmak5HSVJjUGJXM0lFR1R1eWdMcWcwMWtyQ3Iy?=
 =?utf-8?B?elhnMEZQOWloZ3dGdjBUaFRsU1FPYVRXMFpqcCtGZ1g4dzZSUGl6aWpmRG12?=
 =?utf-8?B?VG9uSXpnYU1aamIrYXJZbVk3TkpqU1QxdnhFUVUyVXJSbkZheDJtTXcvcXJa?=
 =?utf-8?B?ZndUaGxrYk5aU3FLUzIrZ1ZSc0lqbjErUWc3YTViYXJRSjBHaDhQZlk0Sm1J?=
 =?utf-8?B?MFcxNkw4OENBdGU1SmR3TDVMWVhFTTNpeFFqWWxma1ZQL0JKTm1EMlVOUDdm?=
 =?utf-8?B?NU9lMmFrNlYvZTZPK1pQSnAvcnF4dm5SYnVCbjA0UEtNZDNxNkt4NnlrVExL?=
 =?utf-8?B?UXRKYnl3aG5ER2Y1ZFpRdFYxVGF5eEJDTnRPUEhiQVVsa25EdHErdVIzQ0Jn?=
 =?utf-8?B?TUZ2Q2RDYXhhZ1k5TE5CT21TdFY0VWRLV0xwMDBlVmthVEJKdHcveUV5NGsz?=
 =?utf-8?B?VWhjMVBSZG9pTTdQN0JWdFUxYkU1M1VUZmpsZkVybndlZzNzK0RMbXp4aFdx?=
 =?utf-8?B?cC9sWU5DT05sZDRDUUNBdUd4NXhmR2xub1ZnQmMvWlNjZmJGdDRCY1FKaHRR?=
 =?utf-8?B?a2ZFUi96YmJxa0tNcHMzbThCZkZGYVZTb3RZbTdCRGl2MjVGWEdVK0RXM0t6?=
 =?utf-8?B?S2VHZ1JreThhZkp1UGo2ak9EdERNTG14Mm5aU2Vkb1JBWFNTSVVFdHM3OEtF?=
 =?utf-8?B?S1pldjg0L2crYzhweHQ3cUJTWlprOEdVY2NsYnRZa0svUG5KQWd4R3NiZjFB?=
 =?utf-8?B?K2tNUjd3UHlER2JDbmZDSnVYckx4ZkcwRU1mbUZ2dGttNGcyNDN3ZkZZVUxo?=
 =?utf-8?B?VSs2Rm5pNnlHRy9oNFJEU2RlUXdWYncwNmRCbGswNWpMV0JVNW9jRkViYjhz?=
 =?utf-8?B?NGFYdXJVbUo0d3JhZnphTFdESmtrZlQ2M1p5WTJLWUhmOERvVm9JblN0TXl3?=
 =?utf-8?B?K0xyd3BiR1FTMW5NdVByU1NuWEViWEFQbVowQ1ZqbEYzTHVJems3SktVbFVq?=
 =?utf-8?B?eVFTQVZyejNEWFc4RXNLczNDNEd0V1ZyOUlsclVYc2JTTHNPWFNsSzhBLzFT?=
 =?utf-8?B?R0lDcFlLUTZzWWZOMU5aZWJJRDFac2dDa3N3S1RhSjE0UlNLZ1ZyODVOUFdo?=
 =?utf-8?B?TnlNQWtOMVNNM2V3bzBVSmN4VTBobDBaWEJreU9sT1JIUUxqd3dhSGRMSEVF?=
 =?utf-8?B?T1lpNk1EUUJQUG1MZ2hUTzBRQmtSSXY2a0p1bDk3Slg2clRIRUhyd0F5MWhW?=
 =?utf-8?B?Y1Q2bDFKU293RWRxWERyeWJacm00M3RyNGhQVFhURWZTdXQxOWdVRmU1cWxx?=
 =?utf-8?B?MFVKZmtBYi9oeE9DbjhkQ1BwYUdDeGN4LzcycEY2eHFleXE2ZHMxQ3FGS01O?=
 =?utf-8?B?aVZoOUZMbkRLd1NwZWF6S0lLeE5ZSXBRWFdxT1UvVUNjTXpxVnhrOHhMdVVu?=
 =?utf-8?B?ZFFxWXpoSE1QR1o4OTBrVDBuY2Z0QUZyVzIrUGRYYVRrdjVVOXk3RFdETDUv?=
 =?utf-8?B?U1g3eXh3NzNBdHRwYUZka08wMXZXV21Jd3YrUHNPemJkNG9tRzhNYmcyZlVx?=
 =?utf-8?B?QVVUVjBZbjdKc0RLblpVN3o5NlhrTWQzR3VkNWVTRnJpa2cwWFlMdTRIbnZv?=
 =?utf-8?B?VmZoWndGbWhvNXlKZ25JR0t2dEM5dk9XM0Jkak0wczlrYjAvVGg0Q3B2NlIx?=
 =?utf-8?B?cHowWTQrY1g2NkU5N0NsSE4wSVJ2S1kwTTM4anZDYUJheDRPSHZjVGV1WG5B?=
 =?utf-8?B?RlFRR0w1TUJ1LzA0cHptMk16bmhMYjRJVDlFbXhGbXV0RnRtN3NSNGp0QXBs?=
 =?utf-8?B?ZGEzYWZCMC81eUZialo5VHNLOWJYMThFUHBhRWp3cjBzQS8zNldRcDQrekN3?=
 =?utf-8?B?MlpySXo0WHlJT3lVdWpxZmlGVCtmYUlzeERSdGJCVVpnMTJMNGloRU1UZy9G?=
 =?utf-8?B?YXAxenV3L21YM2F4eWt2ZEZFb1FWNWtHVy9LVWczTVM1U3ZBckE0RStsYVpE?=
 =?utf-8?B?S3hCYWUvc3BsTkUvMjNDSVpTZ2ljSTRseWpZOEZNMXA1SDR5Wms5SHlQTDVl?=
 =?utf-8?Q?c2pGIJB2g6dKCOeTXkiQwyOBen0FmPaTRnwHa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec12ac8-b766-4269-0828-08dedea30229
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:03.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0Qwl1e8HOLCDN8tsXM2uKAxtMCC1ExYCnGcldUpOXAVHChmpfokFTGyvC7AS7+MEzTXvfPsoJJDFvYhuM87wWRlVj3LOA1G2GK/JGEHXonkvyVUtGC0udl0V6JrLWMT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8578
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_174807_211411_994C8B87 
X-CRM114-Status: GOOD (  13.77  )
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

From: Frank Li <Frank.Li@nxp.com>

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1fec1b52e3d47..53469c8c8b82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -527,7 +527,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf71953..db5f45bf048c3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.43.0


