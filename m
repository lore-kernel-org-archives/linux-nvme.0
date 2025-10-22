Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22913CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 03:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EiNcF/m7QpmV0x7VaXrELwWw0nrc0yRk9B6xO3wBEyA=; b=bM+7rbnbx5RYM62hM2QPgK6n4x
	B7oyXmqZtoxNTZKNwsa+LoVXMp040P9JxSDztt47FLtTHZK0UWnnV+SWFWjLkKFDdfWgWw+yPq56r
	v27xxaoy4eGvhNyrpmJzzQ8i61lUlarMVeHDOUnUhZlxl5Z6LC7VxLciS63EU6o6Mo9//qo+jixNf
	9smNfaOGWUGHIIFoC7X4VdvYxXCU7CyyKC4LbW4FZ11njJLxVxka+wSxO1FzRBzMxxB+TveQz458z
	QKnKFxEddZtRXWyaLsZNcOjtAp13Kwymjyfn/ZHr5Fj5c1wMQbgKakv5Zx35tRY+dQFDiQEcKaFnG
	AYIuonzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBPNB-00000001JIw-3b8I;
	Wed, 22 Oct 2025 03:18:49 +0000
Received: from mail-centralusazon11011019.outbound.protection.outlook.com ([52.101.62.19] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBPN8-00000001JIL-2VYn
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 03:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKmMX7prjBHz3qVsdXiYW0ositHoHKPp0hcz8x7uRU3IubZMtMz1Qmqvoz2+y69579Qn773V9w+s7cxCRHNTfxSMYYEW4H5mkDd7+qY/755tMEB/lepqJNCxY56pepCj0R8WSFGSQE7fX6dqBo8b+K0XKwtTOw95EN7xgiE4obzUAybUZffLVn743WtqSK9ebG+Yr8uF2ccGhcYyDg8VXIITBCxDHjl7l1inC8e8Qq2Pf8KZSfw3MhbaANKNw/U2OUR7uprQzo8sMwmb96DRQDF+2Gwx7rr2JRy45rfdwbEFu1WkGPOWPA51zAH8xZkSaCebSHGmWjswqHHbMnz2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiNcF/m7QpmV0x7VaXrELwWw0nrc0yRk9B6xO3wBEyA=;
 b=ql8EqIzvzoF1igQeqnNz0N1Sel1v/JihB77lHwDTwk+OhKJK8dWBpBYTGQjNU/ZQ5JwhnUz9eKMF8rKHQlH/eRN7V2oEBBjBc5CAdPwiDqnhzCGuk8yWfi3sxgohj0GzrylnC3vTjAXkEnpWkCgHjgYh7vMQrSOz63IsJiN5i8Vl0gDCu8F8o8dqGwZJjQMuKQrY/EoFaurThBWTqOppU2zG1ndSHWyghbglmesiSA1ge5ronVW5/BS0PYDjAQ+MzE2sUx8axlALsFgQUowRUIXaO4WsHUF5OqqRUyt67iP2TuM+GoPg5u3Y0sFF+VhC2FTxNpwm1UhNFPA8tETf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiNcF/m7QpmV0x7VaXrELwWw0nrc0yRk9B6xO3wBEyA=;
 b=HxJya99RxHL4ZnZpCA9jA/qlmJV8sWq11rRqd7QtGwSIZTAo712lwE4VaLtfx3O9eQrPa3onqa0gNKYatJD2AoXjld33BLaQtFAJYGPFsl3n/l4mH3LecrQ1jjhhplu+Ktayb8dZdW/M6q39fOMSQTAIYpGqvn9qtD7I6w3xq1HOwHW1CLYnEAWV5ThvLYj9rH0G2HLrET0ccuP9XxWk3ivqe+DTgf7Y8rc67DTKWWid5VBJ8or8F/qZHcFg1e+Dau00dakf2RG2bHWu/HTAfNAR86woM4b59nTEIhOXA70ZVjQ26t0QoQdYMsWUYZF8QV4JWKbxb+UTI95UcxYlDg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 03:18:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 03:18:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: use blk_map_iter for p2p metadata
Thread-Topic: [PATCHv2] nvme-pci: use blk_map_iter for p2p metadata
Thread-Index: AQHcQp4TAGDv46nkY0eAEj90NS9karTNf9uA
Date: Wed, 22 Oct 2025 03:18:33 +0000
Message-ID: <93b7376f-b91a-4054-b8fa-96209cf7473d@nvidia.com>
References: <20251021151831.2009152-1-kbusch@meta.com>
In-Reply-To: <20251021151831.2009152-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB8126:EE_
x-ms-office365-filtering-correlation-id: 1ecc7e7c-0839-4aac-6854-08de1119aea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WFlpMWJHcEF3VXIwRStvRHE1WG1rNXl3NHlNazJ4YUp4ZldpYXRRTk13RjNO?=
 =?utf-8?B?bkpLYTVkRmxHUlhnbXFzUU1Ya0tzYjVVOFVCRzBib1hQNHJHUmlGOHIvMTh0?=
 =?utf-8?B?R3d3UVZMRkxjaEFrQ2RMbE1QSFdsbnRMMW5GbnpVcnVENGVMWW1qaFVQZ3Aw?=
 =?utf-8?B?bmlWZVhCcHVsUXg0Q3VSZG03RHFHTk51WkNKaEl6S3g4alFxRUlRMEhsajdF?=
 =?utf-8?B?NFhXSFlrYUFDMDg3NzZqSGNHQlF3M0tNckFGSlZmNXpVQTVqb0FKVDN2VXBF?=
 =?utf-8?B?aDBYdlJJci9KV3dpSC9adnNtempOcmpxakwwcUc2M0kxM25ZUFRZdHNaSExy?=
 =?utf-8?B?N2F0ZGRoN2tmWEtZMVUwTWR6WmVNVEhnWGl2Zk5NSVlWSDd6R3llT1B0QnA3?=
 =?utf-8?B?SXozaTdlOUpCbzFGeDBTUSs4R1drc3MxZ3orUkVtVmdBVXhXYzlOQkJUWXU2?=
 =?utf-8?B?Ni9MT2N5SWtseUw1SnpxbDY0eEEvQ0w4QTZDc20ycXdINXozSEZYaDI0SXVu?=
 =?utf-8?B?ZUszQktWSVBhZFdIS3JBZHZPOFlQNS9KNm5Jamh6RkVuV0YyQ3FZTVpOd1d6?=
 =?utf-8?B?Um94STV3VnEyK3JwYzJXeElUMWhCN1pNaXB5MzRRRC9vQmFGTThoekU5WVdB?=
 =?utf-8?B?QzJuK21ub29hRnVtcXRMZlBUMG1jNjhiMGVCMTNneVRHOGQ5UFRiKzh2Z0xw?=
 =?utf-8?B?Y2k2OFNJNUNmNGVkZ09FUThiUnhSNUNjclpmVCtDY2Q0d1hmZjN1YW55OUpy?=
 =?utf-8?B?NlQySXdGZVpsZDZLeWxsMVNIdFZYQWp0VWNIV0NXL003U3Q5cHQ5UXEwellv?=
 =?utf-8?B?bSswNlZ0YWhGTHJQeTM0T01naFd3YkJYNGZjWG9STUJMODBIOTZrcVBWNC9l?=
 =?utf-8?B?VnJ2dnpONlJYY1RqUFM4Y3p0U3A1L2RaeVpkZ1BxR0VtdmdRNld5TE1ZcHh0?=
 =?utf-8?B?SWorZGo1MlJKdWdHMVMwaDRNYjEyU1lubUZKVVc5eXlSSTNXTU1kWnZ4UGxu?=
 =?utf-8?B?a3grbzhGSzV3K2VDRDcvVWlwMGh5bDRMVU9wR0tkSlhBa28rYWJtT0ZaMVUv?=
 =?utf-8?B?Sm1xR1ZaRWFWeXhBSnh2VTRjNHNwcmtUbWxiazU5cUJjMXdiK0hmWjNJTUVY?=
 =?utf-8?B?MTg3YkZ5bFNTUjFsZm5PMmp0bTBWR1VaYUllbDNvQWw4ZUFJdVZUV2IxQ2x2?=
 =?utf-8?B?ZjdvMzV3UTF0Yi8vS29zYUQ5M1IrMCtyV3JpUmxQTHdJY0dOYm9Kai81RU9r?=
 =?utf-8?B?Q2pDcWx2aTdvekVlcEhsclZBSDkzbjhOVmQzVmUydjhIVXNSdU5PRXJ1Q2tK?=
 =?utf-8?B?WmZOWkZWR21PSEh5VlVmL080RzNPNDVDbzc5bndhR0FIMlZhSWVGb3FRd1Bi?=
 =?utf-8?B?dnQvTXN5Zys1Q2g2U3Y0N3QxeEJxUVFxVlluNU5qK1llQU1zQWsvNExKaGtI?=
 =?utf-8?B?dEM5dzNUMnMrVmJYS05ERCtEQ0pjSFhRTDZWS0YvMWZreEhnRFlZYXhhdG95?=
 =?utf-8?B?NEMvZmNmWjU3bEw3eVJlZXJsZVhibVlKRDFTeGx6VHFlSXhXcVlaWittb1ds?=
 =?utf-8?B?L2RXNFNLYk1yem1sLzNoYW0zdjNDUUV6U3hUZytFUmd5MXE5YWtNL3NLZTdz?=
 =?utf-8?B?NmVKaCtSUXZLWm1ndlJYSGlucitzcUVqTFMrUFQ4NmtjY1FkZm1yeWFhMHhR?=
 =?utf-8?B?S0oxR2JGc0xKOVIrcEVvcVFmcXpXaE1LNXhMcjRpQXBPVXNFZEVKdXRWcito?=
 =?utf-8?B?N3kzZUU4eStpSHNDU1grQVpEVGhTSzJWYk1UczdBb3pSbU9mUEd2MlFacGpB?=
 =?utf-8?B?Nk5CYkFtNlZveXlveXhONE1CdlNhc2xUSkRpMmdJS1V3Q1FtOFRiOU9tNFFo?=
 =?utf-8?B?Yyt4WVM1L2pxamZWUE9LWVVWTTM1VG5rd2xCdDVSV2JxS3NzNjVXRWgrQjIy?=
 =?utf-8?B?ZnFIeXlxTXkzMm1KM1N5Mkg0S3NpSUZEMGdWK0Y3Qmh6Y0drZnIyMnlQUEF3?=
 =?utf-8?B?YTg5K1NnL3JBWFFoUmJTMWRibmNuU2s4N0hyMGZBb0hrY1AxT294b0hOU0po?=
 =?utf-8?Q?Y8k1Zx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE9ZV0FhRDE4UWhwZHVTZENIZWZRMDBKanZIYi9jSWJnKzZtNk1lY3dkTFd0?=
 =?utf-8?B?R3l4NHBsWnN3dXhKRTJmQjJUV0ozdkxlU1g4cGkzWXJOMFo3cFlsZmVVNitk?=
 =?utf-8?B?Si9LcDlJWmJlU1NldXhYT2k2S1hBR29DVFRqdmNrVm9WYTZlRk40WHVxdVcv?=
 =?utf-8?B?WjBVcmluWlBSY1RxMnFsc21VS01WbVdwWVZYdFlWajc5ZjJYQzNKdnZNMG1B?=
 =?utf-8?B?ZzM2RTQwK0h5MkJmUDZZRVhKNDJEZ1VqYWFpYWdDSlBJOTNEOEF6ZkJZSDFX?=
 =?utf-8?B?SFd2Znl4Z01ZT3RiMGd5bEw2ekhKOWlNY05QRHlGQWxpSkFyUW1aUUxXSWJu?=
 =?utf-8?B?M0oxZGc1U25zdGRUeTIrMTFuTXlLVzgvU3VyVnBOb1pNeHdCSjVVUVpmQVRS?=
 =?utf-8?B?NWpzR0FmMUh3NS9WcGhRclZrU1kvMng0SEFqdDFRYitYY0cxU085T3RGdnhQ?=
 =?utf-8?B?eUxibXBtaStSa0pGNHVHWDNpVWNyb29peW4rcmpnME9wOXl6N1l3N21neXlP?=
 =?utf-8?B?TjNnV3lCWW9WeFQ0MEdTS25OUHNIVWdkdEVheitSa0FvTVNWVExpU1FHalZ5?=
 =?utf-8?B?STRWRVJzUFNOVHJXS3loMjArSHoyVnBpSzlLUEZvdVNaU0tybDhDNFNYR0ZI?=
 =?utf-8?B?R2FOWVEyblgxVVVLQ0Ftak5WVmpib29EU3ZiVEtZQjBPNFRFNGFsQUVWVkYr?=
 =?utf-8?B?RmhNa2hOdThrMU9WdnNlUFBlYXpTNkVnOWU2QzI1b05zSEo4a1k5YzNBa2tl?=
 =?utf-8?B?YjBjOFhzWGpSTGtEVDRhWURva2NJODhEZjJBaUxiYVZybm43WGFNSGNOYXkr?=
 =?utf-8?B?L05MaFU0amd0YTIvb0ZDV0NIa0tjWUdkYjk5R0ppcnRjWmZOSGJEeWNqcFZ6?=
 =?utf-8?B?MzVTSTd3RUVoWlVzaU5aNDNLczJ0eW1MTDZDakhIRms4eWpFQUNlYjNoOFZ5?=
 =?utf-8?B?OFlITjZtWVBleEhtRnZka20wV21lU0c5YkJzQVlQODlMN2RjL1F4cTJBdWE4?=
 =?utf-8?B?ck1UNFNKY25HUjVTUk5BdzUrUzZZT3NyUzJHUGhScnRveDlVdzc1bVZBVm5r?=
 =?utf-8?B?dUgrWFdDSFpPVFJqbUVXempJSjBaUzJLa091VFVQZmtOeFJhZHRkZ0hwUUox?=
 =?utf-8?B?M3NIdjZlUlptMHRXUzZGSnViemdKWkw2bG0rVGlsTU9wZXhOYXVYR0RzbEFV?=
 =?utf-8?B?ci9TbTVmTHBGdGZMdHlEQk1OTjJKWVI5RFpQMkZhZTBsRnNzVUJtSWh2ZTkv?=
 =?utf-8?B?OXRncEdqQzE1Y1BJVFNnNXd2VXBKcXFKOXN0WWFDTTZYdXpkV2VOVHlHL2dR?=
 =?utf-8?B?bCtFL2RuakhaR3Mwb05YQmhVTENCMzJTeUlERnZWM1hGaWZWMXc1a2J6YnlE?=
 =?utf-8?B?dUk3ZGErN2ZuK2N0UlVPV09hRlNYc1NNOXdaMkU1aHU3QjVOZkt3YStjTGYz?=
 =?utf-8?B?ei91NE13aXdIUmV0K3ExVlB5TmJHR3N0dGdHWDVUTDJKRmE1aHkrNnhJK0lC?=
 =?utf-8?B?bDk0NHRKKzNLTFd3UGVSdmVYMlNmTVllTDNaOGk3bXJ0d0VJTjhFdCtQSWVa?=
 =?utf-8?B?YlhXMU1OOGpGU2JlTTM3L1JIUGxzSkd3UmpRT0RtdnZqUzNHU3pGbURCTGxG?=
 =?utf-8?B?MXRYUVQ4N2s2b0tIWmJJRFJEbHkzbzMvR0RXR0pKcmJlK1hJVzJYeEVzcksz?=
 =?utf-8?B?VzJLL0JTNEdldjZsVkdXTk5sTy92L0xqSXVBVWlnQmN0RW5nRVBxUFB2N2c5?=
 =?utf-8?B?a24vYXkwdmdGLzRYeHR1cnNYZ3lVSmVpSUxsZG5xVXYrZXduVERaRmM4eXNG?=
 =?utf-8?B?czdTUi95YmZ5a0djUWZ6YTFicG9kNnR3TkFTRStOd2Rib2FvSXFrK2tyU0hR?=
 =?utf-8?B?SXJwYUg1S0ozU3o1Y0NELzdtTjFudlRMUTF3N2pRYk1QcTdBRVVnYlBYM0tr?=
 =?utf-8?B?S3RGK05BVkcwbDRBMW1ESjVqbW45cnVuSUhVbVE1RUVjMlFVcVVTS2FXSE9j?=
 =?utf-8?B?eEFVajhPS0lKNitFeGJGcXlUN1h2akJWYkhnUkxLVzNXaEhyN2MyanpFVUtQ?=
 =?utf-8?B?a3hiMUhZaS84am5mQjFkS1FEdUs4RlpBTHBHTllwMHY5ZUZkR2k5My9SVkJQ?=
 =?utf-8?B?cDg2U3k0OW1KcjJIZnJ4UElrc1lWaHJ0Q3ZFTldHWHVhOTVRSkhxa01vTU9C?=
 =?utf-8?Q?xeUAO32V0la04OCi2uKw0xvRezA2SEW9MZbaQ7Nfztve?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A8D95A9648AA9449F6A8939B89153E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecc7e7c-0839-4aac-6854-08de1119aea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 03:18:33.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ0XWT5X7Ntuj/U7+iMS1jr0PfuU9L0KEdLDYo1IzJvICIlcUl4JukM+fkS3asL9PaPJppqBSei6dLhL3gvzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_201846_665294_9DCE4C1D 
X-CRM114-Status: UNSURE (   8.66  )
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

T24gMTAvMjEvMjUgODoxOCBBTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1
c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUaGUgZG1hX21hcF9idmVjIGhlbHBlciBkb2Vz
bid0IHdvcmsgZm9yIHAycCBkYXRhLCBzbyB1c2UgdGhlIHNhbWUNCj4gYmxrX21hcF9pdGVyIG1l
dGhvZCB0aGF0IHNnbCB1c2VzIGZvciB0aGlzIG1lbW9yeSB0eXBlLg0KPg0KPiBSZXBvcnRlZC1i
eTogTGVvbiBSb21hbm92c2t5PGxlb25Aa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2Vp
dGggQnVzY2g8a2J1c2NoQGtlcm5lbC5vcmc+DQoNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0KLWNrDQoNCg==

