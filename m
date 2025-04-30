Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8E6C369DC
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uda/L1Aph2j4ocKV/546bUl0ijP5yKVRKcDWJGjDvnU=; b=DF27VyYlvpzze604gUHpxVtudi
	oq/c8pEajtbRG4eE52/zurYq2yrZKZPkdH7kEpfNIyUfW0JAv1VPewlkln0BCJNC9B/nLjkTHiUA7
	3K7pwpIXN+wHbCb8Ro+7UUV58G44pyJFXgm9uyrzKp0+4bd3vuFmEXyn35R2J7Ie/so+B6U8Kum0I
	dbsP5pwnrWnDH/hI+N6HuS0KT/Zeh94t4gGHQ3OGUYV5SoRtQbDORoyX/Ifev7mp72yTo0aWswnC0
	r9leBkbzKqxBOAGSDcAF3MmlqDn+h2zf7Aq0ge2ORFMTj88acowZBnMIvpL34i036QSCbDzCAK+6H
	HWK8V9pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9vZ5-0000000BMfA-05Vm;
	Wed, 30 Apr 2025 00:44:43 +0000
Received: from mail-mw2nam12on2062f.outbound.protection.outlook.com ([2a01:111:f403:200a::62f] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9vZ2-0000000BMeK-20Cy
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 00:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1hxnLTRHSoiwU795DoX8bDrdx41IzIY2S9Csg8z6ng2UinU3ddjPQDWoq75m8eTrv8kRnZRdsb2XBzZdV2fUZ6vanibX9ESHVtGflN4N5IYlx5NMqpCMvf6/W4PYMtuPemePJt4vf84YjYdg5BBHv7V6LCSVlygWxsDpdRLxbwnUIPEju0x0Cgt6PfcdevfHeeNX6yFGmztLDJi3aqHkcvw5Q9pwcoEQQ8cztxca/y7DwTJpiy+WSWw0AQ0zbW1giBNZfZVWBmfgnKw7UXfpGxgt7c6mGkLLnkI7/M1sG/6ymI5n8l0uMIgO3ENHp/dpYdJrlVDqlQ2TC5UOnEycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uda/L1Aph2j4ocKV/546bUl0ijP5yKVRKcDWJGjDvnU=;
 b=trAV3At7nDy1kNdVdNXCplwuanEsTudweipYf1zlA/4cGc3ckitrtG1uA1GdOSeLW79jUMjBvUDbJ5sn+8PRSFvAwQF2oaPtUP7r7dpKjS0UFOOpxJegcz6BoFJOuK8sRiDwPee0zqwm5TsSjDn2UWzBA9L0xQttrWm4+VbtPjPeVjP7OVDt0I75IBtu33rJeVeFYpeu0UDTmTi7VOUt+kBKcQZVxXcIr+wGFczWxsm+zp5s21v5qBolr5/tSM37N/q0NWXyIufKo8tQt+iCUP7FwylF9K+5NV0V4BBNFwzfVZXvRTc/iGF8iWXyMEwHyiT+cgBvWry3NPXeij9/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uda/L1Aph2j4ocKV/546bUl0ijP5yKVRKcDWJGjDvnU=;
 b=F7sA4ZvBk39HryZ+yw9Q+SsLFrtCbokyI+Vb4g40psnND8KM9nsEODIGFYsSIxKud25O95TNX30b0hAgsGeqOnTOj6w4iU8prK9d92K2M1AKuZ9HMJERsNaKNhzn3aoQOVLNigUEvljLBWlzgd00BrEhWxnAGy0egaVGNL3zU8hsOHXnkkkaK8PvPQLj3Qr6Qw3VJESThpgcmoA2MWPfNYqfid/nAqZPFY5FIgdzP+Q0PvERNYVgECvXCeQ/rhBT5sHPMXxhFo70Il6H/t5RZDhWhO/APPrQfz4GiQkb5aZWOFAyGh8ORSFaUYHamSNCOBiaO7adTUdNcT8SH6YK+g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 00:44:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 00:44:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvme-tcp: select tls config when tcp tls is enabled
Thread-Topic: [PATCH v2] nvme-tcp: select tls config when tcp tls is enabled
Thread-Index: AQHbuVVtYlMlcG2/X0uU6qhVnlN+DLO7X2gA
Date: Wed, 30 Apr 2025 00:44:32 +0000
Message-ID: <8dbb8879-0ab0-4ca5-a040-e19a69189a44@nvidia.com>
References: <20250429222347.2215363-1-alistair.francis@wdc.com>
In-Reply-To: <20250429222347.2215363-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8706:EE_
x-ms-office365-filtering-correlation-id: 382be194-4e09-46a3-8ce7-08dd87802c94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZDRocFBUZmdxS3lOTzJGaWdyMEMwbjRrekUwTEN2WE1Wb2hsTTFLRzlCRGlz?=
 =?utf-8?B?SmxLWk1Lanoxa01xMy9BQ2xyRHdCWlhTcFA3RlZscTRaSW5hM05JMXNsd1V1?=
 =?utf-8?B?NXVmbUJDYlk5ZmppOVZHN0sxcllyY095QUhhNW9oQm0wVUorb2NHT09qcDZ3?=
 =?utf-8?B?UmhyTWgxa2R1ZmZwYmlLK0VuVWtBcGtRYkhwaG9saW5HNlNzeVNvZU04eCt1?=
 =?utf-8?B?eUloeGlQdUQ3SGM2MzdVenR6aDVGUTV3eTZKTWRzVW5IN3l3ZnhON20wNDhT?=
 =?utf-8?B?UVhkZGpvMlA1b0NjSyt2ekphSFIyRnlJU2VmNVMxVW8yamNiUUNJUU9pUzJ4?=
 =?utf-8?B?VXg1M0ZZOWNvWTVDTjZvSkxsZjFRV3Z4elo5ZnBYOGcyV0xLYm0zalVHOG5k?=
 =?utf-8?B?dG02SFNQdjQ5QnV5MDBxRkgxb2xXNG1jMDE3L1JGSzBxd1hKMjA5aUp6NC8w?=
 =?utf-8?B?Vmw0NTZlRCtXTlA0cnY0QVFBN1Rpd0J6aG40N21pdGRwTkZPRy9YM0k5Q0hT?=
 =?utf-8?B?RU10S3BMMjBrTlAxSFFaWHByRUtHSTUrS24vUnRVSEQvWmtOOGhubkk2QTI0?=
 =?utf-8?B?RHo5b2Y5WjJ1eTVUaCtTc0dGeUIwd0QrbEVNUGJweGswZGZ3OWhnTUlDeC9a?=
 =?utf-8?B?b1U1SmJKcjdua1BCVSsvRm5HNHN4aDZsbWpKU3NkUkp0OUd1TmMzdUdZZ0l5?=
 =?utf-8?B?Y3J0OXYzZjcwaGl1cVg3QUhHUnJmbnVocGNFbFQ3V1hqVE5ud05EeUJKcHJD?=
 =?utf-8?B?NkREdzJRUmFBcGRBbENLMVVHZnFVaktwc0hyOGhpSnV2UUZkc2hEVlZvK2xl?=
 =?utf-8?B?dndiRmFwRFFVK0ZublNxQzZZRXNIWFhBRnJUbU9xbzdpeFNZdElCejNlYngv?=
 =?utf-8?B?SXdRRG9qRmhUNEJrVmJXTWt0b2ZvOGtpRGlPcXpja1IrdUtYY1hIQ2lFOStF?=
 =?utf-8?B?NUgvSGZxVk93ZnhvanY2b09qSFBVdFhsSjV4TXlaaTRIUUNSa2lyU2hkdUZy?=
 =?utf-8?B?M2dWam9GcGNxWWQ2YUhKTm1GcGxTcEt3cXBUUGxhRno2ZTMyWGtYNWlXU05w?=
 =?utf-8?B?UXNKRFhBWldsR2lMb2dtTlJ5aTVLTENDaGNWcjNqQkhPeExHL3V1WEx5WVJC?=
 =?utf-8?B?OCtvWVNjcVZOYUxRaXlxa2ZMdXRPK3g0bXNYb3JxcnFwU3dyaGxmNzlrWTJw?=
 =?utf-8?B?NlRLRk14elZndGNONU9EZ0NyUStuVG80ODlqSk9hSlFEaUtBeC95Mks5OEsw?=
 =?utf-8?B?R2lYaVhyeldKQ01JNjNITi9ENkNtNEdIaXdHSGhTV1RlL09kNFZSWVZvMXAy?=
 =?utf-8?B?OVdPWm5oc1c2N3RXQy9ydjg4Rit2U01XL3h0azRSMHozaVBLVDhvVjRFMTJy?=
 =?utf-8?B?bHhLR05ueWVyL3lJMEZsd3dlVVBhWG5Zb1FUSGhJTHZ4S0F3MkYxczU5UzNK?=
 =?utf-8?B?dFBKRFMzZWgwLzcwTlRIN2ZBUXNmeVBJaXdiSmpjZ1JMR1BxcVBZN0lmUzdU?=
 =?utf-8?B?UTRWQUhRMGc1WWVVNzQ5SE5HZWRTR2c0L0NwN3c1SloydnBCWndNOVhETUZl?=
 =?utf-8?B?QXd6QkwvWC8rWThkaWM4TGE2VEJqS2tPN2RocmJGMnVyUWRDWVR0cktDbzhW?=
 =?utf-8?B?SDRmOWxDaXFtQUs4VGNCdXFVSXk1aHpmQnowUjVodUszYUMrbEJTeXVmemxN?=
 =?utf-8?B?UHZQSElMVmpydm9zV3JOWkVSNmhiTm9pbEJsbXByZXBUU3l2d3lFaWxWZkxJ?=
 =?utf-8?B?T3dqRmFCY0k1STRFc3VDQWh2aC9zc084M0JTZTZwejhlVGVaeGdGcEFEMEVx?=
 =?utf-8?B?U0RPNzN6dEVDazFGR0djRkV3bnU2SitrOHNPMzRxWHl0RzRMN1I1N0ZRci9h?=
 =?utf-8?B?andWaUEyNXhYVFRpSU9ZTWxsaGVDWUs3YVRDc3NRMUZIaEtPUlRCVlJxQXVv?=
 =?utf-8?B?dG8rMExJRm5zb0xBMHRmTUZlbGFNMnJ3OXd1bDF6NW1hdnlKYnlMUUZVTWcz?=
 =?utf-8?Q?+IvuTDv/nQpqrF74R23O4lvnP9KOdw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGYxNm9aQTRGbVkyS2JTZW94MjladG9nZW9Db2RCSjF6UElqSlM5aFBuQlZO?=
 =?utf-8?B?Q09EQUdmaEFFSXVHZkMzRGJTaGdiclpKSUxKeSswV3ZpOU1hb2tyRzJ4OGVZ?=
 =?utf-8?B?b2IxWUdsRFYwWE9jZUhKREVVcmhaUllCMWFydStZWk5qZzJXRWU4SGZIdlBK?=
 =?utf-8?B?Y3VlYXY4QkJRY2ZvdnhpdUZoWTVtWFVoSlllQ1VFNThEMml1MWtmNnZVTmF6?=
 =?utf-8?B?QmcrcGo3WHIwRFFsckJ6Q1UrVzltTkNXZTYyUHJOVGU0WGdlY0dTeHdNVXZ1?=
 =?utf-8?B?YXVwWXZwRTFmTUdFNGw4UllWRnRzam4wN0l3TlY4UlYwWjR4OFNhMUx4by81?=
 =?utf-8?B?Q2NxencxTUp4NS9BYkZmTWdEd1FLOTdrUG1UdjMzMHZrU201NkxZejNwZUNh?=
 =?utf-8?B?WFQ2ZFBZS0lNSTJTK1J5TEN6WGJDc3JIb0QxVVN5S3RYN3JHQkFwcTJGUmNa?=
 =?utf-8?B?NnV3TDVVL1NuQ0tma1c2ZU5mUy90dEp3alY4K1ZNK1R2L0c1d2Z4ZG9OVjJ6?=
 =?utf-8?B?dG9WYTYrM2JaYlNRSjAzck1neGhBdUxzZloyb1ZVUjFKRHFPUDcvTEdMd203?=
 =?utf-8?B?czlWN2JpWjI0RnJRVC9mUTN5UWx0bFBGbTYzbFlMa1hWeXJoc3JrT0dXRlF3?=
 =?utf-8?B?S1owNjBFMXZ0REpmNW1laFV3a3ZaZVpTcm1rUTFORkxYQU9Pd0M4WkdNWDJY?=
 =?utf-8?B?OFB6bytmYzhMeXNGNzZLMmRRRHZwU3FkOFRqVXVrYTdFeFl3Mzc1SmZwdElz?=
 =?utf-8?B?QUsyWHBqeFRaSmJyTkI4SEtpVDBUSG5Tb0xmbXVzYTZpVjNwOHRuZHF2a3BT?=
 =?utf-8?B?bXBGd21LVXlCQ2JveEdpREcvUmh5WEg0T1FWbjJwYWR6OXMvSVFmVzVmVjlI?=
 =?utf-8?B?cUNRSkpZUXJUdTA5b05LOCs0bU5McWxybDB6dTlSaVNOWTN3V21RRGlsMjVN?=
 =?utf-8?B?Z3MxbVRjM05pbDNTdEdHWTR4alhIVHBvaDNmc1oxNWRSOVNXK2laeDRCdDAv?=
 =?utf-8?B?MHdXZDZuclU4WmR1YVJOOXZCTDJtaDRNbWpaUFJ2R1ZZelpXZ05DZUNtK3Q2?=
 =?utf-8?B?Y3hOUTY5YnViZmtsREF3NWhuWEJFVE8rTHp3L1puSWRJbzltYW5aYmhOSGhB?=
 =?utf-8?B?YnJOZ0M1dCtxQ0pmT2pybmp5NFBJS3doL3ptMkg3RlRpWWFGVFF3STJONzJl?=
 =?utf-8?B?MnNGam5Ob0M0aTlNakdIRGRPWFBkbHBLcVZML0V5N1lDcmtlMTZGWHFMZEVU?=
 =?utf-8?B?Uml2eUlmOU5BK3pkNTZNazNmRk41Q1dhOGZRWFV4Nm5YWU9OTEE3RWFNNzRZ?=
 =?utf-8?B?Z1pxMHVYc1NOUUxkbUovS2VMOUduS0h2UGxoV09lU3hTMGlWUFFkLzdaWjlO?=
 =?utf-8?B?anRMUHRvaHQ5VUN0M1Q3WjZEUUNTd2Q4Rk5POTlyMFcyVUtuMlhBcUNka1Ro?=
 =?utf-8?B?QS9UdjFGZm1hcHJ5dlhpZ3hNUHlPRVFyRzhocFFtN1ZzNzdNUEVqRVYwaWho?=
 =?utf-8?B?WEljYkloR3h1MUpGZUNDajdqeVVWUXc5dmpHOEtVUGdzR3Ard0ZFOTVYWTZw?=
 =?utf-8?B?ZDlUZ0lvbHd6a1dQUWtnUUVSMCtFMVU4cVFYdEsvSU9kTEZJSUhFTGtKQ09P?=
 =?utf-8?B?d2dwSlhtM2ZrVUNiWWlxSDIyM1hiOWlEdUdYR3pQYnZmOWZRalp2RTRJallX?=
 =?utf-8?B?N0hYTVdKYm9HZFNPdDFtS3A0MFFXOEJ6blVqcnNYZ1hKa0w4TFRQMTgwb1dS?=
 =?utf-8?B?RUJZUTdyZ3JRakx2MW5BVGZIdzc1YVZJTFh4WkdoYm5TUm9UUlYyOVM4UmhW?=
 =?utf-8?B?Q3JkNTdFazUrS0hQM1Z2TDlCcjBGbENNSmpTMjdualFhdXhmdXpvKzQ2Smlw?=
 =?utf-8?B?TVRQWFRZMk1UMUpZRXY4L0tFQTRnTy80ckZPc0RxcDJ0cXVkTkFyMlBiaU1n?=
 =?utf-8?B?b0MrOGtXcnY5NHZZTVB1OHphQkhxT3hNc1YrL0NVT0tTWEZxbE5wNWlnVXZG?=
 =?utf-8?B?aXpNbHNXMXBaMUJVeDhnVUhrVkZQVkwzbVNIUEpkdDU4SW0xU2paNXh0SENj?=
 =?utf-8?B?U0d3RDZqaElscGI3ZHlHcnpmUUIwa0wvdEVRbUw3cEF4R1lFOU9pZVorckN3?=
 =?utf-8?B?WlhqVTUrTUJ2WU4vaDVlODhuMlZMMXRSb0dra3F2eFJTRjVqdzdtV0Vwa3Fq?=
 =?utf-8?Q?nHK0RUP6KMDuMVedhVb+enIPAyPPSqyQC51l0V9vx3et?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B242C4AB1E50094DACC4994CE05D2B50@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382be194-4e09-46a3-8ce7-08dd87802c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 00:44:32.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McQTknl0k2bMGY3NykBePK/1tqd66OXQN4Yfsk1fQRTiguaKHsMSbq8B18avFBdMer9MB8JnXeN7ufMbeYkLAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_174440_529299_F02D5A27 
X-CRM114-Status: GOOD (  10.34  )
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

T24gNC8yOS8yNSAxNToyMywgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gRW5zdXJlIHRoYXQg
VExTIHN1cHBvcnQgaXMgZW5hYmxlZCBpbiB0aGUga2VybmVsIHdoZW4NCj4gTlZNRV9UQVJHRVRf
VENQX1RMUyBpcyBlbmFibGVkLiBUaGlzIGFsbG93cyBUTFMgc2VjdXJlIGNoYW5uZWxzIHRvIGJl
DQo+IHVzZWQgb3V0IG9mIHRoZSBib3guDQo+DQo+IEZpeGVzOiA2NzViNDUzZTAyNDEgKCJudm1l
dC10Y3A6IGVuYWJsZSBUTFMgaGFuZHNoYWtlIHVwY2FsbCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFs
aXN0YWlyIEZyYW5jaXM8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPiBSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlPGhhcmVAc3VzZS5kZT4NCj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaTxrY2hAbnZpZGlhLmNvbT4NCg0KSSBiZWxpZXZlICJudm1lLXRjcCIgc3Vic3lzdGVt
IGlzIHVzZWQgb24gdGhlIGhvc3Qgc2lkZSwNCm1heWJlIHN1YmplY3QgbGluZSBuZWVkcyB0byBi
ZSByZXBsYWNlZCB3aXRoIGZvbGxvd2luZyA/DQoNCm52bWV0LXRjcDogc2VsZWN0IHRscyBjb25m
aWcgd2hlbiB0Y3AgdGxzIGlzIGVuYWJsZWQNCg0KLWNrDQoNCg0K

