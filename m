Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD49C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=41j4i2J8jTE8wl1mRck/rqqTuxk85pIUeCNvbJh71/s=; b=lEHUjg9DHBeX/Q50wxjmTxrNSV
	UzNjl+fQ2M84J2Iqs/zbRMbzFCZxtBaMJGjlh6JxJEACRF+fd4iFmIDd+WpIaidAznZpU8bzu/WFR
	pHaDdeqGWJyzJHuhuuqmSGPd9kR/lqtXkJhL7YL2z4H2nNb7ceEf3GALAzq+GEmAwvqCz5tKi7MKE
	vLrw8xIkgzbUU0rX2SwlOrs+dbhmrvSK30wGF2Y4NuIOIh3SJ2Ci/5e8KtHNM6rBkZiStR2BbAWpV
	XVHhmyZOids4RiYLWowzEOREECM1cHrWmlSTBWOvzEPPwCiXNmxAzPFCyyS6HlrSJ5kwaq0ZjK0j4
	1deM6bQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjK4j-0000000A3yO-0bDQ;
	Mon, 13 Jul 2026 17:04:13 +0000
Received: from mail-norwayeastazon11013071.outbound.protection.outlook.com ([40.107.159.71] helo=OSPPR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjK4d-0000000A3sS-48sI
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 17:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9Tjq5PFYPSy6bbv0aEgAKX9LbflncdfLL2IF9iRw5YvV7BLzTqBotka0kQ8MY8HBe68GVYB6XKqh6NXJY/g02/pLcBwwGKZ071IVUo0/NDmk8oYqvBxrHZ2KHhzm8YAFnE4i3AdqGUSAQIKIk9t209RoQBmlHpCd75HynAeWn5mT5vPl1Aw1MgWje+ZT/pasq9dELpIhTGsHQQ/6o0oWl7+cX6dEA7WAg3S+HCsQb+On6Z2GT8ChDuXLrFw5BYMGLTIKEU5IB1DaK6PXExh1Uh15pzBRCHx7vQ6DFtA/kle7AMx4HYow5QMbF/f3EWhbYlTEwvWTWHDm/1ZQcygTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41j4i2J8jTE8wl1mRck/rqqTuxk85pIUeCNvbJh71/s=;
 b=XQUs4UkYSNyVwET1zgKirwf+VCLssWuKeqA1NjMhhlxKwEVUA2VErXLSB1E4LL6equ3d+vkd5xWksyG6BrX4JNq6Re50nuFhjIaLBM46mRopXbDqUuwvxTZLUD9uxiDQ1PsD4Kpd4IQOKptBOpgvvSjwciK7iR0oAtqha4ydrRTr0ls+sVV2ieHmbgoA5MTqy9a7gIHauLctB3UTRPtLMabMlDMoU04r4yk19Py5d1wEIPBezDoOUMS7ej4dEiIanIlgPt96CC9J/R5DnYiEeajsoF1zUlVOQRPdNrT+HEhyOENYEhPAaynMz4xtwYGFQlj41RLlMilxFjx60ks6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41j4i2J8jTE8wl1mRck/rqqTuxk85pIUeCNvbJh71/s=;
 b=vw2d8nZYXJN9m3vFu7VxxFHPd+tgTlS4hs5N6Z3kIoPvnxTADBYSa73qkIAR/0QANeBA8bG/I/igYNkf3ezr/XRXEKaUsOfJmnt5LNEhKKFlXLEqR+CLcWR/wghTXVdd9Z/mQh1XsmAc2Ib5jznJAvYrMQUIvPB2V61TxilJvW/H6CkZ44UJVk9qAMO/PQ71xIWN2gP1WwLzUWC6zxmA3VXr6a7qao9wXV9316NUPgadGM1V1JrRXTftqs/8VtF8FbZp9E/rOz+XjuQmYDH0SYETxi1n3beZYDtrpg3SoRjcVlG65tgWsp+p8kYAn/5FR6qXIcjuJIT3jAhqUGnU/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:04:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:04:04 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:26 -0400
Subject: [PATCH v7 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-8-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=7835;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iEo6c3L0nFKwZa590SO8zR4RfzzxZwQtYzu3blwy25Q=;
 b=XY7XBWBflD600BYUH4f6lc5stqNFZ/Z4K/IALrw2Oi1xlvcgkO66VsKHgNE8iVtJ4qXDcAnl9
 vhYGictvd/uBqqPLhSCi3VlvsnUxenBwET/2ILHaZW4DEWpk2USrXml
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: c73dc6de-0bed-409d-8a75-08dee100be66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /P6Y57eWESxMmY4kljmNFquR8HhovDaGut/83R0Yjz4iokE5WIqzOlRHpdK+//Yjer4mHTPpM4UX/321OxHMqRJJRLQLDoox40x7SvJ5THsSOzeZ+J6Nb4hpLRhYxLNOk4h9PKSQiqzhWo5DDgPSMccNkXYUNBHTYIXQyGdrGFYjUBEg4ohlA2Zz5XNsbM6jxLD4kb11trIxFiJpCRl/qKUk8Tb2F5coc28T8W77F1hahsdd34CMuR2nOFEATOhqAvy0ve5VXHtAgNeFuezUSYPn64k29FiejE4hovJ0q/ti1iWEaKUmXU90r3+Yv5Ve+Qx479lmvnQaIx+AwlyAZeKbelP7od0NONnzAH8tBAZI1SGcoqgtiii0tyEW/Eljy3JXcQO6VlfKEHAAGInbIoWz69vzsEMAe8Fe225yfNd5vLSAOsjKLI2fQmjyjuOJp9FldAx+9GGkg4xbqAQ5U/URgBeua9zs81+qSJuSa/BDxovonzifA2CX+KjO3v4lJnRcrEH1LR5AgHE8o7/p9EbEABjFBJZ4JdN+2yPn7lJlaKo+pee8rGNxDmudb3i9mO1zlthFoRms7lWcia7Mm/TRZb/md+bPnsJ2rQFPPrA27XEqyfS9duTIn0XvvBmUIx02BdPvf7W1sjivBo+67A/fKb01n84jMv+aYOigdzovIVxLxndpgakmpWPhvK93PDVMPyDd4HZoWouLCtnA5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dBcnBsZTJIbVBQa0J3c2JoeHhTeTN5NXZXYVhwb1ZsWmpYQXE0ck1SSFVH?=
 =?utf-8?B?R1EvVStJY01sdEJVcVJZUWtNRWdoY05mWkp5NFROU3lQOEtIaFYzZDgxLzFW?=
 =?utf-8?B?bUNtMWd4M1k2dnFYM0tubGFaN3dSdFExaTVzSy9NZktzME5LSlZWSTIweE5Z?=
 =?utf-8?B?c2pjR1lFZ3d1ajFNeUJVZmRYdHpyejh0UDRBdC81V1BxMjNBcGhwTGkrNWor?=
 =?utf-8?B?QktpRFVQOSs1LzF2ZUNzRytXUklFd3JnL3dvYWg3WVhtNFZnRUJjZWhVMm9X?=
 =?utf-8?B?WFdKZXZwYjJrcFhoQ1NWcXBZSTlleTNrWFUxaUwxQkppdHRHZHpRQllvSW9B?=
 =?utf-8?B?aXR0VnlBV1QrdTFaR3Evb01kT3dXT0R4bGNENWpaRjJNTE56T0ZUNkZISVhL?=
 =?utf-8?B?TGlDdU5NOHo4eW5HZlpGd1crWkhxYVN0OEYzV1JCWjBhc014STEzL3laSmpU?=
 =?utf-8?B?aTNYblZNRmxRTjEvMUk3TUxCQTh1K2dZQStnOXFnaGo4clo4TDRXRG5pMUgv?=
 =?utf-8?B?eDlNVU10M2pDMGs5cXN3NUlEMjlaVnF6VFF4VldyVjcvODhJQnZxc1U5WEU4?=
 =?utf-8?B?Z0tyVU04Vy9WbGZJSGNtQ2NjQ0JrTiswWUJUaldFL2pmR2xYc3hBN0ZyRnR3?=
 =?utf-8?B?K3djQzEzVHRPenFxQWQyNmR0NStTZjkrcFpuMWJnM095MXM4ZEg5ak1Nanl1?=
 =?utf-8?B?akhRUDlJSStLU01WUWZuZkJ2OVdZd09Zc3MwMWp2TE5TTFlUTXlHRHR0dEZr?=
 =?utf-8?B?SVNxMGJmOEJtZldPQ3hFTm1BY05sdlZaTDZ1Z0tPL1lQOHFsd1JtWnRVS2tp?=
 =?utf-8?B?YXJ1Z25pNkNzc21GNUtaRmt0RWxsUzVVeDlHQzNwQzJJMHhGSFRDaDNnamc2?=
 =?utf-8?B?WlBSQ0RZQkV1T1Z6ZytIQWVOYWg5ZWhjQU0vUUkwYmRHK3kvSUFvSmIyb3gy?=
 =?utf-8?B?NVhpWjNMTHAyMEJaWlBWVVhrNEU3QU1Wa1FsQ0xZbEM2OUZjNEVWOTViWFY4?=
 =?utf-8?B?OFFFeHhpZU4renRHYVJEQ2lxOWpQQzZ2Z0dXcTVvYjFXSUNlTTFucGZzRktl?=
 =?utf-8?B?UVBpUE0rRmJ0Rng2UEU5Rkg2OWlmNjlBSitKb0luZXQvWndJRXNnSWJIMG5K?=
 =?utf-8?B?NVZQWXBoZC81RUc4VjlGVWdxUUhONS9Cay8xSUExTDA1ckk4M012OENGcW0z?=
 =?utf-8?B?Qm9BN0NuaU81cGgrWDNieVFESTFvSVpVVUlqTG4zVEk4aE1qd3BMNU1uODFv?=
 =?utf-8?B?cXE3Q0JPN0paUVVTNjNCUVNmT21BSldoTzlLYVo2YU52c0lkY3ZiT21RVG1k?=
 =?utf-8?B?K2JxSkxGd1ViM3BCYXpBYk1mS2tFb1hOblFoZnN2c3ZHQzBPQXUrOHF3SWsx?=
 =?utf-8?B?VHBwN003N2tDN0ZOU29pQ1htUTNSMlJtL1VnajdkcjhwYjdidEFESVlrdTNP?=
 =?utf-8?B?dm04dnZsQmFmNW5NZ3B4aitJbElRZUJBaFNwVzdpZXQyNUYzWG1VMzFEOFdU?=
 =?utf-8?B?SFJ0SlE3MDJpZytwbmRNREV1M1pZU2lNUW5nVVY0OTB2em14NGJoVTczN1lK?=
 =?utf-8?B?ZzQvOENkL0VLWHZycmlKMVBHNTY3ZDRIVmVWbXZYSWMxVzNlM25EeXE2ZHR1?=
 =?utf-8?B?ZE9kNkZGOGFFdWdBeE1ObGlSZUtxajdmNXNwc1g5Nk1JMStQL0I5bC9kZ0pk?=
 =?utf-8?B?VnNIaXZNZlZXTFpwckJFeG1BUVArZkpIVHpnS0tUMFdFN2ZzVkhwZzNZMmxY?=
 =?utf-8?B?aVZnSC9lZ0p0eG9DWHF1M0NjOXZyNjdSSWZsTXlaYndkVk1lUmFrblA5UjBz?=
 =?utf-8?B?SmxHcUNWVGwzR2lNem10RGhVYXNkNnJLUlZodjc2clpHeVRZcVBxUFBZR1Fl?=
 =?utf-8?B?Q0RPWXI0ckZNdVlnQVNaOGlaa0JrTVdETExNU3loQ0lTL2FHSnNVbXhPSGlQ?=
 =?utf-8?B?QlBERjRVelpNRVI3VE8zYXlVNTQ3OEk2TitudWwyZnpkeXlDMWxVOGpya1I2?=
 =?utf-8?B?ZTM0SmNRK0dyTlNiMTVJKzlqc2xoWG9kRjhOZXY5YW56YVc1Y1lZRVFxUkxP?=
 =?utf-8?B?eWVTYnBCQ29LR3hQa0l1UmZ2YTFORFdkZTFHYTVLcDBneDNuRzhLa25FZkY0?=
 =?utf-8?B?VTdHcjhXWThSMERORmJzWURXbTRHQmxvUWJsaTlNanZvT2lsVVd6QURQN25n?=
 =?utf-8?B?Q1VGNmh1d0Zrb1VsQUwzQ3M5aGw4OFExOWd5Q2cwL1hramkyTFVpQW1BVnBR?=
 =?utf-8?B?eUF4QjhDS3ljUGtXL1V1RjJWZW5hOThJdUpMeHdTZkFBNnBxUzVHK1RiMC9U?=
 =?utf-8?B?UG44TitUS1Avd2tzZ3NaWlg0NDFnNmhkSmR4NTVhZFlTM3FneGtoQ1R6OWNH?=
 =?utf-8?Q?5avhFcbsGCJiraRhWLddBUQ3SWWBmwhPsEBBb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73dc6de-0bed-409d-8a75-08dee100be66
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:04:04.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8cAlXHKz4bk7PiA8M75NfuwUt1JOHHe7ejYk3KYbypXEWmjJNRNlXILjuTGaoMM3keoI026qsmr3HM+0q/zyLP4/UL/K78oWSIjQteDdEp9KIyJSxEr/jC7XglOY9Mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_100408_228898_40F30CA1 
X-CRM114-Status: GOOD (  14.56  )
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

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect koichiro tag

change in v2
- use eDMA and HDMA
---
 drivers/dma/dw-edma/dw-edma-core.c    | 32 +++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    | 16 ------------
 drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 37 ---------------------------
 4 files changed, 30 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2652ad8e7a8f6..f52d9fd18e573 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -163,9 +163,37 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *child;
+	u32 i = 0;
+	int j;
+
+	if (chan->non_ll) {
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			chan->dw->core->non_ll_start(chunk->chan, child);
+		return;
+	}
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
+	}
+
+	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+
+	if (first)
+		dw_edma_core_ch_enable(chan);
+
+	dw_edma_core_ch_doorbell(chan);
+}
+
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return 0;
 
-	dw_edma_core_start(dw, child, !desc->xfer_sz);
+	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e18d6e827c2c9..27415f3a2d04b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -125,7 +125,6 @@ struct dw_edma_core_ops {
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
-	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
@@ -199,21 +198,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
 }
 
-static inline
-void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
-{
-	if (chunk->chan->non_ll) {
-		struct dw_edma_burst *child;
-
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			dw->core->non_ll_start(chunk->chan, child);
-	} else {
-		dw->core->start(chunk, first);
-	}
-}
-
 static inline
 void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c0746e5351410..7b4933c66f9f2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  upper_32_bits(chan->ll_region.paddr));
 }
 
-static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 control = 0, i = 0;
-	int j;
-
-	if (chunk->cb)
-		control = DW_EDMA_V0_CB;
-
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_EDMA_V0_RIE;
-		}
-
-		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-	}
-
-	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_EDMA_V0_CB;
-
-	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
-}
-
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_edma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_edma_v0_core_ch_enable(chan);
-
-	dw_edma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
-		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-}
-
 static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -581,7 +534,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
-	.start = dw_edma_v0_core_start,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 641a513bc52e7..4bf5a441afbfd 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,26 +222,6 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 }
 
-static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
-	u32 control = 0, i = 0;
-
-	if (chunk->cb)
-		control = DW_HDMA_V0_CB;
-
-	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-
-	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_HDMA_V0_CB;
-
-	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
-}
-
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -256,22 +236,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_hdma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_hdma_v0_core_ch_enable(chan);
-
-	dw_hdma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
-}
-
 static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
 					 struct dw_edma_burst *child)
 {
@@ -383,7 +347,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_ll_start,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,

-- 
2.43.0


