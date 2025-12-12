Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3303ED59F50
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 22:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=; b=l7XigisktgVuY6U+BzyER+cniX
	XK7Y4ZG2G61Ser2z7MVylse0HNAw0Gkla2zEYJOt6JkvZuGwy87kGN5iSjr5B4ElVw21R/GtWgbcL
	cSMbW+qGNStCHEKyw/TYZl0nN+ycfvQkc4ghmk6LF5CZjNY9qrGz2RMKzYR1Nos82SjceLs1s6+7P
	0IzhveimNap20MU7FfBwLyUDz1miULEE5DAiLQRIg1o/yTTH7T2acvFBb3hV3WOFsdj/Kcj2c5BYu
	2DJurrgLs0UM7Dy4F7orpJAh4M1LUw+GvsAuJjCfmEsZCbe/ng9VoYvCF2n4lYYR8AZ/r78nZYHqk
	s0Nt+Wdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUBZw-000000019WE-1jyl;
	Fri, 12 Dec 2025 22:25:36 +0000
Received: from mail-swedencentralazon11013027.outbound.protection.outlook.com ([52.101.83.27] helo=GVXPR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUBZt-000000019SH-3ybN
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 22:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPEipdQkSaurSMqKGWP1lgJrKVnEzVQFAsYuYvFxnGxQV/9nABnHwbhtqNqHONl9Qush9mTPuK7xThlWkWyUTedwcvF+BfFq5CttqdlkWB50aMmHHUwgchCV5kXRp8gqzip3jvTDSNNs5q0K9WXWh5NQQWqP258QdT/a7R2TY7ZKgeg2ipI2E4OCl97e6GPWRUkxCjrscBbZg/FeTL2N1VND/rqqnQddcMo6MQfl6Nc0Zl4gGuiZ/DkXJgzGeJdrYYopV7zoHRhyVMCJSSz3Fc2Q2CMleeSRlcULSE/TrACuZUaeKikm1xYjtSUQgq79t8M/6pseiUmdJny49TEXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=;
 b=bgBhChqBRU+q3+jTw8NMkYY2/VZ+GrKEopFyPVBjQlRLv1ipt/dHps1AWwm8/BfeHGqVaq7hL9FZqnFN7e6k6B2Qh/RcDKteQ02NdTlTJevahNfUnFdvnm8ns1siFA4l8eP4UOij1veWeY2w3ZX5IKbAqQsao1t0YJJbktQj/qxdySs0UoWecxI7Jg6vD6uZcmXwCUFb/gCZ67B2m2UNYEVIV3iTWGLAgE4oqBOmoTWrs1QyX2yRmG3Rq5zRDqyeojNM2saJD5T1e7FojszckCItJjbZkHUR7UNWst8sYJqsHoOsnsWurzFnw0a4jG2ZFLAmcakXZ/8lD5X9miubTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TgGwDV/YKOQf4IuvHzx8VIIgBxGCZOV4+RWNREuWb0=;
 b=HXwH6O/XB4qMwXvCefnrLwVWSdRs+ArgukHwqflhiAEuh7f/8OMybe20ijGCx5AjJzvgkJOPg3iPu8q726C7hN1685z19sa4aDpzXhYc+nRG3wmiH84LBvGxKOqfQ9BIcII/+deKGvvCetgu420M+SLMUPUlPAIdrdttY2ZVwKypsAS41QWDi5Eo6W53/m5zu8GKJsXYxC49tqmAsVfQdiskPSn8ZTwEUpAB2s/XDZllta1DLMPus4K4WOawVEwhEy9abeB0GJrXZWUL6v4Gd/z3ojX1+Mda/k1fQk1gPtRF5draShCpN3EyvSbEgURocNZ2+yQEOgAq07t2Bhoong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:26 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:44 -0500
Subject: [PATCH 05/11] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-5-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=9173;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BVei9oaxixdZN/1lIiuFf7ag2w89A7PX0bp9V32XQPg=;
 b=UYUsN+T4lgu7ygjsLGwoMr2cz53ExW7WfrlirY0K4BWgX8QmQlVFNzWr/jArEUzmCiTfM4reP
 FPhudQEHk4OBQ1MkCDCg/NCXSWiA7OQtCExgtbJkI14WpeKpAbnReKE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f05d56-361a-48f3-acee-08de39cd5700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MktJWEhMbktNbURBODdyemkxcUF3SHpvNFNRSy9waHRzM1FBTlY0ZDdzdWpy?=
 =?utf-8?B?aDkxSkt2MFNyMjJKemI1VlBrK2JPUndnMDVZeFZDRTUzSW1NQTIyWUg4aDFu?=
 =?utf-8?B?NDFKRm8veTJmY3plQnhxVlp5VDRnejQ1SHpXUXlVMllKSGV0Q0h2OWJqdmUx?=
 =?utf-8?B?WXQwb1VMTmZqVkJmUURIUzNxeVVyajhURDEyT0tUcWhEOERXcytFbGtnTTVk?=
 =?utf-8?B?c3NDR01zYjBvMnVPWnpoL1psbTZYanFORDVyUHo4TWFuZmZEYndNMDduRVVJ?=
 =?utf-8?B?dE1ZZmhPNEpETTlyaGNTTk5wdXpmVmlJSGNKc3dYN0NHMzMxUE9JWUFMa2ps?=
 =?utf-8?B?ckJCR21yQzI4MHE4d2ROT1V1QWg0V0JxZlhESzZpWWR1WGlSNnpJTFVuaTIy?=
 =?utf-8?B?WnhRTDNwckVRM0F3eXY1bEVzak1yYlM1Zy85WWgxWFo4K0QzenFvcFdUOGY2?=
 =?utf-8?B?OGxoM255Y1U3ZGh4c1JhQ0ZQTG1RZVczRnRSQzU5ZzRvZGR3b1l5aFJFUTdK?=
 =?utf-8?B?cHA1c0p1QkdlblorQWhLOTcrZkRYc2JEYkdNY1BxN2k5Y1lHT083RDdzTzVE?=
 =?utf-8?B?eUlKaU80Y1BnUzV1M3c5eG5uOUFDVnFheVdheE9tMU1mMUJrT2RvTm5DZHRq?=
 =?utf-8?B?b3lMYzZWZ212ckk1a1BPK3lPRDRuY2FGRmZhL25QMDg3NEM2dldGc0NseVN3?=
 =?utf-8?B?VUVZWmxESkVndHZFeS9RVytKYXJPT1RHUW5wOUxRdEoxSHF1SDNkam0yb05z?=
 =?utf-8?B?TnVBNzFKZVZkSUNqTlRGUlRtNEUwbzhZT3JmVUJlbEtXQzBvK3p3NjFBVXNB?=
 =?utf-8?B?SXUzZXdMei8vRnpEL0lveEMraHhBdkExL1Q5USt5b093VWtvTXJZR1ZoS2Qx?=
 =?utf-8?B?aXF3MTV2VU9tZlR5bUhIdmhjK2k1c1A4YlVIRFVEaWw2RkZkQXdpVHh3M1kz?=
 =?utf-8?B?bnd2VTlEQ3RoNUJBRVkxaklrZ0lvNDlQTlZKQjh2eGRNMGdGNjFGbWc4SUFX?=
 =?utf-8?B?K3hobmRnWGVMVnZYblBocVIyUVppNyt1MW9KbFBKTGRqRUVTclY0T2wySkVj?=
 =?utf-8?B?Ri8zSDNhcVAzQllwalJOdTFNL1BqTHhZOTBaaE1XOWEwSC83VzE2Y1ZLN0pm?=
 =?utf-8?B?TUtnSXZkMXdhVEp2S1MyK0R0RXUySy9ubHZuQmU0NFM2OExDKzhUclJzaDRE?=
 =?utf-8?B?TWxmc0Y3VUxuNkFFRmc2V2RycUxmcDd0UldUcnB6TWswdVBZdUVQKzl5ZW5v?=
 =?utf-8?B?eWNwenNZTVM5UjRZRnNUYzBGYjMvbGUwb0FBMy9mRzFCc3NsNGlHT0M2TklB?=
 =?utf-8?B?Smx4TkliMUZEMXJ2NkxadHlBMzNwNm10TUZlQ1RRTzlRcnFLaWZCSlVuM09B?=
 =?utf-8?B?Vm9WSll0Q2xCWEVjdXlTaERwTmNrcStweStYczNpUG92ZFVSb1ZvRDZvYzEw?=
 =?utf-8?B?cVZnalI0amEwYm0xNW5uZDdFQU05d25FWWIvQzRrVms2Ync2S1lDdlpobS90?=
 =?utf-8?B?MHUrVXptVk13YVdkUWk4REFxVzRvcGp3Zk9ERHVZUmRBRTRxU3NsNFB1MTBv?=
 =?utf-8?B?c1MrQmpqSUYvczNDVkRuYXZsaHRrUVZRaUM2UjErVGlvMitLTFU4Rkoyd1J5?=
 =?utf-8?B?ZnAxSmM5SWdBSTZKMnUraWVYY2hsRk5mMG0xYVlkUGtHV09GdDVWQ2lwQnQx?=
 =?utf-8?B?K3A4TmF3U3hVVVpSM3lMd25hZ2pCUUVCa1lQbEtPd0NlWEZwMjhiY2w0a0N0?=
 =?utf-8?B?RUtCb1JQaVoxeHZpdmRQVnpDN1B5WEJyUGl2Z29DclIyOE5wcE1NaFdhalZI?=
 =?utf-8?B?VmhqdDQ0MHAwcUdiZUs5Z3Rkd2xzbjJrUnFvQzlTaGdCRmVJY1MrN3ZqNW1H?=
 =?utf-8?B?Yzg1UHZ6WldBcmpSUmZlQVlVdkVVVm1DOVlHZ3JhS1RhSnh5YzVqVThmNUJQ?=
 =?utf-8?B?NDEvOUxNY3R2NkJuZ2lLNmxJUUlJK0Q5SlU2TnorMUMzTVNaQ0ttSjVMQ1NH?=
 =?utf-8?B?dnhhdWszand5SkZjRmJIMnFkaHNpRno1SDNNN1d4ZFZGRkoxQXdXQ2JwVnRN?=
 =?utf-8?B?N3FzU1JYclppTys0SHliZElPa3VvSi8vdlZqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW5reHQ5TjVYY01JZHVkTy81R0dvbjc4blVwaCt1VWg1V01KNkNtNDFuMlZ0?=
 =?utf-8?B?cWxaQ2ltb2g5ZllWem1Xa0QvUUE3dy9YV1pVVGs4QjBtMDhoWG9KZktaaktL?=
 =?utf-8?B?T3VYQ0VIY1ZET2o5Ymw1S1lkVm0ySFJ0TVJ4VkxUYUdkNmp5d0RpZTVuNG5L?=
 =?utf-8?B?aGpJcFlFWk1QK3pJUEFua0xDRzl5YnFEeTh6MVVINmpkUFJOOTNLM2hReVh4?=
 =?utf-8?B?eldQRzBPRGdDMi93YkJYMy9rY3JxdndYdlBIY1dZUFk2dVFqVXpQWmprNmN0?=
 =?utf-8?B?VVdWRWtQakJrdTBJK0xiUlRlKzV4VVM3VEszcDEyS3Q1WVNOcHgydnhqWEZZ?=
 =?utf-8?B?b2U0NHZnMVpjMU1nK1prZUxGYXV6K011RzBoVTNhWTMxS0k2elIzUU13L21O?=
 =?utf-8?B?dkI5cjBkVVViU0g2YktQb3l6TVp2bVcvdWxHVzZFek1SZTFWOHd6OFB3ZHBk?=
 =?utf-8?B?Sk96aG80N1BWdGhOSHArcTdybHRXKzRkYjNDb2pIbVlqejRzWjNlZGlPakp4?=
 =?utf-8?B?RmxzS3BMd2J5QWpnSlNueGFrTVVxRm4ydEdJejYvUVdtSkJKUTIrNHZMdzRX?=
 =?utf-8?B?WGc3YzJqZlVQMmp0Q2cvZkJ4ZTdjU0xHYitmWjlydExwelBUS3c3cjFZbVJa?=
 =?utf-8?B?WXQrdlNxRHN4bnBTVUN4RFcwK3JPVWhYSFA3dWs1NEkraGJDYVlQSHdKa1di?=
 =?utf-8?B?eHBWSWNxSVhIUi83MnFydkpXSGFNVnhGYVJzUENIcU5qMVhqUlYzd3lhSjlY?=
 =?utf-8?B?bHJ5T3IxK0JzMkJ5SWVWZlE2aUMydlhMZ2kveHlJbTFuK2Rrdm95WlZSZktw?=
 =?utf-8?B?aW9IT2FzL2dLdzBDNE8ra1g1Si93V1FSeC9LejhyajU2Tit5L2ZGSmFTZHly?=
 =?utf-8?B?OWU1R012T25rakNPNHkzZnBHSGhzM09qeVNPZ3J2b051YlAzcDVhOHpWT3Z6?=
 =?utf-8?B?SWxZSEl0eGRsMmFBOXd0UHV4MVlkSnlEUDhRbndtb2Evb1ZGbFBMdXRjc0s3?=
 =?utf-8?B?M2VUdnhrWEJNN3BBUnBkaEhUYjVqWmFSRkptcXNMTDY0blJVRUlmYndMR1My?=
 =?utf-8?B?NXFPK1loRFEyNFhQRmNtcTJTYm10OHhFekhGc2JZUGt6ZFI5RWVxYkprWkpQ?=
 =?utf-8?B?cUFoRVNmVWpnM2MzR3A0U0ZnRDBTdStlTnBxOER0VXEvb2hTSlM3ZzEzSUtK?=
 =?utf-8?B?dFJGTVBNYkhBd2NFMFB5Z0lQU0tSc0luZ1Npak5rc1QwUFlmMFMrcVhJa0Za?=
 =?utf-8?B?SXlZWC9jTkYwODFiV0RjV3NaUGJJZk5qUC9WQlNWQVg1aTFIem1VOGVXZVJN?=
 =?utf-8?B?cmFHWU1lWDh5V1E3MnZpdUhPZ0JPRDN2SEhIVGZxSW51MURYNE9zU0UrTEF5?=
 =?utf-8?B?eTJ6Sk5mQkxlUEJiTXVJR2VpV0ZlcnBZOGg1U0szOWlrV1d5Qi84aEdBalgv?=
 =?utf-8?B?aVIwZGZ4N1BraGJZcTBFeERUMk5RcHdSMEIyWUVwVDhmclV6VW1ySVBBbHcz?=
 =?utf-8?B?dXJkMEFtcWNvNlVqckRUWmJnS2l6TEo3anBMYXRONDFaN2lUZzNXR3JLU3FZ?=
 =?utf-8?B?Sit0VWFFY2xsekxUbUhDUGJIQTR2UXczVCsxRDVQVHl6b2c2cDBNd2NhajlQ?=
 =?utf-8?B?cDNNQnFwaFhxaU1aL20xWnBzUms5a0ZQWDdmRWNoci9nd0VTOVp0OUdKMjBJ?=
 =?utf-8?B?NWdmb09YYVFqN2NtVGZaTEZBbW5mb0JyZ2pvbmVOckQzcyt4T0Z2dnBBaVJS?=
 =?utf-8?B?bEs2Um5HSHVERHR1RUJrVkU1QWdxTUJFUW84MGdldnU0WTFKY1k1QTFMVzg2?=
 =?utf-8?B?WnNwNi96MHhpL25jSkhjZjVKM3RURXBOTExyMUhNNE1wU2VqL1BNYjdxRXpu?=
 =?utf-8?B?UHBiak1MRVJ6eWRZRWExMGFKeTMybkdHZzA3L2hkTFFmbGRVeDluTE1DUWUr?=
 =?utf-8?B?SVRSVnFGOTlZcDA1MEV5bm0wTHVyTkQybjd0bVBxUG05cnVrTzdzNW9rRlpM?=
 =?utf-8?B?YkxnWUMrSkJoOHY0RXJHY25WVTJaV3ZuZS9ZMXdTNlhPMlFqOE12cVRSWFZW?=
 =?utf-8?B?aWQyeWNMSHVqenhGWUE0S1phb2hJQmU5SFdFbzJUdlgwc3J3UlhoYmxzTmxS?=
 =?utf-8?Q?oEaw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f05d56-361a-48f3-acee-08de39cd5700
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:22.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUhe20FHEw+cAB8bR9Sj+lWVhFIA4aPjf2rMqQtMZxj3LsNEck+G1SGSILzG6qjSG6RguLiRuCTpM08qmfVAYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_142534_004072_88AA06F5 
X-CRM114-Status: GOOD (  13.71  )
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

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 14 ++++----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b154bdd7f2897d9a28df698a425afc1b1c93698b..5b12af20cb37156a8dec440401d956652b890d53 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -767,9 +759,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 722f3e0011208f503f426b65645ef26fbae3804b..e074a6375f8a6853c212e65d2d54cb3e614b1483 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 1b0add95ed655d8d16d381c8294acb252b7bcd2d..a1656b3c6cf9e389b6349dd13f9a4ac3d71b4689 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index f1fc1060d3f77e3b12dea48efa72c5b3a0a58c8b..c12cc80c6c99697b50cf65a9720dab5a379dbe54 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 	/* Set consumer cycle */
 	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,

-- 
2.34.1


