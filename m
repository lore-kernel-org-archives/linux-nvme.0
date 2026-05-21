Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA99CD5BAF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qtGtmbxs22Dn6Sqp5hULlAlSENMMX8OuHSRQ3W0Zyq4=; b=bodKN2cOw3SYjVyYpEVo6ndE2w
	65T6xLKzgO3LdWvvHFTc1qTFXxD2r/crkVOCgU+T29e6vvMFQCf07+2YU4mEJDHYPW04TzKlmghnL
	Urk16JHrrSv4M9lajUakuQCkBoV2LPa3m6b1i6uBFlx+qEwV2dgUB/nyv/0iQywd5UTV30RWDEHgP
	6Dq795Y5EgHa9cXZKdXWNHKcQLGd4ffJ61Uz5DfHNkbyH5z9g1C1P/BGziKowoHIv7EACU1b1cicK
	88WAf4r8YIafo+d5UBSBOCV1VxkB6tbycNg5m/oJCK8zqyMoW++rhvIQOruf1WG5l9NxBpk+0Nim1
	/ZTDPb/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5Op-00000008K8L-1Ib7;
	Thu, 21 May 2026 15:33:27 +0000
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5Om-00000008K3N-1yTT;
	Thu, 21 May 2026 15:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnqUKJ9cGvAniOTButpx3kTWHwnmekE0ua7x0IR6pznZaRrgknoQ4eScR/qFe6sOo93otBZhQAd1rLabTIOVg7ofl0v6pjeNKQnAS/IVQDWw6zGXB8KovLuLONjyT1SYOKQmkeo/SGZJ2BYw/05QPfOWFjTYOXvoanE3M6JyzPsbQIYX79saP3oQaqW6CV2wOxY4AteiQ6PopYicvHy/DpUQfFb0HPHGaMCxjwjFSWteWsh078Ls3/L3/8IyJ0GioEoqi0elT3sWizrDSluF357xc6tXxSZYCxlhMkrcFvkjMpS9Fig2hCUyFW+4lm/OnIGSoBn3WMb/KWi1YLcLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtGtmbxs22Dn6Sqp5hULlAlSENMMX8OuHSRQ3W0Zyq4=;
 b=JuCohh4di8hRqpGNUkd/2cMlpS8VxOY5MqjbyTmGdz1QDJyZJP8yiTaxAmm6gm9WveGCQexKHLsRoiC5xPw8RVvGfsG0hOY0JZZh3VrWV7oAqp9SM8iaVIg1hMJzSngz71AOc6PZmxBKWTLX2ESp0hJCGIsZASCJ6DqY6CavUTdXrQCBHgcjJ6aQyMK0dvMf9WwaRGWUW1gE8S6soQjv33OCrgn80pFIv1E7JQLHzfsNVRtRxy1tcooAmG6tp+R3W1Ebp7GizMJkbmcX+eX4lAZvCNyfKz09jel7cZo4WO92LQLiW8dBrLgeffmMoyoRzJD9Yi+EipUlljFKhWVdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtGtmbxs22Dn6Sqp5hULlAlSENMMX8OuHSRQ3W0Zyq4=;
 b=pG9N/7QKSLJ1bSYUCfVxCMJoyzlBOj0TPF4P7B3ZR+1YaLS/vdLilNsK0Q6XDl+Tauh1untbxzFih7XoFFOHoP3FU/J+ecBxuepWqEvDq/7qSPXywqzeWhjwWmK+GZLXO4A59pvfT6r4DYmBn6OjVelJFFLsft6oRLrqX7WG24mMPK1K2ksXH+j1cCm313FvY8ywNplPv1OluNSWoXHWxQP+dlG1GW2Y2BD/jZQu/blpyyxaufIEHe0wiaDv7u8XQPC98qaoHsRfAiROzCOOKygJU9dFz/+1gxR4o01pTFH4q44RgqPtO5JOyhGUS5ZsEoL22bqL22xhqCLIFMAhJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AMDPR04MB11581.eurprd04.prod.outlook.com (2603:10a6:20b:71d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 15:33:20 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:20 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:50 -0400
Subject: [PATCH v7 4/9] dmaengine: dw-edma: Use new
 .device_prep_config_sg() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-4-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=2281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0Ia3JYWUtUCQVv3nu0hL9dzhhqfNED3UBkrlVo7ppgA=;
 b=3YqmQRRqXPVmAv18nyfnCXiRJw7gD9nYLiDNdNAxDUEiz/mjVVTYHWOI6Qytf4oQ6MfHXOV7b
 ukj36Og3aZWBlPo+0pm25yoCm4r6edZ/G8Se3EToPG+78ZO/OCK+Vdk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AMDPR04MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: e9396a40-5717-4d4a-862b-08deb74e4959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|11063799006|6133799003|22082099003|56012099003|18002099003|11062099010|7136999003|921020;
X-Microsoft-Antispam-Message-Info: JSp/FaScSgZ2EA2qMPjG4CVGnLeB1Ky7mAkhZNDzzn86W1dKAj41+WREYhMEX3um/IdbM3yp8Nr3GJnLKERv3i3+NdCs3rCTEwffstTTSVPvCcA9l9fksxBSRys+/qi68uCOLFDWG0H3g+07Idi1P7/lcMAbb57Rcpr6KaqLr4IzW7wcHEwH1h53iX5MsQYmrRAEvci57RemrwWLsSy1N7yUWU2voUmlI2GxKV/SYfrggveUY9rg6ffsWsBWcA35mQ58XoGCKHvf7+yYRYTyusQXtK2jFh4Qh8MHc195Tcq+cakLnaboA034OBUU748VU/luxor3EmA3wkWfWtUD9HhXC1lcNAlKT7Oan1yLnbzf9uluqMgZZmj4UkcUfOj674/JMNoWKyTcOOUVKENmmtMBC3wU7RvA+2oze+7IuMNQ0HfJmzLC0CpB/9HhF6MGssHB7wbfidBPuO5l0YfhIASVJIglmrUUnN2FkI/RgvYeVKv2jfR+eE3AfyB0FvavYztU3unHMPI81b1+GIqd0zdnmhQr+GvokHf9WZWSPRrOdgL/qt+ESaF9x50zouQl/4WijEsi9bMtAsH42g1GSN50oYgMYRke61ucDwJozN7B0UDxxbXdIwncHgNc0hA7M2YgSt2BfX+H734843VjbYC3HJWOAPTM6npA+3C/FnMTP92+lgfI6yXxMhTD6CJfcbbAM0xxBDF90DV6iJhGdDQBCF2cJFt2JvFRhx440kY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003)(11062099010)(7136999003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy9VWEtiY3Q4SGxZdmYvOXo4OFMxNjltL0h5c2M2ekNrTjczalBwU09pUzZ4?=
 =?utf-8?B?ZEJ6cm5GSlRtNGRqejFzQVhhVXNxUDhKL1RMT0dEL1pYSzRlYjdlMk9LRjF1?=
 =?utf-8?B?RHBLcUwvWWMwKzFpd1NWOTUrZ3k3ZHVnZXlkMDl0c0ZSV2pSY2QweXJ5WHVF?=
 =?utf-8?B?RVRMY28rUmlrQ0ZaMDJHMEFuenZzNGRpQVd3eFFaL2JKdVQ5NlZYTFRTUVpj?=
 =?utf-8?B?aTBNSFZNeTZ4M29NQVFtMTZyQlJJYzRCQ2l2cUZBVkx4MEVlTVg2bHhEMnpL?=
 =?utf-8?B?cTVwdEV1SEdJQUFHbVZOT0ZYNVdXSk5WZDlVQ1FjdlRQVmh3bGNSNERaTHRw?=
 =?utf-8?B?Ui9wYW1KTjVrWjRBczQ1VEVscXJvTG14Unhyb0lLdUNZbkI2MGVUcUd2VkhI?=
 =?utf-8?B?bEhHUmhxWkF6M0FML1BPYzFiN2E2T1JZemRaclBIS2gzRys0N2h2Rk5renFn?=
 =?utf-8?B?UWtQWkk4djRNWFQ4RFhENXBvNUF6QXRYellDYW1lV0k2SGVaWmFpTllKN290?=
 =?utf-8?B?cmIzN0JIRXVDZzZXOFQzTldEZUVKQUFNUHZnUXowVUpCMXkxWE03MFZKU05E?=
 =?utf-8?B?V1U0NUkvYjNmNmUzQ0MwWklMWUlnQWt2b3lkTU1saWtUUnNFb25XZkhGY1JQ?=
 =?utf-8?B?cnJ2dlUrblVka2k5Y20vMzg5eE5JQmRaa0JQbk5YQkMrazVPMWNyNGFhZlBF?=
 =?utf-8?B?ZFhwRy9QQUlQTCtYbTJMMkw5SHg5QlJXYnZsZUw4Y2pPZ2Fra3JBOW1nRm1u?=
 =?utf-8?B?NXlBY1NacVhYL2JOWmJ4UTNPSTd1b094YWYzMUh2ZEdGMnlXYWlSQUZ4ME5D?=
 =?utf-8?B?eCtFOThFbmJUVmdqbUV4dHBld2pkeGM0SGIyT29OZUw5dHdDN0E0cExWTExu?=
 =?utf-8?B?WWFlQ0tKc2I5OUlpUXlCSDQraVdDMEYxd0JCVFo1VTV0VkJndXcvVWVMUjZL?=
 =?utf-8?B?cktZbVovaW1PTjBoelhFSnc2aGVmR0paMkVxblAwSFdZVThjZFJja0pKcDEw?=
 =?utf-8?B?YmN4MEFzMjZZZVp6Rjk3WkpMbm9qbXZ5S2xjUnZvZXVRdE1zeWQ5cXFmWkUw?=
 =?utf-8?B?VTc3N3FtWTZUeXNTRnBkNGh3ZWpyOTM2Y2NnYWQyNVp4ZnhlWkZUNEJpSkZm?=
 =?utf-8?B?akhHVFNvWHllbWwwbmZsQS9DWHZVQnROdUJIZzdPK0I1c1ppK0UzWkJaK3k3?=
 =?utf-8?B?NWlPdFNrY1RSS1VaSjU0RW5HQnJzeWVYTzl2NzQvQXFPa2xqaWFPNlJFN1dh?=
 =?utf-8?B?K1dLd1MxVVMwWjgxSWRyVUVnUXRibVB2eWtUSGFuMEFKdDFBRklxdmR2bEJJ?=
 =?utf-8?B?ckRjWXZ2WElmMjRZbWVQWlZpWTZtejZkNnJRNE1ORXg1SmJwTVRTdkdBKzc4?=
 =?utf-8?B?VE8zSTFqKzdLdGgwUDJiLzdrTGdXak9oMXVBcmdmT3ZxODlscmlQWVErMVI5?=
 =?utf-8?B?c1ZuWk1ZOXRaU1kyTmo2OFJCd29ZWEgyLzRzZmw4cEROWWNMTFdqS1k3MEhP?=
 =?utf-8?B?Um8zcDVXdWgwU0dhU0wwak1oMk5KZ0ZZdGcwMzQxdDNXc2dEUVM5N2VQZEM4?=
 =?utf-8?B?ZkZLcW9rZkZ5Q29md3BZSkFLQWFFOTNHZGd0MC9NSzRWUDlSSlJLaG5RZjNE?=
 =?utf-8?B?RE1paTlydmtnbWxqNDFVUk5ISFhFT0ZVMFNOQmlnNENnMnE1WVEyT1pqNkdp?=
 =?utf-8?B?akFIc0ZVVldZSlNiTVNYKzlrNnRvKzlYM0JMWW80SkJLb3RxUWZwZ213WGhI?=
 =?utf-8?B?NERHbC8zVHNiWklrcEtGNXFETFc3b1NPQTFQWnBXUVo1TXJrYXBMbWJaOEI5?=
 =?utf-8?B?KzloSHhOdUxSMFFtUGEwRGFNQUJuMk9TWnBIWFhXUGdDY2pFdUdyVkIvU0Vx?=
 =?utf-8?B?aTJtdzYvdjMyWW5WUkphZSswZk1XT0ZZbTdGMVZaMU1DdUMzRWFKNFI4N1c0?=
 =?utf-8?B?KzdRZ21lRG0xdEpraTN6Y1hhOWIzcXg3WCs5aURtOExieUw3Z3pOMkNTSUtk?=
 =?utf-8?B?UVZheElCeUllTzY5Mzdnc3FzQjQ1L2FIY0dyNlNLZDA3ZnYyeXloY0swTlRu?=
 =?utf-8?B?NC9LREV4WjkxUTI3cjM1ekl2aXVpTEdWUWRnNEhyajlxYW1qV0FlcTFVRDZ1?=
 =?utf-8?B?bXpPZlVkYWFSb1IxdFhvMnRQK0hxcFBieC9BZEJRRWY4SlVyK3kxWC83UkVm?=
 =?utf-8?B?L2I4N0tQWWRzeHBoRHpBZERoTm91emlMMGRBQzZQbnlOMERmVGovRUd3Wjhm?=
 =?utf-8?B?RzBxUlljbGp3YWo5STJOWUFjc3BDeGx2ZU4xWGdQUTg4ME9UTTNxYmZRZ1hO?=
 =?utf-8?B?OENiSHlVMDIrNDhrbU14Y0xkeUJIZjlEWVU5RzlMdmQ2WFhwRDJCUy96bzhC?=
 =?utf-8?Q?XxF/59MvZ6MZwuP6Vk6J9TNHmwr/+NIXc/G+B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9396a40-5717-4d4a-862b-08deb74e4959
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:20.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RldT9P8CvA8nNX0p+fAE0FdcINetJiBDKumaCz2zDFFYuHC1HQhuvO0YGmqlho2TKXsceWU8vxYNAlbFwWR+/EQ8Kh66YAz29TPczp7WJJrAkOhglT4CCPLn0NcLJKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_083324_504667_3E95C5E0 
X-CRM114-Status: GOOD (  11.80  )
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

Use the new .device_prep_config_sg() callback to combine configuration and
descriptor preparation.

No functional changes.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- check dw_edma_device_config() return value; find by sashiko AI.
change in v4
- drop context in callback.
change in v3
- add Damien Le Moal review tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79fa..92572dd8131e6 100644
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
 
+	if (config && dw_edma_device_config(dchan, config))
+		return NULL;
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


