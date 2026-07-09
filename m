Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7776DC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=; b=pzp2GLI15dsZJLgNPIaTzfiCI8
	eb9iGnFGRHP0YYKs8Fxpg2DJ/Yj9/Hq+uU4btO1PDrm98cx3TAaF90+LXKvmPKR6IO2F7FKe84jVW
	lJI34o4BSVz+AiBqKLfbH/aOWep8ieHPECkyLAfv6ef0IOFI07VaVcvOhnolvJckf1hG57owkVS13
	3BBaWv20MdejjnNzPlBs9wND4z4lMNIInNJKNZzSuEdGO5bSHrKt2s75aGQMgfNX3TjPiRzuZdF56
	jsCGTldS+GB3+2d7Y4/rXVRVvTxqnC5kmk+JAq5bb2zVXKRXdn2QJ/vifZXtj3mtwR96oOHVUcp3L
	mzLsoPXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whql7-00000002vlC-0ery;
	Thu, 09 Jul 2026 15:33:53 +0000
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whql4-00000002vi6-0twj
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 15:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxZ878G7lseQSswDVjy8nIGANNU51G7vI8ZY9kgzmqdHbp/ZYK+n9IKfniehXrEYHngJ+zHu3XLmbAr0FRwFzuJ6h05fOAakq7KtCCWM8I/KDcr56Z5bhMVCb8Gf9VyAoaLfJ9UPxuiKHAsv7MDJg6oa8hJIjb4augDvhKx7ebBFm4Tcacgt4f3/ZK25TUc/j2hhfa4HcffBAa4CLjrrWLnzzf4i9E2d9hsZoD+T3hmx+iQ5PX+l4iW3KQQUjTHrDaozTHahWWl/+ttCT6BB5Y7DFwjXVBD8tB3eQ8Ib+1TEl+ZTnrYLJAQ39Fnu17eZrXVFbrVkL105CgCbX9fZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=N/uEZaEjtelBR7RMnpiX1m3wgynShnJxAE3IqyqLxhdQrKeLgOtD7oCnjyebrHolqQjQo5OJHdLxXxbPvFZYc/hm+90G8lytdM04nz6UuvooJ1I4fJmquJYF3kOQfHFgaIGJkcKe8jDyhQAnQHFrfGo6JuZJ46s7aJMaq0+g2lPTl5zAD+cldBYdaBn4Om0nHEmuPvkaAFfdxZO5Di3U53oaZyjsXpBoDpfn1yI5weO8vZHBvFEDBLroudvj8TTB25MNyPUFg7S4K1e6upmZGjzwLzoxAear5RW0eMf9dnwFWlidB5HJrHaK+ZPAC4kd1X1VCisVqhAN7ly2LKfJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1dvpk9EzQP+zr+KnzasNIE+tSe4nwxuB7NxjPdW1P4=;
 b=N0OhyW9CXv4QGWLsdImSXg4tbOx9ChBZw8CC7hbBMGi5YRZgOC/hHqJ0kLuduWk5zw0iLA9UljFSzzVnd0FK8ODrcjp6PuTRJqQNxwMe9P+7/JbxCyQ7p5PnyDKnsXbP8qbbTcOOC0Ptxm7LrwRsk8Y7dLdstcQUSFLmlwEBzvRcLgvBt+s8GDCNqjdwl0ZTbSfsUgX6xNMONL6OONTVvoKw20dW4+JcWobhN5Pjsf5na1rKfO2moft27dT9pEUez631B5MEkdtDFZVTh7SjuQ6WwL+WL/2pLcRXWYPFOTk3b0cGmYqyx07Hj1iliGKHvEos3rAVa2TCS2z15+8M4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:33:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:33:48 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:31 -0400
Subject: [PATCH v5 02/10] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-2-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=1765;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AWFd01V2qiIGFrrfkjJThL7/BfhkdZY8qigjsjdbG8M=;
 b=rB83ZUcbLHX3ldAHMb91hHFcrG4LbkTs+JIyBzZrkx4TedzHuXNlnrUgTwgaG71mGs8sCuDLH
 dAjBcGO8yirBxrgw9s0MXz7VSHiar04E/NEdNOIxzhTTL33jmFpjSMT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN6PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:805:106::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: c65dd4cd-a1af-4c74-9778-08deddcf782f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xOKJ/mya9KBvUU7mYADOSR0P5Jf6ScI11m6YY3BNh1KfKtjZZ5mzvRKQ86dVcr/5D+1W9bsWFWLNtIS619SrCqYex/n7SdMmvK3HhqMHq2gF3NY0dPGssuv06dmZ4DXPVPlLEpuSqNiOiBN46mXzDOiiMKVp4oM8ealZT32sIzb97JRV7myGd1Wr2QHnvrh4wKj3YoIFwHBEaB3QDnt/8UVDqM4y1VpAycmUazfHhB93W9gOrEKn3WGuYdTiVTVHKh/ft2mpjFXxBBG+W5JJZWJReR++ibYDdiVQRNSdKHbQIF+PDEZV0hO0326eFFchE4IjhMx7KwJu9jFjKZmdlQJjasAq57KqOP7t1cYb2YTD8GGD+vTSZeOdF8auD6PSY6hB/T0up1VMj0psqgCvxVrYJLJi8D9skahywCnIAE3Ys/jIX6Fo7UKioIjcPgdve7JeCeP7CokIEcdttJ3s3iLnTdTlIXY9uzcPqe5mf2fcybZO7YnzfmrSF9XkbB4oH/hC06creOuM4p0LaD3vRBqDkDXuXthItDAlfFszUYsXH2muZyUgmeIxuRAojEhc6cdZIPaIbtbESrDPU5jTPyu1Ugrwm6LZEj1dvQVjvuiudAxF9NngqCE3mHE+Ai4o2kNixXYC+yajMud8IYVqZofU5QQe3MdjrgkzoznZNnDWACIgMpnH+P034He5PSMVQUar+RolWHP/YYU9kLaUaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NSWStZaGlyTVhzWXdMWlcySnpISmdmeW9mbmdSUDdpeEM1eEI5Q3Ryc05n?=
 =?utf-8?B?VDVXNFA4a0txOEtpOWxrUVQ4SFRmSktuNkt5V1dEdkhiZjQxdjdJcFUwbEVi?=
 =?utf-8?B?OFI3ZWIwdURtQm81QUJ4MER3UmR0b0NKYmg4L25ZRGxGbEhQNGtWNE1KcExq?=
 =?utf-8?B?RjVNbVdxeGZEZVl6THcxM2ljRTlnamUxZzVLNlhTTHJTbHBaNHp6STg1UTRZ?=
 =?utf-8?B?bXFiUjRxc2xqN2FGMUN0ZnkzVFJkWDV3OHRXNTZGYkYzK1V6QnVQTmdLY3Vs?=
 =?utf-8?B?NG5rNG14WWlodkc2TFA2eUhudm5uYlpQb1R0MGdkTElKeUtiZjNGTzFvd0Zt?=
 =?utf-8?B?dVE4QUlWQ1RaY0J2S2Zjdi9FaGtoUUFZRjA0anBJNFgrUHovaExSQlVUUWw2?=
 =?utf-8?B?VnlhOUpHUkFCTVVydjMxbjZKZWhJOC9LL2pHaDlHNHVrek4rdnlveHBJQWl3?=
 =?utf-8?B?alEybUJwa2xNQUxYZUZtazgvak53QVcrVHJpTXpHa01jL1laTW9RV3h2dGRI?=
 =?utf-8?B?ZnFlNExTTXhEY05BRG5NZzQ4dGt5dXUzZGt1KzMxQzZGVHJlWTVRNW91Rnc5?=
 =?utf-8?B?VnJZYURzSi8yd2pWUVdmc2NGN2NGMlFyRnpld3daNnRGVjQvaVFYc25GYmoz?=
 =?utf-8?B?VEgrdDBPaE0zVGtIcUdoKzJVWWNVSC83TG9HVW5nZ0NXV3pmazdJWEtlb3M3?=
 =?utf-8?B?UHRUdHRPOVFmY1JIem1kRnR2MS95OHFtNC9aQmx1eGZwakRSWFp3b1N5eGVS?=
 =?utf-8?B?OTEzZUFsbmp2MW1TeDkyWDBFNmE3VTVlelhSWkpIV1BkZ2ZnMWNXRHhCVENa?=
 =?utf-8?B?bFRMME5mVGdzbGQ2THFuTHBpYlF0NDFGZ3U1RitmU2h1c2psQ2NYTi9ScnBa?=
 =?utf-8?B?ak1tdlhKY1pEMVN3OWdqcmxldkk2cEZwZE0xdm5xbHpNd3Q1dUpmb25GYW5U?=
 =?utf-8?B?Qk54Q0tEOFVlMVkyc04xd0hTYnYydGhsUGFWZkdYMG1lNnVFZ1IxY3ZjZmM4?=
 =?utf-8?B?d1ExY3ZHUFp6bVBneUd6Kyt4T3hJdGhUL3ROQ1dhWFJpTExNVm8vc3V1bVZq?=
 =?utf-8?B?UnBZWlV0czc4YkN0MDRyMnEvY3VmLzhiQ3RkNHRUTHRxc1lrbWRiV3Z6K1FT?=
 =?utf-8?B?b2VGcUMyVXJSN3QrTTkxa3VRY1hTRnpvaFFiVkgvdURBZm1XWWhDV1p4RUtv?=
 =?utf-8?B?Q1V3RmRWbVU3ZmszNzNzZXFHNzd0M0tHczNrSGVUVEJNR1RlWGZTWlAxZU96?=
 =?utf-8?B?VzVXM0liSTBhcDVDV3E0QzIwTkljWktaaGljSS9NVlphSjlaeFprVXl3N1ZN?=
 =?utf-8?B?aytoaElDYjNEM0xJMDZUWDNldjdUNmE0Q3V6T01UZkQzT3lISTEySGI0WlVx?=
 =?utf-8?B?NmVwSi9SSmJKV1V4ZTNuUnNqdElaRnEwWExHcTJrcTVrcENhV2VlL3RFcGl5?=
 =?utf-8?B?MzZEM0MrU1BocWhJYXd4VWVpd2E3RExvODk5QjNmUnZpUmVVeks0WEpxdmdq?=
 =?utf-8?B?VXlTZ0VRTExONklqKzVTdURnOTBFeGJ2YVViNzAzQnV4d2ZuSGhwQlp6L3JT?=
 =?utf-8?B?bTdwbFJJUWpKQVo2dkdsNy8wZjN2dGdtZERkS3dKSE90V3p2RHFoRzZTTEMx?=
 =?utf-8?B?NktUY2wrV3RoSFZIU2NxOEtreGN1VTQvMCt4c3FoU081eVc1WmNRVG45dGMr?=
 =?utf-8?B?QTBpaW9EbktHeVIwNldXaVZqNW1oQXV4NDdIOUpXd2JHeEYyQW9nbFNMbkhl?=
 =?utf-8?B?VXBYdU0rbmtXaGpZWDdzVjhkWUZveVRHMXRhUVlMdWpBUFFWeVBaSDhVbjNu?=
 =?utf-8?B?cHRDa2FBdGhSaE1KNkdiUVBRa3FqblA2RFVVZk1qWkhCUzFmTzR3VFdNWmtM?=
 =?utf-8?B?MzQ1c1hFTEc2Ly9WQk9MRitrTjFoRjNnVW9KWDNQVmxrc3FndENTZGtNU3dr?=
 =?utf-8?B?UlFOU3VoTzgveHZiQTNnYlFialFyN0ZUUDJvbWExd2ppS3hjVytLVE5IZHZm?=
 =?utf-8?B?czdRRWl2dVdlSmJFT0h5T0hvZmVRMndmMUFpc1RSZStxVys2QkJDTDc1STJR?=
 =?utf-8?B?Q1hQTmdzTXgyK2RvR0xxTmZXY3htc2hJSW1QaEN0UVdHRUJxRDBsbHRaZTdY?=
 =?utf-8?B?dktmZkltTitBeloyQUNuaHU2L3pTVVhNVFVWVHJJaUQ2NU01NnMrTG1IZnpB?=
 =?utf-8?B?QTA5TWQrTGpvWDZLSm5zQTBGSFBXczA4dDBJd3MwQzEyLzBjeU91RVBHenFQ?=
 =?utf-8?B?WVhvdVorV3JkdTJVczZzTThNSmk4cERaUHJEODVlVFlCa1VKeGUwUVUxZWtl?=
 =?utf-8?B?NTRxU3dWazFpUVFmNnM3Ly82cGg4RFZ5KzVWeGhaWHpadnA4MDBxNnpxeVVy?=
 =?utf-8?Q?skKMBud4tCD/tBRnPywysGtVREiiWY9fX40Sf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65dd4cd-a1af-4c74-9778-08deddcf782f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:33:47.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn0kiMrEmNBa0Ux33xIDJHSatomspKur1eUZG/nJSfGdjv2hIzSVOYy3Is6ixpsGc7UMucg2lC1Lbq6f9ejqwbvRSyHpvAkdh0uR0mflZjYlnogzJz26vdDHGRS+2/eo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_083350_257382_6502D1A1 
X-CRM114-Status: GOOD (  13.63  )
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

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1fec1b52e3d47..53469c8c8b82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -527,7 +527,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf71953..db5f45bf048c3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.43.0


