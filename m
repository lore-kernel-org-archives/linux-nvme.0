Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6C1C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTil+8xNqLIewzwvDORcBzICK5g7RqTNYQehSrRj61g=; b=tpC/nsSVrCSw+OTVGlmkaX6MI/
	o52uAXx6inO0j8euv0r/AaBUFDTP4bPhVEIL9QUOGMZgHpXqY0JHCMgTbRumk45zgk60y2n0xXsM4
	R5pXVzYVIbbcNUtR2U6JRy4rMDHw0wF+CfrtkgIRsdToVDUEH9KAKbk9Z95MfEWW5N/EaNGMzExtb
	cOFQsSyP4RIwQ2aVv9fRopLA+37cDNjexXsbC1+ePZdU7aXKtDd9/qM6FDo3s8SEkGaIiKLvd4yYz
	TYA8VdVov19e7nWliWGPlVlVV/id9G+2UHm0qB9Uyb2+kDmvtGfMX/Th9tu/hSOxZiRhtyRjMFQV9
	hCLfiaaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX7t-00000000BlN-1F4M;
	Wed, 08 Jul 2026 18:36:05 +0000
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX7p-00000000BgL-48yw
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 18:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuFeeI2nd8ytcnoUwG0SWG4MS4w1/9WG6Nv7AehTKBJo20zCfqU3KOy9z0fFTeg7ohIOhDLu1I3CfVDPEop4jLaa+kG6BfiasAduoYwNBZIeohGC5fp5eAhS0OUgmUuxMd1qo3rzaO0vbIy4fEuzbnmb3ERMbv8UnuQ7Ni3oPggBbjALUGmVYP4bTUuUL6BFz5004W+rJcYebCHttDlcDfON53leqWjuYb0nIrCmmSXltk+g7xfkf+zbVvr0ryB4K3EtNxseFm64k+jL0SG3euLOlqbMHJYSzxFGTQ2FXLK3tj9NNimKJ2jFTnPZyhuYFiz7jkKCsye4YKRWe1VUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTil+8xNqLIewzwvDORcBzICK5g7RqTNYQehSrRj61g=;
 b=p20DLOR2V+8PQoxaE+IYJCK8r7G+hikhuxZMmKMxV5zV5p+TIjaxa9nAvRG2bWiVjOxrR3TX5oMSmFp5KcdcgDjUeGp94AvVD0rGp9GE3PxKgSlcrBWjuVFOf9CxtS/lruIXrzfSkvu+YuJgiCk+vcxrq+pmjJFbsWeHQvqqxJN+XAl60DSR+wP1Q1z8EcRA5dYEH0pOX09Krm03ZMrg/YEpc8sy4Plx2pHBQgR0QaEWw7rCrysugBF4BHf6OGXPx3obK+jnQESvOtrWNU6MMn/fHyeE8gAVTamEXLo6yfuEcRKs5ZQqVtveahOqfaKi3mgQKIYRVrTyjUgRypLoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTil+8xNqLIewzwvDORcBzICK5g7RqTNYQehSrRj61g=;
 b=wIEA8BwKZj5Rp8e+HOlM6/kT3CsYQEUhVgufJI4zwZ5/jSoAY33Io7xoPo4fIweJjxKD559nHfm+Qi+1XW9H5vTqp9YhFyjSpo2Y28jL4yXVzXhwXh7MU3Xjc71wQdfyCL7AU71yW2GcouhrOvhuXiL0dDtvFH/5dNRxGYc3hi9X9MOIPvklOO9mKgXxPAMjvpx5RcgSMo5rCXGWwjeETug6SjN2U/u8ulDkmmiqyuWTGKzlMprGx5TFEvY23TeZtrw1FMJMQWnYXxezi05cBieWqu+1JTi3YivAQfmKPca5yM0ddbRiBpKpGgRYvxPcD5Nh+PHKKQh8B9ZfuKHylw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:58 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:10 -0400
Subject: [PATCH v4 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-edma_ll-v4-10-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=10259;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YRqAocW0qP2hltMHxZ3RUTaSv5Ync8DH/nO7wV195V4=;
 b=dw7uhC+qRQGBZh1Z0Wb2JdhAjKV6NtctdlsNubttL4u+IVHDIwfEAr3Sacv7a72fYWF3pMBuH
 M2qZ7SMp1PxAwafE7BBkrhSQW/KFdIDSyQxusccmS/eUow/Swdg/s+s
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:806:120::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f2fede-68c3-461c-449c-08dedd1fc085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: p1Ym3INiL5NNNVc1hKJfYaNkfTh4XTF3zxvqwm+bC8ctxjXNxonfFA4tjcAEYN99N7WRzWciAB5bWZoy5MHMket6hkHBGhzT1sv/+Z9TsCmRmtoptRk7UVeibutnig20sVBRK6ZHgimOC1P+Wnedp0QpzllJdSyKqjTGXnY/vIAYY71M20VSIxUP8ksJExd+aCspcpoPp5lpDcBnzoOzvp+M8kHidDX1TWQQctUaHEPUWDewS1inQUKWyYQh1f/sRrRfGpGefhlnO/WeLS4AswDPtTb0NTafTYuy2kP34UN5CURMJyMPbixshOI0j6bSx6EDiuIK0IGWQmKyWBTlumgLsb5JwQbUPNLvktoWItQcqj7kyVetq4oPLgM0CqqP8TdXdEgFL52MBx3D971Tz3IEHS/RnCVQ4Eu4gwEKJam/zrqrutTEx4vu76TncbBzI+74aS1YD/9suu0WHCiwBmtTxDrTYGD38Pm+ggY5erySNSI3NtAFKfxvZIqdJ1PhPANTx0A+sWZmAuX4cy/uRGxvN1Y+DAMeokBVME82rmSSfsAclSXcvXbloow/SP8h1w25Y8J7ZBtrGX/nSn6OwTnEERqufnLipeID8JeEeH/92hmbNfPVp2TDxHFypxmYu/LxIDBfJ2hM0XUH7ApuaT7x1sadnDsvreiMBTbNJ+xTizTm5YeY39+oQ2nnZMVYXc6wzoGo4GnFvTYmFHICDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBBUmlHK0QwS0tNMmJZaHUvSCtwNkdvbE1rOU92eFFIZWdyYWVJQld6R1lp?=
 =?utf-8?B?Nk1ac3I5STc2YVRqSFdhaUFJM2YyNnI0THN2YSsrOWpwRWxReWVsTDFJRlBz?=
 =?utf-8?B?RXQ2WHRQUnZ0YmtoM3ZNYmRvaGw3M3JhSy94NXpTZ0h2RWJoVFdlZWVoRmtR?=
 =?utf-8?B?OTFWT2FNUXJuQnRTNGFqY202NWt1MU04c0ZNUmR1Z0tCNXhpMnI0TS9zR0I5?=
 =?utf-8?B?MEtnbEt6NkZvL3k4Y3dDN1dNVmxtblhvRUR2ZGFyTjdpeEhjemFaSGIzRGVy?=
 =?utf-8?B?SngrWlVFMVltMXJuTmhvWnJaSm14enV5bnMxZGdaUlMrTStrSUhDR29JTXJF?=
 =?utf-8?B?dWNUdVdZWWNOMlYzaWlOZWJwbkx5cDlIUnNZaG43OVUva0J6RUhvb2hBK1dn?=
 =?utf-8?B?bFJoditzQnFYZWVHZEpFcFhOVWVRdm9hYTRyQjlha04zY1A5bitmaS9BVktz?=
 =?utf-8?B?elRtLzMvalNsYXRpL2p3RGxUOHJoZEcyYlROVS9yVm9lYjVQOGhUT2FPUk5r?=
 =?utf-8?B?RjFrdytsQno3Qm1RaW1ESTNTUWYzVHQzSFhjb0tXSjJYYUw2YVk2NEF4d0xH?=
 =?utf-8?B?Z2lERkZhZnFnWU5VSmc3RzRtcGI5SHlyOFlJblJJLytwbnB3bzNRNDFrUlFI?=
 =?utf-8?B?bXl3ZE5MU3NwR1BIdHRHc1B1Syt3TzBSK2lHNUJVSlRLL3JHWi9KTGZQSHdq?=
 =?utf-8?B?Y25kRk1FMXpQdDdJWkJFQUM2RzYrdDFnMnZuNjcwS014dFhHUXE5cjE0emVx?=
 =?utf-8?B?b0gxeVhScEpUTGZRNGdLdDJKbXJxY3N2THpEc1cxUVhGRHVsL0REQVJrQVZi?=
 =?utf-8?B?aWVsekF3L3ZhK1Z2TXl1Z3p4NHJqV1dTdGx2c0h2UGpZLytJZEpwbWE1OS84?=
 =?utf-8?B?ZkNqRlZLMmV3YUdPOFEzbGJQNjNCdXdSZnhablBBZHZCTmVCNWp4ejEyYThM?=
 =?utf-8?B?bGpnWTR2TjAzWUhkVnJBRHFTdGI1UE85dzlLb0hrWmQ3a1ROQ1BYdHk5Nm5a?=
 =?utf-8?B?cEhFeG96elcrTlhuWjRGRTNja1JPZDN3UE1UeDE4VFVFaGIxb3gwcERzNExC?=
 =?utf-8?B?T0F4WmpsUjNDR0tjWnBHTnpNclB5MHdiRmhCaDM1SmJFRCtrSGtCR3h1K1dK?=
 =?utf-8?B?WkthR2Y0L21GWllUZjR1MzlGUUhCQWF2TTl1VzlqQmhJS0FoRk5TZmNBbkFk?=
 =?utf-8?B?Q2s3L3hEZkdFZzV5RjlsMlc3Vmhac25vWVVMbGx0TDZzSmNRUjVRNHErbHlR?=
 =?utf-8?B?UmhJaDY0TUVUOUR3RFVwcDZvRFRZZ050bmUxZ1o4NGpYbmNVamQxeWdBTnlu?=
 =?utf-8?B?Nkg1dDl1bHdkbUs2UlBLbGIxaWxDSkkzY3VUdEVTaUZuajdYamowcTlsWFJv?=
 =?utf-8?B?TDFPNjNFRlhVckt5WXN1QzRrQUtFTUQzL280NGI2VHNZcDR0b3ZIZllLZHhJ?=
 =?utf-8?B?K2tsMkFiTWdEbC8xUjhnaW8wM3ZZWDR0SWlQZkJyK21haGRTeFlrNFZLQXU0?=
 =?utf-8?B?cHVYRVZnZ1g4MW5KSGlsK1VWNkN4Mlh6UEh4UVZJTCtVbXJFc2lqZ1RDWDcw?=
 =?utf-8?B?YjJiRDB1ZlB1ZW1GakduN3lEdUVmbEVSSlEyb2Voc3JWdnI2MGpHRXJPTThT?=
 =?utf-8?B?cm1peTBJc0twRk5ibE9TQWc1V0lhOGFiU2M4WW9pQW5SeDlRSUZOMXpNYUhT?=
 =?utf-8?B?d1JOcVR0ZHlCRzNaanNiQjhoUzg1U2ZiaVBlMlZyWllPOStHL1B2eGhqWlQr?=
 =?utf-8?B?TE5xbE9Pay8zMmxWaTNPcmM0bmNKS0xrNlRjSWtFWGxPSU1lRmdaMnNRZFpX?=
 =?utf-8?B?bEhtQmtuRFNteGx3ZFpISnNYblViZldQL0loVm1tMVVBWkFoM1ZaZTRwOWY5?=
 =?utf-8?B?UGVEOWdUUXN0V3V2cnFYd1pxcFZMNkNJN3hvSk1GYUt2cDR1THhVMzNWalln?=
 =?utf-8?B?WTVrcEMvQWJsZUJWQTVUOXkxTEdEMmV4TFNxbG8xWFc2aXRGZkVHamhyeWFZ?=
 =?utf-8?B?YjlEK0JKMlNJL0JQSUpYenhLVGdHSk41cCt5cFduQUtiU2dLZEM2U2l4ODR6?=
 =?utf-8?B?SnM0MG1MSnBhT2JKMGtGY3FLTTk2QkN6YzVYd3VVZnNKazBmckVUUkNFcmkr?=
 =?utf-8?B?Njh3Ymt1STZjQ0xoUkVDVlJoSnZnb3pDdFByd3k2TytnVER3ODUxajJSVXMw?=
 =?utf-8?B?RGd4cDMrVGFOVkVXK1d2RjNMckhKVExMRGc5WUpYZWhSdDFNUWs5WVRBWk1V?=
 =?utf-8?B?LzBxY1JaYmJ1N2lSN1U2N0M0YzVrbG9nNUcwQ214V3pVNkFsdk5UZjJuL25l?=
 =?utf-8?B?bEJQdUZsOHc1Yi9sM2wwa3JaMEsrT3hDTk5aUmhVbWxHS3BVaGEwTDE3NkF1?=
 =?utf-8?Q?8YwzyzrUFJve5KLWSrl2tTmx4GkxLfxthdXmf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f2fede-68c3-461c-449c-08dedd1fc085
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:57.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuJzeKkRryzixwFDDcl1s1Su+q1XpkC9IZheOyOvTyfGVaxcNplWA7oJU6ldkbQAYFN6NCgIragC3QxaHwBBQtwAEJChXeRszmY2Pa3Z5xenA0pbWb6QMNDmubGmMW5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_113602_184563_D2BD2EFA 
X-CRM114-Status: GOOD (  20.97  )
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

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- fix loop condition check in dw_edma_core_start(), found by sashiko AI.
- collect Koichiro tag

change in v2
- remove debug code
- move "residue = desc->alloc_sz;"  in if(desc) check
- keep inline to avoid build warning
---
 drivers/dma/dw-edma/dw-edma-core.c | 143 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
 2 files changed, 61 insertions(+), 106 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 01bee22fe3b3e..474debb53c470 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
 
 	if (chan->non_ll) {
-		if (chunk->nburst == 1)
-			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
+		chan->dw->core->non_ll_start(chan, &desc->burst[desc->start_burst]);
+		desc->done_burst = desc->start_burst;
+		desc->start_burst += 1;
 		return;
 	}
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i + desc->start_burst < desc->nburst; i++) {
+		u32 idx = i + desc->start_burst;
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+		if (i == chan->ll_max - 1)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[idx],
+				     i, desc->cb,
+				     idx == desc->nburst - 1 || i == chan->ll_max - 2);
+	}
+
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
+
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -125,7 +97,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -137,16 +108,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -337,8 +301,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -355,12 +321,10 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
-	u32 bursts_max;
 	u32 cnt = 0;
 	u32 i;
 
@@ -418,17 +382,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	/*
-	 * For non-LL mode, only a single burst can be handled
-	 * in a single chunk unlike LL mode where multiple bursts
-	 * can be configured in a single chunk.
-	 */
-	bursts_max = chan->non_ll ? 1 : chan->ll_max;
-
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -452,19 +405,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % chan->ll_max)) {
-			u32 n = min(cnt - i, chan->ll_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % chan->ll_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -473,8 +422,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -529,12 +478,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -605,8 +548,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -625,7 +574,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 4950c57fca34f..7f2ec871f5bd5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,15 +46,8 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
@@ -66,6 +59,12 @@ struct dw_edma_desc {
 
 	u32				alloc_sz;
 	u32				xfer_sz;
+
+	u32				done_burst;
+	u32				start_burst;
+	u8				cb;
+	u32				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -128,7 +127,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -170,6 +168,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.43.0


