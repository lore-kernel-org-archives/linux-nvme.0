Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C009CD4F24
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYI5Zc4jJp+5mbqb3XlY43lqPo1gBAB3vr+K/tK7l50=; b=c890WUcmyFgU0rPzxJxwjkX5ba
	qCDzKz584Wj6nW7n2R7QdiXrUhOBQjw7s0INpKggvVee+ESjm6wDARxjRFuEk7x9DlmHn47oxl74S
	jrQq7VLit5irJtp+NNqLSQ42Qs2IBkV6h2Fd151LebY9FBQztHqEBnphM8O08QqU2m9mS1/Z0qlxO
	djPD4jjAdD16ZrJ4kWXtQrA05xuwr/4Gmg+U4M4G1CDkxGfdIFLyR+/ClGVngLWC7LqySnBvDOUWB
	9chL2Wx9NFUmOSAfS7QmOLNEjqUDzDF51wlKoMyq9Bof1gV01J/mdxlqM+lx4S5jhWXr6Xrb3O4n4
	kkwPRUow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqC8-0000000HP95-2ZUk;
	Tue, 12 May 2026 16:42:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqC7-0000000HP7g-1NT1;
	Tue, 12 May 2026 16:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=NYI5Zc4jJp+5mbqb3XlY43lqPo1gBAB3vr+K/tK7l50=; b=GwoNbR5CdCeNNsJPApnV+f5cXT
	m/ILLfV9zWdEeMOZUULDxRcYN/qQfAn9KB6oq8lIKm+wPtbNTL5P1b4+K4c99Miv/r7B2/O7mkEeD
	geKqUnGknKTzJu1/2TGF0OZh9K/hmdDR5hhcQ1me/lSz6NzbUK5NwhmNBEVTQVzMpV+yGOTamdX+/
	n+ltms5sjB80Fi2l9aoNME8nhCOD8G4zxR9aTH4V1ApUPnBTaG1vj7l6x90d+rGMJLpfHydx3SHNE
	MJu9RJXCJwkP83OV2gTxdFnARxcAg0bZmypU5cqhYf8FDsimObjoIEOXMTb+aQUdXgCb22EtiKKG8
	W2N5SMTA==;
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqC3-0000000FNJA-1sek;
	Tue, 12 May 2026 16:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNDbwBHRht5S39CX0uq5f4igsyuUP39l3Fx89dW6kNmpfsQiGNdAuHPPApfr2kgWJO2lynvdgaIoG1t4N9eHTBRRUo0erPO9l3s6A6wuVR7oGHcxKllwRRv4jJKgfLA4I7vFJDQPFSxxxwZE2S1tud3vmCJov+JU5cNsgKJ78Sgw5IcsreN1AQiej3UfHNb4pBvV/MLURislvWgxWKoro81WFuykKYLYoWc3lyJCn+9wOg37GK9HKg+x8J4OYpxFOhEox4eK0ml4kPEDuX44deZjXfSnQnANVKMuaDmmB+fG6qAkQmqZFZop8cjnJHmduxgnFDyZE0d5OzCOW9dmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYI5Zc4jJp+5mbqb3XlY43lqPo1gBAB3vr+K/tK7l50=;
 b=H4dusD1qpeHHAvKuCPiv6/LFh9SWezLPVwGzvWZAFA0xed7ycW8Tp5K+U7TyBQQEW6itT4YXIOJ2yx83Z4y8vSuDFnQXucDef1PrF019NSyq80vKl+c5T0EMfo/Qu5eDyWQxNCgZDqnK4OPS1D5spJwxC9oH/BeQ6aIXiedywcK1+wR/FTVf9T5h0nRExjCO/5gzZBLLzQkAvZp9COjMtSA7ISwNvS6shnPmVnU2AUuHKQCkgIwN2Mmi/J3Z0uMj/tzHiJvCNu/s9qpo+whoVDJ43PVkPQ1J1o+rctHOvq8kIHWvQROLikXc4It+yXdNB0rKcoCv0lR8ziNghbTZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYI5Zc4jJp+5mbqb3XlY43lqPo1gBAB3vr+K/tK7l50=;
 b=DJ7dufQVv7z4Fhn6948cUXzDwE+ifQtyxEhbgMckgxwGvhnMdKbOnqoCc8oi5Rk3VkzVpE2sGYCeQ92Z/+C+1IcME4J5AIE2fxaMQr0Ut2m7EVf6nMD5yb2BzpaCLmBRNGJC5958E1+himubtoSerLfiytcHoj8lrBrgAVrS65HrdtmYL7mkWUtcSgAK5+ErGefhkUXq3xXxYQAqPEnxUAECqkN99NTYCjUi8m3caQogscty+Xtj1xqCphOlTNzATAyz1ATTOnlajHabDeuu9mZ+8FXa6vzZc+pRgKVPncov1cox8UtMfoFYiqg6FsXSh0VquO1IFhcHjCiJYkf6cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:42:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:02 -0400
Subject: [PATCH v5 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-4-26865bf7d935@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=2239;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hltOw2Cx/9LlwBERE81ajsgDLN9LjUwIl3Trdv7n/4E=;
 b=3+fabr9YksKR48iDfpdhyZ2/LTF7VuWhoR9cz5R+eh2vJfTe30DBwdx3gK2CVzUzBPXy5kZXs
 FM8/mrC+gQAAx8/54lEPFLoayuC3jE3PF0AeW2Ulzcl72kRity0+4zo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f4c76c-de7c-4b06-d7d4-08deb0457f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|11062099010|56012099003|18002099003|22082099003|7136999003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: hpT8x4WOllKEdq1tgZj/iCsiuscULYajqm5ZEFdBY2ySND4UvZogHAbLVns+oz4SEp94sSHL5MRIp7Viy1pgFx2XUNW8+O4/kLoqbjjaRwhmNaMFaiXXU9vJNwa+NkreUzbc1COea3qk/jX8rwO2cuuQJbFcvDO2CxFPl6PpWx777lI0Q9XRtUYKCQ9PX+eedlAlMVZ5Be5dx+TNGYqx6U0AlvEbIgvE3n8ErVIZiVETqQAjTvz/wAhjGcNJx1SqgmUiTkXKsqJ70DQBrGmcgksd/Rbu3OL6p0vcT0MLTgWdRQvro2exb4t9Oa1akInIo7EGhxVB/wl3C2KHSz2ANNG4kD95v4M/sL0oabGQX+eNri9y6lnOiQgj0h1a3AUgqbtUyciI+xZvLH22wpxf/bplB8xJcdJiaf6+IL9UmcruiOqJmJcJzrtHHy9IfQgBqf+dkGMOsa84vgIoJfA17O7GizzrnAkzqWcQax6L14q2NDG78dP9C5Ua0x2ckh0iDAjsdZ65HOUyvVgtqRQNnnmNTaGepMQPBzt0pA+TxlPtx8tATAVL9kPWJ8QZrRp3/rHF680LInpSGJ4C0swprqIvoFuWXuaucxuutBx3Kgi+SwfuQNpfh+IN9v4Es1i2MdfTuI3XtwXj+QeRuYjpKxE7CEiiKsTFMGF67IfOIGgIvKv4gTqnsifKkkZuiKPx0324/uRMjNyPb7E+VBMhacSw+PUQ/pZ8YHmSex80aYhzmFnc16+rBM2fvmg7lcE2MzSW/nNRikA3wc8FROQoNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(11062099010)(56012099003)(18002099003)(22082099003)(7136999003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpTbG5BYVJGRVNKMVJhL1paWC8raytSdHJLMnlJNnIvU3IzSG1hT2RQSmhy?=
 =?utf-8?B?UW16Y2FrS0FJb3czbVpxZ2s4UW4vOTJKL1h5cUY0ckZidmtDTW40WmlZU1da?=
 =?utf-8?B?OEVXQ2g5N0taSkRMWjFuMy9HcG5Lb2R3RkcxakkxSU9ma1ZDYXdpRWx3UW5z?=
 =?utf-8?B?SW9wbitKY05pYzYxMnRHZGFwUzNEc3FzSGt2RUF3dzdYa1l2bG12TEJDdnRP?=
 =?utf-8?B?Z2JZQjFCemFVWTZtOXl2QjJFeFJtYnFMUTVka0RiNERtV21KQm4xamZGMHVl?=
 =?utf-8?B?eXh6V2hQZ1BaaXdqbFVBWkxsOVltUmFPL1NFUWt3YnQ2TDk1cTlqNkxTMVAv?=
 =?utf-8?B?VFFGUnE4V240WWx1UXBlNFZZT3lxUll5OERIbHZJS2tyYlFsNmE3ZnFGcUN4?=
 =?utf-8?B?VnVBdlQyb2JhSWxUbXI0L2xMdjMwUlk3Z0M0M2taNHE5enNPQkNoWmNsNU0z?=
 =?utf-8?B?NFV4cVBQcHB5N01XV0xmY0llMEJNOS80RGFzOWNwMDUvQkJGWEw2bHlvZEJZ?=
 =?utf-8?B?NEI2Zk8yUHdKSXlyT1hxZnR6Zmx4YWhqeVEzNmtMd3ZlM1NBQ2xaUjI3M1pq?=
 =?utf-8?B?M2FOYzc5Sk9rOFYwM3lEV0p1aklybEM3aWRvaG5iNUVxRVBQMGxrcHMzSXo3?=
 =?utf-8?B?bHpXcEdOdS80THVudDJDL0Z0M20yaEFMZUoyaFljRjBadDlrdWVkUXh1emZH?=
 =?utf-8?B?NFV0TTBoODNjYk5HWjVTeEpTVldna05lM1hkUlUwYVEzYktTY05jczR1RE1E?=
 =?utf-8?B?Q2JlYUlrdGl5Nnl5WXBhU0oyY3Nha2l5VTFUaXpZR3IzQWhwNDRiRTRXT2VU?=
 =?utf-8?B?cDlya21vL05kWnU1R1NhZXEyK1o5dWJRM1EzUE50Z01pQ3NCeTZ2Ly9VMGFN?=
 =?utf-8?B?V21BaTlzdHBiQjZVRDExK3kzdmRJQU9kSTEzWFo3UVhpZkp1ZkVSZTNsNTNC?=
 =?utf-8?B?K2FpdUpNSVp0elY0NzFDc0h2S2tUWjJabmR3Mm5HVG03Vi9jMkx1ckNoWHdp?=
 =?utf-8?B?QkhWUXVGSkUrMUduM01CZmV5K2lCajRGNFNBeFdCVzdlMUg3c3ZubGFzWnhp?=
 =?utf-8?B?NTd5bzhoUUd6Zm8yRmdWbGREbmhjV3RpQnRVZHBvWWdKVHBUOVVJbTRLd3Jr?=
 =?utf-8?B?ekw0V1NYdFlPME5sTWs5a2tDcGdjQS9BaTIvTnZWKzVxUTlScjk0NFF3Ym5F?=
 =?utf-8?B?d2J5QVg3TE5DNzhGZ1pXTEgzMFBEdGpyeHAzN3E3T2pTRXF2MHNWY1U3c3pk?=
 =?utf-8?B?UHJhYUtmZTNhUFdGUFByTUdLOGgrdmo3bWtwMFBNVGRVNmdZSEFDTVFpY0Y2?=
 =?utf-8?B?OFRtMlhZQklTZ0lUTnRESFZEeFJoYWh3NEI5cEtYeFRIM0gvM0FyWlEvZHVo?=
 =?utf-8?B?ZTdPSndxTkl5SzMvbmhhbHlST21ZcmM0MDJCT3NKZlVQbmwvOU5Kalh1SStk?=
 =?utf-8?B?cDVTWVF6YnFUQUxINjI1MjBjY25Lb1dmR2NNWkJndlNYTXhzdWlaOStLK3Ew?=
 =?utf-8?B?cHc3L1Z3ZGE0aFY5MU9HeHpVTEFBQ0hvTEIxYU02QTdIaVprUVQ4Mk5MWldo?=
 =?utf-8?B?TFN5U3lrYlJRSDlWc3J1a244bDMwNDBjN2lTcjEzMjAzaFRPU0N5emoxNTNQ?=
 =?utf-8?B?RzdDYy9yUWpObE00WGNHMXdMbUhJRXNBRkczeWwwcjZNRkFqUE1zU0dhZG1O?=
 =?utf-8?B?dmt2ZktNZ2UrSTZxcXhZTVM2NmMxUzMxanZMeUxJSGVQdUZTZ1c5KzhBbWo0?=
 =?utf-8?B?NUNWNEpBMVhFcC9SNFEwTjFQRVEvK28xSG4rYnVhaCtrY2dVWmVocDZCcm9W?=
 =?utf-8?B?TE0zRTJSdnFEUFZka3JTK2dLSzlhY05ZdDBIZGplU28ySDdCWjFQbFRsNmp6?=
 =?utf-8?B?MVFBWEN6UjM5cVBZSm5wVGtFeUdVZzBNTG03RFZDVTBHQ3FpUm5CQU9Ka2ZL?=
 =?utf-8?B?NjZoNU9sV1VnVy85TnhYT0hFb0RFclNDd3NTRWRlSHNvdXJiblRIMTVBeUhE?=
 =?utf-8?B?eEtzWVloeklkcUZDSS9jZWFVYU9TUlVUcUZ3OWtrVTF4VnV4ejZVYmo5UFdY?=
 =?utf-8?B?VisyMDFrK2VXNFlYS2pjbTFEaU1HNXFnTkR3cTBoRGREV0hHWkNDaXNaWVJv?=
 =?utf-8?B?WFQ5M01Oa28wak1ib2lIYVhhaGdpSW9sRFRyY1ZYSkR0YWZib0ZsWGJiYkZH?=
 =?utf-8?B?MDNsWnJ1Szc1cHIrTFE4TGloMzJEVkVyalNnbVVlRE5xTkFBMk8xbEtBUm12?=
 =?utf-8?B?WUx4Y2kwaTljMGwxMUlpZmJHMFhmQWNyL1IzODU0a0xQZnVSWmd4a3dBK1lm?=
 =?utf-8?B?a1ZFdkx0aW1UdGJodjVsWExjQ01IM3dvTzgvLytsZmsrQW9BUllxdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4c76c-de7c-4b06-d7d4-08deb0457f30
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:46.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t7oexY8fnHfhqllX2J8EM7VcoiNm4fHKq7LzcunDuJf21rvlacnXmtpxNgV94uAGRzkf8Eaqx6KoJunxnW+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_174252_527330_33B7681A 
X-CRM114-Status: GOOD (  12.71  )
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

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in callback.
change in v3
- add Damien Le Moal review tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79fa94b016913443305b9fae9deef12..f7f58b0010e26b529ffb7382d5b166a703587c71 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -577,10 +577,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
-			     unsigned int len,
-			     enum dma_transfer_direction direction,
-			     unsigned long flags, void *context)
+dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
 {
 	struct dw_edma_transfer xfer;
 
@@ -591,6 +592,9 @@ dw_edma_device_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_SCATTER_GATHER;
 
+	if (config)
+		dw_edma_device_config(dchan, config);
+
 	return dw_edma_device_transfer(&xfer);
 }
 
@@ -970,7 +974,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_terminate_all = dw_edma_device_terminate_all;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
-	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
+	dma->device_prep_config_sg = dw_edma_device_prep_config_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
 

-- 
2.43.0


