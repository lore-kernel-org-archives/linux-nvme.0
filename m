Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42801C43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=; b=Lb/HTxrTvnSCSHFpB+QGdQZVAT
	aRvuS/5LQtQFio2Elwa7b79JLTm1KKtFcSasIPzvDVgEGBjlkMEvNqL0MsEQTiPL6lfcbgQlWtqOD
	HGVhV4FTxD99mpNIxz7dZYmyAaIa9LvAPr51m7e1iwR/YqF9zxyQ/27Q+GzaM2/cdd2crmnF2XxDn
	dh2RB5HsTUBy8BE/e+pNgh+/EkVgjWiNGf3J6C7qlsyxGr8qwUnWJCHSIjxE3aJWs/YECKfctAjxw
	gaOwoOlqjDW+0UAtMkHpM3v0P32YzUEhSAtmSluZacjsUrA3b3OX+YRic3I+Z816ppwLtzokwsKBc
	x3GmGVuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiEOk-00000005Mu6-2Dt4;
	Fri, 10 Jul 2026 16:48:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiEOj-00000005Mrh-1LMI
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 Jul 2026 16:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=; b=VxBNeOfPivj3iQWMnxLcW/Wan5
	sLo2/KlchftlowVnJDKtIWKzyLJcFPLs6iNXZA3H4k4obJofgIzAk0QYcYr5ody+zLvnbl73AAj1n
	juEcG3/LtC4hCMfBJugamt+31fiBtbOgjk3D+XgU55yB+7kYDr5ALcXE9CLnIIbHlLiwFbp8UfbaY
	ybUqnNojALE54zXszW1Ekyt2v7qLUlAme606MH5TXXRcWd9shYSs4CQUGVmeFjtGhLB2V9IgpS2tC
	0pPxBSKh5cNvz+gDAWV5LSrT/ypZRiNCYifRNPfywLNy43usfLTprzwiqln+w+ogHAr8n6ad/1vZH
	x3Tjg5cQ==;
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wiEOg-0000000AAye-1cWc
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 16:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/9YoAOu3api5+MMTfPZ7pbAnepdxzS7ZZbQsDVCcDtjPi4kUz1mOD49auWCrMZpnCM8UxftNy9PO4L8lOn9v/dPy06NbrWCLefz+0uh8pUNjdFhskcf0lJRFey84OyCrRrXF11OVuF1u/EZRKqbn215QN9VSgSQs255YsLFBAfsWLXErMHSx9MWgtfnoSmM00kX5bv5cbY1UzDRkSpdb8GSRJGbeolohyUKqQWrc1DKDVaDW76eQaJJabUvq04qJo9LobmYnw0W4vB26adkLyE6IOftPoeGiSYhGCGo82w8MV6fNp08/bNIQuXd7QENWBKHyfOEIaIhqFnnl5DVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=BSk0hFex1h1ob7f9JC/QHVDVc0nwiCgN4kCdOIWU+mnwiLv/X6ppBx3plXvizb2RbzK19FDKxaZS4CQWnen5+NngWcZ5Ibge8CJuHuxwmsXofDV6SjcOmad701xpdjLrOyiHnWtU+a3kN3x7lpqHfsQ9Znsmtk4JG8YV9zFy2t1O9QdnCg6MWRjuM7UbepIYQkVX3nZfU9xWnJGSVmpI6eWw4BguiI8pZIYsVoL/fSIw+jhWYK1cJp99MQPHVi+IC6bOFMSzlblsjgOwkMSc9PvDYnUHusxUVFUO1gPeLHXMQ3fOQJkkTePrvFm9c2lSlag7dtIV5QQF7OwSC8AwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=sgv3LbgP8I03XbF3haVy0vJxLlgLserDHf8jtTSIkiIow4nT1NnPzg1nIZzBt5Kj9/d4jw90yORGeLhhYAgcaPQ+JX8lBWMfugiEY0yFkUiSj1iDtTjc8BSKQ8ul1ltRPmVn9CiHGlKKx26mD0ojaHM50SF0AxitdVQMP5KYC4fW6lyJfLFdfTqqIKcUNnfImx0ysj58eshgODyDCh2HOb0UVW6H0sFslAUHpiuxM27noa19o2D8EwfGsVAtVjzYhSV321EfCEG2IKy0AcLNdWh/Fj3/grKlSbChNx1syRlPCZeFPmiZhkzrEENDb1y7S0SG7VNJWI5AIvVzwNWqSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:13 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:46 -0400
Subject: [PATCH v6 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-4-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702066; l=6919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ErdapcPMmXhUaz/yq+JBAR/2OB2luFQ/CFcEy+/xZuA=;
 b=Ga/7h9VoMqTqOD5mKeCkJacLfKxnP9oo5LpKTz21qXHhpOIPvOsRTiYGb7unQPyXPXEO5G16v
 QRv26/H1xu6D/cY0G8rdDKElwjHWoz3uqxF4rRy6lpmm1f9vWfIPlkJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad0ebf5-2c6e-4093-e49c-08dedea30857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5OfhnsJsnG8xHFWT/Wf9KBTsctFVb3XADn0HN67Wl+X4eL0R1Q2HqUmE/h9k+a0Jd6SGYKLpENGaLqAcdiM1AIJ6Xhe50VlgK/ISmtw2WW032in+dKZsA5INCYXiYKe2nyO37BuOt2BVJvBMPNyldEu8ie/F/G7bMuZO9+Oz5FrN0PV5/JZrNiJCvs1h1gQ7SE+USl8pJqC7ib2QofwDZOfc+m15Ow8C+RORU3bNEounAoNDc3SCaIGUn7liKXo71EUVjByXw0MuEoW7HfZIblaOP4nrbg36hGt3Lz36EJT7X9HxHgCB3IAGdi7m9mCCJfzIIsK8qeG2jB+tZA+srfCLXn1kny9Mfum2LjRo4PMW9L0wCB5l2e4ckF7xtebJsDAK0RFDXlPutPVHGAWhGvwtzx3+RTQpSlnRELpdpJ+auNPxMhM1cXEk5/HelUimOnG5adWGRU8pD4ugMrMQZt9Xba5SU3P/wGlLvUsQXLAaOP2DkZJNmJB/CDTI9xPT+THcMXRazC5Qk0UVYVtkjXD15KsrluwOZockFte6IrV0Bel9kXYot3i1wzfwtp3bqMds4vrxgkx2FTq4zRhxQYvrXDOIjhnuQ2daAoUjtCNLLiUKs2qKPWkAALazcZcUgypujZ2e3cq1HK4Y+EgQRrSmxkbDQsCLo1C/OOTKyI2ZrdpmlBb8DT9qo/bXk6KvawXn1P+HmpDBsMoankSVtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU8vejV6Zi9Sanpsb2dQNUdTWHByc2hSb2hzajhQNXBxNWQwMnMzUHYzeUt1?=
 =?utf-8?B?aXdjL0dOT2k1a0E3K0Nnd0JLOFp3VHVFZ2ZQY3c1ZUIwMHVoTm8zc0gvR0g4?=
 =?utf-8?B?QWtzbncyWFd3Tks5K1dLTWFacWpYV1BUMTdQVjF3TXFkeTJxaEhIRGRHM0ww?=
 =?utf-8?B?anV0OHB3ZWFiNTFvckJQVWlKMm5IeWlBSU11SmN4akV1c294THJtdzdSSWt1?=
 =?utf-8?B?TmRpUU5GZWs0QnQvSkV3VUtMZzVqa1BRNzF1VGs5OXpSZ0hWNFhsSmNWc0Y4?=
 =?utf-8?B?SmIvdkVCUzE5Q041MUNwSE03TGRTcEVYT3daYjBMU0R2alh0RGRYVjErb3Bl?=
 =?utf-8?B?MWFOVzhFT29UdzNFeklNU0FFdUdsMUhnQ2NWUjZXWmlSVVAxUWlMNTdCbGk3?=
 =?utf-8?B?MEhhcHF2M1piUVZNNUI1aXQ0V1pTcHptNStxWkJFeDNtcFF3WGpzNHltK3Ew?=
 =?utf-8?B?QzEvWS9XVUF4SXkzS0ZPaitXQ09HQzdwMER0RzVva1B1L1pjMFJPTFkxa3hF?=
 =?utf-8?B?YTNtNEJOcmpUcG94YWtxbUpFSFNpcm1DUkpyRzdQeEFWRExDZ3g4alRpdG5D?=
 =?utf-8?B?eGFOTEFwUDRpb1cyOHcwWWF3ZXR2eW55NXVjUjJoWG1FSlgrSHdUazdWemFO?=
 =?utf-8?B?RksvbGdMZnROWDVjNi9mSk5mZ1IwZ0Z2Rjl4bXlJd2g5YWpad00vcjdmUlhG?=
 =?utf-8?B?K0YrQUFVNFJtZldLZmNNS3diMkh2N1FPbldCMmxnWW9GTGNxQnRmd3RvK3hY?=
 =?utf-8?B?bm5OK3dpQ29SQUt4ZEhlUUN0QXlwVDNjdWZYWkJHMS80YlVZZDdMNzRGL0N5?=
 =?utf-8?B?Y2JCN0plN0NtdU5oMDZhR0h6VWJod3lheDQ3OXI2ZGZUNjNkZ1RoVDJCR2Fs?=
 =?utf-8?B?M0RMeWlMM3dXRm95VkVZMlZ3NzRia0JwbE1jaFJTTFU0NlVpSk10SGFVdEVO?=
 =?utf-8?B?YmE3RUhZcmozSHZVMlJWd1dHcjFqZkNJNnV6bnBnelBNMGcxYUZIcDNuUUh5?=
 =?utf-8?B?akowNkJkcHBWeVZtd1BYOFNDRWtTSHZHa2pFQWttOFluNVJGa3Q0bFlmSjVJ?=
 =?utf-8?B?OGFGRmo0Sy85RUlZZFQ2bWprUHFCZWVDcHEvSFZtNkwyN05xcTFqOHRMSjJF?=
 =?utf-8?B?c1VwZGIxVUE4Y1dYb0JmcGlyTUZxQjBuOXBqbTFkODZRc2N5NEhsMUpWb0Zo?=
 =?utf-8?B?OWRhRXBwVE5WUUMxbzNPSWdLS0JiSTdpNmJyKzlSNUJScVB1VjZvZEFXYlNN?=
 =?utf-8?B?MmIyNVhrcXpKdnZSUlNaWE1JcTBBa0VTb3pLQnBEdkNFZ1VXVll3bURRY2pj?=
 =?utf-8?B?RXU2ZW94dlIwS2NGR1cyV3Z6OGh5SDAxSHhqR0pqY2w4WkRvQ1h5NitNQ2dN?=
 =?utf-8?B?aEFSYlZ1WUJtekc3bmQ2d1Btc2N4L05HbS9mb2tqd1VXaFZFZEcveWZYM1Ay?=
 =?utf-8?B?UmZKdi84OENvVXJEYngwcXlPbzBqOEpFMWUyT2svTUtGajBHOTBOMExmNlRp?=
 =?utf-8?B?c05pRE9PL044NXY0U2RYcnpGTDRnbXhIcXFFZWFDOEZlYXJCclFuUVBFdVYv?=
 =?utf-8?B?NW5jdCt1RWxiSkhsT2V6cmFYK1NuZlQ5TUdUYWdvb2RDQitWY2lwbHhDT1RP?=
 =?utf-8?B?UkhBcjFPWjYxKy9iaEJKc2ZPdFJ0Q3JqYXpLRGxpWnRSbElRbDRJVUFTdHpU?=
 =?utf-8?B?b0RGdEMvQ3k3NjA1T00yamhMSnV2NUlFb2ZhVGNzdnArMTdERGxDUUNLVWl4?=
 =?utf-8?B?Ly9TT3hQTG9tc1VVSFg2bkExZDNtRWxXc28vbFNqWFJJSVVRVlBDSXY0UjN3?=
 =?utf-8?B?VWlIaFB5dGpWeHdaZDBtK1lDM1VmRVF2L2d0a3M1K3NqcURObmNReXduaU9O?=
 =?utf-8?B?cWpzUlpvRUF0MWxkMHJUWi9jQmp0Z081aS8ySjM1MVZRYXZTMzVrbE9wbkU2?=
 =?utf-8?B?NTBwRVdBZDM1YmxsR1VTZXQ1b0V1QWMwMjNTbnNGSmFISDJreFZKMUMwd3F3?=
 =?utf-8?B?ampvYnYraVZRSUFMN1NORXg2djVwYnRuWWwvdlZid0FXVjJTRm1kdnhkazEx?=
 =?utf-8?B?cmlkRmhCKyswQStYa1Q2TkszcE1LZ3FibEpEKzB0UWQ2VThKeDEzWEFLVlhX?=
 =?utf-8?B?SHdzWS9xMVgvMUxLN2lGNEVmSjdnOHFqaFJCZ1lWZUF4VjdKL1VxK2VlN2VR?=
 =?utf-8?B?OFZYSDFzQk5Oa3c0MlZiYWMvVmYzQmRoQlF5MkR5MmpETTZSMFJwTFJuR3NF?=
 =?utf-8?B?U0VUOU0rcnpacEJibDdZemg4YVB6eWVpVnBXR09JRXJPT3dMNkV2cDkwcFpT?=
 =?utf-8?B?OHlpa3drbmhLNmJrek1oQzhmNU1VYlkrUWhtWU95cG5paGxZRUpLZ29zV0gz?=
 =?utf-8?Q?9Dvl+VSsBfQJPVZktZq8o2ZpMQPy3wj9VBb+y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad0ebf5-2c6e-4093-e49c-08dedea30857
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:13.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8LLykGFhB4zVIlBB1R/p2/Yuc6l4sclEHaH06WZHmXJONl9+v/QrX+nXu7CZJPRF/7o5izm+5aVItzn6D/FC4WzuRnJ28Mo4uBk8JyEyXgH+lTts2oL87JfYnDnrgO1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_174818_689912_5C488E77 
X-CRM114-Status: GOOD (  10.93  )
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

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51e50f1fdcac4..c341aa5343417 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 20089d57f8ab0..156b1cc225091 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.43.0


