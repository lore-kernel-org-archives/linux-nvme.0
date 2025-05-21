Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DFEC54756
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 01:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PafsggKis9zZ2nNCit3eC+jHS2gFnmT+wPkImM17fA=; b=kTcip7A8FB6A2ZyqzRw6DBZwYe
	TE6v38wfBVpdGJ6Y4iLAbKcKUKfVsu+oO11zii1d84hQyLQPu9l6fqMxsUffsZglEGWtKN491cxyW
	oBJ07PdNmOY7evAH1dHzrh9uyjdwldtkBSFsEcx/lFtCeHvx3lOUo1v34LE2y2kgyl8YJYjz3PR7A
	p7dJ4sy8mxSWHPh8ABYUlRJEgzwsc7k5FMgHIKQv5DEv+K5bIEjNw/T8enLTldNQXVIn0ucDKsaXi
	E9KI85I1545UeroL0NyrBYUygKgYP2hVRcpiGoV7sbO+/cxPnPaOqbBN3Iz1PVImxpgplaHH6+Y7o
	SdNicMWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHYX9-0000000EWp1-04eh;
	Wed, 21 May 2025 01:46:15 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHYX6-0000000EWnu-3Msm
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 01:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am0Ew+3Eit92qjn2cPtN3q6owiOMpVaZIyJYkay+LcUQ5OG7KfnJvPCIWO84eOjfuz1PgHze9hDaUmn1Ov7X3bHQ1SNBAUEb8ztz6LwQJuakDFZe985ZGpUNpKSRe+B7U5BkGchhbTNWf4mcEucJF+pBUdAM2UVUuy/A1qminiYYUweZwo9Z9VzX9Aps797VHrHleeUJAfYn0VmDpxV2SqMZteVMFpnCzdKROQ9FzE+Rujds/rIUP38jen5g8LNbo8/Qc4Fu0VPaxJLG3AQpQbhp4ZMu6m27XTqRCRQvy3Vp9AQk2AgKwy8rGJ39ORjxoE/s8w1/ZraQvIKdDwhk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PafsggKis9zZ2nNCit3eC+jHS2gFnmT+wPkImM17fA=;
 b=h+HSMDJNadV9FJR5M7BwKdNanQjxx7PMYF1JtkYkPAHopst4FgMZVF/52YQg2H5DtEJ9fjhI8iLvYdYwXZjOS9LwqLx1wtx3Ll9n0naxqyMVLd3xmSQcRLHRm3/DNvhLp9ejcd0bcAL/WL5yuKW2G7pb7hRKbM0V57BGV7FtGjaV3XhkjKGAdDpdCk9YE+kOOwl2g1oy1K3MpM6HYOGMbR3iyQeECRF+9iBj7gHATnjScGeuKkZSPWg6MCrcM5qbhnF4jhnSyTrQsbKkyFQe+QMjF3YImdRvs9bL8vTYxUeVorp+wPqzN+Qh4JaANnGtAT/0zuOBV7wN9S84Ep7l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PafsggKis9zZ2nNCit3eC+jHS2gFnmT+wPkImM17fA=;
 b=CbqFoN2JGBfDbyBNoiTy7w9AqGr1nPVXVVZscjP64I/fAlSW9NrLeQctckbK9yalhNd0WocytdwdTiaPhgyo9RpvrvnkO1/fujO4xxqr2vNOeWkq5aui7s9UofXZxDONYBNGT5cxxKPefQs1YwSE8f1hN3pBKDZJDolBqU5ayvvlVbLTwFJ5H80VqaY7POqlZDSQpB7JYBhqnH3AHucmvbjB0YGb3jvJVc6OhvPXYwqkeN54JSSOrAGZ5lFi5GUgFNb8jfwVXilsJ6MYvTQLbOx69Bc8DEZgzuuXxeABOhajf5ir259mGAtkLQHxwQsCDPImUmX19B4yIMnHKaZC+A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 21 May
 2025 01:46:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 01:46:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix command limits status code
Thread-Topic: [PATCH] nvme: fix command limits status code
Thread-Index: AQHbycSyjaC1lRk9R0esobzMzVSxF7PcULOA
Date: Wed, 21 May 2025 01:46:07 +0000
Message-ID: <b5096d90-703f-47fc-85ce-862216212b82@nvidia.com>
References: <20250520202037.2751433-1-kbusch@meta.com>
In-Reply-To: <20250520202037.2751433-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8613:EE_
x-ms-office365-filtering-correlation-id: 3a34beed-f9ac-4cb1-628c-08dd980941a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nk1vMVE1SVg2bUZNUlI4c0o2T09oQ1ptOUhGUTZOS3MzUGkrZnJjcTFabmor?=
 =?utf-8?B?bllKSVBObjlIQTlCVFVLaTlpa25ZNGZQSERvYW1sR0Zvd0tzQ3ZmaE9rL0l3?=
 =?utf-8?B?TFB1OWNoSDVPaTR6dUxlYnBNOURNbDZmZmVTdzVPam1GUjhKMGNkYlBNS1Jq?=
 =?utf-8?B?R0k2MGtvVkV6OElvWVh5Qmc0a1VvUmpqWEF3eW9wOVlmb3NPMVEyYkxJSm1H?=
 =?utf-8?B?TGIvUDRybTRCTmpFdFNDUGlZdEpxRDljT3Z5SUNYanNsODdUUnAyOVlRc0dC?=
 =?utf-8?B?K1FsRkJMdm5MQm0wRXM5aG9RVDdhYjR0eTNDWGVXbVNvdlp5eWJ2RnhiNDFO?=
 =?utf-8?B?cTRFSFVNQmZLam1YTlpabFVDQWZRb1ZQSVE0b1NaTTdkdG43VGNHRXVCNnBC?=
 =?utf-8?B?YVM0Z3JEdmFMdlk5L3k0N01iMElwVnFJVWhsNUVEbDdCWmk3aFdDQUlzWG4v?=
 =?utf-8?B?WW55QjN3c0NpbjBreWowV2wyQlFFYTVRaHdsdVFjVnBTeFZhNFFNQTFCQWkz?=
 =?utf-8?B?WTFBVFdpZy9uYnlUa21mUmZwRTdxYlhURVZMdm1oQzRKbUVDbFhpeVpCN1BW?=
 =?utf-8?B?ajJyS01GSjF6aTNlMHJoSGFzWWtPVURNbWZUUXRxVUlRNExBM0dyTThlTm5r?=
 =?utf-8?B?djc4ZnFyQ04vLy9yZnVrQzF5NUxPcThCNHF2cGpYS2UvOVpuRXhaeStTNERj?=
 =?utf-8?B?YnFJamwrM1FPSDVTYVVsSVhKdnhLckJEWVVZUEtNeGE5MTBCai93RDBQQ1Fu?=
 =?utf-8?B?b0NkRFB4eFZMQ0x0SnZIQ04xa3BycHR1K2MwdlhvNU1tbmdSSFJNaWw1ZnJS?=
 =?utf-8?B?UHJibEhQc28xcS9tQ2ViOGZsbnVyQndTNnNyUWtvcEFZVzg2bkRwQUJpdlJj?=
 =?utf-8?B?UkdnbFg4UHEybE1UODZ2eVQ2ZW9lM3ZPdllVM21YdVVBekJYV0xrY2ZndDc0?=
 =?utf-8?B?U2p0V0hOUHMxd3czZE85TzFhbE1nTEpsTHVHT2lrVC9sQzFYUlNWTmJaeUJu?=
 =?utf-8?B?eXA2ZDFML1FmNStjU0x0Tkt3enFFbE1jR1pobG5VYkl2ZTdjWFlhZURxU2ZZ?=
 =?utf-8?B?M2tXa2JaMjZ0NENNbW5GZ3pvdTNiZU82OHMveVREZVlxQUV5Ty9mVS9aQWhP?=
 =?utf-8?B?cUlvNTdjRXFZMURMOHJNQzYwbDlMQzlHaDJJK3loN1dXVExjUE0zUEhEZVJG?=
 =?utf-8?B?NlhML0ZsVUcwTlhMRWs1eFBEaDRCVUFJcnJTWXBVeGNEWlEwSkFtUEhzVnRa?=
 =?utf-8?B?OEJLU28vZkwrRk9lL0UrczVvYTZvQzVwcnFxMlpkYUpxT1U3N2wwcTAwQ2VR?=
 =?utf-8?B?bjh3VGZETnJqY2FwQkY1Y2tjL3h6OGFXSzk2YVlZSnFTSm43eXZlVDhTWmhN?=
 =?utf-8?B?Q1l1Sk5HTTgycjB2U2U2eVQ4STZOaU9qRkxKZTRtZFJFNDVGR1FjTWNxUmVx?=
 =?utf-8?B?cHFZYlMvK2trNDNtbmI1WmtLc25USng5QisvT2dCMFdjR0g0czlac2RIL1gr?=
 =?utf-8?B?bFMwN0h1cDFQUnc4TjREenI1ZXhxS2xHaERiVm5BN1o4algzSzFpelJTQ1hK?=
 =?utf-8?B?Qkt4WEc0WVMzMDZNL3hsS1RMcEt2ZFBJWG13OXhaS3pXMjk1UXBITjYrSjNI?=
 =?utf-8?B?b1RXdE9WdTdNMnFEbWFWdDhGMHl4Qy9vdnkrbzFyc1pEV0RYbXVsUzF4TXJt?=
 =?utf-8?B?QVFSTHRVMnhxcmI5b1BENzVJZFQvbFM1M3drWDlET3FuQzNxUDhWWkVjbzZV?=
 =?utf-8?B?RHBFUEdJWWsxQjh3ckVMNEs0Tmd0ZGdYY0ZGVG5sYVNTVlVtbDRwMTRXQjdi?=
 =?utf-8?B?bGZpWklzUHNzeUJjY0wrRExlUm1SRCtCazJ6WTRSdGNESFRIbk00NnZidVA2?=
 =?utf-8?B?azNYL1ROczgzYUxKTTVtc1AxOHFyZnovVnNKQnBuSGJuamFib0JicWlJRlZJ?=
 =?utf-8?B?ZUVpRlg2Mi9yelBnampBVE9neDV4MitudTYxOXpLRkVoK1lnaGQxVWNzdmRO?=
 =?utf-8?B?cHIyQldwSmdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajd3Nm9rSWZOWjY4VU9nQzZ6L1FmMXl6YjlkVWkrQityeGIwZHJrUnkycStT?=
 =?utf-8?B?NUVQRk9CY3R0WEZFazdMRDIvWFZGR1VTUXBhOFVzdHd1YlBsUXZjVUZ2Z3FB?=
 =?utf-8?B?ZllKZjVSbzBoOFQ5Si90ZyswUE9zYmFUcjQvcysrdXY0bkdIZ2p0MlJhZ1VI?=
 =?utf-8?B?UFg4U1VoaFRyeWxjeEN2R2lleGVvY2JtakE5MUZnZ2o1SDNza1VUOGFVZ21l?=
 =?utf-8?B?enVCUUt4YTZvUW04dW5WWnlONG5aR3JmVFg1cXdDckhKQXFTRXlxcmt0Zzhx?=
 =?utf-8?B?bHBFUER5YWZERkNLZk8vN1lKSnA0Y2FvbmtqTy9sZjNQNkRLcEF1aExWWTVY?=
 =?utf-8?B?Rlp1YUhIa2V2bGs1aEhYU2RHN0oxVjhFU2QrR3lSYTNqcTE3NWZnU01mblVH?=
 =?utf-8?B?ZFhqaEJRMHBkTDF5eWhTQVpTSWxkMHpQV0pWQjc5c2pOcXoyMjJOQXlDRmFZ?=
 =?utf-8?B?ZEgrQUJ0MzY5dDJjUFh6eVJXN3pnMEIvZXRFQVNmTVpubTFycVh4aVJGVnFt?=
 =?utf-8?B?bHFZUkM4cHpZUi9OUlVIS3hjRzh4ZlpSWHM2RVoybWREdWwzc1JKbU90WjVC?=
 =?utf-8?B?QW5WK3J6N2tSUi96QS9tTHhZN2ZaSm90UXVOZGFIV1hoRE5UUWN1TEV5OUEx?=
 =?utf-8?B?Q3J5MFp6cHlZTzNhRXR2N2MwWE81QWVnb29yTGlPZ2swZHA0U0QrSG9oSkxa?=
 =?utf-8?B?NXMrVEtQbmpHVVJpdTdoVTRmWis4ejR3ZHk0Mk5Vb3FNSXFCd1NySTFVUnlD?=
 =?utf-8?B?MC9sbWZWS0UzT0JnQ3VGaG9hTjErak5NOFczLzZTQXRpWGdlNWRIcUFGOVFY?=
 =?utf-8?B?QjJ2YTlpU0daYjJmeDdlZmNWRVlEeUs4Ukp5azB3UFowS216dzJlaFNicWdE?=
 =?utf-8?B?cWQ3bnp1eGJ0MEJSOVhvVVY0UExrb3AzeW95UGpnZjdwdmxPUjdjeXFaQVoy?=
 =?utf-8?B?enJkOHZNSkF1WG5KaHJQVkZJTENTL0VrWlpDSE16RHVJUFh2bWxyM0duQm9x?=
 =?utf-8?B?YTlqaEpWcHp3ZStJeXFaV1FpSDBncEM5QUZ1M3AyRWdFMEFDMXNPRVlqYmMr?=
 =?utf-8?B?UnFvOVRPd0wra09rR1JnSkg4VmVaeXB2MlpYdXRkVDMxQmpZQ0FjVUpxenZF?=
 =?utf-8?B?K1F3S3pLRHlST2tmZWNTY2NsVkZlSTdFaGFCZ05SQ3NBNEg4KzYyNTg0UFpn?=
 =?utf-8?B?aXM4YlV1OWhlb3M1UHc5RWdzSzhBOUZkMEZjMDhoalNKSm9OTSsrVU5XMWhD?=
 =?utf-8?B?Z2dqeFQyK3JET2FMZVRGZjlFc253WHlVeVczZUVCNzdNcjRxNFVCdFFNU01F?=
 =?utf-8?B?eWN1VDczakFoRCtmbFBoOUxpVjRKdFU1RGM0R1lGa3pkZjRDaU1hMzhocEw0?=
 =?utf-8?B?T3NTYnVQZlJYZTR2VjdvNk8xZmxtZWpBMlFUSzZndmNJYWlRUXFtckRZbUhO?=
 =?utf-8?B?Zm80a3U1UE5kTnZoZ01Td0tLRTBxTEhPZVprd1puR0pGUFRrOUVhMTc1VkU3?=
 =?utf-8?B?UDRySytTWVdEcFRGbUFoemVzdVRQU3BzQ2pDYVdseUJYaTFTM3Q0VDJORTd5?=
 =?utf-8?B?Y3JGOGo3NzlOaG0wTXJHdEs5Y3d6cEsxMDdLNlBaWFVTM0tBelVKNXFESm1R?=
 =?utf-8?B?MEt0T1BiY24rUUgzWTZPZFdXUSswcjVQNDdKblBFeWVIN2FNYmdxOHlmbDRE?=
 =?utf-8?B?UkVkZTM3ZlVJWmhyMkJncWFmMlNlSng4U2Y5c0pWZ1VobjEzQ0pMS3RiQmZP?=
 =?utf-8?B?eFZPaGRQd1huVjdmY2VDbjhtQzhZbmtORGVERmNibTQ4bXBSSFJBRGJXNjJq?=
 =?utf-8?B?dWY0ZS9BZGlrUUhwQ2pSOUxvTXFxeHBQQXIxTUtGaXluRll0YUJzczFMRVA3?=
 =?utf-8?B?aXRwQUF5dkpyWFBQUSs3WmFYYWNFVFFPSGpRTGU3Y1QyNUJoUmQvUGp3Tm9V?=
 =?utf-8?B?Tk0rb0UvUVpXTjdsMm9qRThEd24yVlMrQjU0ZVpuM0w3aXVPWngxS2ttc0Vr?=
 =?utf-8?B?dFhPUmtxSEFQdExYL1pjOThia2RsS0JBSWN4WEJqelRHdGw0SzJVNGVBSFZE?=
 =?utf-8?B?VjlseTNYU003V1ZmcU04dE4yWDJHVTRBRW5jVHRXSGNRa0FMWGI0M3VTUXpH?=
 =?utf-8?B?TDBicUx2UUFZaHd0azFta3B6VjRmT0NoSXJiY0tlWVpPRTlHeVVQb2k3N3g1?=
 =?utf-8?Q?MVjdXRTccquM2vm5nxbz6BlzVC2xZdDc2zobBsvzc918?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F4D9AB6083C4E4DBA53F3597AB17571@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a34beed-f9ac-4cb1-628c-08dd980941a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 01:46:07.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rLf/M63d9pcWFEMuSIsAbwDKdIVVbXONCUfxUZuksQf+Lh84FlkfLaenVY8MQ3MUeoynn2TKuloxs4utgy6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_184612_857399_2A51609D 
X-CRM114-Status: GOOD (  10.09  )
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

T24gNS8yMC8yNSAxMzoyMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBUaGUgY29tbWFuZCBzcGVjaWZpYyBzdGF0dXMgY29k
ZSwgMHgxODMsIHdhcyBpbnRyb2R1Y2VkIGluIG52bWUgMi4wDQo+IHNwZWNpZmljYXRpb24gZGVm
aW5lZCB0byAiQ29tbWFuZCBTaXplIExpbWl0cyBFeGNlZWRlZCIgYW5kIG9ubHkgZXZlcg0KPiBh
cHBsaWVkIHRvIERTTSBhbmQgQ29weSBjb21tYW5kcy4gRml4IHRoZSBuYW1lIGFuZCByZW1vdmUg
dGhlIGluY29ycmVjdA0KPiBzcGVjaWFsIGhhbmRsaW5nIGZvciBpdC4NCj4NCj4gRml4ZXM6IDNi
N2MzM2IyOGE0NGQ0ICgibnZtZS5oOiBhZGQgV3JpdGUgWmVyb2VzIGRlZmluaXRpb25zIikNCj4g
Q2M6IENoYWl0YW55YSBLdWxrYXJuaTxjaGFpdGFueWFrQG52aWRpYS5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KDQpUaGFua3MgYSBsb3QgZm9y
IHRoZSBmaXgsIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

