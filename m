Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138AF8DFCC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 21:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sgtglRbeCeaEIhBLghQ8mlGAKjE+H7A4axNmfe2o+6g=; b=xyy9nmfOdbD8dqF6azPtqt05Em
	/9vVFP1+CJoHfaebZCTFCfQ+i5chdqa5msLA/DsxKHqacm17n4UF211wH0CCflQ3oosc1XV8UsAqf
	EbcQj8BOYV2a2yWVzb5aG41xH4MmSRxXur4F/Trg9mV0EBlP3omZLNywcYLjjF8IRy2d0bHtukgih
	zkx1zICU2SLsEy6KFUMc5ADZ2zPoViH7rqtoPPfIsa3XIGkBy9rf9y14CMlfmvSaFSqGT5fvOz5x7
	Cld00zHt0/81XgjouuEs2MiqBgiCLSRFJV1OxudfuWN5vdUFTgjazkF2Ft7u2+eKluu6Or11rMXkK
	YQgPwyOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUMR-000000035rt-0c1Z;
	Thu, 16 Apr 2026 21:34:55 +0000
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUMO-000000035rQ-13fG
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 21:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt8OgPiYnqt4tViwsEPKUf2j5nHkwt149xlfQY+xYUdmCVF0UQ+maqzJVe3SPBs66ssF9sx66HmP0VoXBa6YTqboTccqqJCsfUiR4I1J9ObcR6e1YxvCBiS3ZIXyh1VN2UWNtuRMrxgaiCJGy31XkAYBOO/B6WtAemb9Diz6TjWhFTy535hP8jOGzZNGrUEwg66zM7CtDpvKlHYV5tu4BOrKpff8wrP4lNhp8fuS73PUcF5mPLXt4IXu2iwe/0f8YlQX68VkwKUUiZwkLS23MVkcvoILxM+EAI8zxws5+E7EAdijySjsIAJB1zEzE5TfBQwyLE+ek213Oa5Zt+g/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgtglRbeCeaEIhBLghQ8mlGAKjE+H7A4axNmfe2o+6g=;
 b=boY1Mc3LCyfEzlZPv684hITFEXcT8llRVuE7BM1GQc9vpljxLZcNSjAZzdWT4gIe0EK+5NlijeY7wQOPfAoKJwexHRhJnc9fF8cVj3rPYU+eciQqJ1w+u4N4QXxWTFsJvinje4PAXHtNx+reG/DK1acWvCI9TKhLDjwPBqCgWeGyd3qor7SC5uWM2ttR3LBISIgaaczgyHX4XG9uFju/jpjxkq8x0UMSG0P/aWAAo5lThv2MDxvcvHZuoSTncmbLdJqek0O7YI1SJeS86kkayUpz5VLQsm44pz71ENzCPEDk7TuWA4dDxLclXUsycFWoyySYrNaeM6trHUDP4NfH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgtglRbeCeaEIhBLghQ8mlGAKjE+H7A4axNmfe2o+6g=;
 b=Rch+UZAA51Y2TmrMzk4mHJOcCHpXOqLvv9Md50hmY2DbzbNwGDVSyrJ3Ie/ZulJUx1rDmoMkhgGCTMplCHAlMT1O2rFFfyONWufkuJ3HWl4BdUjY/XKaIFgc948eE+zHXQPkcFAPGle/h5T9G92zfrcMQ8WGqbhi25Kb7eBPkom3T+JmzNp7EJ/EHRsgws1LluDSyg6eeSv8TDY9rRY6bgTg6zyesC/V023fU5O54MlB1kDrYaz3k/rs6d4r8jROkhk43E2hmNX3f8EHeJrOItV6Mkg6/5IAEVRSNPNiBLjgRLImEKfMBSV4rjlnKOmOD+V7ujoPT89hKBGe7NI9ew==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 21:34:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 21:34:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hmi.jeon@samsung.com" <hmi.jeon@samsung.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?7J207J2A7IiY?=
	<euns212.lee@samsung.com>, =?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v6] nvme: Skip trace complete_rq on host path error
Thread-Topic: [PATCH v6] nvme: Skip trace complete_rq on host path error
Thread-Index: AQHczT10sP2ORZWfaUyiQ4HE5xDYNbXiNzKA
Date: Thu, 16 Apr 2026 21:34:43 +0000
Message-ID: <72f67764-f2a7-441a-9c3a-c45635e862df@nvidia.com>
References: <CGME20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
 <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
In-Reply-To: <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 811f86ef-a065-4fc9-6167-08de9bfff946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: KG8HmxtuTb8ii4egLZDaYxDY9mt9xrZN4YG6xGW0XpTl6krgTuglFI8J/0n4y3sRskrajHoDq7HGBIfBtIBofZ79WOQ0BkyuEA3Oo8b0LRp/uq29KaZhuqLH8NvivsQTcRe3ubSNZvZWd4bzRyJDzk4T6n/Rnwgfx8HbKfjabVMwCJ3EPkM0KAD7+UAAfFmr2iQFkbAr8pKH+1pIM1cjkE0mBErp1QRfCIqPhT114EU8MhcTAkkmm5YMm33TnT6q4Vj/eH8fPB4yacVTNsUn42pkMVRUwV2JX38K/P7EOUmQR+8860rPjbmSkSygy1RY9MEr/attMQlkKZCZwgjvXXMFgR+2IkUaIlPykiEIjEf0UT1Ga0ZoJUXQ4S5xWEZOCcNfpvseMZ1iEHH7cpweIbipSv2TN6FqoxdnB1i6YZUqCG0L4Ym0rl6CAxQHzijssJUQ3uJDWjmqHP0fvRp+myHwSsQGN5dfU4rudbUdkT1bkIGGUx6pccWMlGejnAC8eWwI8G33zDtMRG10HynMhCw1LmE9XwOE3r2YpqD65pNladV1J+aVUzZDBUAUtf8XmclkFf73pTsaDz5gIvw72qrQh+hbEMhNvlwLL/PkZU6S1/mew5FEhd2ipdQyyvf/APJmmavMloYOZasEMEttpQETBlB2VFqeQMnF3Lgyr6blNk3vY5iQxWBdEWcFY30DEoBW6ZvaFDdsQ0UlqEdrEZbDpOoGUmrjsLarJ28fsyX3F8NLWT+3HQn5tA+hDYNem9IjKjPeugFGKmZV1MFToaZWMAWbjgm1+xL6hBWfyrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3RGZVk4VVdIUE5PbWE2N2paQTNzRjVNSzVncWNLd0dEQk9BTzJSVThkM0Js?=
 =?utf-8?B?N3FJa2pCbkVsTjZXMmEzeUNXMWhMVHlkOGpRdnlnTnd1bEsvTXlUZmZOZ3U5?=
 =?utf-8?B?UEczQmZxSXIzSE5LUi9nSDVwdjlMcmJ0bTVtNC9LOUJ2Qjk1LzNHNkZUUUhD?=
 =?utf-8?B?emtPam4rRkxTVDNrR0VIWGtzK0p3aitKZUo4ZUFBb3VRYk1rTVJUc3MvWTZm?=
 =?utf-8?B?SWxHbVArVit1WVVKQkFlSmo5VDgyelpLdUg1d0Yrdy8xOUdWTi9KenNtelh3?=
 =?utf-8?B?TTJYWXlRSVp0Rmp6T1U5bmdnWVpxUzFwSkQ3a1E0ZU9LZlBKU2x3b05nRlFX?=
 =?utf-8?B?cnpyUHlXWUh0cml6cU1seWxUbFdlZm9ERGFidTV1RW93MmlMck02QjI3TnVs?=
 =?utf-8?B?RldjMXZjVlV4bXdhUnFPSkl1WVNKb05OTkgxSmY1TElEOWJmbTExQVpxQ3Ry?=
 =?utf-8?B?UU1ZQllUSUZ0enU5TUVuSUpVL1NXdXVhaG9NOHRpK3AwMHZsNUVxKy91bFda?=
 =?utf-8?B?SC95a0xMTHdvQ0VEUTVqQUJJT0RkRDFkMlFnekdaTHlLQ1AzbG5jbWNiZzdh?=
 =?utf-8?B?R1ZmcXNnS2xtazBETHJCYlJnRG8zSERiZWZLck9HS0UrVjFqTkYya3QwNllR?=
 =?utf-8?B?emE5YmRkQnVYaWVkQU43TzJDYmVEWFBKVVNyYTlJendmdXdnTVRUTkR0aEMz?=
 =?utf-8?B?bnYrWjJmRlAvN0dIQnhjc1RWdEREUnBaWUhDQXh2YUsvc1VFTURHS25FZGlk?=
 =?utf-8?B?TmRYUDI5blJ4MUJSZWpwUEZNRDF0c2dZREhZM2xxbmVSekM4SS9LT2RxT1J6?=
 =?utf-8?B?Q0daZDloS2I3ZkFpamNLK2lXZEM0aEU0YS92ZWpVaHB5dDZxV1RQblRnU3pZ?=
 =?utf-8?B?WDdNS1l5aXlkaWxUdTY0eFdFYVZQTmlmMVN3SW8vS05YaXZnTmluWEZNRVdr?=
 =?utf-8?B?NWJKalVlbVk1NzBLMG4xcGVCVCs1b0FCNWUxV1V4NVdlM2RLVGJDMWRoNU8w?=
 =?utf-8?B?OG8zeXU2cDFybjlHMENUb1lIMlRBQnpaZ0JzR0kxUDVqWWhEbyszUFY3ckxV?=
 =?utf-8?B?Z3VwcjQvWGNzVnRJS0IxNldieFFqOFdjTGM2RW1HamVHOXcwSDg1QVBOcmtT?=
 =?utf-8?B?V0Q5dUhVc1RUVHptczdGOGFaVXA1QTJ6cys5akNpTDVuZjh1M3JmbDg3VUxQ?=
 =?utf-8?B?NENmTnpjeHZHMzJOOUptMXhWTm1DUExMeVc4UlA0SHlhdkQwUmVHZDBGVWtW?=
 =?utf-8?B?VWRHQUNaUENpTkhsVkxtQlJSU3BUZHVaeCtsZlcxc1l0ZnQwRU1OWm9pdEs5?=
 =?utf-8?B?RHN6ODRXaWx4UzdUcUMraStVNTF5cXRpQjQvT3dQMy9RNDFXdXMxdlNVZnJq?=
 =?utf-8?B?MmxqdXFhbldaaEltN0NyNkJqc0lPb2JocXIzYmdITU9iUExraTc3bzRoTXRZ?=
 =?utf-8?B?bDI0a1pGbGdKU09FcnZsdXE3czl4UVdUQno5Q2RTUld3dHdkaWZ6QWV0SDJF?=
 =?utf-8?B?bTZCaGRMRmkwcm16WWJzaHc4SXJvMFRCdGtMblM3UEw0dXU4b09FMU1UdGFs?=
 =?utf-8?B?ZnNoZGhyS1NmY25GUUtWSElYVGJPS0dSV0NaNVAxMDVRWDFKTkJGc3o3bU5S?=
 =?utf-8?B?bkVIcWZMMTdnMXg0L0ZybFlnbGdwVWlMcktOWlF4cGloS1VnZ1QxUDlsMSt1?=
 =?utf-8?B?L1JEaWt3ZXc0UUo1blY1OFUyUFNLR0d2dkVxSU1xVHIxQmNuWlBqd0xKMEx3?=
 =?utf-8?B?eWVUeDZsMm9hWGhHSnBBeHQzQjBzN3ZrRXNIeE15bDJmbzY0TzRlYjcxbjMz?=
 =?utf-8?B?bmc3RHJYc3MrWlg0a1B5S3RhczU4VDVBbkcwcEMvNXdXT0lDRFZZeWIwWTdh?=
 =?utf-8?B?bXFCTDhMczVYbHJqQXhnblZSaHNnT2NGSERvNVBleWwxa0lKS3RFNnJHZUpm?=
 =?utf-8?B?aThNNEZDN2F0bzFYZzdhMXNwMTdYTU5sbE5VSE1icm5GektGN1NqOHZhbldJ?=
 =?utf-8?B?NVc4d0VzNDNQcDA3TER2alZPMklaenpwMi9rOHowMWcrbThuYm9TVi9ZMGJ1?=
 =?utf-8?B?UTlmcVJWZWVUM1BMQmZIT0dnWW14bE11TytndzhSSWpGZDdqMUxmRC80K0tt?=
 =?utf-8?B?N3J0M3VrM2RudGZpb1ZKd1Y3WjhBYkRXTGV5WDRtRmRxd2Z3eHV1RGExTXRh?=
 =?utf-8?B?d3FuRmJiWWhVSjQ0Y3YxOW53RjZDYjNzRW9GOUlyQXdOeGFoZE9ySjkzVlVF?=
 =?utf-8?B?WTBGbnVxclV2Vnp5eFNjcXMxR0NCNWlNLzZGc29tMTJOUXYvcEZzUFlBVHQ4?=
 =?utf-8?B?cE9iUTdXcTZYNCtJQjN6ZHpIWHZ2Y3pWbzgrU1VNbjIyc010RkpJdlo0UFF3?=
 =?utf-8?Q?4uRR/8R4Tzu+BCn3gc4FdY2RSw7nkhlftPDoHQoVm3WJu?=
x-ms-exchange-antispam-messagedata-1: wr194Y0EKy5HrA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5B2B2C250F9524FAC0C0C0C848E26F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f86ef-a065-4fc9-6167-08de9bfff946
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 21:34:43.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRzuHvaLl5Vj/XOvME9f82UWZtee41FMMq06NYOz/sXOoExCUiRym8eTVbgTfTJlRxTc8mm/Si1bAi+VJ8gtUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_143452_295435_9D015943 
X-CRM114-Status: GOOD (  14.49  )
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

T24gNC8xNS8yNiAxODowNywg7KCE66+87IudIHdyb3RlOg0KPiAgRnJvbSBjZmQzODZjMmQ3Njk1
NTJjNGRkMzJlYzhmZjUyMzNlZjM0Zjk4MzBkIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPiBG
cm9tOiBNaW5zaWsgSmVvbjxobWkuamVvbkBzYW1zdW5nLmNvbT4NCj4gRGF0ZTogVGh1LCAxNiBB
cHIgMjAyNiAxMDo0MzowMCArMDkwMA0KPiBTdWJqZWN0OiBbUEFUQ0ggdjZdIG52bWU6IFNraXAg
dHJhY2UgY29tcGxldGVfcnEgb24gaG9zdCBwYXRoIGVycm9yDQo+DQo+IHdlIHdlcmUgY2hlY2tp
bmcgaG9zdF9wYXRoaW5nX2Vycm9yIGJlZm9yZSBjYWxsaW5nIG52bWVfc2V0dXBfY21kKCkuDQo+
IFRoaXMgaXMgY2F1c2VkIHRoZSBjb21tYW5kIHNldHVwIHRvIGJlIHNraXBwZWQgZW50aXJlbHkg
d2hlbiBhIHBhdGhpbmcNCj4gZXJyb3Igb2NjdXJyZWQsIG1ha2luZyBpdCBpbXBvc3NpYmxlIHRv
IHRyYWNlIHRoZSBudm1lIGNvbW1hbmQgdmlhDQo+IHRyYWNlX2NtZCBudm1lX2NvbXBsZXRlX3Jx
KCkuDQo+DQo+IEFzIGEgcmVzdWx0LCB3aGVuIG52bWVfY29tcGxldGVfcnEoKSBsb2dnZWQgYSBj
b21wbGV0aW9uIHdpdGggY21kaWQ9MCwNCj4gaXQgd2FzIGltcG9zc2libGUgdG8gY29ycmVsYXRl
IHRoZSBjb21wbGV0aW9uIHdpdGggdGhlIG52bWUgY29tbWFuZA0KPiByZXF1ZXN0Lg0KPg0KPiBU
aGlzIHBhdGNoIFNraXAgdHJhY2VfbnZtZV9jb21wbGV0ZV9ycSgpIG9uIE5WTWUgaG9zdCBwYXRo
IGVycm9yLg0KPg0KPiBDby1hdXRob3JlZC1ieTogQmVvbXNvbyBLaW08YmVvbXNvb28ua2ltQHNh
bXN1bmcuY29tPg0KPiBDby1hdXRob3JlZC1ieTogRXVuc29vIExlZTxldW5zMjEyLmxlZUBzYW1z
dW5nLmNvbT4NCj4gQ28tYXV0aG9yZWQtYnk6IFN0ZXZlbiBTZXVuZ2NoZW9sIExlZTxzYzEwOC5s
ZWVAc2Ftc3VuZy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1pbnNpayBKZW9uPGhtaS5qZW9uQHNh
bXN1bmcuY29tPg0KPiAtLS0NCg0KSXMgaXQgcG9zc2libGUgdG8gc2VuZCB0aGlzIHBhdGNoIHVz
aW5nIGdpdCBzZW5kLWVtYWlsID8NCkFsc28sIGRvIHlvdSBzZWUgYW55IHBlcmZvcm1hbmNlIGRp
ZmZlcmVuY2UgYWZ0ZXIgdGhpcyBjaGFuZ2UgPw0KSSBkb24ndCBleHBlY3QgYW55IGJ1dCBpdCdz
IGJldHRlciB0byBkb2N1bWVudCBpZiBhbnkgc2luY2UNCnRoaXMgaXMgaW4gdGhlIGZhc3QgcGF0
aC4NCg0KLWNrDQoNCg0K

