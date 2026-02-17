Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE169E9A03B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lyVNXYBjP4tgMMK5nmUf+lhc+0h/vmffWhSQqjWxNTA=; b=gaDmoHvcQnxknvg9bqdSqigPiW
	1IZozn7LwQRMgI4rauv0dTVuXx3midzy+Ja7ovuObJ2bqqdcDK0P0R3rrwU33MV5DBB0antgrGeut
	DzXkko2yHsuEDVpVqkZm/Ia78+//j+y5z2isNNS+OTTeWHjQUB8E1pHVenjDqqT6Jr/m3Bqumo+VA
	fMyIpmyvgVj+mWJbL01HppQCUS78H9EptgqVKp3Lf2AceynwGpLs2v5c7/Rx6rkhVeaVbEnBMhIJL
	yiCO51hgfQuWz6drUJkl7nGY6HPO5tCF86Tw99stmr77d3ew3elTDifdIGfRfY+nm7eMHiOe7U+xk
	QKSu8YUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsSWC-00000008u54-3hPu;
	Tue, 17 Feb 2026 21:22:04 +0000
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsSWA-00000008u1c-1Ae8
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 21:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZLoknw6GA3OgEaZhwCITSgzOULctXYPZpdjXarzgwkOru5g4F8r3enS9dw+KyFPgTllDGLI77A4EOFdJ2CtlUI0vnDcdXKSenHLn+k642LwhkgigfSO0/AXEwXpGvil1yUNHD3113wuE30znugRMfJBdxhcgCrsC5TJR9w+DVdneyLx5XLjm3A9PuK0voqMK6I03c24maDXHrWvIIC1Ky1WwTe97qKl+vBirF6aavJ4zI2HkJsbXmKc1GG1MpJ6r1NK1NwN3bUL3SinEFMdK+b2ViP78ZPctWY0FmX5fBFbuiziqw7+mxagXJoIVii2I35k4TgIpSG+iKpiQKA6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyVNXYBjP4tgMMK5nmUf+lhc+0h/vmffWhSQqjWxNTA=;
 b=bwey6IzYpXfRBWehZvpaAau/TE85g8/6b7zeyVft3U1s3+nNlnVWJdb/aQyJQAbf2ghxcO8b7+n/9PaDC0zuhPS8dxokU8N/PBGX488/gVX9J9FD4TNgPfPjbtofU7zDb26/mmR1AN4R8WRsYCDn/YVIYSCxK6DCnhcY9g+lXthyVtHg9G1a7vc3nawFDfxXJvBYCUIcHWA7kbdMSb1zC/zBaDBp/S0d7hsfzvpOFAGl2iSp+rIg/9SSaldW/2UqX1IBsukqjFLoHlhyGmyGjff1KVKRm34Z8b9IQStaPZa+rtUPKARjIqlXCbZIUbVDm2KCBjdznYE+exzwvlrjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyVNXYBjP4tgMMK5nmUf+lhc+0h/vmffWhSQqjWxNTA=;
 b=caybVLSB1asJLFrFzypCAgJq9R11l6VyhVfgzPDpTbYIbu5e+zxAG74Qi2wFnPWIherJgCXE+uo7Rkl0vWXMuVljjXa/8FaiHwigO8JxFU+rY6ISJ24ko2fDSOhO9FEP9FwKHtEgCI/t2pM+Kqbonb+jBzKe1qAqANfvat+BpNCU0Fw14bCDwjpqo4vXWAwJLqsP9Pv0DARXSmczAriOReWqLIY+/GWqhy0HCCPhGbq2o5s88IcI8NoCda+MJQamsGfu6Wbcs58DiwZpKgNPIl/72WjIYbbIzI6suk4s1umMXQ7OsRU1eYufb0ey79Oc3zu3zcaXac7A8UoIKAckTQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:21:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 21:21:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"dwagner@suse.de" <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: move async event work off nvmet-wq
Thread-Topic: [PATCH] nvmet: move async event work off nvmet-wq
Thread-Index: AQHcnhmDzmHkrdRbxkuTS2nBwQNI07WHNuoAgAAzwoA=
Date: Tue, 17 Feb 2026 21:21:54 +0000
Message-ID: <312f20fd-c22f-4a72-a2b7-8a82f358f854@nvidia.com>
References: <20260215012151.11684-1-kch@nvidia.com>
 <aZSwhqJHPmAFcvd5@kbusch-mbp>
In-Reply-To: <aZSwhqJHPmAFcvd5@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7106:EE_
x-ms-office365-filtering-correlation-id: 89d5d216-56a8-4d57-1497-08de6e6a92f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NEtyTW5wMngrN1dsMjB0QlJZd2tOMkpQTHYxSVJITFBPV1ZYSiszWVdqN3Y0?=
 =?utf-8?B?YU5rSVpvNkdGVCtGMTBObmxnUUNQMDA5elo3SFc0Nll6K0VpbjNUU1pYb2lH?=
 =?utf-8?B?WXNGQUsydDFjQ1ZlcmJWNlBkclU1TTY2VXM4MC9IeGJzN0t4SkREcjFzcEsx?=
 =?utf-8?B?bjk5bXRCbEFFWVozZVBHZStkZ2duZkEvSWtPbFUyZzl2SnJvZkhtb012Zlg5?=
 =?utf-8?B?djVJbjAyZzhuUjdnbUxCNFZLL1BhYlEwdmFIREhrTXA2cFZDUGZzTEVxbVFl?=
 =?utf-8?B?TTc0UkMrekMyRzhyWEExM3B1bGxER3Z3SERqWW5zelVxdHIrbTV3c0EwaWlH?=
 =?utf-8?B?YmxPa0wwRXpRR1pZYnVyOG5xREUxdnY2SjRGTWVUN2tVMGhuMlZSeDdYYkRq?=
 =?utf-8?B?am1JVHo3bWtyYlowRDQvZ3pGMXdKVGtFWmo2Q09qdGtvR09DK2dvbHA2SWFP?=
 =?utf-8?B?aUZOb3hFTEgwQWtTbjNENUdKaU1qKzk1K3E3Qi9ZNUx5dkl1eW42dGxhZU9S?=
 =?utf-8?B?VEpKUGE1dzMwa3JuTTlMY0hOWnlWcGhDS3VRc2I4dzA0WUh3QlcvNFFTckFI?=
 =?utf-8?B?NU0vQUwwRks0OGlIRkVzZWR6ZUtCSWc1aUNyS0V4U01pcUQ0aHp6OG5GeHA4?=
 =?utf-8?B?Y0RMbWpMcjloS3hJRVJLV3BDMkFWMGF3TDlISFRkTzRpdjRPTCsvM0YzelFa?=
 =?utf-8?B?dmxtMEx6TUtBYkE1Z2JSQjhBUTd1UFVuQWd2RUVsVTJKS216TG1CU09wU3V5?=
 =?utf-8?B?RXg1UndmQzljS01LVEkyNzNrblR1R1Z3aGduTGVod08yckZpcFJNQlF3Zm1D?=
 =?utf-8?B?djBNeTY4SmtHcEJiNnc1UE5hbDQxRGViREwzR1gweUUzaUQ5cE1OTXc3bnRs?=
 =?utf-8?B?RVdpZTArUHpJTG5hcFFnVVYxMzYwZ1I0Z0xBQUZ1THVoQ3JKS1ZyL3BYdy82?=
 =?utf-8?B?ZlBBVTZDR0ttMzRZTG1ZQ3pKZ1V2VXZxanUzNkU1UDBWT29UbDdNQmN5L0dN?=
 =?utf-8?B?THFoa3QyMlpwc2lVUUg0bHRoUUZMTzdKZU0zZXZLM09TWkFqVG1zc3BIZVho?=
 =?utf-8?B?Qk9ZZGtacXVnOGw1dUJ2R0E4TVpxMjEyZklSbEJsdHllU3ZxNWtaRG92WWx1?=
 =?utf-8?B?M0pvSnljNDFWY3Q4UU8zT3BrZlJOYjNvMHhEOURYbFJ0K2ozQkZGTXg1bERx?=
 =?utf-8?B?SlpVMjcrR2FDRFBldXRKd245U3FEL2lCNDgvUHpweUl5Z1YwYVc3M05YV0dE?=
 =?utf-8?B?RGlwZGpwcjg0RHREa1Fxcy9PdFVtSzluMmhFSkgrbTBROFEvVFRuRGs0VlJx?=
 =?utf-8?B?ckZOUEhuaUxVV2wxbzZTcjEzRHFJaFNTZTl4RzFCVHZPZGZCbTVzMVFrSXRJ?=
 =?utf-8?B?Sm1Gayt3QlE5aE1nb0NYd3hNMWlNNkRybVdhd3hMUWpNK3Rra2x0STZLbVYy?=
 =?utf-8?B?ZlhhUHdndW5UeDNEZ2p4U2ZYOUo1aWh2ZjFnZ1llekdUU1hYQ2xwREJLeWtR?=
 =?utf-8?B?UUFZOFFBUnhmSDdaS293NjNmdG1mSCtnL0htT0dZbjRmais0YjhCN3l0VjBv?=
 =?utf-8?B?SmpOdzkxWXJRUXMwcUdoelU0U1ZTVGZzZWRtNmJEaEpyangxWm9tamVWeHBI?=
 =?utf-8?B?cDVMKzlMQ29iSlp0MVhpdWNUaUVqQndPcmxVUVFucG1lUWRWY2RsaTErc3R1?=
 =?utf-8?B?aDQ3SHJsLzVhemY5eVlFbjMyVVhoK1lLTzhQdnIvMGR6dHVZM2VFellzVUNa?=
 =?utf-8?B?S2VRSHEwWVZMZDJzYVhLNE91b1M0cDBpRUFHbmRZRnovdlQ0NE9UZ2c3VE9l?=
 =?utf-8?B?NENoZmNnREtGdnNKQVg3b1NLZE1OUVpZOS83dDVlSWQvZTBRSHcxNDhybFhw?=
 =?utf-8?B?Uy91ZXhnSi91VmpVbzJzWG1lanNML3pHT0hkNkQxMFFuZStUT2FaUE9CMnZv?=
 =?utf-8?B?UUhvVnZVbEtra2FFMkxLZEtZaFIvRFVnNWovMXNMdjhGYUlSRC9uYkt3Q3hR?=
 =?utf-8?B?eGZXZm5hdHdvQ0k1VkdLR1c5RDY1SUJCV2pGTlh3Wld2emRCN0VxYlZsNFFt?=
 =?utf-8?B?alFkcThsZXM5SFpaTnROcUtMRUpBY3c1QlI4M1FpRFVpc2lwK1ZjVHphRStS?=
 =?utf-8?B?M2JhSzBBRlVKNm9XeGJlR0ZEOXByVWtNUDRHSUkwQ0xva3ZHSGtGT0U0YWUw?=
 =?utf-8?Q?I0fjS34qKSC9faEykr0bPRY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnhZdXdNSjNrcHRIb2N6ZVE1TVVCNDFYODNaWnAzMHk3cjdncDhvdWRpTnRl?=
 =?utf-8?B?WjZMbVBKbzlhdVY1YzUzelQ4YUc3d1QxU0xsUzVwM29IdVplYkUxZHR1dGRt?=
 =?utf-8?B?MTdVTGNIb2U3a0hTMWdKeVlSTG9tYm5wcHRtMWpJUEt1ck5jUVc0RkM2cC9O?=
 =?utf-8?B?aDBseWF0cytlRmJaY3V2Z1dBOCtmVnpycTVWQzAyL25RMmxHdXJ2a0s1U0hs?=
 =?utf-8?B?a1VHaW1sL1JHY3psV2NaWmtiOGJRek5MenhHTklQa1dlc0gvbTNWajhsYzM0?=
 =?utf-8?B?aFVyUHRrcVJXdDBqQ0xKV09yWjdFSy9ITUtwRnl5aWYvUDRKcEd0cFZlNlA2?=
 =?utf-8?B?WXhCbVg0T200bjZpOWM3aW5lUEREbEt0Z0pxbUtLZzI4eWFPbzVwOER6TTJm?=
 =?utf-8?B?cGcvUSs1dytxU1h2NEErUCtlOWpFdnVBWXNGUWpCQldlMnFSR2tKdmNyVGxj?=
 =?utf-8?B?elRCWnJhbG1xSWI2RllrYUQwZFl1LzlsN1hvc2doVUlNeEdKb3JWTzc2SWlY?=
 =?utf-8?B?T3ZjVHM2Sk1nV0pOU1JzNGdHYXQ5Z0R2L0hDTm0rMFRwcUZOZE1pWjRzRTVV?=
 =?utf-8?B?bjBzNWtLUW05TnlPbzloclNJaTJpZ0ZTUEhqQm1rTVNGQVUyUVNTeGp4anBW?=
 =?utf-8?B?U3FtUGoyNXRiMjFJWGplNXp0UXF2WFM1SCt0R1FTRWh6dFRieXhvSVduWW43?=
 =?utf-8?B?YzVXZXlNWkl5cXJxTU5CNnRJV1ljdzNaV3IwdU4wUkdQaVJ2TzU5dU1QTXFl?=
 =?utf-8?B?SWdYU0lhN2NMK3ZyWmszdGJHeG9MTmV2MFM1dUFRN3FhTG5uQkZpTEtEMWd1?=
 =?utf-8?B?TVQ2WWRhU09CZUNiTkErSnVWMTFleDI5aStSY0VuRDh5ZHVmbSsrZDRGTUJ2?=
 =?utf-8?B?NWVxU2dzdDZPaGJ5YVJBbm5yWVhhMElMTk43UiswY0g5YXFoeU5nMDMwRVhD?=
 =?utf-8?B?YTV1azlYMHppUzVRSktNeGtpUXVqc2RiSitONm5PUUF5YU1sZGdjMTZqZEY3?=
 =?utf-8?B?NFJJNVhOQjd2S2JwYWU2ajdqUEkxblhlNzZsbktiM3ExdERlUmFrZXhQMEFT?=
 =?utf-8?B?SVJBR0syVEpOTVozWE1iQWtoNm4zM0tYc1h5VDFndUZBNFVhTDZGQVNxTU55?=
 =?utf-8?B?TktZQW9BK09oRlUxbGZ0dzVsN2tMVFczMVpsUTExaHF3UGhBRWVxQmNlcXZr?=
 =?utf-8?B?QThEYVcvcm9FVWNuTFVNbXo1SHFycXp1NXh1d1NpV3FLalQvK3cwdGtHdlFq?=
 =?utf-8?B?MENONUU1UTJuQ3BLM29NNHR2TjBzUDF6RDJYa3RSaExMYWhBRVh4Mlp6SnRN?=
 =?utf-8?B?c1E3SFV1akZSVUxRcml1L0FJTEppbFptVDZxVk41T2liVkVTMmdFMm9VdVNK?=
 =?utf-8?B?aEg1U2VYQ1dCQUdkZitBQ1lvbHZvbEt6Yk1DdEwvTWZTUmcxR2IzRXBKRUxp?=
 =?utf-8?B?VWxqTFc3QXBOYXhHRXJWTk14QWNhU3pKSitEd3pxTCtrdUpxQS9lOWFoOSs2?=
 =?utf-8?B?Q3RhZ0xvcGQxTnYyUGNEV3ByM09ESnBpSFJUd0hScWhzejZKUkZ1bllydHhv?=
 =?utf-8?B?QWhGQ25CRzl4OXNZajdaVDVFdHdZN2VidlJrWmUyRUFaS1RBajVUYjZPVTVw?=
 =?utf-8?B?SUtGTkhudkNBeU92YlNMTDZVM1ZvVkFQWFdnTGZUa3RvVSt6OWpwWVdURzQ5?=
 =?utf-8?B?NCt1VDNhTVJCV0l4RVdycFJBNW1HYlNQeGJkWUpXbU00OFVScWpjUU02MFdm?=
 =?utf-8?B?dS94b2g2b2RMNXRQakpkWWIwV242cEJUTElDLzNCbkU1Z2RpZUhEdmh3RGk5?=
 =?utf-8?B?WFVETytNbXJzQWEzV2c4eVNvTFcvR1RRdnM4bWQrL0Ezckp0Q1JpVWhwUXFW?=
 =?utf-8?B?ek03YzIyYVgrOVZSREtZOUtCWkRtcTVyV2o4RklYbjEwbDE0cGhHNjlPRVJJ?=
 =?utf-8?B?bW9nQ09LN3lLbkltbi9KRllCZnZ5eVNqY0FJV3cxcmIwTkFvYW81VWRocHFt?=
 =?utf-8?B?YTdxcndBcWptUnpFNk50c2VTTHhuZjNvZzNKYnpKanA4WVZPNG1qVmpScHFG?=
 =?utf-8?B?N0FHUmdiSVFFbkxNRm5sOEpJOUZ5SEFHTkttQ01lcm9qTVBWQXFRRExzUnls?=
 =?utf-8?B?MkFvM2l6YURTdjB6anA3RnFLdkFnWGpZNTVLNkNiNTVWSHR1NE5BaXRpSzlm?=
 =?utf-8?B?ZWRCVkllVWFjRFdkTGw2clc5YXBud0x1cFlqZE9kV1NsNGk5Mi96dTFoM2M4?=
 =?utf-8?B?aFhtVFhhVk1wK09HWm8yOW1QSmtBbFpDRTJRYU9ZRC9xSDMzbnoxVnJaWDhQ?=
 =?utf-8?B?bGtsakNXNk5RekJlOWlnbHJhSW1PenRSNm41S2htM05abzA0cXhKSGo1UzU4?=
 =?utf-8?Q?Xwgm9nLs8l3nvQ135SxSYBIpUGYKkoMfgT79F3EBJmiwk?=
x-ms-exchange-antispam-messagedata-1: 15fce54FuP91+w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3F2853AB0408247B0AB3B6B197C1EB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d5d216-56a8-4d57-1497-08de6e6a92f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 21:21:54.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQswj93ryb0aXqzZQmgu4r4llPASpq6M8BFEqCk1XGMC+5814BZwASWSzYXKWFYHNj6oetGyyRZ+xwsW8ScJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_132202_343604_EC6A53A1 
X-CRM114-Status: UNSURE (   9.10  )
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

T24gMi8xNy8yNiAxMDoxNiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFNhdCwgRmViIDE0LCAy
MDI2IGF0IDA1OjIxOjUxUE0gLTA4MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEBA
IC0yNiw2ICsyNiw3IEBAIHN0YXRpYyBERUZJTkVfSURBKGNudGxpZF9pZGEpOw0KPj4gICANCj4+
ICAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKm52bWV0X3dxOw0KPj4gICBFWFBPUlRfU1lNQk9M
X0dQTChudm1ldF93cSk7DQo+PiArc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKm52bWV0X2Flbl93
cTsNCj4gTG9va3MgbGlrZSB5b3UgbmVlZCB0byBleHBvcnQgdGhpcyBuZXcgc3ltYm9sIHNpbmNl
IHJkbWEgbWF5IGJlIGNvbXBpbGVkDQo+IGFzIGEgbW9kdWxlLg0KDQoNCnVnZ2doaCwgdGhhbmtz
LCBsZXQgbWUgc2VuZCB2MiBhbG9uZyB3aXRoIG90aGVyIGNvbW1lbnRzIEkgbWlnaHQgZ2V0IG9u
IHRoaXMgcGF0Y2guDQoNCg0KLWNrDQoNCg0K

