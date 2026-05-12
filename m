Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD70CCD4F24
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=; b=xufhxRNGVXmsezKPIQgi6ANTYR
	RvwDhpN9OkT2Dj7+7LTY4reufdiRbAGjmfdxQxN9NYO9tA4rVZNEus7H0UXAIHpCUWFxBpbPpAnfD
	m0N0AI0vRxz4Uo9IqZWNdumpAWY8RbghqzU3I1Kr6qM56ekL5ZvGfD2UhzwwiazstGK1uUPTSmOI5
	V2sI8mkIeZKEJODikvDFN5XUX5ZRVGE2uqBphGO+M+CmcRtvWIIRkO9fv/TCYVXldgoJCqte4pRjd
	KVwWc9vXR1KIzJrjBUxynHM9qOwqc74ZgAOmXmhd3RJ7eNcMBuQgp+X3aZWZwlwiaFeA4byDq2hWo
	HCSe78ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqBz-0000000HP02-0Ox4;
	Tue, 12 May 2026 16:42:47 +0000
Received: from mail-northeuropeazon11011011.outbound.protection.outlook.com ([52.101.65.11] helo=DU2PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMqBx-0000000HOxQ-0yaU;
	Tue, 12 May 2026 16:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvTfVI9arwI1EDhgi6pIviWw/hJeMUpqFiv6UarY6vCvvNNeJ1AMhefdkOwG8ED2FYth4j7bszfLQMwRoN55mx/9dnC2kBA6vm7kimEMS7q/y7JqNEmvXyA0DrdOGbBiiEe03jECv4Mh/s+2MHfYlv9zRakhyGD7nynI/xi4jLdxPU5zzKOEhug2yEFUYJagvZs2RjdCwh21fho9mxiWdKfKhdQmhi7e8A33SbdVVB9qH0Utr1EnTnQ10F+NamjNFyKRY4z8dtXcIS858ka+YIF1fHjZSSEx6NV3fpkZfUVT0HC+KTdDE7npnX03PGCoit/rz9fuN3u9mDRgVgw2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=vRrgI+DGCHnzKXT65F+rndNuEZwEHDuDGHtoIGwwwhACPXR0tkB3cNfh8fGAd1wVraZfzXm33ryJW/PRTrlTwqJ8uKoux83Vsh0OJJqEvSnIE0fDKFdfBgVNCJO5aKTPuf/vk8OJZ+69jiU9pVQs3VsctEUVEoZMzHzcgJIWdkU3U4Q6qb2ScCmEsssTXPuse4avhhoncBH25zg2o+3VmLQ0wjwvzZi9XJX96YqkQ7PYCuCd/WUByirZ79Rw2mCBWxabsrwlOCbWEZhL0KbryKg+Bv13q4XoJhfzMP02G3vvXscw46plPwzpoilNKcV+aGfLbAMM5eIcjYcSwPoZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=Q92zoi5xKjPo+GfHWQppO1sA/WWzLBF0sNPS5gMmOHAHGm2zm8zMU2IgmcXQY8yF7HKenRSJ49kDaLj5uJkONHjjKe6/IzyW3kJhUDlsCsiebb/OAYAp/EDz9MgR0nQoycG7JGu3ne7ofQuC5paXrEd6YPy9nrEBMJNTJ5OhgDaE5rWvXWztlqOSeamLYueYxG98A5Dhd7TFcbjoM32abPk4yzzDpVm7b+rU9qkxrmZW5aSUin6YvNxdvgYZPbabC1chVBgM3fM3wJY5b+BDHsKZco5MBkkImqk0cZaFEuCb/ciM99lTuseT2H+5L2uPUqHlLiYDT2b62NavDE8glQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 16:42:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 16:42:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 12 May 2026 12:42:01 -0400
Subject: [PATCH v5 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-dma_prep_config-v5-3-26865bf7d935@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778604135; l=1293;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5Ht3OpV64qQBJF72UE+o9BDFv/FIRBIdPMczb03BKkU=;
 b=pe6cig6xcQzt01HDBZpbt8ocLepQ9e+SUWFEAUke2+yg5utMfwhYnuWSI6zLPb7ot5ipQyr9T
 d0zNL6+Ced3A97y+QmBGUtf0aazVQwhwOFDI2Z/MMpfTaUItNOESDkc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffc2656-ba54-4058-6b9c-08deb0457b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|11063799003|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: I0otguAMgN0ca+rrbSkfEbDcde1dZ4AGNUZNVx0/pAT8sjBb36pB0cxwNOKEVpmTsjrdcnPWeQoNly9UuOMPE+wIO+iwgvPv3/O1RHhwZbSiYvtzb0dm1IEqUcgaaO1mvNcStOziVnJIYLbAWVHj/pfZ3zBTx2O3Gm48Yw883MSYTGI4BFcFJSIUPYXDWGAPPG9IjHQqMWb0LtqIjoYfftWyNXjv8web7OX8bAhM3YGyZvVkI/pVvz1FKt9rdzFO7ByjWW6b5B7WzOEyX3eMjN51yI7gSt1oZwi4UBZX/KlvyZljLP3vnww/qWcvcO9KFWAboSiRx7tOPixwYqfqjCTaXpC+EQePfxzn7fDFXLbiKti4kChU037aRkaxm1sZV/IVF02NfmCw+JW4ZycnE53UpZTtaSCNdQ/a6fEce4J+Yb/5318IIWt9kEUCCmcoYGhtFKkSTuBQI+knkdJlx/Un17BtxSd+uXih86hLy8DoULD6wbI8cdQaQyD6pygLHB0oqNJ/SO1c2AvHXpantFA2hJBJhAO6mNNq3u7lBTb/Q4TXUAX0dr+BS+ul6R8ncsRjmScT+LMgeIVHF6DumIvqyHy3pv2p/voCtm14u1z6GibjnNMhFlMTKIKkMwnxlujWobymUfcCAn2ZCt8NR1avF+43IgkJKjD80enT6G7ntSPhVQpv7upvuvAgFd5eY5rJRq2dxchhkHry6GS5BOxSqTET3eONkQkKgy4+zwmAnEtru9COOEfJSylByN/Tu1xsnCF5irHI070XtDi2Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pVMzdiQTBoV0QwTG9DZkR4M3FpY0VOUXJTbW1OM2xrYVNxWEJsZWplUmVH?=
 =?utf-8?B?SVY5NGZ5cjNhb25uSlA0alFwQ1NRaXljNjQxOGp6aG9rc3RWVEgrTzdCYmZz?=
 =?utf-8?B?QkRpdFdVUnNvYnJORDViZ1VDK1dva0QxamxUOVJpOXpGSyszM1MxanpmTnRw?=
 =?utf-8?B?SXBCcU53bGJnR3VhR3ZwajZRMy9LSXNYSlgyTFNWYUV4Qk5sd3hxR0ZrMjF6?=
 =?utf-8?B?elRzaWNaR3VUa282QzlNdXRwR1NQVkhwemoxK3U1bmlVWTFycGRhTGo2YnBv?=
 =?utf-8?B?aTExRlZWamxNdW5jNGJUUkkrcyt1Tks0UDJIc255UUdrL2xNeWpEd3pBNFVZ?=
 =?utf-8?B?ODB1L01rbHdtUHNvU09PNHMxaHlRaTEvcHNMZjRtZjBHbyt2SDdZODA4Smt1?=
 =?utf-8?B?YzdCTVR0VTdrSlBvcVgrZEk5YjhvbWhSdFhkL0p1bHJHaytnREptMXF3Z3lV?=
 =?utf-8?B?dytFdGhKVWhOSzk5dDdZNHl4YXYvZWFZYmJSM3JGcXQ0VHM0dGg1ZzVkUWJz?=
 =?utf-8?B?OUpmeUdHSEtqdmlCeWY0WnlzaDFGMXVOMmJQallZQytBS3dWMmxhd3lLd2FF?=
 =?utf-8?B?c2NMb0tZZGlJNnh1QVUwTHpXNlY4VnFGeUFBTVdEdGJnTldWWUJYbUtOOEdz?=
 =?utf-8?B?MzFjOFlITmhYN0JKT1VaTjBPdGREVEVVcjE1dmRBSkVqRVNuUlA5WVQ1SlRy?=
 =?utf-8?B?QjQvWWh1S0pub3o0YVByR1FHTUNnazZGTHl1c2tBa1IrcWNjeVFZTGVqdUdN?=
 =?utf-8?B?SlNFdGQvZUZxNUphNnBEWVZhMVlLM2lqUU8ycmR0WlFhUW9jRUJ1NENjQVFN?=
 =?utf-8?B?RzUzY0YrSHhSZmRvQUZJSGk1MWZTSnYvYVFVWUNhQ2ZKWUhzRDRSbzFRN2xp?=
 =?utf-8?B?MWVEcm1sMjVvREloeXZ5ZjZjU01uRVBidjh2a2pybGdmYmFIVldidzRTSmdY?=
 =?utf-8?B?aTBkQm9rU0xJQmF0bGE3OGRSdGZBUDc0Q1V2bVk5cDQybG53cnFvMEp1U0tn?=
 =?utf-8?B?a1JYWFBCdzBlMGptaWh1YWlMUG1VTHYrZTVKc1RNdnM2STNkVWNDMkI1U05N?=
 =?utf-8?B?akxYRzFTZzY3SzA2NWFYeUp4ZER4b3hHSDEyaUl0ZWlnempncTZOVEIxMHQv?=
 =?utf-8?B?WDhCUklRcXlQQmNiTktQRlVHSE56R1p6SDAzTVhTRWpSd3hYSGxZQTh2ZzVm?=
 =?utf-8?B?elN2QVYzdEhLMmFYeXVmWnRhUVlBSjZLMi82RG9CU2tWV2YzQ0VmcStUaTBo?=
 =?utf-8?B?a0ZxUytseWJMb0EyZklqeUhWekJJUlltK0JkbldhaGw1MkdWRG5ja1JSTTVB?=
 =?utf-8?B?YUNsU3BUbytZOXNyd0lDUVd3QXprS3B0NHVYOG1PQzVlQVJzRE13VmlsNnFQ?=
 =?utf-8?B?NmhhZWtYWnpiR0crMnNVOWtPeTE1cW1hZlMzOXl6Umlwc2J2MlBrMnhSUDMw?=
 =?utf-8?B?VGk2eU43RWJJd2EvQ0o0SEZPazJTWEEvelBJU0dRdUZaclJSS3ByQnFWVmpz?=
 =?utf-8?B?ZWF0MEsvTXI5MS93bW8rdFhjUHhJZVh2VTFzbldLcWtRQksvZHowQTJ4OHVt?=
 =?utf-8?B?Z3o1RDNGMmFVdG9taFVkZVpBQU1uNndmUW1Ba0d1bWlmVnh5dUtnZkdjaFFE?=
 =?utf-8?B?NHkxOXlBTk85LzV3aFhQa21hVWZ3am9tNjltY1FwZWZsNlJ0c2pWR2ZZS0Fq?=
 =?utf-8?B?ZFRRdit4Ri9hZ0tzelI1a0FIekZjUERrZmlCUWlmbmJFcGw2NzFDNHNRcE1m?=
 =?utf-8?B?RjZUME80NlA2KzVRNkpCUnk4Tm9id3Jic0ZidlR1UStOSmYwUnN3UmpzUlBq?=
 =?utf-8?B?VWhGQTdmelZKOEVnRjdKL280TG5HRkVicFFVakdlY0lMeUpoaURaZFliUHpE?=
 =?utf-8?B?UzBUYkNLTHdMSlJKakZKR2ZUNUdmK0dwUDUzUnYwb20rU01vZTRCQm1BSENQ?=
 =?utf-8?B?Tk5MbWpVQVlOQUVTeVpRRk5xQ2VVVmY1VzlZY0FvUVErKytKTjE1Y3lrZXdu?=
 =?utf-8?B?ZDJPNC82SVBOQk0zYlNrNFRrNktDN2pwb3hNeEtRSllKbkoxZ2tZQi90c2o1?=
 =?utf-8?B?Riszd09BSjIwRk9Yc3BKU1lZL0FDeUlIOVNBVlllcWRBSUw0UWRBS091am8w?=
 =?utf-8?B?YUNqK01RMDVuY05TdlFObVBCdmZYVDB4OUlOUW80dXhNTWhkSFJ1K09SSEVY?=
 =?utf-8?B?RXc1OXgxQkZFZ2c2SXkvZGYyQjFIaTVLbmN4QzFmN01GTzY3N2JYcytxZFla?=
 =?utf-8?B?L1RiRCs0T2hPa3B0MURWWk9DZlI0bThwb1hYbkFVK1hQRENaV3Fsc2ptUExn?=
 =?utf-8?B?SmJEZU9raHdLL1NYNnBDVVFuR2xCRE10R280a3pwMzh6dU8wazRBUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffc2656-ba54-4058-6b9c-08deb0457b87
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:42:40.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNi97MvDAJCHS6aRyl3NMVyxcbUjOSFLLABbV6F+L2JOEqA1uwH2TI2Z+MB9co07sv5+pvKWbH2nXaJf7Gl3PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_094245_281571_9B39FDF2 
X-CRM114-Status: GOOD (  11.28  )
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 591d301fa89d89addf5df16e775e80460b689589..0f5cf2d7951088af3801ea1cc240b2ea8627eed5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -182,12 +182,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
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
2.43.0


