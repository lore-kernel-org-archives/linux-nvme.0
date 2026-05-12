Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6634CD4F25
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTCkJ+w/uG8pOruChRO1wj9sfMtpUUqcFyuh8T/2Puk=; b=VHCdHwsPkDOJDhl+jAuXX55fXQ
	SIHXvQyWiLZQ2g9UV5j0yzDDpexmWNBMVuySqjtkbn4mq9iKyh7qwj/R5xF7VT+zAZmuIBFFKtyq8
	xIK/xOzQoZThXc7IvLlgfjaN0yicP6qYj8F7GZl229CW5unSRpZfionhlcRMFic5Pi1vu2CDU3oSr
	RhDX7Aa/zrYhActMHXV4NB4hilx8TkACdxJJZiaDULVhzX+V/doK+a1pS+Z6Yn87wzBfTPPKSKSx1
	/jyyFAP/kpGftQzI/tkC4ZW0YHhrxS1q/WjER/xI1du/+9bVvlIlvKCArdo+PmE5pm/u74H5QXCup
	cSOIgdtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqCP-0000000HPQZ-3rLZ;
	Tue, 12 May 2026 16:43:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqCO-0000000HPOS-1LW7;
	Tue, 12 May 2026 16:43:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=eTCkJ+w/uG8pOruChRO1wj9sfMtpUUqcFyuh8T/2Puk=; b=PER2COlcT2Gz90dlKMHj5Ju40K
	x38Ts6/51Q2aaJEySEurGETirtUdrRASfWeRH7HnAQOJg0R8iN6VvMRvVEGIais6l//cBmji0YHMo
	s1nNYsnun0pGGwPp6ZBkNkwKU5/B0wwOYJ3CximLwTYKXZQPDr1HnjBpOAML11cvytL4Zgy4arFrY
	C3gZCuCWfGnw+Ckyfa2/mBC60LS0P/gziybBwzvIgdYSCOnqw0gRiR8ICtUwuXbjXWgFSNrmZogVw
	aED26jVbRn+Y7ZYTWuDZgmq0yAhga+IGZAx0q60XoWf9zyub9NVmUSQ02LSVWJdqNnB+hon4nRfNM
	qJqtouLw==;
Received: from mail-northeuropeazon11011005.outbound.protection.outlook.com ([52.101.65.5] helo=DU2PR03CU002.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqCK-0000000FNLu-3tjQ;
	Tue, 12 May 2026 16:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VseFfK0y26WRPaRMiDnilILCCvbNMgiuK1YkEuLAOqZhdO5dZJllMXGOTEmqGW78QZ7ocZ1yPIT3P540Nuclt+CteeyzlmBIwhGG3KUJzsxnjACiuE8G5eC9JSDqzPsmTlf/d1Uq2F+7BenTpyB0RYySC2Py01QiQRYnE2SLDR48ueNIAgCxin0DLUcQ+LAiZraXbYQB3lw4eUI4imXXXY6gHxUV6NQBIfrYlUGLgi0rIS5XTeJQGO0mwR2K8fwpV1zDzTLGZ7Tqp/GfyWIKXlUU3nJfEs3NqtIoUfmT3gKY23BUV0CwXJkDmEEg9Dge6E3SfDCcC1rrddlo+GF6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTCkJ+w/uG8pOruChRO1wj9sfMtpUUqcFyuh8T/2Puk=;
 b=WMReZ0kDfZP7VOWZIJRWC1nC5ZsGEJ66xiY5eMzVRXXLDHkMRRtkkaaT7Fn6SYZcPK4fwgvOFINQPvTy7Q+iarjWzEBND8g65gDs/CnreABJXPTqjXxSKELsd0NBPJRRUfVZACIQBoXUESCL6E3FaVZUXHo6T/yI3KwVHDCUU0aj95xNgH5sPcE5ScW7vkNknevBCjJ0S0vxOKSDCjVvwXhx1okYIJYdc9dbOLCXGaLt8ukxkzh8VKJrrlaadGFTkLJ0PjaiTaoiX7LxqbncwatIMADsIx5bCTDF0iy5NqNAYJxOKGjhBEEPMSu6zSx2cKpmSLPstuGQLi+W0TTNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTCkJ+w/uG8pOruChRO1wj9sfMtpUUqcFyuh8T/2Puk=;
 b=jzREjBr7zT/f9lEwJbbGRuUoScGXkF9h78/BSswksZJQVsf/vuIHGxIF+Lte6emADVd90bcwq958Fb+2GV64vqmeI3kNWkR4KgH9VltMYkjJVAUjWFfJaXLP/KR6DiKJSUDRfBwrrUQSZpkkorfYlvlSpI9M1Ga6S+Y+6KNr1cH0DNOWsAzGai+kmLYKonXE2haXozsbqXL70SNQewr0AhbKiWqQf09cxkq8l1Cl/NXc7HaxK2N6mvCUywFT/pSl3fvvDSc5WtMUW5Yxd+wG6Xm0hdoAuJ2T3RpctrNufJS9bST2/0R6XLnS9yTVo5mTtu1pju1N1FLqEiofi3gcmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 16:43:05 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:43:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:05 -0400
Subject: [PATCH v5 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-7-26865bf7d935@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=1807;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uoQYEHKnhB4SOdknYrMgOMSNBVCY5jUAj4dofplJINU=;
 b=Yu7NSgOHixr43jXKd2rc/Q7o0RpfdkivnBymXUwxiyvA92ntIVVZrx0nSymoFO13jxFkURsEo
 ULzYqONum/MB/yZpRAfvqHpGpBqySKVAiivT5M5NDdUloF+JtXZ1Ij9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e7e4af-7f69-4674-b681-08deb0458a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|56012099003|18002099003|22082099003|921020|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 6jO31AwfVemkDk+IncOWo3lVlDoDgGIQBSjeQMPz6qrOI1bbFdjZJakW980pmpsoE7Z/U3VPSS+2KK3OvEjtvhTDj6qSn+9gyQlmX9FKbj+01KShrlojKZYnycLFSjIHU1tocwoJPqlkOERL2QFemDVbRCMEbSrM0jbHLNc2MXp2cGPYDRYHPMWiEpI9kppXTWtioOtnLfUqY5zUu08oi175tNtUNrfeikHMZkd4e2w0msoLIzcSsIyDRQpHtGAt1vKxWs20ThL8dlj3sqrUdx0msBdZrAxuBqi7oJzY6LYL8KVZZOK412wCh+2vw1Lmw2InmU99ZcOWTYG+YsrojhTDE/NZo6euyEeg4sLzwYAOHuLD56O16Ph3Fm60smZbn/g8oefVSCaXJZLcfNwG7nvE2dypoFQubARYXmZl2Bj6oP/6axmTShnEJ5C5rBXgE7ZdWE/dKWQfLv5fC6VGe617V8Kg29Zk3H1/ZI1flqYOxJfURcNyVYDnp6WR+M6FnrpeADHLVjoywlphvfsR83scNAQOAuX0E632FrtbR0y+Fcm6weZNfLzFut0/lRnK2zeAKKPfkfkyvvr4evPFdwlYFUpWkU4nEA1uPdgTCaiIp9Do8fg5AcwZdoXE9fxF/jV5OUVThMM9AdwP45GlazFR0YYtLFNs8fPOyNLXqaZ1ieZjAUkajw6YLkZEQycMmctgF0CS8PJpuFZ/34VcsvkHLADirnaGvnr9UA9/t7EF1HBBirzqwvIKBwl9ip6ZP1sa4qWfBnXDuFGBwz9p+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(921020)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpXbTc5NEk1ek42U2hSVUNGT2JWZDhiUkcwL1laTXJoQmFyc3ptQjZGNXRP?=
 =?utf-8?B?MHRMNk5UREpSTFBOM29PNHJoc096K2lNYmc1MERDN3RZazJFZ01OOU5zMDVM?=
 =?utf-8?B?YzNBMGZvQ3piNm1qdjdkYjlFL2p2QURBOTFTM1ZPQ29DQWJOWWlYcDZ0a3Nz?=
 =?utf-8?B?R3NHQTEyWTVvd29uQXBqVW16VlpHeEZGWjNpY0lpWGFobjJqRDI0YkxSTWk4?=
 =?utf-8?B?UlVKMXpoTHVHalpLM2VUZndDa25Na3RHZDUyaGVsZHNIK1I5a01pRUZaQU45?=
 =?utf-8?B?d1BRQWd6QkFINTBrV2lheFNRM2RRSWNaVFFydDZFUWF4SnRnTXJYQXdWRHNR?=
 =?utf-8?B?cXhoRlhyRlNaMURnRHBiWWl4NEpWbkg5WVNYcy9oRDFyTzNBMTYvWkRwTGk2?=
 =?utf-8?B?OWY4aFRIaXZNOGErTTdHY2lFc0pSRXZ5VGNwT0t6bUFtNi9sOENUN3FBU01k?=
 =?utf-8?B?QWtlOGhianQ3eEVvbjlBdm52NHdqTWpvNXpUcFVPcnVtZVlMM0hRb0pUVGlL?=
 =?utf-8?B?YllvbU5oblQvaHk5S29oNnRDVlh5V1ozZ2MzRlY5QUJodSt2Y241Q2dicDgv?=
 =?utf-8?B?S0g5M1JIcXAyL1h1NldhQ2kzZGU3L1NocHJwN1hHaW9xWmFNL0lLSGp5UDJB?=
 =?utf-8?B?Q2pTL0Zkd3psU2tjL0FrcEJLOU0ydW96N2RjeGF5N2dXRm9URkp3YStIaDln?=
 =?utf-8?B?S3dSVnFTTW55UTIrazNRS2hQNE1uemJ5VHBUb0c1ZXVzY0UyWHcxSjB2UEFE?=
 =?utf-8?B?dnVXTUYyT1B2cGlOSW5uZjl0MFdxMGtCeFRrQ085K3l3anVzRk5lY3lCcnhy?=
 =?utf-8?B?RlNjRFlUZUk3RVprejdNY2lCR014VHBwTjZzQlcxaWpQdTllTE9EL3JCRkFF?=
 =?utf-8?B?NGR0UitQRVVNdkZPb1RKL2FFZm1tclkxMXZjeFdxUEVsR21WS2F5QnJ6RVh1?=
 =?utf-8?B?UUdna3VkVnE1NkNSY0c1RUtQNm1pK0FRbjArTTc3bHBmWi94UVJyNDVXNFA3?=
 =?utf-8?B?QlF3TmpiWkx5OHFuTUhmOHRKdnNXK1pRRis0UzdwMVlBVDI5c1gwbGdWamRH?=
 =?utf-8?B?U0wxWDFmYjBvRUVwZVJqNGxPOXRTRkdNdFg0b3JJUmszdXMvRWlVTzBLdmRw?=
 =?utf-8?B?WU9scXRza0dxZ2Q2d1EvbEo2dEIwU3hNM3ZPQkMzdHY0MjI2SjJtRGpZMDhh?=
 =?utf-8?B?eG42cFdSZ1JrTFRSbE4yclJaM1YyVEJKWmI4bndhN1MrSEo0QmVLTjEwMkxj?=
 =?utf-8?B?VFhSdTYrSzR1Uk9PcWMrYW0xcTd5NkF1VmdjcnJuTVA3N0VZWWRZcm1heERi?=
 =?utf-8?B?dHBHT1RQM2ZCYktaREVjcFZPM25RS2dXZDg3dThyTGFoRGhZVjE2TjQ2cTJk?=
 =?utf-8?B?RWNFWWcxL2xCZWV5VWtta2tkWUw5Vjh4OEVkT09kMkJQVGkvQ2s3d2tYUXBW?=
 =?utf-8?B?bzVjWXRmMUZKaEY4SDdLU2E5emM0TTRjRGt1b0tHenhLMmdPZ2JibHMxRVFy?=
 =?utf-8?B?Vm9ndGpUemVpeWx0a3pxS045RDJuL3BtTUZ0U1FSd3hHdEdmWStINkpoM0Zh?=
 =?utf-8?B?aTcwVjRzZWxtNDkxRHBONGxyOFZlZEdYbi9ZNFJYVi9CSjlKeGp4QU9ER3pr?=
 =?utf-8?B?SllrSnc5UkRMczlhSVA0MlBuQVBnR0xUUVlmcnAxekMzVGNYRGR4VThpYVN0?=
 =?utf-8?B?SUVlMS9QejlENHBUclBnM0o5aDdHdHJCK3hXMGh1c0gxT0g3Ti80RmV3dFZi?=
 =?utf-8?B?djl0bmZvVk5FV3loV3dtVkRvd3FESThYb2ExN3NDSnRQR0FCdFkyeHY0b1pp?=
 =?utf-8?B?SXd4bkRYeHJFSVNNMFM3V3hOTGhDNTRrZjFhMkRTajVQTEYyVGRoRVkxV0hC?=
 =?utf-8?B?M3pKZmtRY0trcHlvUVFxRGJYekFJNlo1dEt1OFM5cmR3SzAvZVNRcmNqQ3FM?=
 =?utf-8?B?Z2VpRnc1WkszTVJ3WVZjMFhnbUVNM09aSGZCZGFPYzlFeFpJTDVQekYvSXpz?=
 =?utf-8?B?bjdVQU5lNWs5TnYxUW1LK2IyMW9LQjJKWVhES21SdHVaSzkvUklTai80ZXg3?=
 =?utf-8?B?d0o5WGw5Q0o4ZmdxbzNVUTJ0M1RGMUN0K3lvVXdaL3dXZWoxUGFZKzUwWGxm?=
 =?utf-8?B?S0FFUFViNFpFTDJDZFdnaFQ4emtvY3RlL0tjaHN2U2hOeVdVaCtRRDM1dmFr?=
 =?utf-8?B?NldDR0N1c1lOWjRiYkJ3YmQ1NkdPVGRpSzRTelRTcTUzeVpUYmZlWDM0VWpy?=
 =?utf-8?B?Q1NEeFRQS1pJS0JyNElIVGVpU2I3cmlBN3lSaDdsVGN2RGduY1J0M3dqTjR2?=
 =?utf-8?B?bHp1Tm4yTERGWHpKeVJORmJEdkhtMmh0c1FVczhDdEJmT3NCOVA1QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e7e4af-7f69-4674-b681-08deb0458a82
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:43:05.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT2SU2ROSuSgYnapmHNT24kkewXGaXqzQmZ48cQ7vwDOXVQgajU+6pFz1acY9ty2ItGJtPAoQZLapMbOO/P7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_174309_525576_3FF9BA65 
X-CRM114-Status: GOOD (  11.55  )
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

Use the new dmaengine_prep_config_single_safe() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_config_single_safe() performs the configuration and
preparation atomically and the mutex can be removed.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/nvme/target/pci-epf.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2afe8f4d0e46104a1b3c98db3905cf33e8c9e011..04d8f48d6950349ca97d2dbeae4e38e4714ad0d4 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		return -EINVAL;
 	}
 
-	mutex_lock(lock);
-
 	dma_dev = dmaengine_get_dma_device(chan);
 	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
 	ret = dma_mapping_error(dma_dev, dma_addr);
 	if (ret)
-		goto unlock;
-
-	ret = dmaengine_slave_config(chan, &sconf);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto unmap;
-	}
+		return ret;
 
-	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
-					   sconf.direction, DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
+						 sconf.direction,
+						 DMA_CTRL_ACK, &sconf);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 
-unlock:
-	mutex_unlock(lock);
-
 	return ret;
 }
 

-- 
2.43.0


