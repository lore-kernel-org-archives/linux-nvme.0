Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1C3CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/ReP1rgqWrU4/sMzuwdfH3iluXexvaN58iUOEqpsAA=; b=haoyY2xmahuq9rOpzlTVAoCKyd
	z9Mq360hIaC1W1d0TusUExrw/eo1h3zukuRYD1HpqxIlVvBqkKQqNCLha71Xivjhv5F5cu7knQhtn
	kN/K+gRRh/NcSbZbrolwEnPeK/N8oh+9ftV4U9OYLvh2D6AbfMR35IKB9Vmdq1+7kOr8ImosVIO86
	kIIgKooRAkuigiDSFvvnolFELv5u7+exl/Sjy89AN6RGiJXvApeK0071EXXGfCXhwHTDK3IIVQZPg
	tT+MLStls3vBwUjHWv9gx39xEh/N/th8HR63hpNa/B1GfeNi4W/YIX4C8SyGPRxnQXawFJx/gNktb
	8ABwieKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoz6-00000005uvK-0ybR;
	Wed, 20 May 2026 22:01:48 +0000
Received: from mail-norwayeastazon11013024.outbound.protection.outlook.com ([40.107.159.24] helo=OSPPR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPoyy-00000005uOV-1FFm;
	Wed, 20 May 2026 22:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+JC3JPI//wbgrkfwxIqMCyERt86+Rw75D8IEgyt6smb/kVor6PxoIf0dur9Fb34u8H6vcmIYfcP81hWn/9Twi/eYaj/f3UvVnHTHOHhQSNkOtClqrbXplMPNUQzn3V6pQBFkleilm4cmkWbdjU+eaCc6kr0SRthTfNz01tuodwMtVKZw9nwETSPkPAAYgS4aVjGDmbYa6uK3psZw0QXuetohdpPAoN62/fu/6d5gdVEZa13FuV/jhp0LSSQ6w4MZlPV7wGo2D784CIsv7s2hu9n5W8IvGpcC/ZVgK6oWvVdUTivQERO/Pcnd2HTFMRUFGMgno7syp+nZ2typ0IFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/ReP1rgqWrU4/sMzuwdfH3iluXexvaN58iUOEqpsAA=;
 b=RdAOGwYOVB5yVQlrIzcLp7Syr+57uo1wFiwHoU8bFOZTb/hxuFzNOg4m4PuTOLlC3XQoUdZdZtkUT7lZPGO6coHSwbd0jqqZIrhAud6H4BY9PP6AJQidSKlmrSNBr4mOCK9goczGkUt2YbUOIwkpFsQDD/iXjbhXkEY/XFnXEJurap/DoFbJNyLxRRspzoLRiPQMYm0GdEtb0U3SZVdHX9DfsUMbHcjGPwz7a9o1yDxvzBf3+VediHJYHVQj/UyypmAZGoolcdH0D+DWnviI8AbMEyHQf6RqWCXsh1Zxz5b7AIB1BjfxTexO8oGgHCxdse3IRVG/PYXO3cO5Xs8dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/ReP1rgqWrU4/sMzuwdfH3iluXexvaN58iUOEqpsAA=;
 b=pVj8z0i8Jb6Q9JWZDF5bMAvYBcqlEV+w5rXsGUOXslYoNnyJybQlFARoXfwkGrOZaFMkPyIMljjslCL5Uxw/SRZLns1Ry+i9lWp3IPuM54CrC2Zl93y7XxmuDxKJcnzKcea8cSTHigpgSoi2t3MArBcS6HzO/Dx0eakyUGux6i4VbBeuSMnGHsDTvKtjRzg/DIHc4ywBzT4BzHUg/7UGogMhZFBxU1PAH8VDyK1o3XO9ZzSfjD9A0UCOnzon9aGWK1rFvbAG/gcaL/uvPtxcCdj76fokP2YJA/dcA08ygQucQWKLoU5v42sth02bn/aqH2+b9m8DtWvjPEL56WMG6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:30 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:50 -0400
Subject: [PATCH v6 9/9] crypto: atmel: Use dmaengine_prep_config_sg() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-9-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=1773;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=erGKLaAZMNXPQALsbiq4uU1FrELcrAtTPXSGZhnyQ3o=;
 b=/Xyzy8RzK6dkLmE/eKI0VzHHc7C1CD2oir42Z7tjFQUJypShx9pOrLKm1h+fKtnpElmhuvfkS
 lIjR+9AroGyAZVQpayYbkHFyoPrRJ8UhgrEft5zXtUNpBXeuQXviM3p
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: a57588e0-419f-41f2-b018-08deb6bb58f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: QwNEh13UvSusglFN+StZkU308E+KM8Yd/vRORw1T3mH5yu4Rp2sMxfcTvbwCWrroVROSCU/qgxVRr+lzfT2GE/GHhW8DGALYOg+D5tCWwxbFl6bTGhlYzp1GIlwN0/y/WrrQxx6QuqL2JVIbSLj+I/mir9+uEp6UTfc13pn+7Q5wDmAgFk0lLeorvQI8xtH8jliSmVg2bU6t6MAT60NvgUBc2XQnZ2jQExCn20PVmywa+f23bb3J50OfgvEPvsFK1qqYbMNCoNZjv7M+SS54coaa5Y4QRDvPazyaOY+YrXat9l/U5NQ4XrMj26/KIjmxj9l14RdXMKtfu3Z3Zlnjw+M9fVC0pzLHduB5swm+WRCU7/sqfXcZXPhFHTLLIQWqJsVsLxeTko3YodiK2sGs7OWX0jPNhqGP8oowvlIk8gblZlF0qEIGLZ3029/9oNaCZpVUPLmoIdIAi9aQX3Z/DGYUOqDIT3sB4AzJS0QpyQV0O87r3TfHYqn5keM+PiQi5moHHzdW36qgSPriy8/XDg1EXFU+hZHs6m7eNNxPHfwNhm7bhhr+hw3tRl3xmYh/ZvN8dFTR/hdM9sNbSozl8qlv9e1uQEyYJoWY6h2EZfapNY4P9KyoMCF07DbLGdN3k54tVepUHU/xFIB9zRXj5SJoh0J7A93iGgU3Mc5sAFKeckxMwuVBD553SzpjmwwqYIENq4sY7Bxx3Qkbg3DxYrvaeunJ2bNvqACJZUj7t1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW00SEM4QnBuSFFXWG81cklTS3h2WEY2T2QreWQ3Z1hkd1JhM0t1N3o3WmdF?=
 =?utf-8?B?SDhlcVkvNXNmVTRjVDVhNEdRNXpicDNMNzVRVDMwa1RpaVJNSkhTYm40Z3Vo?=
 =?utf-8?B?aWV4M3VLV0FhUWpTNWVmeStIcTdvTjJOQVo4TmJJQmdGK3U5QlBpaVBkTkRl?=
 =?utf-8?B?bUI2enJYdzhwc0ZBY24xZDMzaFhGK213WDRNUjkwOXozTzVxUkdPeWFGdC9R?=
 =?utf-8?B?U0NZbDhvM2hsd1RieXFlTTl0KzNmbTFXdmVqS2c0RWQyb1oxZXhPdGpuN1Fo?=
 =?utf-8?B?WlhMTGNQc2crcVFHYjRCd0VXSk5uRElEcFhYZFR1L1JqeUVrb0N1dk9HYVNT?=
 =?utf-8?B?bG9odE9VZkpqWWhzYjg0cGwvTVNxUi9CbERwdVVlMXRoQ0JaeGc2NWpRSkM3?=
 =?utf-8?B?bWJ5cUtBWG9CQmV0ZHQveFhvUWZDZDU4WUFSR3drOG05UXJDdE1WZFRRR2lV?=
 =?utf-8?B?K1ZWUTdWaE9IbU1wNk1la1RVUmpCeWNrYkd4U2hRbjRpVm5xVGd2bEwrOWc4?=
 =?utf-8?B?ZDQrQmNWWGVqTU8yOElnU0ZOZDc3MXYwQ3RiWVVPQU8rUmlERzQvQlVwZ2tW?=
 =?utf-8?B?bXZoNEZEYkZPV0pUVGZCYVFpd1pvbXhTRVZ4dVZZRTNrWERXRlRCQkRPdytW?=
 =?utf-8?B?SjJzc0VKSkFmYThsZ0lFRjVkZi95am1oSzFSV2NoZ3pjSUdQcUVpc0lPUUlr?=
 =?utf-8?B?dHI5L3psN1R6TnYzNlpzdWFISjJncnBBS0xDOWhINlBINVN4dU50N2poWldm?=
 =?utf-8?B?cWlrSXFzUndNZFNZcyt3Z2VMR2s5K3hrZGQrOEhqTmNzVStkMFF4ZDJ1ZG1O?=
 =?utf-8?B?UklUbXliL0ZEdXFKR3JEVnRHS055ZmpQemtXdWtZclRTZVdnTnVleVMyUVBv?=
 =?utf-8?B?TWdlY3ZFNlBkcmY5RWQ0UmpzRVZzM1JWNXJSZnh2czNZbDNsWjIxMmhZOUFP?=
 =?utf-8?B?MHcyajVHNjJzRWJjNWJPZ1dyZFp0cko1c1A0RW8wdnVnOGEzWG9vTTdsQmtJ?=
 =?utf-8?B?MzJ3WVEwN1RBUzZZNlZ4dytEaFFNWXFLTWF3Z1M5Z21iRmFyOHNWOEZMb3d4?=
 =?utf-8?B?cmRLRkowc3RVMHY0b3VyWDVHNGZJNWpJSkN0eDMraVRTQUJ1TSs3QlJvQ0tN?=
 =?utf-8?B?RkIvd241TjVrNGdZdlFaM1I4bEkzSGhRN2dzOGdvZy9KSjlzbitIM1BKTUJw?=
 =?utf-8?B?QW5FOVYzM2RxVnJMZGtodUxlRWxxNXBFMGVib1JIWmNucFRWWHF3K0I0dmRx?=
 =?utf-8?B?Z25qWmN4ek9JSXliZzhQNTF5YVc0S2RFZHNoSUtSQytkR3QycjlZTS96SllD?=
 =?utf-8?B?dGdWZjFrYTVwNUc4bVZ2SjBYKzdIVDhZaUZFM2orL0xBYi9BOGMwMDNuUjhj?=
 =?utf-8?B?YVpXTzdnbGEyTGN1c2NEYzNnbWNIZExCYjcrcjhzWUlSMlNkUDZVeDhLNEUy?=
 =?utf-8?B?S2o4bDBHdEY2WTV5TUVsWlZpd09YNjlTU3V5d2U5YlV3Z0NMamZCYm5OVjFY?=
 =?utf-8?B?aUw1SVhGcXpNbVpvRmNpVlJ5a0dXU0xaNnpvRnEzaGFuaWdubFB2RjZjb1ZU?=
 =?utf-8?B?dzAzblFVOXRsMi8rTWM1ODlLTjdNWS9DckVBdnBTUmZ5OC9NQ3NiUy9mQytz?=
 =?utf-8?B?YmNlVXcxODIrLzNWNlJHd3lKWlBONCtUdDRaR005M0sxL3lacGIzWWhsaHZk?=
 =?utf-8?B?enNBVzZqM1V5RXUxa0VVcDJmZGRZK0c0S1JLTXBCWlpKd2FXWDE5K05lSVRW?=
 =?utf-8?B?ZC8wbHZxL2xST3BXanhUSkhEMWVLZ1V6VTlkWlBQa0ZQM0ZZQ25aZ1gxcnFR?=
 =?utf-8?B?Rk5ZaEFtL1BOVmYvbzRCVEVIcEduUmZWUnBSamZIbE5WbWtwYlkyUWRYSCtv?=
 =?utf-8?B?bEdPSjEyZGwvazBVY2hHVXhQTCtUUUwvK0V2ZVQybDN3QlN1T2JoeE0yYmF6?=
 =?utf-8?B?aGNXTUVaa245QWJLWjJkK1JCZmxhQWlEU3lVbDJ0NDhGVHVjdndCa3FzUlJJ?=
 =?utf-8?B?UStVNGxNYVBLUUtET3BEbXptY1lTWlBuMVF6ZUsrTml1NklRTG9xdUJ1RExa?=
 =?utf-8?B?REE0dk9aZDFwRWJ4N2JuR3B2MFRZdjdob0YxaDlMYVp1cEkra0hpSHBkaFlZ?=
 =?utf-8?B?WTJWK3JGbzNQU0ZKMFhMbHY0aUplQ21YOWk3M0ExbGNVek9aN3VSUUYwR3lK?=
 =?utf-8?B?dWdTY0JxdEhhR1ZPUmJ1cFpaT1NoOUZEbEpBTnJWYTVPcEpMaEQ5bFZxUFRC?=
 =?utf-8?B?aHFUVkNZNUtrOGV3OVA0NzI2M3B3OGNFRzJZNWx5RHluWlRqd2w2eXVkZENP?=
 =?utf-8?B?ZGhWTnhvNGV3NU8rSTR2bXdFSEgzdUxkRmdNenAwWExGanBxMS83bjdPbEUw?=
 =?utf-8?Q?FFx/TtkqEldRjCfo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57588e0-419f-41f2-b018-08deb6bb58f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:30.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct7NZG1BSRnaeO/xjkO86vp1QujXuZ/9agZ1ujghbdJOla0JvMvz0RshljmrO3usyaYOMAitq3XtLjsE6KMkzyss2zcZu3Kv4i373Oscjq+z4PivvGkyNokjTiMe7W+x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_150141_505898_2E0704B8 
X-CRM114-Status: GOOD (  12.31  )
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

Using new API dmaengine_prep_config_sg() to simple code.

dmaengine_prep_config_sg() does not distinguish between configuration
failures and descriptor preparation failures, as both are reported through
a NULL return value. Converting both cases to -ENOMEM is therefore
acceptable and consistent with the helper's abstraction.

In practice, most users only care whether the operation succeeds or fails,
and do not depend on the exact errno value returned from this path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- add commit message about error propagation (sashaki AI)
---
 drivers/crypto/atmel-aes.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index b393689400b4c..d890b5a277b9c 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 	struct dma_slave_config config;
 	dma_async_tx_callback callback;
 	struct atmel_aes_dma *dma;
-	int err;
 
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = addr_width;
@@ -820,12 +819,9 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
 		return -EINVAL;
 	}
 
-	err = dmaengine_slave_config(dma->chan, &config);
-	if (err)
-		return err;
-
-	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
-				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					&config);
 	if (!desc)
 		return -ENOMEM;
 

-- 
2.43.0


