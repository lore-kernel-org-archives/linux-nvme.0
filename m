Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178B6E77199
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 05:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BWbpzkbRP2uFXACh96S1IU5KJ/gORpDP9NIVsLyDdI=; b=bg9XLHSTEHpM5FXoh7dKGoELpd
	uzYspNSLeEU8VkcSkuh9HEVifay7kNbUkrD2oj93U6QZU0OwdDafoL/ieKS4/UeqEk960G9hRBTy6
	WGRCOk52a7Gb6hGHtOw49Wn+Kn3+URgEkIMpBx2KtlMg5S3OeAKomnP5l//ezQyd3TQOMcgOi04QP
	l378dT8ou46aF0gdHe7QB0bDgg7t5vJYFKJnRMC6h1kk7hyVcFovYbXyhD6hLZgWWCKk1uU0OSVji
	t/W5pzrBSHSUnJdVGAYvBkcDr2/GCJQjdaMes62UACLiT1PDwPRXBeYDLJ70rIBWTc2kp5WNmdYkM
	uFPbnntQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVl1p-0000000AnXG-1wDc;
	Thu, 09 Jan 2025 05:24:21 +0000
Received: from mail-dm6nam04on20607.outbound.protection.outlook.com ([2a01:111:f403:2409::607] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVl0z-0000000AnPu-3iET
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 05:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO6PXIF9v+2ICPeXjrT3C96YYSRB+TDgaGt2JFnAZ+tJ8r/Q5WDQUtlCZTFUYd8H0D8ctQrpo8qiZUcFxE5DOBufOhIh+GkTxx8n8RGW92A2mPU5HBqBirFun0vaMx8UzOgLdXe2h/z43zVK1lnCyalJh3JEm+f7gV3DWYS2JlNAfBtx2boxPop8ixaLOxrwyEJeDd2LxciG2oGrT0/JqapfnfU/AUuYSq/DFuX8wd4ThaAGlxnK4JXJM97V3ZO4y7bWilzOyRm8TynFVxvdLM3GFY+BuEn3GZZIaFs7NEu6QnVIwmvrRokfmDM2Pq4+HG1qklzp2RJE7DpHWaq0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BWbpzkbRP2uFXACh96S1IU5KJ/gORpDP9NIVsLyDdI=;
 b=fyQEHXgz+H1QDFtJJAbEjJn72JoXqp6jrGhPuooFHjpiik9mTEtGj/Em/n0kCcKRSGA8nXtryk8rwnrdGzy5qp0ibe608X4JJL8b09xRq5QUpVn52aBOdDQysZIV2xy2EVLK2X/dr+2N11lfO/CuqnM3ZiUALneBi8qERNPr2ymXKEr9kWy7cqpLw+6pnosRf/+qoSBI/xmv7TzPOGSyRa0FxCOea2hTP6RG7JvmdLThDlAVY5vY2U8nh37IDt+wMfoS0pUG3mQjma5CEy2H3KhqwPwPgAd2KOnRy0A/bU7bahv69nxTiE070qOFXXfRP73vSKvDDypMnslcL3FHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BWbpzkbRP2uFXACh96S1IU5KJ/gORpDP9NIVsLyDdI=;
 b=rz8MGsGNGNRM2Mj0foxql4GEi1yVoPCrQPJN3Y5Ww6BP3eloHhil9YQKf58Vb+rpz4bP8ZGZWEYo2LkjY1an7ie6eXse/PoS5jX5AkOhHmhRvOehpZzzu4Ben9EzDKTTkDs0gRcVW03YC2hkVK1ZrjS6pfri38mUk2iGRyiDm3M2FGV+UhHlInQQfX8BOvhB0BJC/IEV7GF7ffgfmw1BqZtOD6SCfygweT4nnNg2TSEIgh/oPnqUZEwj+mwDp1xNR8IokzBNRf4b8Vw48OAELz880X3wKuoAj/n3/VytVIiNRRW+X9fs9fp4fIUUFA+YD4CCkN/FriXCumufylaFEw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 05:23:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 05:23:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>
Subject: Re: [linux-nvme:nvme-6.14 2/36] drivers/nvme/host/tcp.c:1583:18:
 warning: variable 'n' set but not used
Thread-Topic: [linux-nvme:nvme-6.14 2/36] drivers/nvme/host/tcp.c:1583:18:
 warning: variable 'n' set but not used
Thread-Index: AQHbYjcJXg+0/OeeZEmj/J/+VHgtA7MN6MaA
Date: Thu, 9 Jan 2025 05:23:24 +0000
Message-ID: <ce33fcfd-654d-4608-a686-3bf2b4d8d221@nvidia.com>
References: <202501090934.Dhw69M6j-lkp@intel.com>
In-Reply-To: <202501090934.Dhw69M6j-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8921:EE_
x-ms-office365-filtering-correlation-id: 17b30302-0b84-4f2c-cc14-08dd306dbd69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eU03WUxBczRnUEplSkdSbXBCc09pQ1piTDlFZlRGTlpLYnBFYWQzSUZHcjBZ?=
 =?utf-8?B?bEkzdElGcHNaNExxREE4bnp5QzBqZ2RBZmUzY21BQ0U5N1BCakF5aFZzdUhD?=
 =?utf-8?B?NmhBa3pPSG5yaS9SemhZRDFzK1doem14TXFSelgrNnprNzBmVkRDQzZQcjg1?=
 =?utf-8?B?M1JGbzljdHZCclFwWlZRa2c3d0d1U3ZVS1hVZ1Y3TURmSlpBZEtUL3dDa1Vu?=
 =?utf-8?B?enBsOVpQYnhwZHVaWWlhaFJUVEoyYXFRa0t6S3MwMWxpdVpmbTFFN1NnbVVK?=
 =?utf-8?B?UVVnK2NzSFo0bjh5bmRFeTdwVFVHaEJpRENXOTlwc2I3aEMyVkNGWXhsclR1?=
 =?utf-8?B?UVd3T1dpZHVlYzNpU1NpOEpjYWVMNTluL2c1empXa2tyWkxZVWVVVDRDamJD?=
 =?utf-8?B?aCtXQmhnaHo5RGJQL253SDMza3hWNm9jejc5RllnWEJrRG11akRGSmZmdmNo?=
 =?utf-8?B?RlFsaHRraXU0cnVyY1IyQmtJaERFTVpOQ2dwb1JNaEVmU05jeGNSNVhZb05o?=
 =?utf-8?B?QzZQUXJ0eDVOWFFnakxaN2toMGxMNVZyejUraENLMGtMVmZxTEtmMWsxVXF3?=
 =?utf-8?B?Wk9VaHNrNmZ4b2JiY2F5b0hrb2l6WUN6b21wZzlNNm5ENVpVZXNKVTRidHBX?=
 =?utf-8?B?Z0Z0RzlLcEU1SmNoSDg5dW1mNXkremREQmMzQ1N1Tjh5bzI4U3RZQmMyR3BZ?=
 =?utf-8?B?WTJQZCtzanZRQUUwcGh4NGxvYVJwcndmOWphOWc3ZFBVQ1Z0aHA1bkpBZ0ZT?=
 =?utf-8?B?NUpDd2dDOTM5MURzUUIxdVlwamU0VTVZSk0reEVsSjJOZjBuMUdQTEdCT3N0?=
 =?utf-8?B?L0NENVJpQWhwUEJrTSthOFZrSE5NV0hweUVPVEkzM3ExOVR1V1hxa3RJVHBG?=
 =?utf-8?B?QVQ4OG1rQldHbXdDQWZqM29nUWFtSFNFWGVOQTdQUXBHZUtSdWFXY3NGdWpa?=
 =?utf-8?B?Uld5dWpOdmpRMWU3bTcrOW9HRzFQNGViY3Z2R3BpeGo0bnhxNmFSTFg4RDdl?=
 =?utf-8?B?QnExMVVLTm9TYUNqaCtIZ2ZIMEpGVnhlRlJxdXRsRmptQ0cwQmRFcEM3d3o3?=
 =?utf-8?B?NDFQMGNVUFFoVXpBUTBMY0szTGNETUFFRmpFdVhubDRnNHFNMGFDWkZQSjM3?=
 =?utf-8?B?dUo5cVVNYWpQblVib1JXN3kvekZWZVZ3UUppUkFtd0Z0NVpyaHJIWEp1VDFp?=
 =?utf-8?B?NmVqTnVyVmp3MVd2Zld5ZlIvWVNMSTM4Nm9XcDg4V0ZIMWFBQUxZek1Nd3hN?=
 =?utf-8?B?b21aRU1tU1hwclZJdDRMamRHZnkzbnhCaHNQZHZheGIxdGpYdjZSRjVxWktI?=
 =?utf-8?B?ODl0OHg2ekdNRktEYkRkUkZYZk55c0dqTHRyZFVPUjZweEd0d3lkUEdBT0pw?=
 =?utf-8?B?MUVaamJLQVlYRkExb0RDSXRjUlBNN2FIQ21JNzRmSEtxRHlwNzNpdWt1UDNF?=
 =?utf-8?B?Y2phd0N2TG9VckEyNlNMTVhDU3NMNGE3YStyUExIcFMwK2JEYTBXd0JjOUhZ?=
 =?utf-8?B?VWNkUzlQd3JHWWxxcXVYeG83VUNJd0JhUld2ZDcwNWVlMmVXbUoyd0xleGFX?=
 =?utf-8?B?QXpVRFg4WTJMcDkyaUcrN0tpZjVHdXQzT3hMTXBSK1JKNXpmeXNmbkdzaU9Q?=
 =?utf-8?B?R0ZnMVNDc2g3VERVQVNnYzJKQUw5M3Jsc1pvZUlkbnc3TUhDeFU4b1M3anFj?=
 =?utf-8?B?Z0ZROEV1VHV6SkFINExQczd4cG5YS3RyVjZaRVZhdktzT1pyeUVGazdieHh1?=
 =?utf-8?B?ck05ZVJyeXJQM2U4N3VGWktRWVhLTHczWGVSK3UxMGRTcnZyOGYwamlhV1Qy?=
 =?utf-8?B?WXBpZEFPZUpPZ2NRK2pmZUF2M1NaTGxBUlBFU0tkdk1PTEdheFZqMnhDRDNU?=
 =?utf-8?B?UWZueHEyeXJaOE5SdWY2K25MajJiNTlJWnpkR21RK2FQcEw5WjU4NnIyVEYz?=
 =?utf-8?Q?kYVdN67i6qvnZeXxSvksZGqfty5yXfr4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzBpeG55ck9uZ0NsQXRGcyt1cFJTNXpNOGN6OG1lSEZLaHZZeXBDbE1KSVV2?=
 =?utf-8?B?c2N5M01XNnEweWJXY1ZwM0pKVVNrTTE4LytucXE2Y1Nwb0hIL21uZXFzNjY1?=
 =?utf-8?B?OVB1OVRLOWZhT0s4ZnlONysyYVhuc3BIdVhmU3FiSGEwMlc2RTREcDNzNm0r?=
 =?utf-8?B?RVlyTjBOYnRYYmpZRlB6WHFxeXRmSDN2WFNWeVBhWEFKQnB0ZjJvWm12Z2ky?=
 =?utf-8?B?QVJKbmZ4WndVSkxMWlVLa0Z5MStuejcwSnY2N1BzWGxza0dCUEdrTGhGSzdL?=
 =?utf-8?B?QkJCamh5anRpYXFHMXVqeTUzMTJ1T2E3YzdNaU0xTTNhZktMZmtGK1YrTERO?=
 =?utf-8?B?eFV3a2tSK3AzdUxFbnl2RHBpcWZwaFNaRlJwWnRFQkZwSjVBc1hLZ1NCOVJ2?=
 =?utf-8?B?ckZFa09hM3FHemlxUEM0a3FudEV4d2NsMEtlTk1yQXJ6bWtxWW5DR0JTSkhR?=
 =?utf-8?B?ejVlZjhzcm1JWVZKaWxrakVlVWhDQWxGeXNLOVU5UHp6TmtnN0FxbWlGS0Zl?=
 =?utf-8?B?MUFQQnpRb00vMFJBOHlDRUcybzBKZkY0ZWRMNFRwU2s4UEo3M2dORUlwVjlJ?=
 =?utf-8?B?SU51ZUE4NXhHSnFNTXFOZUNkUXF1N1NBS09Xdy90cUFtblRLb3hobGhRZWZO?=
 =?utf-8?B?S0RIMlkzek5vRlFvbEhBM0ZMNDFaNWpFc0hPb2UxZkdPWldZbHhJeDhIUE9C?=
 =?utf-8?B?WCs3RGpBOGV6SVQyTU16c2t6S1l4OGdvUXR3OWx0UVprRlRMNm5RNXdlRDJq?=
 =?utf-8?B?azJKRHNzRkEzTWZPMC8yN0VMcmE1UFA3RDJRd2RGV01ZV0JhcVB5eGI1aXdv?=
 =?utf-8?B?b2l2YkpVbk9NKzR4MjZkRHhEb2REM3AyaWNMUUZqbDA0ekliYkZqb2ZHTmxl?=
 =?utf-8?B?Rm5nT01EeUFnY2wvNExwejZYaU95V296Q0cydXRSV2NYc0c1TmtWZ043WTdZ?=
 =?utf-8?B?TmdaNkNISGlRaGNKUXlWSHg5V1REQ01KaGlwb0lyYlJvRCt4dHVuQjcxdkkz?=
 =?utf-8?B?Y0l4WDZQWkd6T0ZnU3ZlYzkrM3pSTjFTejRjSUY3VVdTQ0RkUkEzeEQzbEZk?=
 =?utf-8?B?QXhsd2VUcThEWDI1OTNURUFCYzdVeHRzMHIxZDlmbzlJUWtnZzg5a0IzL0Mv?=
 =?utf-8?B?MW9wenB2VG81UWxCUmZCdFZBQ0htcmc1NFV1Mkk0MUhiZ0F3WjBieTViK1RC?=
 =?utf-8?B?czBoUzRnbmsxc29CbGlaUUpWSFExRG9SMTRqbU85NFhHdVZYbjVlSkpvNkI0?=
 =?utf-8?B?WEVMWVNQdUZhc2dCRWVDald1RG4ydUNJYnpYVXBRYm5sVHp4bGp4d3U5SDMr?=
 =?utf-8?B?YzBpZysxdHVvM2RhamRmaDNmL3NNVEM1MnQ2MGREZm5HTGlVY0wrMFhsZkFs?=
 =?utf-8?B?ZmFKY21rbENSMUw0VEtwaEpMYkJkL3RzelZaM1ZHSk02TW5HUXR3TWEwck9U?=
 =?utf-8?B?MExZV0xMemxSNzhPMDNtVy8zamFmZ09YQ2xWZnFJR3lMWlNwVUt4aU9GYnVq?=
 =?utf-8?B?VG1QQzRFNGw2blNOWGZCd25VSHhjMjVkOEtDV1VoMUx3aHoyNjk3TzNXeUVs?=
 =?utf-8?B?NjdEbXdEWDNRRXNoUHB2cjFqOVh0Z2ZnWStCL0trOHVwMTFjd3ZDRk1IM2lJ?=
 =?utf-8?B?WXhLSngvUDUrTkNJSVM4bTZRQ0RQWDlVZ3NSekp5ckhQOE00VCttOVdJaW9G?=
 =?utf-8?B?M0ZoM3JiVlplWDlQdEtOdzY0ZUREZC9pV2IxRWk1R05MWnM0VEFOQS9NcTZU?=
 =?utf-8?B?VXpWTHh5V2JuWTJqdzFnQk1BRkFweGM3akhFcmoyVWJUNGgwT05DMTFYS2JG?=
 =?utf-8?B?YUFnVHpYWld1TEZaa0NRRHp3ejZjaCtFbUxubXEvcVgzNXorOTZUZ29mSTND?=
 =?utf-8?B?WWpPUzJDRzdVV0NsRnI0V3AxR1BrQmJFeW9JK2l4d2Z6UzFxTHdEdmNvQnpJ?=
 =?utf-8?B?bndVbjJtODFqTEhTUEI2eWNBMlpha0xoRE91YVBoN0dGSXhnM1MrM24vT29u?=
 =?utf-8?B?MkZvbWd5NkJxanVUUmV5TmNMOWs1R0xsRjVRVVJEeUt0ampnS0J1ZElkdld1?=
 =?utf-8?B?WmRReHROYlpub08vd2dJdTM1aFBJSVppNGtQZXh3ekM1Q2N6RVd4eDZYYTFK?=
 =?utf-8?B?SjhHeVpUeDZVQjhEWG1LeWJDV1ZmdGVIVDlDbEJpSnlsb2RPTEZLU25NN2Ew?=
 =?utf-8?Q?+BmKeEwWw6QlRUaaTTd7AuNAXBbXyGNdGwD9qqZ+NiKZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3748C4B007F4A24FB6F9788F59256220@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b30302-0b84-4f2c-cc14-08dd306dbd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 05:23:24.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVhbAmEO3az9KkCkRqA8iyanIXjvju9pEuLCI1zEdSHi2IcEn8rkRGQE+qJx8Eh83nZ1JVnumcoRe0e1Gv41wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_212329_927709_D0C8FAFE 
X-CRM114-Status: GOOD (  18.17  )
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

U2FnaSwNCg0KT24gMS84LzI1IDE3OjM2LCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToNCj4gQWxs
IHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6DQo+DQo+ICAgICBkcml2ZXJzL252
bWUvaG9zdC90Y3AuYzogSW4gZnVuY3Rpb24gJ252bWVfdGNwX3NldF9xdWV1ZV9pb19jcHUnOg0K
Pj4+IGRyaXZlcnMvbnZtZS9ob3N0L3RjcC5jOjE1ODM6MTg6IHdhcm5pbmc6IHZhcmlhYmxlICdu
JyBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiAgICAgIDE1
ODMgfCAgICAgICAgIGludCBjcHUsIG4gPSAwLCBtaW5fcXVldWVzID0gSU5UX01BWCwgaW9fY3B1
Ow0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgIF4NCj4gLS0NCj4+PiBkcml2ZXJzL252
bWUvaG9zdC90Y3AuYzoxNTc4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3Igc3RydWN0
IG1lbWJlciAncXVldWUnIG5vdCBkZXNjcmliZWQgaW4gJ252bWVfdGNwX3NldF9xdWV1ZV9pb19j
cHUnDQo+Pj4gZHJpdmVycy9udm1lL2hvc3QvdGNwLmM6MTU3ODogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3IgVHJhY2sgdGhlIG51bWJlciBvZiBxdWV1ZXMgYXNzaWduZWQgdG8gZWFj
aCBjcHUgdXNpbmcgYSBnbG9iYWwgcGVyKCkuIFByb3RvdHlwZSB3YXMgZm9yIG52bWVfdGNwX3Nl
dF9xdWV1ZV9pb19jcHUoKSBpbnN0ZWFkDQoNCkhvdyBhYm91dCBzb21ldGhpbmcgbGlrZSB0aGlz
ID8NCg0KIEZyb20gOGZhMjNmZDg2ZTgyNjY0NTI2ODY1YzYyODUyOWI4YmNlM2M0MTNiZSBNb24g
U2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQpEYXRlOiBXZWQsIDggSmFuIDIwMjUgMjA6NTI6NTIgLTA4MDANClN1YmplY3Q6IFtQ
QVRDSF0gbnZtZS10Y3A6IHJlbW92ZSB1bnVzZWQgdmFyaWFibGUNCg0KVGhlIHZhcmlhYmxlIG4g
ZGVjbGFyZWQgaW4gbnZtZV90Y3Bfc2V0X3F1ZXVlX2lvX2NwdSgpIHdhcyB1c2VkIGluIHRoZQ0K
b3JpZ2luYWwgY2FsY3VsYXRpb24gd2hlbiB0Y3AgdGFyZ2V0IHdhcyBjcmVhdGVkLg0KDQpXaXRo
IGFkZHRpb24gb2YgY29tbWl0IGJkMGY1YzEwMzEwMSAoIm52bWUtdGNwOiBGaXggSS9PIHF1ZXVl
IGNwdQ0Kc3ByZWFkaW5nIGZvciBtdWx0aXBsZSBjb250cm9sbGVycyIpIG5vdyBhbGwgdGhlIGNh
bGN1bGF0aW9uIGlzIGJhc2VkDQpvbiBpb19jcHUgYW5kIG1xX21hcCBsb2NhbCB2YXJpYWJsZSBp
cyBuIGlzIG5vdCB1c2VkLg0KDQpSZW1vdmUgdGhlIGxvY2FsIHZhcmlhYmxlIGFuZCByZXNwZWN0
aXZlIGNhbGN1bGF0aW9ucy4NCg0KU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCi0tLQ0KICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8IDE0ICsrKysr
LS0tLS0tLS0tDQogIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jDQppbmRleCA1NDRkNmFhMDBjYzMuLjhmMjE4MDNhNWE2MCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3Au
Yw0KQEAgLTE1NzksMjIgKzE1NzksMTggQEAgc3RhdGljIHZvaWQgbnZtZV90Y3Bfc2V0X3F1ZXVl
X2lvX2NwdShzdHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlKQ0KICAJc3RydWN0IGJsa19tcV90
YWdfc2V0ICpzZXQgPSAmY3RybC0+dGFnX3NldDsNCiAgCWludCBxaWQgPSBudm1lX3RjcF9xdWV1
ZV9pZChxdWV1ZSkgLSAxOw0KICAJdW5zaWduZWQgaW50ICptcV9tYXA7DQotCWludCBjcHUsIG4g
PSAwLCBtaW5fcXVldWVzID0gSU5UX01BWCwgaW9fY3B1Ow0KKwlpbnQgY3B1LCBtaW5fcXVldWVz
ID0gSU5UX01BWCwgaW9fY3B1Ow0KICANCiAgCWlmICh3cV91bmJvdW5kKQ0KICAJCWdvdG8gb3V0
Ow0KICANCi0JaWYgKG52bWVfdGNwX2RlZmF1bHRfcXVldWUocXVldWUpKSB7DQorCWlmIChudm1l
X3RjcF9kZWZhdWx0X3F1ZXVlKHF1ZXVlKSkNCiAgCQltcV9tYXAgPSBzZXQtPm1hcFtIQ1RYX1RZ
UEVfREVGQVVMVF0ubXFfbWFwOw0KLQkJbiA9IHFpZDsNCi0JfSBlbHNlIGlmIChudm1lX3RjcF9y
ZWFkX3F1ZXVlKHF1ZXVlKSkgew0KKwllbHNlIGlmIChudm1lX3RjcF9yZWFkX3F1ZXVlKHF1ZXVl
KSkNCiAgCQltcV9tYXAgPSBzZXQtPm1hcFtIQ1RYX1RZUEVfUkVBRF0ubXFfbWFwOw0KLQkJbiA9
IHFpZCAtIGN0cmwtPmlvX3F1ZXVlc1tIQ1RYX1RZUEVfREVGQVVMVF07DQotCX0gZWxzZSBpZiAo
bnZtZV90Y3BfcG9sbF9xdWV1ZShxdWV1ZSkpIHsNCisJZWxzZSBpZiAobnZtZV90Y3BfcG9sbF9x
dWV1ZShxdWV1ZSkpDQogIAkJbXFfbWFwID0gc2V0LT5tYXBbSENUWF9UWVBFX1BPTExdLm1xX21h
cDsNCi0JCW4gPSBxaWQgLSBjdHJsLT5pb19xdWV1ZXNbSENUWF9UWVBFX0RFRkFVTFRdIC0NCi0J
CQkJY3RybC0+aW9fcXVldWVzW0hDVFhfVFlQRV9SRUFEXTsNCi0JfQ0KKw0KICAJaWYgKFdBUk5f
T04oIW1xX21hcCkpDQogIAkJZ290byBvdXQ7DQogIA0KLS0gDQoyLjQwLjANCg0KDQotY2sNCg0K
DQo=

