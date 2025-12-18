Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2578ED6E2AF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Dec 2025 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6PVyBvYHsh2oMriTi9Q96RzJuWKoq2fVoKj8JnAdpc=; b=eWUPtSpzB7E/4eWOYtSS0KZtDT
	dkn6oItYTUT1fWmZaJfF7Ze0o14a4WHHm1y+CVhyrX8mG+P6ytqUhilGZ1+JwRyRkQ3UV9gZ64TWk
	U1V9wFwngjROKYo7kCnNGlnAgwHZhjJMkttnn1RJWYe9aNQzfMPNiD0KEG5Pg5j6MtYUJRNWx+XJL
	akBlCzQIiIKHOV517s9OG+h8swh2a+nkRtsPVN+iVpnabK6Wq6PHoreeT+sMNrJmgr3EIOBDixS/Z
	O7dzHF+ve4fIbGNzBDcHpVIq2W5Y6sPLalFsGRrFn6P2n6Tehn5Ifm6AJdYohrT3obnD+mqgq+g2Q
	ca/Ih0NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWGN2-00000008k8f-3VTT;
	Thu, 18 Dec 2025 15:56:52 +0000
Received: from mail-westeuropeazon11013054.outbound.protection.outlook.com ([52.101.72.54] helo=AM0PR02CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWGN0-00000008k6K-2HNR;
	Thu, 18 Dec 2025 15:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLfCRh4IF65EEwiMEsT2ZgN/0Cz4UmtarYW9uf0vugmGhyVEjJeWlznPLcdTuNDiFxYS/Y1jI8oHB+pkaU6sYaB5WETxMHcbBbVOkU7Rxlz7aLJDCGPIY6obuIAOJk2JZBYn5ZYf/tsS0fdyB8VTJ+KyorRm0lTBI4LSDJTt/zl8LAlwS6/mFSL2b/PZDwlJ1gc3qfsHPBguTEz0r0E10Ang9lk9tiB5JYCkrVmo41wiUcE0kpCLfAe8/JLrP+mm6FPydgVZm6ZI0JDWCCxdHJ1mYqdHek3nBCz0ZWJRbEH9OIJyTVrDgvdpdr/EZIyFgs59wBrFDQDp07QUJDLmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6PVyBvYHsh2oMriTi9Q96RzJuWKoq2fVoKj8JnAdpc=;
 b=bDMSh9wf7T6lCCoOj22cEtDeEB8o2I7GtvactImkfTIdZr+IjtqApcRTYXKbL+D5d1ZmmriyQbmJMU9GoC5EgjqMs4k+JFfhwlt7m9Fgse+EX6WnRvbVxQ/LVv0D//f/DZXvF1sakdC5KnR+OhEBiDaMxS74za6b/evYpyl2WAPmvTkejakuZ6NXmuFhxsUKiwZkPRk3VWZXatKfMIFsKXXUr/TP+jtoGy8+5lzsE53grdmq5q7bsT+oNsxAX4uHZMXm6qCq1wtNP9GektDZoT3kJ/aX0/rS0ECSMgHZc7/Ogz6anKVZFHgiFp8dcyfL3L7k5uoKNZ67c0vYcfkQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6PVyBvYHsh2oMriTi9Q96RzJuWKoq2fVoKj8JnAdpc=;
 b=Zk8CAm3K8RvwoM2HQqIPvacC1z0ytRxOOprtbiFl3p8BkMzypUYvYJirQvi+gU664A8Ht0bXujYjFEUL8NkcuBKwVTf0U6BF/oMxkdsXr8Kl6CUVXzcFXom8VVMo5cUuDsHXzED2h7NxtZm0PBGFKoeR0WNQW186x3RsfLyAWUpV3/qDSwqpBYJ4oglKp02PGoiEXHdEoKxEOAih5KYnbl1hu9pAgB1cZ6Rsou/2BRclEcSthpFu6qRLml62r1JrClE/arB+RLxKhx4mhrNpA3QgUOM3MHJaa2mPzhhaowe/FMUtuVzz7zA+1hKRcb7ls2ZHJYjvKzq1Wqanrw+Zrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 15:56:46 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:56:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:22 -0500
Subject: [PATCH v2 2/8] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-2-c07079836128@nxp.com>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
In-Reply-To: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=1140;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XQrf6uvIJMm26qlxy2eCeqlJaP9dBMx8OlvOr6mTYpM=;
 b=raKg9lYu7bqitTPYuVR1hw5gxiNrYyZCRu0NH5sr5Y18D7j18S+UoEZVgFu2sgeBlCdaoYLT1
 PaE8WTGZ1+cB544GfUKsZTdE9d7TR7oVWOWUmq+7TydVeZgdiI8dbCW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: e566daac-263f-4e22-4c52-08de3e4e0bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enVYT05UaW1ra2Rna05mQVJCd2NCQkJhRzRGZUlwL2E1OFZmalI1WnpnUkRQ?=
 =?utf-8?B?SEpGWGhXUWRqYVNNWnMvM3BVSVh5UW95djZxcnE3ZmxEMm15TFVWTTdSWGhi?=
 =?utf-8?B?bURNekkxb1YreGt0Kzk1Qml0cTEzVlR1WUNjNTcrMnV3SHg3SjFsUDJha05t?=
 =?utf-8?B?S05MQkk1UTErR1orMzY0T3FXZU9NRGFIMTY2SU81SXUwM0J1eU8wMFlObTV6?=
 =?utf-8?B?ZWVuR2haaHJJbVlCS1RQVnc1bm54Z1NNb3Vvb2FTWG15Ti9FQzY5akVJY24z?=
 =?utf-8?B?VXFkS2ZEc1NuYkh1QjJKR3hMSnhPYW1ZbmhVSXdtcTdyTWY4bytRL3AycU1i?=
 =?utf-8?B?ZCtjV3dsRk5JbFpMZWVob0dGbFR1UjdWNjd1dlJIbUVBNWdENFdKemZqNHlJ?=
 =?utf-8?B?V3o2R0RPaXdZcnhhOGJZL3R4RGJDMlhXMklVdDBjUExkRzVneVppMU5RcFhX?=
 =?utf-8?B?amlXdGFXcWNwWHkwZTFRd2ppaStreC9FZmxIRXF4T251dWRKcWRIYjRTUVpo?=
 =?utf-8?B?Vlo5OFNYQUpXaE1rdWhJYmN6RTlEVWlrQ1pkaUVDOE9mQnhjOGFXaHlHZ3ND?=
 =?utf-8?B?bjJNeng1RUlTWWRsUnJBWllDdktmNFNodldWU1daVVFtcTdMT3FaVGNYMXVs?=
 =?utf-8?B?UjUwcTlpSGJTZnRndkIzUG96SWs2MmFOcWtEQ1FvQ0RMUGZaZ0huYXd0REUw?=
 =?utf-8?B?Y2pHcUppSHBINUQrM2VyZUwzQ1ZYTWxvc21SbnZPMTlOUFljcFpnelNIL1Nu?=
 =?utf-8?B?OGUrVVoyS2ZCY0dXWlh5NnNaeHJUbytjaURBOGJCbVFJa01IWkJ6bkQ0OHlW?=
 =?utf-8?B?OXpXckRHa1Rmc24zZytsTWl4V1V3QVpDRGQvOGxnSTMxTnoveHpjMndUZnRI?=
 =?utf-8?B?bmtUV3lXd3dvSE1qdjY0cmdoekYwcXFhVkVuS0I3NHdLeDgwMjZFSWZXMEwv?=
 =?utf-8?B?a3JSd1ZaNHY0djBSVzJxeXg3dUU4Q250UmU2dEZ3dE83WDdXOGs1NGZRWkZB?=
 =?utf-8?B?cEZhMi9IOHUyenVVWDloY2xMQjJQbkY0aUlVWXJxWks0WXVLejU1eHYrdjAz?=
 =?utf-8?B?WGdyV1RLZ1BVd2NGYUtZbklWbnl0YVprMmVOT1VBS3RUMllPM2V0ODdGWVhN?=
 =?utf-8?B?TVhocVd1V1RkQWM1cExSWUVPWFVCbmVGbnQ1bmZKQWhtU3NNNmJ0ZjZEQ004?=
 =?utf-8?B?WXp4MXo4R1A2VVJXRVFNSVhLOVNpMGp3MmE3cGM3aVVQb1dkTlhCZ2pyQW10?=
 =?utf-8?B?d1hZMjhsSjI3dUtkUVZ3QmlNZm95eUhZaG1jR3Rha3pQcE9oVFg2aElPK3FG?=
 =?utf-8?B?YnQ5UmVRTjdTQVZ1aEdPS0xKdzk2M2pBVWNhUW15dVBzMWw2VlV0SlI5SzRE?=
 =?utf-8?B?US9ISmRSUVlLUXUrNWNOYmFtcTQ0UWM1UGRzS3VDS0JZZmtmS2RoaUJvKy9N?=
 =?utf-8?B?eEM0UC9US0ROMk5XWEZzZVU0N0pBTU15ZVEwNWFkdzNoNDZUZmsrZVZ4clo4?=
 =?utf-8?B?YlJYM0RnU3dQZzB1d0t2UFhzSmRlRnhURnk3OGk5VmplRzVEUmRNSnFwSk9n?=
 =?utf-8?B?OWhvbG4xNnJtc1NiV1BlMUxDbDJ3T2Z1SHZHWWxnUmJOUkZSQ1gxaEJCT0VW?=
 =?utf-8?B?QitjTEJRVEtDUXdUaGcrc2d0NzdFcGlMcHdNOXBvREZjRERTNTNxWDBsZDl1?=
 =?utf-8?B?cUJoSVFIN290WHk3dFN4TG9qdnBMekFQNmhWdUpHZ05FR1RYaSt4SjltcjJZ?=
 =?utf-8?B?Qk4vWncrQ0cwZ2duclRXZXBYVHhtVmhqcVRSS2RGSFk1QVJ4SmJPc1Y2VWtX?=
 =?utf-8?B?RXRkK2hsQmtJYmtIdkVGTHBtUHFGbVpFVWY5aXNnTzdSa3RQWHpqNVoxMG1V?=
 =?utf-8?B?cnVJVW1UZmkveU5nS3NjbWQ4dVlqVk81anNvMXpNRDdtN0hMVFVsclpVOEVH?=
 =?utf-8?B?c1dpbmZRcW44bVRYZnZmV0hwZHlmZWtKOHFpRSt0ZUFyajB0OE1JNURFdmhm?=
 =?utf-8?B?aFhMVjgyelpyQVYzc3ZQVit6R3UrSHAwbEdoby9ZUFZmb1VNSG1jVW9kRmxR?=
 =?utf-8?B?ZWFJbnRZNHJkek1tSzBnQXI4Nm9sM1R6Rk9hdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElCb3hXdzl0Y0drZVlQNklpWjNrSGoyeWZPbHlGTjN1RGVKOXR2N2VaNlVI?=
 =?utf-8?B?amMyeTlGMDY4L1R6cHhMeElRM2VGYmJzdmZjWGwrM2FHand3ZWhkSEx1eWZJ?=
 =?utf-8?B?REQwZUZqMXg3aDVoWGRvblJxWTlWbHN3UzNjTStQSEJ1THhCLy9kMnUzcnpF?=
 =?utf-8?B?MFRqSnFTNDRyb05hODJkeTJCQnNiZTNGUTRCdi96QW9sY0xsWG1EamR6OHNQ?=
 =?utf-8?B?M3hUK0FDSU5GOWRzT0RTODg1UDdCSGFVem05cUIyc2NEVG9FVXRwQmEvS29D?=
 =?utf-8?B?ZDRmOHpTM1RpVVJrUmRRd09xNGdOTitTbDQvY2JrRDdFSHA1WHFmNzVsU3h1?=
 =?utf-8?B?M2NINEdYNTlxOS9NOW9nNjB0QVRUR0dOajJlenpVQmVjLytURW9KVllMNXo1?=
 =?utf-8?B?aG5kSmFBc1RWU1d4UEt3cnZFSFZiWDNZYnkxUER2THEvWW9TMlA5SFZINHFG?=
 =?utf-8?B?cTZkNVVnN2UzWnIrcHVNcXpaU29FbTVFbVZ2UnRseFpNVTIyUURvd3lNQVBo?=
 =?utf-8?B?SHRxdjhJT0Eza0ZMTzN0b084MnZJeGt0Y3NLQmpOR0E1dVcySUN3aDdIcXJh?=
 =?utf-8?B?cFJRaXBaSFJ6R2tkZ3l3bmhzc3VrWk9WZG5LT0NpUk81T1Y4Mk9rWTJhWENM?=
 =?utf-8?B?cjU4bzZGSWF5aTA1THFmZmMweEFCTnlKc281R3lpakFZanlibW9uU1FRYU8w?=
 =?utf-8?B?cnJyNzR6K1JrWU9pNmhVc3l4aGl6Z2F6citxYkJtQVVsQXg1cmJnREdQQkFF?=
 =?utf-8?B?Qk41WjA2SUJvTGVTajF3YjE3TzJGN2o2bVZpemxFbnZaU2xHTTl2MXFLQ2J2?=
 =?utf-8?B?dDJmU2ZCdDV1aENPTE1mSFlicWJ1bnNZZFVzTCtrazhvRjlrM25hTk43SFFs?=
 =?utf-8?B?VUVSa1ljeWN1UEl2YUJIY3FwamRmbWdmQlNXTmM1ZGlxUWtMQTRzVHRuOUd1?=
 =?utf-8?B?d2JJOTI3S2dvNm80eDJ0Yk10R2dKMTRWT0d5TVp4MmNRWU5RbXNaR1RxeFBx?=
 =?utf-8?B?bGlQc1VKU2hiNWpQWE1pRXNWMHNVWUMwR1RTcEJXQ3FPb1ZUa0pnT0pnL0hM?=
 =?utf-8?B?cHBQRVBuaWlhRUdmdjYzRGRKMUQ2ZTVtUE9uZGRTUWxFc3Y5QzFNZmovR0tn?=
 =?utf-8?B?ejF6SFZuUWVjRExrb1NRQWdOL2JOcGZlWU1teEtza0E0cSs5Qi9TWFZ6NGVV?=
 =?utf-8?B?cVpzRTZtcVFkN0llSkZKZTg3MlpjYlk2Qll1U2lkVEVxOXkyM2Q2Ly9TdGN1?=
 =?utf-8?B?ZFVYZUh3V2N2N0I0OVFSRXNGNVlINEFHVzd6emxpd251VUxUdlFaMlBNblhn?=
 =?utf-8?B?dVo1OGRqRjhRckNVSzJKMytTVDM3Y3VmTCtkTDExVUR1aUVYUXZEMllDR0JG?=
 =?utf-8?B?RWhGT2t1NzV5NWhVSlF3TmNWVUczRzRadlUyWVZpVVhZVjd4bU9xRDllVFQw?=
 =?utf-8?B?L1RxYms4clUrc0tqdXM0cmg1aW9ZS0QrbUxuNnJnV3FXY2FLa0xaclNtQkVV?=
 =?utf-8?B?dU50U09CZ2hFbTM5NnhzUmFOM3MxQldwcEJnOVpwOGlBUGEwcG16VlQ3eVcr?=
 =?utf-8?B?Z1FjUFhnVGNjS0JIOW5xeTZpdlo2dWM3T3Arb094L2xxVkhFcnpHL2dOT0Rs?=
 =?utf-8?B?R0NsM1czL091QTdPR0FIREo5MnFMVW91azN1ekhicjg0bUJsL1R5Y3VQU1g1?=
 =?utf-8?B?Yk9yL3MzL3V1c3Z2bjEvcmdaQ2JVSTBFdlNqMTRaTDVDbHdFbVI3V0cyVG1Y?=
 =?utf-8?B?VkVxYXEyOWNja3lQaTB2cVhSeXFIemZHR2tabkViYUk3cnlXYVhBYWNZVDNL?=
 =?utf-8?B?aWZHTWRYZ3pCb3h1TjFla2VITTZYRFQyS2FJM0pIc2VrSzFJaVJzVUQrZ2NL?=
 =?utf-8?B?ZkZ2QU41eW83alVJVVNvYTBaUi92SXYvUTB0Yml6YUtLY3krM0NjemVkdThH?=
 =?utf-8?B?QlI3aHE0SVc4TGFEUzI5eEErWnFUSUkxZFZKVzVCMkF5TjhCSmpVc01SYlBs?=
 =?utf-8?B?YlhtcTltYzRyeVRZV0JCWDJiZmNON0JTSDRpd01obDdBRmhRczBpR0VVeTQ5?=
 =?utf-8?B?R2hLWE9hQnlqLytlcldiRUthWEtKVVMvZUszSEpqWDlRelNMWGxLd3FaRlhJ?=
 =?utf-8?Q?gTCOqXU32CR1wOIm0lOTNOmsI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e566daac-263f-4e22-4c52-08de3e4e0bde
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:56:46.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXi68vIRJ9UmRwq5uoUliMZ0ySDMoQHGv/zT/Q1oVyNRffwtljRKoXFhwxk635WUnvx2coR0rEFsL9IzBwTSIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_075650_624686_B1932307 
X-CRM114-Status: GOOD (  10.43  )
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

Use dmaenigne_prep_config_single() to simplify code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index debd235253c5ba54eb8f06d13261c407ee3768ec..95b046c678da7ca4a0d9616acdd544251dc05aac 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -162,12 +162,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_config_single(chan, dma_local, len,
+						  dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.34.1


