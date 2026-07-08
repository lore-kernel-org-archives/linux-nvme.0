Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D878C44503
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	Content-Transfer-Encoding:Content-Type:Message-Id:Date:Subject:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ydRism5BVeBIOMMsZga1pva95bk0uVRrzHmdGkcABFc=; b=bTvPMreCLAdVzrFqyi49QM2hwZ
	cGUred+HN998ULLyS5pRUcizsX1gvV9CyJA3GiWsK5PQAlnx1+8+U103IQoOxaK/3H4MbjuZ+aVGe
	gFgRlIuDnh4F3SORkEl/geeXH4qltSTQwTERCqQhKjQQnwLK7Hf06X64UHjJCTC2OTKkX93Sj/vlz
	NJGmGq6LrHm7UWW6GXCVLobPG7smCOIkxRmKFrTmx7fxhf+iRrAIuLEc9UoDB7yiDb4GZL0+IrYSc
	fZvTkEiGB3PPcNTDsj5yEV2yh89wDoJCOsOw/N+LEziclZUvFDSuQx+QEj+8qwAnI9Wzo0mQ+U83H
	HJyi62dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX7A-00000000BDN-3IWn;
	Wed, 08 Jul 2026 18:35:20 +0000
Received: from mail-westeuropeazon11011018.outbound.protection.outlook.com ([52.101.70.18] helo=AS8PR04CU009.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whX77-00000000BCm-2pXh
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 18:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzjxrFRz9vKQyZxmzg8NzdmvktVLuDhKlRZ8/Qqei1/uRXusjDxTVbeTCQ2tWrVroFeFNbZYF/RaMSAU/r8TpfYC9TdGCWi7g03nAU3pctVCFmE3yAnbzdKjZIMvFDN4qUa8s4Am/5vcK6KEi6yJWSSYIYNmqEMaUWHMtOad6yXGDF/29lqxaBut8XZYkx20Yt1jLIV5WrisAcHYAHIanbUZIb2qissfSHJzagiQREltPttl5V64+2s9uLd1R6nBXp6JDFrILMpbxOF4+ndK/eS8AVMXdvEB5pws1EDu66iu744qlKSjT7RYwmMt5XNEFQzyiRcTiivnP7PI9zE2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydRism5BVeBIOMMsZga1pva95bk0uVRrzHmdGkcABFc=;
 b=JZmQu+1sjkkqi4nLqcW1jKqOXA8fhGTObxy4edtD8jOfAh07ooaUITUC7ZgXNViEZc1JX0hynTvNStVTDv5E+8sOvPCcrCJUkViKPRI8Zpa+i3UWgeuThSWH6wCtPl418+fYz3Mh00pjHA0+s9rmQXPA7uISldEDTytJzBIMNSLtgjZ2rMW6OLHXulaJgQiq7V1o4MbNaHBHBwj/yd1NbwmYkfRKrTU/Pwv2gir8aetUB5JGVQb3wabD+uvL4VwVR7tBnknmdOHEcO2Dv02XXatEmTd+Lj/vsik5Rqtyd5XV6VLxObJPg+tzvkhEkAkz+ojubOf9ZCWbhm/okdwFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydRism5BVeBIOMMsZga1pva95bk0uVRrzHmdGkcABFc=;
 b=pYoV0XHw4VYT1/F6Wh/bV1dKBNJ0OUudJMoYVKd2AfTg8bQQzaPjCL/XSA20fxYhevqGPc42+lVCQCtCCmXLBsyUHYbGTIptrZiK7EYY/FmWYjxjALWyt9CxR1mbK8Z4TYiN2FHguk2AEUvEblm7uo9h8EttIVfwG8kTWWx5iERr3qKMdI3B0jmUpr2NnDCmThZQmqZHacpUANs1ayRww3lhccA9k8oGUjlXbljUdjcgoI8reFgcN333ntVq3N+qph1zs3/Wy2OzBHX7QD+mHpuciTRJ9lGqzJEMxzOI8m/JPb+rm68G9nNL2hPxC3jFnpBAi4ks07D+oklaXE5i3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11883.eurprd04.prod.outlook.com (2603:10a6:150:2f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 18:35:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:12 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v4 00/10] dmaengine: dw-edma: flatten desc structions and
 simple code
Date: Wed, 08 Jul 2026 14:35:00 -0400
Message-Id: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFWYTmoC/1XN3QqDIBjG8VsJj+d4/UhrR7uPMYaZLqEvdEgju
 vdZ0NoOnxd/f2cUjHcmoEs2I2+iC27o0+CnDOlG9U+DXZ02okBzQgnBpu7Uo20xlMArBUVpgaD
 0evTGumkr3e5pNy68Bv/ewpGs171Bv41IMGCrC8Hq0uZasWs/jWc9dGgtRLorAQTKQ9Gkcg0Vl
 RXVQvB/xQ4l4ecvllQhpVJcMMlBH2pZlg+b93GoCAEAAA==
X-Change-ID: 20251211-edma_ll-0904ba089f01
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=6489;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Fx2G78hHYjpcV57npHbY1m2fyd5VcQvHbIfOkHYql/M=;
 b=omTiHkfVvWFBtF+ClBT1Q6g/JILvO+kMZAcHCCG/LcJlkcNz0QYLtjXPzovYLro4Pg/eBKFli
 SANoZnUKyKyAO+FnZZYpcI76AtIXCU1vn1+tS7KWn3ZjnwfKn9ZqoZG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:806:a7::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11883:EE_
X-MS-Office365-Filtering-Correlation-Id: ac82577f-25b4-490c-4dcf-08dedd1fa504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|7416014|921020|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: W/tQhBec9w4x6b2HpRHwN0WHokLko2yUcCjcAe4t79Gi/t7UicEkkvZgsfGf1En14CHSkCq1u8JgFodLB7FqNBNrYtq9Xd4ejc51kjG2uE+Srw/xGBmqUGz+1k6o9MueGLEYVkjeuVoyxxShVELul3RYJgfxU4f35MlGnkTMFx81rTRHcaOmNyUTm81FbztaA+nxP3UPMxuVLlOVInBUqKic62yw8jl33OgFIW+qnqlahFure1mT97pi9kM2gWZfemTJbokCiVkSiQOrflOiPJaqSxzo96JHFc+gFfjK97jhsRJApV8QSh8xrYq0DFXBVt7qApcD0wQ2PAim2YVWfi4h5OnmPZD/DcSVTqBAFNhe7FzPjPn3mWaiGlKOies0I1GOQ8DEduNydWKtmOT+NAhuyxfWcFYfJwj0BtdlZaqxPbOGMiw413BEfYznLbkbfqBYPuRgwpNr7UwQd/ZDKVoxHxiS5hjj14JBiyl+S90UQmLg2XfKBhhTWkj+o3xwylduVIQ73AmcV0xNtegWz0ydMqz29+jB93xGWEGYeCnZuoE34fsRoDQ2WXhHFxPaZfW/OyuKkgDB4qjrPqjQLTgtD6NdIl+Q8O7K2ljvV1qsiIFin77W23lk5ZxJPh1KUVKkz80g6y/eeLSC1biyJfwPXGvbwi6pL6WsHv4rEOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(7416014)(921020)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDBJUEFuUVJjeDM1M2ZiSGc3TDN0VjgxU2dSU0lCOE1WRHFFS2x6cDhFaVVm?=
 =?utf-8?B?eTNUeWU2MHRNL2NDdlIyYUhGeTZEL1RkdFZEVlVmUml1Vk1Yakt6UjFvQW90?=
 =?utf-8?B?RSs4SWtxUzcyWkt3NHV5cS9KcnlDTWhyZCtVeHdIdEd1NmZvVG4vNFpVU3cx?=
 =?utf-8?B?QUI3aW0zU0xDN1dtTnhmTlBXdTlkcjU0MDNKWm5BbWVQKzdSN2tVZ01IWllL?=
 =?utf-8?B?c1JmdU55WnJtNkxFcTMyb1BMWmxRN0RDKzhReitpLzg4VkVrV0dPNmVyOEwx?=
 =?utf-8?B?U3JWZGtMYTZTU1V1cUxJK1JKdTZZR2R1bDVkZjdGbEZMSFpwYnBKMGFYZFpu?=
 =?utf-8?B?WFA3Yk1YcElJL1NBT3VqTUdSNk9TYWJiSmtscE9TTVl4c2NINm9CZGpkWGEr?=
 =?utf-8?B?ZXlFbndsSytrVCtEVjVjZWt3VTRJUThVYk1SejhnTzNlL0ljQ2hYZ29FRU15?=
 =?utf-8?B?dUEyalNGUTJ6ZGtOSmVEbmcrMVlob0dEb2hXbHNTRlIvNG4veFFLMU5uZnhj?=
 =?utf-8?B?TEZlSTkrYnBJSjI2MmE4cTBudkRoaVRtSitXTkwwbkZOWGJNMkhpVTFDYm1V?=
 =?utf-8?B?WjA3OGdnbVF1eG1NVlNwaUpBcEFBSWE0SllOQ3J6T1AvcFNzQXZDSXZ3TVVW?=
 =?utf-8?B?MURnc0ZCYzIyaWdoL0FwdzJ2UkNHbDhnU2hPL2pxTU5lL1AyL3NiaFJEaC9X?=
 =?utf-8?B?bk9ENThEbkJab2ROcEtIV3pmM3J0b2NGcEpZdDBoQXhDLzBTU0JXV1lUTWEx?=
 =?utf-8?B?NDBTUk5sUHVBcHpTVytXS3FRbjJZR281VVBzbkhnS28yc05kQnhETStUdGFX?=
 =?utf-8?B?SlZpZ3ZFQ09PS2xKZzU3emZQaEFsTVZWeDVpblZrQzJZVlNrQUtpU2kwZEo1?=
 =?utf-8?B?Z2gzMnk2MnE2MUhOdTlxUVY2UTlLZ2NHSXVTdDBaMDhrVlYvcHA0dlpnVEJm?=
 =?utf-8?B?Q09lRDYvWE9CaEEvanZLbmZnbldoeFE2SEZGc21KYkdHc3lNSjNra01uUjlK?=
 =?utf-8?B?dWM1dERmQXU4Z2REb3dKSWYxZ3QzTXVoQUZPUWRyTnc3bTdjemRXQ2lGVTNV?=
 =?utf-8?B?UkVpb3pFekk2aE1mWFdzdWYzRHhRMkl1djlSNkUwYm9FSVlxOFQxWFFsaHM3?=
 =?utf-8?B?MGRKK1o0VEdyYkxnZ1VudXhvdWU5Q0U4UWxuV3NiVUJWYy9yeG9JdmdwS0Z1?=
 =?utf-8?B?STJ2MzdDa0pqVzcya3ordGlOTUJTaGJ0TVVGOHZMNmhIdWRkNndkYzh3bnNN?=
 =?utf-8?B?YnlXZXdEUFU1amg1U3h6SE8yUU5LK3VpWVhyN2xsd1RERzJJNytvQk12Ky83?=
 =?utf-8?B?cU8ySFVZZWZ2YzdONjhYUmI4RTlqbFlPc1EvanRjTzBmcktTRWx3emYvYU5R?=
 =?utf-8?B?WjRKK2tsR0FjUy9BeHdoczhRYjhqRDJpcEg5U09HZVowMTl2LzdJT016Qnkv?=
 =?utf-8?B?MFdWRTllNnFSWERCc0FGQ0NMNnRPenRsNVg1Z0JUSVMzQXpseTF2NGdiVitM?=
 =?utf-8?B?eS9DcDM1OE5wdWlIaXdLd1hVVDFPMEdHLzVCTitWOG9Ra2hjYTJhSW9xdlRC?=
 =?utf-8?B?YUx6VnZZa0F6b0JwR1ZBT2IyQnQrTi8xcWdMbUVTTnkweXJGU1V6ZWZ5S3ox?=
 =?utf-8?B?NWpUeUN4MmZJTktycm5nMG1PeFNhWEwwK1EwbG1GRUxqY0QxVnhpWVZST01j?=
 =?utf-8?B?eXNmS0JjQWdEVStIc0lvbmpYM0M1UDgwcWd6NXZYbjRxTGk1UUpFdERxRk5s?=
 =?utf-8?B?TWpMNDgzMVdLYUhkRVo3L0lDd0gyRkM1VXk5WVBsakFNb3hyQjN1UnJwSThG?=
 =?utf-8?B?QkxRL29TWHZJWFN1SnVhNnM2OExTLzdraS9jQWl6alR6K04xQmxaVWNzTmp4?=
 =?utf-8?B?V0pPSzhyUlQ4eFJXbnNNVDJYUzI1UUFIWHJBMGQ1eTVrczEyZDgvaHB5TEZW?=
 =?utf-8?B?bUljOWtkZ3MvUGRpZEVmM3YwRFNwRjAvNzM4eHlPTE8yS28reE42bS9JcmhD?=
 =?utf-8?B?c1Q0dDhBaG8wYnY3VkdaZThWRHhVNW0yRFFDcUY2cVJYWHdRb3B5SFZDRXJT?=
 =?utf-8?B?UkpCTTZQMVVoclFJN2M3bGR5dGZ5cWJ5ZGxFMERSOGFDckoyRDFiL201bStJ?=
 =?utf-8?B?UUdNWUl3ZXBzSzRkYm5CcGY4M2pZQnQzQmhuYWVXTndLejN3WllBNDRodkFT?=
 =?utf-8?B?Myt5cnl3a05zZ0RFamRFaThIRDYyVnRiUUFXUDdnRmJVajIvb25oelhzZGlh?=
 =?utf-8?B?a1hFN2plL2Mxanc1N1Zpam5US1BLNDRvaUEwTHVuTUxGQ1Bhb2wrM29VZTAz?=
 =?utf-8?B?ZFQ5QnRzTmY3VnVvZ3ZlQk9KSkhuZVkyN3VWdzFjdkhRUU5CaUFBeUgweFpF?=
 =?utf-8?Q?U1AB+qXYoPlpgsi+aQWT5ti8cCR3OxqrdEUi8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac82577f-25b4-490c-4dcf-08dedd1fa504
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:11.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ODUONLHQg0Wnwomdk5jWWJdLMz4kqJ8Wv8jcn73zHk1upoIZbkYSSVT11r0NXxMuamVPXBjVGH9YIdqyeu8Jy06IUAPCv2YyefqVBvCABQr3OtMZ1KAhIUdIovTdSNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_113517_874867_405D6796 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
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

Verma, Devendra:
	Can you help check if block non-ll mode?

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

And reduce at least 2 times kzalloc() for each dma descriptor create.

I only test eDMA part, not hardware test hdma part.

The finial goal is dymatic add DMA request when DMA running. So needn't
wait for irq for fetch next round DMA request.

This work is neccesary to for dymatic DMA request appending.

The post this part first to review and test firstly during working dymatic
DMA part.

performance is little bit better. Use NVME as EP function

Before

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
  IOPS=261, BW=132MiB/s (138MB/s

After
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
   IOPS=266, BW=135MiB/s (141MB/s)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- collect Koichiro Den test by tags
- use addr in argument when set ll address, found by sashiko
- fix iterate burst problem when exceed max link list, found by sashiko
- Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com

Changes in v3:
- remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
- rebase to vnod's dmaengine topic/config_prep_api
- Add non-ll-start() callback to handle non-ll mode transfer
- Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com

Changes in v2:
- use 'eDMA' and 'HDMA' at commit message
- remove debug code.
- keep 'inline' to avoid build warning
- Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com

---
Frank Li (10):
      dmaengine: dw-edma: Move control field update of DMA link to the last step
      dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
      dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
      dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
      dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
      dmaengine: dw-edma: Add callbacks to fill link list entries
      dmaengine: dw-edma: Add non_ll_start() callback
      dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
      dmaengine: dw-edma: Use burst array instead of linked list
      dmaengine: dw-edma: Remove struct dw_edma_chunk

 drivers/dma/dw-edma/dw-edma-core.c    | 218 ++++++++----------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
 4 files changed, 304 insertions(+), 388 deletions(-)
---
base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


