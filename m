Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49399CD4F25
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5YgE1hFnfhZWhedU1IGXIHTK2CPBFEfwsc7cJev1UQk=; b=Mqv4cSWaj7q2R1MXh78upFDaMA
	CDd3mz1nT1ITIrZGBeM7/lzOet6Mw6QcRicZsPK+uI0FDYxM4gB8U0HR2beVlSFSFtt+N6QcmsLUX
	zVEzfT6S7DFvonP6DshI7LBKT2FvAd5zRmiPgpd/N5EhKBnk3/CHx9CwOKiq+dbP466S60j4/8DaG
	nx0qlnAKbAI0rl5zLLvKwYN58D0r3ImcgKITAfUn8YaBOK5nHrh6CFCGKkVRUbR+zEAUKIiHuTEsD
	BLz5XGvXMTCK6yelQm3q45O1hnXzf2Z5ChdMfUjZOVu3ugml4uP7Ghx5YZFOj3bF+yx0gBWlGoiMi
	SoBFI8qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqCJ-0000000HPJm-2MGf;
	Tue, 12 May 2026 16:43:07 +0000
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqCF-0000000HPEq-33YK;
	Tue, 12 May 2026 16:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDIVK1FWCHShNKk6QOPUIU2Dc9AHhHeSb/NltKJLgMaobUZUCtU1K3xFInkDrwVZTpivgL13APOQuN6JvZZ2u7M9DoCBdpbhRz70/iKYruIUul4QAcn2qFaEP71ybj/AzPl351yt874BQ8Jnk3Rzn2tE6mL8OWi63BMXNyH3egPMELVGQCZDudJ8xjjUQh7rdoOYBwEsYRiQ4cZLnAPyYY5NI3rTZ9Fd9t7DxZFQpnu+x9FLPGumjPe0RtK5Y8S2xx+xSmu/X79rZhLBLPxtrRUSeBVC2m34IkYZqZoyHpjREbUGaz1YAektNDUYmpz4TPRIzIWu6L0UBTSMcxsE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YgE1hFnfhZWhedU1IGXIHTK2CPBFEfwsc7cJev1UQk=;
 b=SdXLbHpzDodPhd6KJQalx03ACbdztgsCSrxYo/HFLZGNosSSLujFDf6cFxMiVtVuSFPvE7GaRdEAFYhwvVXftJVHmKhaD/wH2TfUxynFrnkZAkNeOrf+HdL+a8okLVjPMDtzSkPiS/wXBN95fv90/kBnW+duyIMEGU3/9Y1gDyFw+HuaxGqVKhMigRNzhUEZf9zNIk8mznSLLczXkqouhB+j4p/ehO5aiDVOW1Agvur8rGnBFWFu0A3FoNJbo4dF8XEuJ0AgvixzyYeCL0tSxHRkdTDwmOmH72fsW4nl8V44DgEURnTXYWrCmHwGWHsslG+yDuXa8Qz7y+da7CM7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YgE1hFnfhZWhedU1IGXIHTK2CPBFEfwsc7cJev1UQk=;
 b=Ar+srFgeVwvTqMPQWqbLGDvXQAjN1xkyK7AzBGbk8umvdJkVzTu5h6DQ4xKaZXoaCf0cEOa8/TFDFEgpbmaS5WxI0rdEeCyZdh03lC03hd8Z8sY8jI7STdLDX/FRb/LEXXACZsAorkfRUOjVa59Qz9LZA2HelGtA5wSGW303qgcyaPjfSmara445d3oDieOOBLsZyl+/NzmlLuNuFnDWaQ1XLAvFHxJ3OMZ0JWCPcu4qiY6J54SFiHM95T298dzQWBRy16JSWH1mtblxum/vRHFf3/tlyglQhxp6FXYUk2+OQcIAiaAF3e53R7FT/brPpiwtcz31dcRzYTt93dvRLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:42:59 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:04 -0400
Subject: [PATCH v5 6/9] nvmet: pci-epf: Remove unnecessary
 dmaengine_terminate_sync() on each DMA transfer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-6-26865bf7d935@nxp.com>
References: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
In-Reply-To: <20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=1348;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u/ZO1AP76fZZRv/fx9ufCob+a53Ej8jFDdQt/XPzJ1o=;
 b=mlK60Q4s3EpoMoLRx9QPWlnsB0SZr6qJfEIlD+QKa2WdrXqFRQQ8YMakzsJ5VH9WIULim4EPN
 SgLGt6SlM/4CKgaNg7ovzgyNradKL/HA5xzZ1gzPBubh5kmYhG8hBj8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: d527d83e-f7e7-49d9-bf1b-08deb0458697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|56012099003|18002099003|22082099003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: HbnWO/4tzSP9WNVR2KNEswgOf6rsFDN8qadZB/Xw1VwkRQxp4UmIIjTULOJM5iNGm7z98MsyililhfRGphuTFnuubG4RhDTKtAPAM/4TYCB7lgRQ+rrs90f6h7fuLkrSzCenbs8W9qRvzmNFHDBhbntb/2h93+WMgB6PS0G2DsfIsuQctWxRnHxzYLB4a1nllB/wbvvlDBb9t8SG7upHkGXAa0u+L8LL8fKuW/nWuQrA1zUktx0yeWFpvjcvwXbxr64tZ+Vhsv2g5I+QS0fatBqAt7DooHU0ksoy9Msn4Xf6o0GQ/m+woq8ZQuSUJ5kdzJuLaf7Axpl+4muSB31F+mtPc+xA0PF/zMtApKREJSYr9neyzCLvmgQc5+LTDfB1UrZX8hNILaduCGdeNvf2OqlW+s4WdD/U8F6BOm5TLAx1O/KK0k2t02ZaGJIZXolBDFvZ8Ig3K1MzENhGlu932B5hI3vIyt4zNYbrTWLykG2kVaQJt+BnzC0WVWGjjm2jdbjDU32frC7yEk1riSR3cw5dFcVSbwJwUq6hPjQPIVxmJwW8drV515VVHazygnbMwfLxEyxaSHDPbH7iDc/fuH9ubY8vXIT3ssKbbRLIpb5+soNyhmRbKNlsVEp4tV+zMpdT7E5uaOjSgKAg0BVhdhUf2FrO3AxZ3LCc6ei7l1YcUkqzfS4r2ODcXGMbeuS2AMXVd3lEtaqSJJfvEPlLe+ia2dwlAWmzMq4DQaC38dX6+9UJcoKQ/VOOcvza7cl58loKYuMC2UfwatTiHmLXkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVJCTlJZUDNGcEwzUDlmNEd2ajV2cUtzNHJpNm1hc25iN0kvZDlmZVhodmVB?=
 =?utf-8?B?czJUQm8yWW1xQ2ljQzVvM2pra1VFcnhUVUdPSWV2NG1MUXdUenhVMEZGZUw2?=
 =?utf-8?B?K0FibXdUbHhZdVV6NGZvRnRGSkpPVVZ3Z1l4b1c3OHAxcnVreUtoLzFKVDhm?=
 =?utf-8?B?L1VSTkxTRFpWM3RvcFp5T1JMVjBTT3IxOUYvUUhHVkRrdnpPTUZEUDh2Wkw1?=
 =?utf-8?B?MUNqbm5rdVFwWEk2ZXZtdGFpOGhwR2xCMXoyb2MxMmNScDhpbU4yOU9Kc3dR?=
 =?utf-8?B?bXc2Y2tEVzJmaWoxcGJKdFZnbXA2OVJ3VjRWYUwyZjcvOFN4cGZMcGw3bjlm?=
 =?utf-8?B?UGJjbDQvTjhaMktOcS9mQXNySUxyVnl5Zzl6ZUxPM2VNbDd1aHJweUVVcGtR?=
 =?utf-8?B?MUF4c0JyMDNBK2NqTG1QaEhXN2RrZUJPOHBWWXNkRitHL1NKY3BTMmEyK2xH?=
 =?utf-8?B?ektOVFROdnZHd0NTelVLT0J6U3VSa2NxRkMrcDFrRzYzS05IQWFWdW5MU2tN?=
 =?utf-8?B?d3RZS0RxK3VXNENMcDkxcHQwUVlyWmJmVnVmRmg1NTJQV3FHR3JoK1B6Tmoy?=
 =?utf-8?B?VDkvOUNYV3I1aVl3Q1RZZ2dibG90Y2didCtKZWVNMW01Z1R0bGptSE1SVFN4?=
 =?utf-8?B?UW15TjlOU0hCZDBuWE9JWjJ3R0JnbUp5YkVmK3BLcUxJWXN5eGxpV09xOHdE?=
 =?utf-8?B?RXVQdy94Y1VLOU1iZ3VQQmdrbnZ4OEtxdXk5bkhEQnYzcUxrZ0FZNFZrYlRO?=
 =?utf-8?B?NGtkUlBIbThkL2xoMkRseldNNTZvRzRDNGRrK2JFRHBTckVHSFJjSjlLNmJz?=
 =?utf-8?B?akF4TFlkc0VjN0hVSWEwME05aXpJQURmc0FrQWJtVE1BNS9UODExYmFaQlRl?=
 =?utf-8?B?VXloc29qUjV4b25zMkxpQ1RlaXJHeXVuU01mTkJzMkREUmp1cDRUSXpYZ3d0?=
 =?utf-8?B?dVhlUU5GVU4zSk80VldLZGJ5bXgwUDRjTDA1UkNkNkFWMHUvbklIUGtOQS94?=
 =?utf-8?B?ODVnVk10VEtnaTJVOFVHcEpHMUpoNmxESUU3QW8vYVZFa2hxVTdPYjFsSGUr?=
 =?utf-8?B?L0lZdEJDSyt1MVh1SEl2QnFkYTRobzcrTTFBbExhNitmdFVramxYRWhaK2pl?=
 =?utf-8?B?c3pYRncxWEVqSVBLcmV1RTJiK3JLOGpiS1lpa3lycGwxYVRSK05jUThhY0xx?=
 =?utf-8?B?M1NFcHRNS0RJNitaNXVoVXdMTmk2VGtoQWRiVUZqNzQ5MjQ5TjYveTYzTGJw?=
 =?utf-8?B?d25BWE5IWElBeVdNT3ozT1JXczVta1VHQmplelhHSWNUQkIyZnBDUmhsMHNl?=
 =?utf-8?B?ZnJXRjVLYk9qNFBEMytRbEl0KzZ2ODhLMkFjYWNSK3J2SDk0Z2VxWUdRams1?=
 =?utf-8?B?Q0tQL1BuSzJ2Y09OU0xpQWJVeEgxR2haMG1WY0psakhzZFI1Z3JVZC9hL05X?=
 =?utf-8?B?NllMRnkrSTNLc0h2QnFxVDBkeCtSSkphTVB3czFVTUJPRHNtRTdvdmUrOFJi?=
 =?utf-8?B?WTF1OFpaVnhmVExndkFhNVRaZFU2cHQzYTZZVktRd0xRQWN2d3Y1alRQSzBq?=
 =?utf-8?B?a3ZjWGNzRHREVS9JRG5pYWYzcW0yaWtGRlpFMzhnbnBsczRsWm1BU1pMZndR?=
 =?utf-8?B?dk42Ym9weExkbzVna0Mxd01jSnQ2Ly9oR25JUDhSQUlwSzk1d2EzRHVqM3ZN?=
 =?utf-8?B?WGVnNXRtOEZIcklIckVabzUwdFlBY0hqQ0l1cG4wdXVMKzh6SEptSU9ET2cy?=
 =?utf-8?B?S0dDK3pPcWZhWjJIdThETGQrVmkrQWRrQ25oenQza0c3Q1pra0tHWllvUUlw?=
 =?utf-8?B?NkthK211UkF0bDlPV0JJVUJmcUo5cDVLRS9rVGZwcEM2aFFYU1hQdml3TndW?=
 =?utf-8?B?NTFmcGJxZlV2c2ZnN1FtazBlL1VkY3BBY2UrOUorbzc0YlJJZDJ4UzdJVHJX?=
 =?utf-8?B?ck1TOURqVjdGZDFvREM5MEd0K1V3UXl1L2txck1MUE85ZlIyYU5WU1ZPRnBz?=
 =?utf-8?B?T2RmdXZwOHUwUFlZR3ZUUERoRE83NUkycEU4RnlsMVhENllPRFhPc0F3eUdz?=
 =?utf-8?B?TTJzaFo2UDN5Z0h6eHRtQ2xNNGI5Y1U5RGp0bGJzK1VmcHllRmZVMCs4a2cy?=
 =?utf-8?B?R2tZc3ByRTgvd2x6UnB1MUhuUTRIS1NSVTBOQ2tTbHJTMVJPOEVYb0xDZlRQ?=
 =?utf-8?B?UjFzWk4wQTBod0JpK1M0WlR6elg0VEVURG5rdWZRb1RXNGh4RGphZ0VmYTJy?=
 =?utf-8?B?QmNsVHBJNnoza1kvNFZ1cS9zTkhRenNQNm5DdldoSExNV3pQRmVqQ053MThp?=
 =?utf-8?B?LzlhK2FBb2xEby9pUURvaytYODExdkFvYUhtejlJZENqODROR3JNUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d527d83e-f7e7-49d9-bf1b-08deb0458697
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:59.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZLhszR5Pcur6xoNWWGRsfJhSaY5tNoVnk1WOyiTv2DbjNg/rzbJol421bB3INxSMi2tWyHWRTdeX8X50pv7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_094303_817036_9383E736 
X-CRM114-Status: GOOD (  10.99  )
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

dmaengine_terminate_sync() cancels all pending requests. Calling it for
every DMA transfer is unnecessary and counterproductive. This function is
generally intended for cleanup paths such as module removal, device close,
or unbind operations.

Remove the redundant calls for success path and keep it only at error path.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
This one also fix stress test failure after remove mutex and use new API
dmaengine_prep_slave_sg_config().
---
 drivers/nvme/target/pci-epf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfecd796244e5dc67c23e1abb1a14974..2afe8f4d0e46104a1b3c98db3905cf33e8c9e011 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -420,10 +420,9 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
 		dev_err(dev, "DMA transfer failed\n");
 		ret = -EIO;
+		dmaengine_terminate_sync(chan);
 	}
 
-	dmaengine_terminate_sync(chan);
-
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 

-- 
2.43.0


