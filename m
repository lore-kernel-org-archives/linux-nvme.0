Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EFFD7497E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPIW1elT16kVLjbY4iTiFTC7MSQkTChdDIXxAZIdDoA=; b=zpPnPsXo+YNbtIwmUbfLEkQsm0
	2hbpoBxF+2ABLcaQAQbmFM4t2oxhMGl9R4g/Ms+onk9rdxPWdPl3TDMXSmx2afheILimMIAdmVghD
	8U5d65mnPoUPkcfhcuhP3euGZ41yz8zWIxtUdGT84Vo0uRGSb1RksQLyw76h/T4vmPlbC99/CrRXL
	azVQQDhzJh6DTToE3YaMdWm2u1WebYWai6TJVY5WAIigWnuDHL0xHiUz2zTc2MPBWIZPnI03RZtS/
	7JpxMyooapPKLh1jIRYBYS2/F9Ueo/Dk0NqSChG3CQkqEX1oyh18KigRpSLTevn9rwM0Cb4xwXzdt
	chAR02tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63cI-0000000HDxg-3mg7;
	Wed, 30 Oct 2024 07:59:46 +0000
Received: from mail-dm6nam12on20615.outbound.protection.outlook.com ([2a01:111:f403:2417::615] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63cF-0000000HDxA-2bgD
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6H1lpwvUeX2STpfAk3cR90iTJpydOB7UTY7xoMMg33YUQ//uA2qlGbuDRInaZAH/ejWzNs1xYWViBsXXBvzT075dWmkskE0f9olTKXH8Hq+KqXYuM/CZ6LOVfjAe86JHpn8kXX1PVkExvO1nXykMSgAI6MaKAK7UCvnprL03FK4XfP9t6hqomfNAGDig7BV7QbcrBk6aMyDyvEUEvf4qgPsqbVNWl+TuHDzbZh3V4RQTLOVVkUq1md+eb88UoTWKAfSyxZwoCjm+AX/tjxC0X6NvjLq3UuiXnU0FXHCMUE/UtpoJWsY3GKDy2LCO8tWTpswL9xp+V559sgQh7Thmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPIW1elT16kVLjbY4iTiFTC7MSQkTChdDIXxAZIdDoA=;
 b=i1NDFmKNRxt511bNL8ZiAo29C2cxZXbQGJzOW8fzGNE1PhYxCBJ8kRaszwk5RS6lJYGZSuMd0E7pSiaCIynMWlcZhO/MuZJo3Yj52CO/0GjVe+ewkuWisvO+XYQdvr1ZpVsm6wVGSZiQ2izy8j2BJhIYajw9JbyV0GsBy61Yto6JsYsSq+bC+D8rvPZhXtJw8h5DVmpVzRQfO49MOka+ORNWgcVSmZbSRF9ToX7kPbxKGjdag7EdjQgbDibHYJnakTUNjF4lwMw88ojbNaLuM+KPcdY7Tikf/Cw35ykyX+VMhBFOWW/MKrUSr4U5N9c4giUXPgegOoV5McxM3cy26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPIW1elT16kVLjbY4iTiFTC7MSQkTChdDIXxAZIdDoA=;
 b=Sm2pFECvKwTpFjsOHvMMhU5SvTRUpKBmpONY/jKpF86hdnx8Qt3hT1OfVSg4D+4rfNS0esI7AEg7DrJ71q38AImwczT70azlZGrqP7WRShWmR2y7J9RSy9MCGjl6dMggPqSuDywIRgRrsBaUF2ZNfPO1q3otfu5u68pwJMkfiX4Vhn1MRvXM1i0diSsrmb6acxL0zlFcZM9Bvdcq+uvia69U5XLOzVbttrGVMbEMbVsKCNPnzxCNydfYwdre1pjRQh+2xfmWx0UOdjCtPUwuLooVjJDdK6+Bh2vaoH7XYOvoszfHub0Mp7D1sm0jHpl74B5xf++b15vBkGmj/iUJrw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 07:59:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 07:59:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 09/13] nvme: check for controller device in
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests v2 09/13] nvme: check for controller device in
 _nvme_connect_subsys()
Thread-Index: AQHbKphNSVUr8eGGOkCTmXfuBZ2fGrKe7iGA
Date: Wed, 30 Oct 2024 07:59:36 +0000
Message-ID: <8d6debb2-c6d7-40bd-80d5-8361b0287082@nvidia.com>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-10-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241030065149.2297405-10-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 72f355bc-cf11-4aff-35a5-08dcf8b8cc20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzJLTTBUcVkydE53MnY0dkl4WGswVkR3OG9YSEZoWDZiNmdMVmg1NlpVTS83?=
 =?utf-8?B?czZuV21GYWp1anVuUnVqR1BzNjE1UVJYYzQ4SjVTejR5TTRaZEszUldDT1FF?=
 =?utf-8?B?Uk1nSjFveDNHQjNjK0E1c3gzdEZxWnJqY2lncm1Odk1BVGdZZUhUQWhDQTk3?=
 =?utf-8?B?aEFweUdDM2VXMXpYYmQ2SE1OSm80S1EyR1NlQi9vZmJhYk1DVUg0eDV3L1RX?=
 =?utf-8?B?eUs2V0c3OVhVVlJzOEhtNWdwNUdKdEZ3clg3c2ptcTdUQis1RWxTcldWOEJ2?=
 =?utf-8?B?QWhIR2FFandvQTJ5bFZTZi8yQU9Zczl3dnRTRTVldDV3aW9zWksreVNIdTEz?=
 =?utf-8?B?TE1vbEtiS1MvSHppSnN6Zy84dWo5RTNkRHBQSjRxQVdwRHg0RnpDenFLc3JV?=
 =?utf-8?B?QW9tbmZOaUVoWUxrd1NBempKVVptdEYraWxpNWhhR3ZuYkxMQjZlYmxXRGRo?=
 =?utf-8?B?RmorNTZ2QytISnNIT2VEUnNWQ1ZMZXlITUtBK1JFaDVwai9HVDVqVU1NL25T?=
 =?utf-8?B?RE02OElXRGRjN0JuWDkvaTJ5ajBETmxGUVlTaTA0NUFqVkhEa0ZTcmJ5UE1o?=
 =?utf-8?B?TTFpZ1dtVjl0R1Zxa3BPcjZheERRNTVsb2lLK0xiZVJEYkluakNJZkcxOTFL?=
 =?utf-8?B?VXd2MXpsNitST1VPeUhwM2VlYTkrOHdTWmVoc3JIZ0U2ZFg1WkVvczY1dytY?=
 =?utf-8?B?SWZrbFdrUUk2TnRRNlp5bGpkNW5vQWlKdnRaMnpsaTVHR1lMa1Y0NU5uNWRI?=
 =?utf-8?B?WDhJc3kzbzRKNkVpN2FMUDV1NnkweVp0QXFkTVgwcDVONi8rRUFXUE1kRHNn?=
 =?utf-8?B?YUJ0d1BXZnlYSEQ1NENaM3dtT1ZUU0hYU2xSRHVxQWZwT0F4RjRsWWpjbzly?=
 =?utf-8?B?SGFPejIyYlVlRUp3enE4V2VJQ3d4QXBGU0c5M2JGdDZiLzNEclZTek0vNmN0?=
 =?utf-8?B?Q2xqOVQ0cG9PUlVJYUF2dFdJM1pXYmo2NWtjaitvK2VHZkpXbVI3eE1USzdh?=
 =?utf-8?B?Ukk5RDhBcG1BbktWNEFMWWQrSHJlYVc2ZnM2a0VZeGZON2lEcTFOWHIzUFkz?=
 =?utf-8?B?dU55YndDalFCTXVuYjBLbytpVEMrVVRtdFF1SGpIZjVWcXQ2RUs1L2txcllL?=
 =?utf-8?B?UU55RnRlQ2gzV3hvdW9DTDFiUVJFc3J5YkxESHF3RnBtSk9iQjdsY0lFREdW?=
 =?utf-8?B?YzA3Q0Z1V2tjZStiUzkzWnEvbHducnNKQnU0dG56YTZDSlRXWHFtYXVaWHk5?=
 =?utf-8?B?RzB6YmVOOUVXaTlTV29BRHNIR01VNWJGN1pRTmhkbEtEdWZHR2txR09BRGsy?=
 =?utf-8?B?VzBOU21qWVI0V3RFcEE4cG5CeGZIM2d4QjZpdVhYSTlkVENQRnFxa0tyaVFC?=
 =?utf-8?B?eGpPUEcxOFl1MG01Q0tvWFRRUUxBbm5YK3l2SCtFeUJXYkxheCttQXdQNHo5?=
 =?utf-8?B?dE5QMnp0THFtTWhxalJLdmpnZ2ltU3FWMy9VbkdXWWgvc21kcmtlZ1lva21Q?=
 =?utf-8?B?dFFZWXNlMmcrSmZybXNNQ0RlNzJjbmcraW5uemdMY3pYOXJHejZoaGkxUk5n?=
 =?utf-8?B?ZmdtbUdtdHJTdE56eENvYmtnR2s3ZDJCMW5rZUpocnFVTllYMy94WXZDc3FC?=
 =?utf-8?B?UEdDVDlQYThPeWNsTFQrY3pkbFVKdjd6TnZzbXEzWUVrVldnUEkwZzlXcG15?=
 =?utf-8?B?ejJHMnBhVm1xSm9KengwdU92SmZBbW5NTUROZ3NFaXJLcWl3WkwvOXd4ODJa?=
 =?utf-8?B?K01HU1h4THV3Yzc2RytoN2VHQmhDUTNCM1dhYUtua3ZsMVFkeVB0eG5CYWxG?=
 =?utf-8?Q?fOw6xgZq/CLx8XWkbDv+VhLtTkbk7DwdW3QgQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC9xYllZdWhtMGlJYzRra2lBZ1ptaU5abndWdU1TMTdoYzR2NkNZVFZhOCsv?=
 =?utf-8?B?enlIanNIOGc2alFPVWVDZm93c3NYWGZpaGl1bmdUNS9vOGwzR3JsL1hxNmVO?=
 =?utf-8?B?NkptTndPSFJEK2s2RzZ2dXUyQmdYalNMTVR0RDZpYjhsSlBabUY4YzAxelEr?=
 =?utf-8?B?S0F0TnpJVUcwYzFDbmljQXN3S3ZvYU9LTEwrT08rcytiT3JJNUdzRmxPblR1?=
 =?utf-8?B?UHkvR21NUllxOTZhc25yRDZXMUNBWnAzTVkwS2wwMnlJdzhLWnlkNmRXTFpz?=
 =?utf-8?B?NVppVDNjODI4bmFyemdXWWo5Z2xUd1NFdjlYazhEMzM0WW1zaEVldUJKSlIx?=
 =?utf-8?B?bEV6S1FWZDI0WS9LZEorN0xHcDJLTWFRenVnZ0doLzE0RCtNQXU1ZUdnUEc5?=
 =?utf-8?B?Nk9DSk1uMHhLUklMOVJjSVRaa0hxU0ZPcHRCZEdITEFkZkkzVkF1cWx1b2Yz?=
 =?utf-8?B?VFhHVmgxV1ExZE5pOXcrS0JHSHBqRWg4VTdROFl0SjZGVmtrRkJuM3BHV2lL?=
 =?utf-8?B?Yzk4aFVGWlQvZzA5dGtPUUo4ZTRESHA0a1haVFlTcEc2cGl1MFgyQ3VUSFFU?=
 =?utf-8?B?a3l6SHNabWV4N1I2TWVlQXRxQWRCVUdZSEdtZ1Bya2ZlNlVNVzB6SG81dTIw?=
 =?utf-8?B?WkxXVjViNU1OSVlrd2k1QkUyem4veDYvbjZRdTdWVkJWSlFOTnRBUzJjV0sx?=
 =?utf-8?B?cEVkTURLeEpSZDlKMWF2aGZwdXljdVdHc1RSdGNUa3VQWGplbXoxaGhCTCty?=
 =?utf-8?B?MEJtMmtNa1NGZEFFSS9odVNzbGU0ZzRsUnR5RWE4UG5UOEtGTGRkeFo0Q0Y4?=
 =?utf-8?B?UmFnNmsxRXhPUm01UExacmpwazJTbUNDQ1BEODJxMGRwQUJmdnhQdVk5Tmg0?=
 =?utf-8?B?RzZtaUJPL0RScllLd3hmQ2l1NFhBRUZsNTE1aUxwQ1A2R0xUUmJKcC9VK3pR?=
 =?utf-8?B?MDV2MUNrcWRrQWUxSWk4cGJ3bm5rek9XUmJxTm1SVUJGQVJEMFREUHd4L2Vj?=
 =?utf-8?B?OWhrV0Y2eDgwVXVpMmoyT3hKQVF1TVlpUmpqYjFiRi96eDdMbUdzRjMrVFA4?=
 =?utf-8?B?VVJ1anBMemphdG5GTTl4bUd3NTF0N015cE1uWlh2b2J1Y3Z4UG9TZVJubzdZ?=
 =?utf-8?B?ajNNdFUyQU9nYWk2THdJVGF3Wlkxbmk3VjJXc0o3QkhYS0dLTGNWMmEvS1RM?=
 =?utf-8?B?MkNPMFpzL1pxWVRsemlidnVqY1dTeERXQTlsT0thQTBkNS9zelZuNFQxbFJ1?=
 =?utf-8?B?YTVFQ05nVlZQL3ZiYjNRN3FUR2grRVNzUFpqRGg3RFA2d2s4bmdTb25Gd1hV?=
 =?utf-8?B?Qk93ZFFveTNVMjFYR0ovMktncVhIZFJnRE5ubWd4TENQRVFHU3RMUGhDTmVZ?=
 =?utf-8?B?SElvcGpmeFlSTEg3VXE1ZGdWQUpDenpVZmRRRE1Ha0tmQ21YckNnekRZdFV6?=
 =?utf-8?B?U21ta0NDdEtQa1VuTExMem55MmxqVE43RFNCeW11b2pjcjRWRmJnN2o2QTBw?=
 =?utf-8?B?VndJNnNCbXhlcFBZQnZjZjYvSXI5OGxWWDU0aHNSemlYL203ODYvdkFIVnpE?=
 =?utf-8?B?N3pCM1Z4cEJYRFh1OUtBUk1ZY1FBekVPY2VJR1lRTlJUOUFsTTJzQkxlZW84?=
 =?utf-8?B?TkV1bHZwbHF0RG9LRitHQXhxdWt2RE9rWWdROTRsQ0g5Rjg5bkwzVHlyU1Zw?=
 =?utf-8?B?YlExanMyTUxLK0NST2VtWG1EUmo0UC9sWWEvYkVTeTR6TU1vL3lMK2V3cmM5?=
 =?utf-8?B?NXhTZ084OW8xeDhPVUpVWmtyK3czSDh1S2pjZXBQVVNLSDZLaG81dFVOcDNW?=
 =?utf-8?B?V3BLNUo0VFN0Wkp2MDRVQUY0ZTc5RlNVK2tvd3ZXODh5a3lqVVFQYVNsRC94?=
 =?utf-8?B?RUhiQVpCNWIzaUVYcTVJMnFGQkhqZmxmK2ZCWXJXNGtyRDB6SXVQWE1VYlZM?=
 =?utf-8?B?ZDliWEhXL2RMQTAxTEV2WG5ZRmZHT3BUdWZ3OVhwRVlwOUpaN3p1ZXJMSytl?=
 =?utf-8?B?L1M0SW9PdnA1YmVYK2hTcCsyYjhCc01NU3J1Q3M5eWV3ZFlSVHptaldQSjlM?=
 =?utf-8?B?cVA4UFV6aEdJZzh6MFVWZk5HOW1DYkt3RUlzaUFuZ2cwNmEvNnJSbTExckpO?=
 =?utf-8?Q?GfmEOlpY16hUGPYHzyUyevqgz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C33DFFCA1067E842ABACAC633E12A51F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f355bc-cf11-4aff-35a5-08dcf8b8cc20
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:59:36.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzU6eYD6Y8/N3lfVpVgVUkihqGpMualhKaQSEHtLKrjsVBMsftpxriYgSoU/AUYUn5aRMzdnbDT46pVjrA4hPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_005943_684864_C60ABC1A 
X-CRM114-Status: UNSURE (   9.11  )
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

T24gMTAvMjkvMjQgMjM6NTEsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBGcm9tOiBI
YW5uZXMgUmVpbmVja2U8aGFyZUBzdXNlLmRlPg0KPg0KPiBXaGVuIGNhbGxpbmcgJ252bWUgY29u
bmVjdCcgd2UgY2Fubm90IGFzc3VtZSB0aGF0IGEgbmFtZXNwYWNlIGlzDQo+IGFsd2F5cyBwcmVz
ZW50IChlZyBpZiBjb25uZWN0aW5nIHRvIGEgZGlzY292ZXJ5IHNlcnZpY2UpLCBzbyBiZXR0ZXIN
Cj4gY2hlY2sgZm9yIHRoZSBjb250cm9sbGVyIGRldmljZSB0byBlbnN1cmUgdGhhdCAnbnZtZSBj
b25uZWN0JyBoYXMNCj4gc3VjY2VlZGVkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVp
bmVja2U8aGFyZUBzdXNlLmRlPg0KPiBbU2hpbidpY2hpcm86IGZpeGVkIF9udm1lX2Nvbm5lY3Rf
c3Vic3lzKCkgcmV0dXJuIGZvciBub193YWl0IGNhc2VdDQo+IFJldmlld2VkLWJ5OiBEYW5pZWwg
V2FnbmVyPGR3YWduZXJAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3
YXNha2k8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

