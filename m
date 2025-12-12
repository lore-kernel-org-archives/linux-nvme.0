Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A72D59F44
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dQA20LNG7+et9xWe1UisxhvgvcTKC8YogQGNwTftR70=; b=o49H3ayXz9FV8vDTplfbUdG2fP
	9uX2zc/fkLpA6aOfGoWMXSw9+nbnXUhXUmOD1kmMHySUFVtAEDtoz6aZtro4RdUK6mnXj/Xj7xHrU
	r05dTO2wV8xdj+SSXVt1mFxhJJ0z9An6jxVRL4UchYMVu1ylUBbM0viy9iyn1aiNjMWWc8h6RVDV1
	V3vWWwZpiX/MB+lAoNT71jlUruCO+CRohlBlOgJcMSFRUG9t+I2aiiFNe8pKYh4AAfF1gGEFMpnLk
	xGBkbgluhWy1r2trqiNQK+GF+h9GHflqIszIe03kZ/pgniP4jE+1yirPzzlUN8rR/gxWSrVSvDbZ+
	t15hsMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUBZn-000000019Pr-3m7U;
	Fri, 12 Dec 2025 22:25:27 +0000
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUBZj-000000019Op-0dXh
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 22:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmC+U40ywiyCEutWIWjCbMz1yy1lnDbD6cNS4vQFymnDk1ztpxHkBqmTWwv1I9S1wynAC/pQKytFGOK8N/qD2NdEGwyHdiKiS3el0D43d8rP2iTGqHsfJeKWpVBFJvJY+CEQHco85VDmxf8a1ibtmPhWxWy+DPBZq+IHbzj4Qmw0ANrdPM0c4oalbi5D9oTmlBowaljlqfnHXZ32Ldp0JFchlgr6UsrAkhrW7xu2C0XMSsbzyp28+BF+7j9lqJwJO5aC4FnsaAE4c63TDHBsa9CPmWC/BrdS665Mwe1ErRMuiPdG9NtLc2dVsLa/dLJaLHh+Gv7MUAC867WtKrT6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQA20LNG7+et9xWe1UisxhvgvcTKC8YogQGNwTftR70=;
 b=QxoJLDoKDiETMry+TbRJCJpgyLRuyFt0T+rSoCrPxLqEg/7GyXS6CxKlZS8WNkdcXo9QHRz8O9BRNI2vI60OfW6U1JM+KxSh8QBd/buPIIjJEbW2YO23ZGyo+2nTYrx+YDpumDM1gw9Z8gI/wM4heGd7c3gFt9IYtUm14bjvnnG6Y5n/Kn0cXVhyoGJKIvJ3+nJfbV7WRxjv6i2rRtIBiYyGLGSJufgjQ23bxjhzouX0o4log4gYFYwZC5YLatS3DNF12i7n/Gx6yzjG8lp4Uyd8HE3wTF5m+U3dhb4ZBMq/I9dxo9+E7TxofW+WGw1mcxyu9bFg+QCdFwT+jjSXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQA20LNG7+et9xWe1UisxhvgvcTKC8YogQGNwTftR70=;
 b=CV7yAGiyFTXmQO9Fo2U/TgCA4u6qanSR1lbfKoZqfp75nFQx6vBZrPhcB6qhmyu5Oui/R7jhvl4q6AE5HHIBXxIWO8jOhEpSfLEuyTKATTWdD1HwVyR4OcUoVfAF7yOIhsFCzlL7UHUGDunl6eQJeTcNWSIWbYqH6V+rOy8enjWT5ug+P/A9OUcOtINjGcV43MNOIvsepwdk2Xq2cfJINhM9KpR9Varze2kTkq7Y4dYgqBK2+EpABhdCnNjXOBt6OT2dvnt/vWeOTom5FDz58icr6zn00nl+3FTwua4WYPSHqEIZJ242tWcvyxXv/JKH0DAjtQzpdYd2x2kFWJHwww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:10 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:41 -0500
Subject: [PATCH 02/11] dmaengine: dw-edma: Move control field update of DMA
 link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-2-fc863d9f5ca3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=3587;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ee8HiqhZVyhqwGOSxl3X+NNbfup5c8f2QFFTSVFP+54=;
 b=ISCV+hGz57U3Z94cMs7Xivm/4iXJM7TV+9APS1GJVAdR+iJbQRsyu/KRwIWt64Ed46cqtlhqK
 WhQhyJqThJpBqkRpBL9IZvLEDk0VuMftwL+pjPUbiaTea7xhIju9bO+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f8e522-6a18-46dd-1aa3-08de39cd4ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE1FbVkzNFAxMWlQWDg3RDBHUnMvbmZZbmg1SmNqZzlrUWF5VytPblBRNkU2?=
 =?utf-8?B?cWM1cnRoellCU0M5aFkwc3NGVXZKSkRPbmEvRDg5RlZqY0tSN0M5TW9NZnZG?=
 =?utf-8?B?RjBDd3M1OE5EZXI4UDN3Uk1wVHVGQi9QRm92a3ZJOWo5TE1vamlUaFNWbUlt?=
 =?utf-8?B?QnNpMlFZQUxMSkExRzhUMWlmY1hlVWczcVE1R0FIUHJLSzJvdENaUWYvQUMz?=
 =?utf-8?B?ZlVMRUNTRDZJNEgzaXFGVU5Qc3JZcnhRUVNKRVN5Tnd6alVweFRpSzhkWVVx?=
 =?utf-8?B?ckdlU1p2Zis2cGlXbHZ1eFRRamxlM2hIcjBobGhTNitiSTRKbGExUDEya2ZU?=
 =?utf-8?B?Y0kzSHZwRHQvNm8zTHJ6REpORU44VnVEY2N0M1JNWVNLZHprTVhpZVNQTHZW?=
 =?utf-8?B?bS9YTkVHSU5JZmR1a1g3RUloZVBEU3FpWkU2Z1gwRDE5OGpVZlI0NnptUUtK?=
 =?utf-8?B?OG1iQTUwN0VydFBnQlVzRXVyY1JZL2QxVUhmbTdmWXdnVGgwQVJucUxOVFdw?=
 =?utf-8?B?Q0I5cXZGaS9lQ1JzOVh2dngxREp3Y0thM1ZGMCs0R0xCVHFsYm9SRHBDN1pJ?=
 =?utf-8?B?NEhvODJNK1pvQ3pCZEJoTldLTS9BVjZoVkZ2aVcyUW9WN1lLc3gxdUtHcjRw?=
 =?utf-8?B?ZVhpTU5aMXdBV2RhMTNlTXFWQ2VFWkZIMGxoYS9NQmw4eHNLL2p2cisvak9P?=
 =?utf-8?B?RDIyZ0dBMldld2pmTmVTWEgrSGdIQ01vSnJ1ckFSVEF4RTg5VFIwK1FkbFdZ?=
 =?utf-8?B?eDVZb0dmZTFldEZTT2tnNVdMZWhNd216aDQ0eUk3dzBPYU9RTjRSRDEwTmN3?=
 =?utf-8?B?cVlUcWd1T3hxN0ExaFAwN1NDWEtGSFBURzVyNXlNWk4wQyswRDJLRFBjMXh3?=
 =?utf-8?B?V2V1VjZZbm1sUEVkMVVPZ1JvR2hydEt5Wmh2a0hBZW0wL1hrWXZFM0Y4bFVh?=
 =?utf-8?B?bjY5dU94ZWNmVmd6Mmk1M2R6dXUyb200L2c1NlVhVWh2S1dPaEQxTForWUNR?=
 =?utf-8?B?WkZNSUw3NjRzM2lKb1Y2UjJCcFlZa1lYZVdVSUNmbStnbTg4OXFrZzcyTWJv?=
 =?utf-8?B?N0s4cUp6Z3ZJYTllU2JiQyt0VWZrY01vcTlIWDlhU2NWV2MvbWdtVHNmdWdk?=
 =?utf-8?B?U1FIUldZZnBkUDUzb1pCYWhkZ3FhWXBweEdzWGl4bjlLV3lWUjlRSGtTYlM0?=
 =?utf-8?B?OWlFRUVHaXFLUVkrUDlvM2Y2VFZBd2Z3dHVKelpQc241SnhiMEJLV2ZBcy9F?=
 =?utf-8?B?MkVZV01sYTFXM0hlMWpsSmR1LzRKYTdIVmc1cnRaejExd2NtTFNhdVFSZUZY?=
 =?utf-8?B?SG5QSXlmaEZhT21jNW5uVHdmanZoVTZBR2hjQ053TU5sMVo3U3ZMRFdRd2U5?=
 =?utf-8?B?REY5NVBaU3czbmhoTGdBWEVDOTh5Y0VUTXdvTlJBYjVIUXNmOHdXbkovdVRW?=
 =?utf-8?B?ZXJUcG41dE5rVWQ4NkYzK2Y1dStVMmd6WHEzWjlYOXAvRjZXYXMyYW1zNmU5?=
 =?utf-8?B?bUduZC9pbVNjR1htNmpvN2xTUnhjZUlLVzJSMWZwbHNaWEZuNTlWWjlGSlIv?=
 =?utf-8?B?cUlsd1Mxa3ZTMmtpNnpWNjZCMzhzTll5U2loZ09vSlJ6NFA1SHJKRmpjNEhr?=
 =?utf-8?B?OE1RUGJqYUpNYVhab1BhWkxzK3A4cDZuY2lmQkJ3aWtZaEluL2xUV3lmUmlO?=
 =?utf-8?B?ZHBvSkh6VHUyMjR4cytkVHJFSjAydXoyeTlNZVVTaW1WNVZEaTlIc0pHWEt1?=
 =?utf-8?B?RUpiWUg3c0JtbnI2Yjc5dDZaakt5USswS0FUTXNQbHpWWnBUNjV1S29TbmRO?=
 =?utf-8?B?MnVVaFh5RzR2T1V6VWdVMnd1M2g5MnhGamRkc0thUkN0K2NrQnpjdmtvR2Fu?=
 =?utf-8?B?QUcxcmUyQ0NsbXBpOVJXenJ5QmVMWGhJZ2llMnFQaGw3Z3R4TFRtVzRFWDN6?=
 =?utf-8?B?bWdYUENvT01QdWhMTHVrVkQvV1FzbVMrZU1ncnllZlZ3aVFtdjRxcDZxU1BC?=
 =?utf-8?B?RE1RTGVMODRWMTlOQlVDU2FyZkpQazcxT3dZRlhNdVVhS2czOWc2SGRFbnJt?=
 =?utf-8?B?TmNUL2FrdHFQV0JRdXdBS21yQndFMmVQSDdidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXA3UXpmSkVYenJYUmd5aFZjYU1BeU1iNng3SEhPZjFhQWpOcUc2N2FJSUVP?=
 =?utf-8?B?ZEZIZ1pIbjRoNmF1YVpYOG5YRi9weXd1d252Um1UdU5PVHpWKzN6RUkvTnZj?=
 =?utf-8?B?M25NM3lBOUJWTGsvMDdhMGdZTGp2SHoxbVNhQTgyejZLZ1RHWHoxcExXQVcx?=
 =?utf-8?B?MnVVaGxTS3NrOU02QnlKT0Z1WWdKcTF1blJFLzVFZlRKUkpCWnErTWZheHZZ?=
 =?utf-8?B?SUZ4NGdYWEZjSHQzdEk4RnJXR0dYMWhYbkNFM3d5Zmp6M0VWNUhPSFU1djN6?=
 =?utf-8?B?blZXcTBLanUzUndZSjlwTlJrTFZhTjRubU1vQXI3UEtzU3NkdDMzRzY3REEx?=
 =?utf-8?B?NG5IcGNDYS93K21EKzBUWlg1Z0g5djZJbHR1M21MMW90Q0RFMjFBR21QUE5K?=
 =?utf-8?B?bk5oRVRhOUx2ZG1Yb1ZURk12cUNBMllySU00WEszQnkrQnhuS01kZk54SElr?=
 =?utf-8?B?V2lLMWdkdzV0RXg3TUNmUE9OUWtkcURWMjVlME85ZVQwU0NpSDgvd2plVVNi?=
 =?utf-8?B?SVRSUTh2MVVyZ3JkQy84S3psbmt3RXROTkJGZktDZ3lJVEk5NGFqVUdRTFlj?=
 =?utf-8?B?ZUVRbG8zV3hmcW1IOEkyanVDaXRIc0VFWFR5TDN2UUZOVVZYdFlBWkZXSXYv?=
 =?utf-8?B?WDdtOGZRNEdrMXl2bzFCQ2dGUzFXUjVmUGVPa0xNZ3ZkbjBBanpxWklhd1NN?=
 =?utf-8?B?cm1wVnRVa041SHdveXlVTzdDVk8yUHlHd2NSTVc3ajBkQ0VWMXM2RGhjNGNz?=
 =?utf-8?B?Sk9FWmFEemFKaVFhT0VhYldQemtmQVBSaW5qMkI0QXV0ZTB0QXF1WXZ2OWxv?=
 =?utf-8?B?Ujd3UVBjSjZEVGYvMVZaTnlMSldaVkU0dVFsMksvcmVOZ0NnMUlzeWhRanFw?=
 =?utf-8?B?c3FKMUtFTWZLdmR4ZW8yUGtyT3ZrU0RKMHVPYXl0dEtvb1M1V3g3MzdwUTdr?=
 =?utf-8?B?WjRNeUFkL3BFRzgvcVhyeVpvTGNrN1hJem1pOWJiS05neHlrZFlXSE10VWFR?=
 =?utf-8?B?dXVXN01LNXQycmEwcDZ5cERnQWFBSkRBdmRSMnpaN2ZBalE0NUlmdXc5TG91?=
 =?utf-8?B?S2FZOWdOK2dFNFBhMFN6cGV3U01iZlZraTNydWZrS0pHSUxOc05jSXlhSXdF?=
 =?utf-8?B?c0JJb2ZUNjVZU1lBcWVEMXVqSEhPQzhmelBvTjlVMFpZeER4QmRuU2pNRDlm?=
 =?utf-8?B?UTFISWlyVCtub1U4YXQwdjBHVVAwaWU4c1ZvRklCbkNFTDkzNWxMcG5PYy9R?=
 =?utf-8?B?YTJvZVJsTWtubDNvQWlBdEJhdzBBeldVUUNSbTRFaTMzamZrMzNhME9UN1NE?=
 =?utf-8?B?cXdvV2NVbWM1YUlFMU9xc1JQZWh6OUpVeTVEcVVFOW13TkxGODR4MTNnWWVz?=
 =?utf-8?B?TzJjNlJwbXZjZGdNVlNqaGE0cU1YRmN5RW1zLzBNUVBzY3dBUTZkdVp0Y1Fq?=
 =?utf-8?B?WVVaU0J5aVduQkZOUGVCa2FUOEEvUGJpRmNlK3ByRHJxU1kvWStuUzNWNlI5?=
 =?utf-8?B?d2hNQ2FzZkdDOWFxdWQrRWo4eFJ2Y3BqRTBwaVdpRWFrTnlVelZXeW9EL1ls?=
 =?utf-8?B?WGZCN2U5MHFJT0xxQ2dFdzNNWmpRYmd3TVQ2dkt6a3NvVGJCc2tENjZDUUln?=
 =?utf-8?B?cW1uNTErQXJEZENsaUZ1dlg0Q2NEdkQrMGtzMktSMXA2dDBlWmR2UFppY1dS?=
 =?utf-8?B?MnNXeXZjaVUvR09MOFpHMS92WEpjd2NEeCt3STdZaXFLYmY0Z2dPUE9FeERR?=
 =?utf-8?B?L3EzdXdDYiszMnNiQ3NyQUFOMUFCTTRjUGhGQTJENWVHb0R6ZjJmK3F3S1lT?=
 =?utf-8?B?UnFiSFlhVFByaHNZSTdIMWlFU285N0QrQk1nZGViNloxNUV5T29HOUUxNzRu?=
 =?utf-8?B?cXpuMW9KemVhVnF6UlA1Yjc5UHpwSElaMnlDTlBQUEYzK2xpcERKQWwwN05t?=
 =?utf-8?B?UFp4aUY1R0Vqbmw0cS8wRXM5K0pkWFJEZ2lWTkFQTC8yTW9TMTc2WUp1NDdR?=
 =?utf-8?B?S2ExWUJzU0FwTG56d1BjT1NHWXBBWHVaNHZjd2xmQ1BLdXhFRVB6TFc4N1JX?=
 =?utf-8?B?eGRRb3NRVlU0RllvNFZVbGtXWjJZUFMwem91K2Nzc2NBOGFaZ3dVSUprMVpm?=
 =?utf-8?Q?vc4n7pu+trzPeTU7d4UkC03lG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f8e522-6a18-46dd-1aa3-08de39cd4ff1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:10.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Io14mMpAFrTm7VKZGEh+ZnYjr1zu7PFI5UJuJ3EHLrQ42jVDDwy7GeHZtcKg8h/NGYXVBRdOXso5Tkl/7kiJ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_142523_200922_6E3DAE2C 
X-CRM114-Status: GOOD (  12.76  )
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

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 ++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 2850a9df80f54d00789144415ed2dfe31dea3965..1b0add95ed655d8d16d381c8294acb252b7bcd2d 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909a1776bb5899e0b4c9c7a9d178c05..f1fc1060d3f77e3b12dea48efa72c5b3a0a58c8b 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 

-- 
2.34.1


