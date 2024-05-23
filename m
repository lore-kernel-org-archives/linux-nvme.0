Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E693C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 04:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubvZ5B/U0zJRiHoKkK1kUFSJPLS1kJlzT1bOlSqqO60=; b=1y71e4ZwDtod8hnAIO6RS6ocvk
	+McP2ewjYbA99LT9kifzj6hxIBzUf9ce9GF29cy3m84yG+71vxobH7b2Yz3mJnAdFbLOIZItpb+MU
	uWDlio9d2F+krPRnBK4piUsPdDFQXWGxnjkgbOK4j7cjlXkn2Z2MI1c9Diquu7TRO9MN8xkxcQysI
	kXsIEaNaHSqVPEGbffiPaFw68ETZN2tQu0BGHFanJIBLSKiHcD+e/0uruIk1FChbGc9CnJymzWkc4
	MkbaGfal1c0jj/5PWz6/l1gIRVO2hlqKkS18hZByR8ZFhZhtcNgGf97UW2mGEVO7/8SuHtzL1IThW
	1FIFsCtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA05X-00000004zyy-24aw;
	Thu, 23 May 2024 04:29:59 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA05T-00000004zwa-0SFh
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 04:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuOGMpBwspGl5vBcb+gX4NoCE+lMvku91oJpRdyWN0+HbqRUTx4ud0PwFVgKwkRDLIM5rYuIGUH6LS4rN/9y9+XpGAP5rJ/2TQRHKaXSVTrx/AS/R7s9T2XaqxfF0oUNAHEcRsgqb2aB3PwqqrYlb3bYL9e71t/DvRMW/ocCtJWuDwISJLNTs1wIQafr6zR++UgbRBbek0NonjswM33QhoG1Bs/aEiMX6bLW4KyGApqtZ+5dImtGPBp76p9cgZ10plH2M9k1l7EkcriOFg3sLAx8L8X+YdVbJh86x+oyiYgfoyGgI0BOShuMIwRbC+dnQNRvD0EaxVYk+/ZKlSl6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubvZ5B/U0zJRiHoKkK1kUFSJPLS1kJlzT1bOlSqqO60=;
 b=BlS/lDzDdRLEO9Np34Cb+V0dxhcaWjt25NNJa8TyzKDgZQq4rxqk1djRdul/jFI9UAkewVn14j8xV6wiEE0AH/VDtdcOnk88bbu9PDW7DG0Rz4ZGUM2LcPTkMyrUp6hAENI8Zh5F0Dnqy2pgGaSkHYHy0YRDesNFA9Kl3oUQNktTvkLFgVK9b9iTtihKaELabF/dMkRCmtZ/0fXxDiyPB6jGGp29ohnmpYyYV3nAA1nSc7ekaNA9X/rbAqqkyXpgnLXIBzd4yzRlXBNWlEjJ47tgQC7+d9aPgjdFjkVgbxsM9F5gcLLwtAN8tH0DfcIRu34UxWeTAgxHaZyGPxxqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubvZ5B/U0zJRiHoKkK1kUFSJPLS1kJlzT1bOlSqqO60=;
 b=TwPwkMahRU1PkIZ/Uhi4qi/U6X/a/Z5eFfLEplByT1braygeOdHVP/bg6u6X4QIpM2r6BXXxKJ0B7TU/aDfAA7FBF3wNvhwt3vyQyZVXDagm2WbHB9ahqeSKj1iypUkVoZem0lcynn1AcDBUDYys2gR6DQXeHpSzxR86PGRcz5/qSAwEeyYpHOwBXkpSsZVhtg8jHJGDCbX5z0ieoi2F6M3ZDzrRJcpegyYIGk/+xprYo5RQvOkBZb4WcFGr9sBqGiVUbk3zJbWcdXFCWnusw9vFZEBicQakK69ccdtKu+JBP4VOlpXqG3cvF05BpQ8Jj7Ra2xvC26uqAUKLsek1GQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Thu, 23 May
 2024 04:29:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 04:29:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Meneghini <jmeneghi@redhat.com>, "emilne@redhat.com"
	<emilne@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jrani@purestorage.com"
	<jrani@purestorage.com>, "randyj@purestorage.com" <randyj@purestorage.com>,
	"hare@kernel.org" <hare@kernel.org>
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Topic: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Thread-Index: AQHarGjF7HO7Dhk/3EeKOsPlzX5snbGkOs4A
Date: Thu, 23 May 2024 04:29:35 +0000
Message-ID: <935f7e10-ccb4-4891-8f29-84909c061e7a@nvidia.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB5981:EE_
x-ms-office365-filtering-correlation-id: 62008ac8-5c6f-4df1-5a00-08dc7ae0f340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TUdsMGM0ZkdSaWo2RG96bHpTdjQ5K0NTakE4c28zSm03a3AwakFOZVpUdy9q?=
 =?utf-8?B?Vnp5cHhMQ3pCMlNxNXpZUWxHOWxBSnVrYjRubzFGemFjVG5IOE9MYUtlT1pl?=
 =?utf-8?B?UTNrZkd3ci9zTi94U1M0eFY3TEdZN3VwNzZpaEhpREVqUm54QXdxK1hmOWtm?=
 =?utf-8?B?dWEwRjcxM1c3UVFLVjNWeEFtdVl1VnR2U1g2OGpUUExpUmZNc21hVnZtNnJR?=
 =?utf-8?B?aDJ4T2JIeHlTMklwTWgybzM2bDZMWG8wbFFVekFUZFl4NXlhVFdRTTR1VEJR?=
 =?utf-8?B?cDE2NndHZFVaZXM4VTJHa3czVGduZUQyKzkzU2tma3h3UmFYVjQyam9VSEhy?=
 =?utf-8?B?QzhGbnBtb21FUVZDY1BXUjZXUm1uTzlSdGxSYjJJUVlYdmNRODZtVkQ1eTVa?=
 =?utf-8?B?MmJ3ckFONjJHU0J0ODQ4cTV2M3RGN3cwUmdNUVRMMDRqUmVocjBURllRdUJu?=
 =?utf-8?B?a0xrOHNWYk4zWGt4ZWFqb0ZUVmpHZDF2Wjk5dDIwSmFYSFJEL2tvV3pyOUIw?=
 =?utf-8?B?K1RLTmphVTBhcVpEU2pob0lhUE40SDJQNzdqZkd3TS9Sb0dvemhmUXhiWVVm?=
 =?utf-8?B?dWZxVXI5NDF1dnFpZE8yUE1hb3VsV3dhUFBMS3JWYjBHVFg4NzJ4NzgrWlU4?=
 =?utf-8?B?OC9MRUtxbEtoZHozaGxJajIwUXczVzhRMFFlUkFxK1p4alNnbHhJcjE0WE9N?=
 =?utf-8?B?V2owMVpKbWpDcEIvQ3Q5SmpjMzFkcVhYdk5OL2ZTQWZCQ002NjFHM0hDRXpE?=
 =?utf-8?B?M0pNbkM2Wm1paGJUSmE0YmdhUmdQTnkrNTMxeUI4U2d4anVpM0VTMmw3YnEz?=
 =?utf-8?B?ZElQdjFUbWowZDNjZ29wM0lzekVqNE9XVStOc0YyNyt0QTVHUGVKalB3YTE4?=
 =?utf-8?B?U3NjQnBONVVOUHNaM0kvL0x1YjdQNVlMWkJha1ovb3hpeDNrdzVtZ0FIeG9T?=
 =?utf-8?B?MWtVcXl2ODZDZmh6eSszYkpTeFF2dmxUdXBURTUxZW51MHh3WDB0eDRCQTVv?=
 =?utf-8?B?ZkFnNThnQWhVeHlsdVk2YXJnVjg0ZFNYK01TQXpFMHk0dTdjcUYrNkZPaHlF?=
 =?utf-8?B?L3lhMWNCbWlZZEZVeFhmV2tlVTZ1WmRYdXY3R3FPVVpRUFZPYXhrWkUrRENO?=
 =?utf-8?B?TEVFM3M5bTlUdWVzb2FQQXNQMUovbGpScHBGUkZrR3RWenB3aDc0Y2pXRFJk?=
 =?utf-8?B?cm51SU1hNXNad2o1MGcyaWRLa0JJZDdoOG5YczhOWU1QMHM4VUtDOVEyY3dB?=
 =?utf-8?B?ejd6cFNXMDltZlI3eDV1VFZpRWdJV0tmL2dFVUkxbUhnVkRpMGRuVnpNanRC?=
 =?utf-8?B?b0lGcndSUUIrOEd4WFhhaDE4SzJtM214dXkySklYMkFnMGFLV0c5RzVDRVQr?=
 =?utf-8?B?dkN1OGRFWDljOWo3Y3dyOTZKQXJiNEVJYURsNEYwL0xQWXJyYkk3cWNiL0c5?=
 =?utf-8?B?MzRtNEppZURZV1JoRHZXcGxOUk50TEt4bkdSZTUxUjc4Zk92a09icXJHSGZY?=
 =?utf-8?B?MkhGOVpFUU9SMzFBSGl4djFURDl3eURnM3pqTy84MWpkY3IrdnY3UUszVzQ2?=
 =?utf-8?B?QlJ5TVBTLzV0ZkQyTTBNNTUyMy9WWG11QmFXaDk5UmMyMEowZjlIYWJzZ243?=
 =?utf-8?B?cllBMzRNSE44eEFCMlZjci9qY1QrY0o3N3R6cDZmc2RXc1ZZOFV4bjVTTUl3?=
 =?utf-8?B?bDVKbENGODBqN2F1aTk2cEYwVk1oa3dNMkZDdXpiRzh3b0dXZ1QxRnRHblpz?=
 =?utf-8?B?aldjd1RRSGpoZmpvUFo4YkppS1laUDJHT1pwejV6ckQzZ1ljTEFBV3BmeE9x?=
 =?utf-8?B?YzBVOUYvK0JDZ2p4QktmQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEZNR0xETExTb1Vwb05QeVVrS3B3U0xOYnVNL0lmVWs5YnMwUWF5QzJ3ZFBu?=
 =?utf-8?B?SnpqVzYzT1FUTjVFWklsNG9ZU05BUjIwbUR5djdnbmx2WUFEK2FhM0oxa1Zv?=
 =?utf-8?B?TnRDY0s4MWExNVZOTlU4d2FhSzZGcnJTNE92V2M4dm1hNzN2VTE5S05NKzNp?=
 =?utf-8?B?eU5jai94ZGJnWE45bG4vb2dRQjlSMUdkLy9TT3JPTlZGbkdOWVpCSElJaFVu?=
 =?utf-8?B?VnlwbmtiMUxCRHJxN2Uzd04ra2NBcHcwUm8wTmMvNGg2QmFCVXd6Y2l5ZVpw?=
 =?utf-8?B?WWh5RExDeTJjTHJaRUxDNEJ2Z09NOHg2TzA0ODQzNUoySWN3OTYyM1d1REZy?=
 =?utf-8?B?Z0xTeVo2TTBaU0hIZWVvN2tRTWJoWlphSUs1Wi8zdlYzSUhmWCtKSVJqNUlt?=
 =?utf-8?B?blNwUnA0cU9UYnZYWi9yby9XRG8yVWlaMEkwa1dQN21jSnBtRzFuUFBDVnJ3?=
 =?utf-8?B?dnh6K3ZqbWtrUDhZM1dnenFFMlZHd1UzcDRockw1cVpmTWttU21XQTJnajg3?=
 =?utf-8?B?UHoyS3Q1YXk0TmZoc0dSRjdMSFpsRVl2TUpZbFBrTFlLOVJ0cHpaSFlOMmdN?=
 =?utf-8?B?NTcwb3N2TVlIb2k0OEVHbGxZS0lzQThjVldKVmlMa2xxaGxPRXJFbFZzTXhB?=
 =?utf-8?B?bFl6LzB0KzhqZ01qWmVDaUlRQkFseXI3VEZGTDdKV2t5MW1FV1NuZC9IMkRT?=
 =?utf-8?B?SkJmTlRDb2lqa01xd1REMTJqZ2lrREdiaXJ4MjE5eFBSN0gzaVpOeUxRdlBX?=
 =?utf-8?B?T09DMFdUaUxuN3NCT2hFK2NSRXVTdVo3QmZUYzJVTUNCb0RhZStrMC9GdmFn?=
 =?utf-8?B?cWovTUNqbkd1WG9IL3hkakRGalcydlJScytNNzNVY0svSTNUUW5aeEZiYmha?=
 =?utf-8?B?WXE0Mk1zR0w2ajdiWFp4Z1ZOWUxjNk1wNEU0aXUyQlFieVUvWitvSDZ0bnM1?=
 =?utf-8?B?UHdJeFZ6MWxZOVFhdGpjeGlpRGdWYWliRmdFTXo2S0cwNXBSdHdUZGh0L1g3?=
 =?utf-8?B?cXRVc0NUNmdLNStCeHVjSzZRVkUzckpUSEFVZHZFTUtvY1hueWd4SE8rOWVL?=
 =?utf-8?B?TWJOQlgrbVJuMDdpS0JNRVc5Ujg0VGF0SE14czcwUkJEbkhUdzV4T2ZQZUIx?=
 =?utf-8?B?OWtNVUxTaDZRVlR1NlFaNTVYdDYyeE40OHFzZ09PYlZzdHBtK2NSV0pZOE9x?=
 =?utf-8?B?VGFjSlE2U2xqNXVvZ2VHNU14ZDRzQkljK1BIVmJkK0k2MkR4QythK1V1dDJR?=
 =?utf-8?B?MmhVOFBkaXgvb3RIc0l3dHd2T0xLNm9XdnYyOEo4NWxRVVJoUWdJSHRiemtU?=
 =?utf-8?B?cWJPSllWYkRxRHA1MDNSbGthRmdidmVJblZyMklyQmd2VzdVNXord0lodlZr?=
 =?utf-8?B?bC9FRWNySFUvWFo3ZmUxSXRjd21jcVBHYWVjTGVyUkdzSFVPWkRlTjVQcEVk?=
 =?utf-8?B?cDNxcFk5ajFNQWFFdXJjQnQ4RjlMRzJYWTRWRkx1NndHNnlzb21WMktiR3F5?=
 =?utf-8?B?OGxqVjl4MEpic0lLRm9DY3V6cFcrRE1KR29FU3pEOWhUYmxEVlB4SXlVQktR?=
 =?utf-8?B?QmpiamsrTVpNbHZLUG9xdTJBcEI4YmlVWmNQY0RCejNMUEdYa0UvOElvako0?=
 =?utf-8?B?STBLazZORVlZY3NsdmI1QXZ1b1J2LzlPUktRazJHOVhhWHJ1SmRsZnpSWnMw?=
 =?utf-8?B?RU5tMFk4OU5HeXZ1cS9MYVhRY1A3MGtVUGVUcVVmN1FIYVg5Q3c1WTVKeUpy?=
 =?utf-8?B?b0pDUy96dnk5T1krVXFEWS9ka1d4cnFOOXREMDlnbzA2VVVIQndQYlJXcUFZ?=
 =?utf-8?B?d1NFeGQ1bVFvYkZzNlJIUXUycWxUYWRwUzJQNTVXWmxwdHcwdjU3Y0U2TG1Y?=
 =?utf-8?B?bTJKU25MZUMzUWlvUUVTNVVXQkZLOXNMWFNKSmlOWmxSOWRCSXVLY0ZzQ2hP?=
 =?utf-8?B?dk00RDR0ckQ3cCtFY0lMRHlxeUdLek1FZWxHS1U1VVB1cWI3YnpKOEJxMi9l?=
 =?utf-8?B?aTZWT2w1SlNvS1l0UXJnbFdUc0hpbW1OM3ZncUFZSU00aUNtVjhnUnpNNVFY?=
 =?utf-8?B?V2E5NEZINWQyWDVBd3JERkQrbHREU0xCUTBTaEZCbFNXRE9zdUpaV3ZSdXIz?=
 =?utf-8?B?TXRBY3R4dUlQS2h5dlhpN1NVWlVzSWRZN2oyM2duZTljbGlmRkVTM3RVQW8x?=
 =?utf-8?Q?qlLfd+gQ46CpO9fKYj/Qp0L5xXeU6foJxnV4qaDJlbf+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F447C6DE4282824E90C2ECB725C1752B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62008ac8-5c6f-4df1-5a00-08dc7ae0f340
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 04:29:35.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqvliYUzfHAO4/NEDif2DrHeLUjkvrv/U6fC/jRHi2/IGMTEC6ECBhmKi8JI8MXcmnUy2vQqUKm5qEcFsvhPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_212955_211124_F7517629 
X-CRM114-Status: GOOD (  23.80  )
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

T24gNS8yMi8yNCAwOTo1NCwgSm9obiBNZW5lZ2hpbmkgd3JvdGU6DQo+IEZyb206ICJFd2FuIEQu
IE1pbG5lIiA8ZW1pbG5lQHJlZGhhdC5jb20+DQo+DQo+IFRoZSByb3VuZC1yb2JpbiBwYXRoIHNl
bGVjdG9yIGlzIGluZWZmaWNpZW50IGluIGNhc2VzIHdoZXJlIHRoZXJlIGlzIGENCj4gZGlmZmVy
ZW5jZSBpbiBsYXRlbmN5IGJldHdlZW4gcGF0aHMuICBJbiB0aGUgcHJlc2VuY2Ugb2Ygb25lIG9y
IG1vcmUNCj4gaGlnaCBsYXRlbmN5IHBhdGhzIHRoZSByb3VuZC1yb2JpbiBzZWxlY3RvciBjb250
aW51ZXMgdG8gdXNlIHRoZSBoaWdoDQo+IGxhdGVuY3kgcGF0aCBlcXVhbGx5LiBUaGlzIHJlc3Vs
dHMgaW4gYSBiaWFzIHRvd2FyZHMgdGhlIGhpZ2hlc3QgbGF0ZW5jeQ0KPiBwYXRoIGFuZCBjYW4g
Y2F1c2UgYSBzaWduaWZpY2FudCBkZWNyZWFzZSBpbiBvdmVyYWxsIHBlcmZvcm1hbmNlIGFzIElP
cw0KPiBwaWxlIG9uIHRoZSBoaWdoZXN0IGxhdGVuY3kgcGF0aC4gVGhpcyBwcm9ibGVtIGlzIGFj
dXRlIHdpdGggTlZNZS1vRg0KPiBjb250cm9sbGVycy4NCj4NCj4gVGhlIHF1ZXVlLWRlcHRoIHBv
bGljeSBpbnN0ZWFkIHNlbmRzIEkvTyByZXF1ZXN0cyBkb3duIHRoZSBwYXRoIHdpdGggdGhlDQo+
IGxlYXN0IGFtb3VudCBvZiByZXF1ZXN0cyBpbiBpdHMgcmVxdWVzdCBxdWV1ZS4gUGF0aHMgd2l0
aCBsb3dlciBsYXRlbmN5DQo+IHdpbGwgY2xlYXIgcmVxdWVzdHMgbW9yZSBxdWlja2x5IGFuZCBo
YXZlIGxlc3MgcmVxdWVzdHMgaW4gdGhlaXIgcXVldWVzDQo+IGNvbXBhcmVkIHRvIGhpZ2hlciBs
YXRlbmN5IHBhdGhzLiBUaGUgZ29hbCBvZiB0aGlzIHBhdGggc2VsZWN0b3IgaXMgdG8NCj4gbWFr
ZSBtb3JlIHVzZSBvZiBsb3dlciBsYXRlbmN5IHBhdGhzIHdoaWNoIHdpbGwgYnJpbmcgZG93biBv
dmVyYWxsIElPDQo+IGxhdGVuY3kgYW5kIGluY3JlYXNlIHRocm91Z2hwdXQgYW5kIHBlcmZvcm1h
bmNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgU29uZyA8dHNvbmdAcHVyZXN0b3JhZ2Uu
Y29tPg0KPiBbZW1pbG5lOiBwYXRjaCBkZXZlbG9wZWQgYnkgVGhvbWFzIFNvbmcgQCBQdXJlIFN0
b3JhZ2UsIGZpeGVkIHdoaXRlc3BhY2UNCj4gICAgICAgIGFuZCBjb21waWxhdGlvbiB3YXJuaW5n
cywgdXBkYXRlZCBNT0RVTEVfUEFSTSBkZXNjcmlwdGlvbiwgYW5kDQo+ICAgICAgICBmaXhlZCBw
b3RlbnRpYWwgaXNzdWUgd2l0aCAtPmN1cnJlbnRfcGF0aFtdIGJlaW5nIHVzZWRdDQo+IFNpZ25l
ZC1vZmYtYnk6IEV3YW4gRC4gTWlsbmUgPGVtaWxuZUByZWRoYXQuY29tPg0KPiBbam1lbmVnaGk6
IHZhaXJpb3VzIGNoYW5nZXMgYW5kIGltcHJvdmVtZW50cywgYWRkcmVzc2VkIHJldmlldyBjb21t
ZW50c10NCj4gU2lnbmVkLW9mZi1ieTogSm9obiBNZW5lZ2hpbmkgPGptZW5lZ2hpQHJlZGhhdC5j
b20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyNDA1MDky
MDI5MjkuODMxNjgwLTEtam1lbmVnaGlAcmVkaGF0LmNvbS8NCj4gVGVzdGVkLWJ5OiBNYXJjbyBQ
YXRhbGFubyA8bXBhdGFsYW5AcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFJhbmR5IEplbm5p
bmdzIDxyYW5keWpAcHVyZXN0b3JhZ2UuY29tPg0KPiBUZXN0ZWQtYnk6IEp5b3RpIFJhbmkgPGpy
YW5pQHB1cmVzdG9yYWdlLmNvbT4NCj4gLS0tDQoNClsuLi5dDQoNCj4gK3N0YXRpYyBzdHJ1Y3Qg
bnZtZV9ucyAqbnZtZV9xdWV1ZV9kZXB0aF9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQp
DQo+ICt7DQo+ICsJc3RydWN0IG52bWVfbnMgKmJlc3Rfb3B0ID0gTlVMTCwgKmJlc3Rfbm9ub3B0
ID0gTlVMTCwgKm5zOw0KPiArCXVuc2lnbmVkIGludCBtaW5fZGVwdGhfb3B0ID0gVUlOVF9NQVgs
IG1pbl9kZXB0aF9ub25vcHQgPSBVSU5UX01BWDsNCj4gKwl1bnNpZ25lZCBpbnQgZGVwdGg7DQo+
ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShucywgJmhlYWQtPmxpc3QsIHNpYmxpbmdz
KSB7DQo+ICsJCWlmIChudm1lX3BhdGhfaXNfZGlzYWJsZWQobnMpKQ0KPiArCQkJY29udGludWU7
DQo+ICsNCj4gKwkJZGVwdGggPSBhdG9taWNfcmVhZCgmbnMtPmN0cmwtPm5yX2FjdGl2ZSk7DQo+
ICsNCj4gKwkJc3dpdGNoIChucy0+YW5hX3N0YXRlKSB7DQo+ICsJCWNhc2UgTlZNRV9BTkFfT1BU
SU1JWkVEOg0KPiArCQkJaWYgKGRlcHRoIDwgbWluX2RlcHRoX29wdCkgew0KPiArCQkJCW1pbl9k
ZXB0aF9vcHQgPSBkZXB0aDsNCj4gKwkJCQliZXN0X29wdCA9IG5zOw0KPiArCQkJfQ0KPiArCQkJ
YnJlYWs7DQo+ICsNCg0Kbml0Oi0gbm8gbmVlZCB0byBhZGQgd2hpdGUgbGluZSBuZWVkZWQgYWZ0
ZXIgYnJlYWsgYWJvdmUgPw0KDQo+ICsJCWNhc2UgTlZNRV9BTkFfTk9OT1BUSU1JWkVEOg0KPiAr
CQkJaWYgKGRlcHRoIDwgbWluX2RlcHRoX25vbm9wdCkgew0KPiArCQkJCW1pbl9kZXB0aF9ub25v
cHQgPSBkZXB0aDsNCj4gKwkJCQliZXN0X25vbm9wdCA9IG5zOw0KPiArCQkJfQ0KPiArCQkJYnJl
YWs7DQo+ICsJCWRlZmF1bHQ6DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICht
aW5fZGVwdGhfb3B0ID09IDApDQo+ICsJCQlyZXR1cm4gYmVzdF9vcHQ7DQo+ICsJfQ0KPiArDQo+
ICsJcmV0dXJuIGJlc3Rfb3B0ID8gYmVzdF9vcHQgOiBiZXN0X25vbm9wdDsNCj4gK30NCj4gKw0K
PiAgIA0KDQpbLi4uXQ0KDQo+IEBAIC04MDAsNiArODYwLDI5IEBAIHN0YXRpYyBzc2l6ZV90IG52
bWVfc3Vic3lzX2lvcG9saWN5X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiAgIAkJCSAgbnZt
ZV9pb3BvbGljeV9uYW1lc1tSRUFEX09OQ0Uoc3Vic3lzLT5pb3BvbGljeSldKTsNCj4gICB9DQo+
ICAgDQo+ICtzdGF0aWMgdm9pZCBudm1lX3N1YnN5c19pb3BvbGljeV91cGRhdGUoc3RydWN0IG52
bWVfc3Vic3lzdGVtICpzdWJzeXMsIGludCBpb3BvbGljeSkNCg0Kbml0Oi0gb3Zlcmx5IGxvbmcg
bGluZSwgYXMgcmVzdCBvZiB0aGUgZmlsZSBpcyA8IDgwIGNoYXIgcGFyIGxpbmUgPw0KDQo+ICt7
DQo+ICsJc3RydWN0IG52bWVfY3RybCAqY3RybDsNCj4gKwlpbnQgb2xkX2lvcG9saWN5ID0gUkVB
RF9PTkNFKHN1YnN5cy0+aW9wb2xpY3kpOw0KPiArDQo+ICsJaWYgKG9sZF9pb3BvbGljeSA9PSBp
b3BvbGljeSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJV1JJVEVfT05DRShzdWJzeXMtPmlvcG9s
aWN5LCBpb3BvbGljeSk7DQo+ICsNCj4gKwkvKiBpb3BvbGljeSBjaGFuZ2VzIHJlc2V0IHRoZSBj
b3VudGVycyBhbmQgY2xlYXIgdGhlIG1wYXRoIGJ5IGRlc2lnbiAqLw0KPiArCW11dGV4X2xvY2so
Jm52bWVfc3Vic3lzdGVtc19sb2NrKTsNCj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGN0cmwsICZz
dWJzeXMtPmN0cmxzLCBzdWJzeXNfZW50cnkpIHsNCj4gKwkJYXRvbWljX3NldCgmY3RybC0+bnJf
YWN0aXZlLCAwKTsNCj4gKwkJbnZtZV9tcGF0aF9jbGVhcl9jdHJsX3BhdGhzKGN0cmwpOw0KPiAr
CX0NCj4gKwltdXRleF91bmxvY2soJm52bWVfc3Vic3lzdGVtc19sb2NrKTsNCj4gKw0KPiArCXBy
X25vdGljZSgiJXM6IGNoYW5nZWQgZnJvbSAlcyB0byAlcyBmb3Igc3Vic3lzbnFuICVzXG4iLCBf
X2Z1bmNfXywNCj4gKwkJCW52bWVfaW9wb2xpY3lfbmFtZXNbb2xkX2lvcG9saWN5XSwgbnZtZV9p
b3BvbGljeV9uYW1lc1tpb3BvbGljeV0sDQoNCm5pdDogb3Zlcmx5IGxvbmcgbGluZSBhYm92ZSBh
cyByZXN0IG9mIHRoZSBmaWxlIGlzIDwgODAgY2hhciAuLi4NCg0KQXMgZmFyIGFzIEkgcmVtZW1i
ZXIsIG1vc3Qgb2YgdGhlIG52bWUgY29kZSB1c2VzIHByX2luZm8oKSwgYnV0IGlmDQpkZWNpc2lv
biBoYXMgYmVlbiBtYWRlIHRvIHVzZSBwcl9ub3RpY2UoKSBmb3IgYSBzcGVjaWZpYyByZWFzb24g
dGhlbg0KcGxlYXNlIGlnbm9yZSB0aGlzIGNvbW1lbnQuDQoNCj4gKwkJCXN1YnN5cy0+c3VibnFu
KTsNCj4gK30NCj4gKw0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gaW5kZXggZmMzMWJkMzQwYTYz
Li5mYTM4MzNkODhhODUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0K
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gQEAgLTUwLDYgKzUwLDggQEAgZXh0
ZXJuIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpudm1lX3dxOw0KPiAgIGV4dGVybiBzdHJ1Y3Qg
d29ya3F1ZXVlX3N0cnVjdCAqbnZtZV9yZXNldF93cTsNCj4gICBleHRlcm4gc3RydWN0IHdvcmtx
dWV1ZV9zdHJ1Y3QgKm52bWVfZGVsZXRlX3dxOw0KPiAgIA0KPiArZXh0ZXJuIHN0cnVjdCBtdXRl
eCBudm1lX3N1YnN5c3RlbXNfbG9jazsNCj4gKw0KPiAgIC8qDQo+ICAgICogTGlzdCBvZiB3b3Jr
YXJvdW5kcyBmb3IgZGV2aWNlcyB0aGF0IHJlcXVpcmVkIGJlaGF2aW9yIG5vdCBzcGVjaWZpZWQg
aW4NCj4gICAgKiB0aGUgc3RhbmRhcmQuDQo+IEBAIC0xOTUsNiArMTk3LDcgQEAgZW51bSB7DQo+
ICAgCU5WTUVfUkVRX0NBTkNFTExFRAkJPSAoMSA8PCAwKSwNCj4gICAJTlZNRV9SRVFfVVNFUkNN
RAkJPSAoMSA8PCAxKSwNCj4gICAJTlZNRV9NUEFUSF9JT19TVEFUUwkJPSAoMSA8PCAyKSwNCj4g
KwlOVk1FX01QQVRIX0NOVF9BQ1RJVkUJPSAoMSA8PCAzKSwNCg0Kbml0Oi0gSSB0aGluayB3ZSBu
ZWVkIHRvIGFsaWduIGFib3ZlIGxpbmUgdG8gcmVzdCBvZiB0aGUgbWVtYmVycyBpbg0KIMKgwqDC
oMKgwqAgdGhpcyBlbnVtIC4uLg0KDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIHN0
cnVjdCBudm1lX3JlcXVlc3QgKm52bWVfcmVxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+IEBAIC0z
NTksNiArMzYyLDcgQEAgc3RydWN0IG52bWVfY3RybCB7DQo+ICAgCXNpemVfdCBhbmFfbG9nX3Np
emU7DQo+ICAgCXN0cnVjdCB0aW1lcl9saXN0IGFuYXR0X3RpbWVyOw0KPiAgIAlzdHJ1Y3Qgd29y
a19zdHJ1Y3QgYW5hX3dvcms7DQo+ICsJYXRvbWljX3QgbnJfYWN0aXZlOw0KPiAgICNlbmRpZg0K
PiAgIA0KPiAgICNpZmRlZiBDT05GSUdfTlZNRV9IT1NUX0FVVEgNCj4gQEAgLTQwNyw2ICs0MTEs
NyBAQCBzdGF0aWMgaW5saW5lIGVudW0gbnZtZV9jdHJsX3N0YXRlIG52bWVfY3RybF9zdGF0ZShz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KPiAgIGVudW0gbnZtZV9pb3BvbGljeSB7DQo+ICAgCU5W
TUVfSU9QT0xJQ1lfTlVNQSwNCj4gICAJTlZNRV9JT1BPTElDWV9SUiwNCj4gKwlOVk1FX0lPUE9M
SUNZX1FELA0KPiAgIH07DQo+ICAgDQo+ICAgc3RydWN0IG52bWVfc3Vic3lzdGVtIHsNCg0KYXBh
cnQgZnJvbSB0aGUgZmV3IG5pdHMgcGF0Y2ggZG9lcyBsb29rcyBnb29kIHRvIG1lLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0Kbm90IGEgYmxv
Y2tlciB0byBtZXJnZSB0aGlzIHBhdGNoLCBidXQgd2UgbmVlZCBhIGJsa3Rlc3RzIGZvciB0aGlz
IGNvZGUgDQppbiBudm1lDQpjYXRlZ29yeSAuLi4NCg0KLWNrDQoNCg0K

