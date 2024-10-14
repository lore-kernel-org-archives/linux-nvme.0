Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3125AD1813B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6vwQ0RN6vkMTM7LTKBHWt55D8vTE5yq+QiXXAlxEQX0=; b=eH3BnikWQDH/k+tjBpqSzsTgyA
	agX1AWfGi0SyF0EuQ3Umy/zwlDEEaanYRDzN3nCWClEbwQmarMsDaMSHhMuv1eh+W5f0KKeJLYxax
	q6IifE5M88p1kP8K4vsMFrzy1fIGPqyyL6nNpqVOz6GtjiP/ZfU7BSjE5y8GY6WUT+iw8i29u8i5j
	Dplo/yYR65aVmyoQJRj/83m2NLKQ5r0JK5630o6d551QJhP87s/12CPfJVuFs1mq2ckcNf53TacX7
	+y0EUjRY/lrsLdg4gjbewnWbmRdeHu7j3gEtqT4+I/5yEfC0WrXi5U8GHuOpd02Y7960Rog5ukuUP
	eKVR9u9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Pog-00000006Ap4-0lAc;
	Mon, 14 Oct 2024 18:29:14 +0000
Received: from mail-dm6nam12on2060c.outbound.protection.outlook.com ([2a01:111:f403:2417::60c] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0PnP-00000006Aiy-47az
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 18:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPwW8CP4gbgGHhm1JvCKUJMJdOxMWxxDWg6vDCwa96OAjZnJL/mEnnNdLE4/A0bs7hBAoFk6qVwiBJCcI3TyqOmimgdmhO/t4jl0jgqA1BBOdVVU0jUtI7b+fM+4/DWB6397MDgZI3Gx7NGaksfG6JQgaLb53q/xW/7LfK7raGCcr2ozovIW0nlC10AbDAv8FlqxdtKZ8tEEDMJj9Am5bCCQ9EesajwE8Mp9QnnenXbG5sLyXnHDv7OzxwL6HMCZkvQpHErW+4yZY9R51o0dWjQ83FNWFYZsD1+JBbUV6HAUFCAn3Reckaz9BoUjUmNYfqWNbFFw2lETzbpfXGp6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwQ0RN6vkMTM7LTKBHWt55D8vTE5yq+QiXXAlxEQX0=;
 b=cHS99H3KlzJFw2z3krPHt1CBMnJprCGE9N88Fzed3AqvZweTHOWyl+ytKXvVQ41p8arkjpbuZ0GndMZXtg1MpXIpnBOdkm6bj/dqi/WLvXK5z25s0CciuWzDkiVzvTflXqBCgBw+072Qfya2MlVJZgjaxv0wm218iNvQrQ4dywxCB5D6NQFRcWV0PvJaEIb8K7iJLAnh327HPM4N1h5vNL+KxXQg7PiligyI/XLnnx089CnkOfMoOIRKDjyEKvf9WSAkVOGw/bw+lebECh0W8nLiL710VKIsijI4xnztAuXPkPUENd7jey9zC0f9dOeqQgkgaN16cZ4Ok3OSWqI7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vwQ0RN6vkMTM7LTKBHWt55D8vTE5yq+QiXXAlxEQX0=;
 b=J/ynBIUr+efqwVjvXvWjIm5BaHhhNAzUH3hqmKjS+XGCj7c8oRgqBWfKTJXx10NvnG402hOwN0ckovrFxRrgjjkP8MLudD2JHqrJQJk3y9/HIroA19BGHXAVz3o3nFdlzBEsNJY9hhiV96pL7Hurnw/k90dYsB7epty8jaqR5njuQ+6QzuHlDvJahpfyi7OgwziE7rOshsIiBmxeDpL1ebqDH8/y3HtzyRj6p6zu6it8bMxz9hhf6oUqcWce7D7K+nqP8MugHsaQUH+xYRcrWYzzyzU4XSv7lEe8yrFNvDcw32w2hibnumtXGJzJOXWXoUQcMGYBt6tbCyeqb9DNJQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 18:27:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 18:27:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] nvmet: add tracing of reservation commands
Thread-Topic: [PATCH 2/2] nvmet: add tracing of reservation commands
Thread-Index: AQHbHiH56f5CEPrEW0yV/iJYlHskWrKGkT2A
Date: Mon, 14 Oct 2024 18:27:41 +0000
Message-ID: <bf3a8202-180e-4079-9bac-48e37c0c0edc@nvidia.com>
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
 <20241014101458.80491-3-kanie@linux.alibaba.com>
In-Reply-To: <20241014101458.80491-3-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB6878:EE_
x-ms-office365-filtering-correlation-id: df8961c3-31f0-4c0f-2760-08dcec7de3c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmlCNUllUVBZaUtXS2pZNTdsWnAyREZoL0ljZ3V5UkNmTjVOb1FHU3RiNjZH?=
 =?utf-8?B?czZtclIvM1cwbzR4TmRnU3d6Y2htRDhqc1ZZdTFaTTI4UWU2c0drY2dJT2gv?=
 =?utf-8?B?N2Z1WUgzYnFDY0ViVmFFcmdVSXBWMFFOUWZMdS91NGI5TkdSeWhhWTJBVW1B?=
 =?utf-8?B?cERoUHd2YlNTYXRiRGx1czZiVXNNclZGdUtiYlZ5S3hnNjMzaWRCUG5pV1Jj?=
 =?utf-8?B?bUpkZGZYQi9ocXVJRmVxRHNRWkxCZ3JoQkR0TlVSTVBYVVUzZkFLcmphdFds?=
 =?utf-8?B?NXZFUnRzMzh1aFpMby9jbTdXUFllVzgxYlJuWU50Mk12NXlXWVk0TFF4Y25t?=
 =?utf-8?B?bjJvVmMzdzE2Q3JwMWNUM1B3WWx2eTRpWlkzLzVXR2ZnZUVGTmtoYW0wQlNF?=
 =?utf-8?B?Y3k2b21oVWdoc2sxbmF0UTBxNHNTUU9UaWZyMmZ0bE9lMTMxeldsVjlhcm5X?=
 =?utf-8?B?QnNWS2ZrK1V0L1Yrd21Qa2xMUWpzQXdQaWZtUVBUNG0xc3VQbzRzUGRiNmpw?=
 =?utf-8?B?aEJKa1JKMEk1UVllWG05Z2tRVUhWSUNKR2VvWmxRUHVROUtGck5tT3ZuaXVm?=
 =?utf-8?B?MGNuSTQ3eW54MnRVYXBScVdncklBcnpCWkhuV3E3NDhDRWltSElGNjZEZFdM?=
 =?utf-8?B?VTgyNTZEZ1VKUks2ZXM2Ym9PaXdmcFdHVWRBaHFjMEZCVTJjMVBudWxiQ01K?=
 =?utf-8?B?Z21DUWFub3M4Q3pRWEI2ZHExeTFFVk4rd053RGk0UlpJKzUzWXVaaXFrbTdI?=
 =?utf-8?B?QlgyRnhiSjlMQTFNRVdGTHROb1QvbDdheWNQUHZadnFOVHdzbEpKMit3SnVm?=
 =?utf-8?B?ampmK3J4YVN6cVV0WS8zM0paZVVvRHE4ZmpUWXhOOWJ1dFE5S3IxeTVZRHdQ?=
 =?utf-8?B?dGE3Njl2a2w2L25CazhTWDBsa2RJOFJUcWJYV25JK200RVIzSW1ZYVFoNWRP?=
 =?utf-8?B?dGt0aHVxL2gxcWFUQlRZZ01DTUpHdHpCSVpjcTRvc1JrN2ZLcFB5cmwxYnZm?=
 =?utf-8?B?VnM4c2UrSVprSEpSQ0d6V25ZanAwdHQybnRvb3RoQldvWGtqV0Jla2hWV243?=
 =?utf-8?B?ZE1VampqK0o4SThrRTlaeTViUkx6MzNoMTc4dE13V1lVa3RGZ3NBTHE3STBJ?=
 =?utf-8?B?a1M1ZVhWZkl5Wm8yVXVQMFlwd0wyWXZMd0kxL3JTNDY4ZWNIUWphR3FvR0Ir?=
 =?utf-8?B?b2pBazV2TEtYODlTcGRmUWsvNEFkTlRWSXZmeGYxVDF2VzB2UDZOL1U5MkU5?=
 =?utf-8?B?VUp1MWtSSnlLK2lPeG4wV09xQ0ZVQ1pzKzNrb1ZNK2pPYmdtTDErYVdGamlK?=
 =?utf-8?B?YUFFZFpRYVZqNXNDRjFRV2ZBZmd1bmZ2MW9CZWlQWEJkTDVWbW9TZXZ0eU0y?=
 =?utf-8?B?ZnlWa2o3eEFBaTlRYXNBVTRQUGU0enRhT0dBc3FGRGp5Mytxc05Jakt1bStM?=
 =?utf-8?B?ZW5yd2V6OHdWRFRtUXArenlubFMydm05azNvZ0JjVHB4alBzRTV1WUlYbFk5?=
 =?utf-8?B?d3EzUStlNGF6aWtOQ3V4NDJmYVhyalNZYlBBZW9RYmhwSmlrZGlWVXhkWDE5?=
 =?utf-8?B?YlBaSUNneXdNNk51bmtRRWE1TTNOMEtFYWxWNUE1R0IvaDlSa0JKK0VmTk8y?=
 =?utf-8?B?NU1BTXpJZVVwa1N0WVlBZEs4NnJYQktnSlo3OXlGeFE4NUxjOXZ2cTM2REpS?=
 =?utf-8?B?c1hnMGFwMFBPN1RsNEp4MUFidWFhM2NEb0J0czd6RU8rY1RjNFdPb1J6K096?=
 =?utf-8?B?eG9BNjRKWWhtR3ArTmhFMVJyNW81SnZJSVJHajVqZW95OEJMQ2s0dC8rcEdT?=
 =?utf-8?B?bUZ2dzNYUXY3TDEwamxXdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFkzQ29uMElJSUZZYVM3TTVyU2lRNTlHYUQwSU9BdmJneGkvTUxQWDkrLzZM?=
 =?utf-8?B?R2R0OUtjcEwzZWtUS0wrSHRuOCtGdHh3R011MmhkdjVzWnljVHpnZzJtU1ht?=
 =?utf-8?B?YTQyaWttaVBvdTk3YnpZcEo2UzVpMEl2dyt2UDZWd2xMWWZmN3daOEZ3ejVG?=
 =?utf-8?B?MFljM1dEc0hpbzI5NEJxcTI5RlI0dXBaQUh4enplQW11Z3lwTmhzNTU3UlVk?=
 =?utf-8?B?MFMrTXh3T0tZMEtZeUZFKysvVmdtb1BMRExlZ25qcE1JMytWU0FNc1piRTZQ?=
 =?utf-8?B?VkY4MUd0YlBSOXJTTHhSZzRhZ1N1cGtHQjZKWi9Wem1qbGx5QjJIN0xQSkJv?=
 =?utf-8?B?MDd1SkI2MCtJVzkxc2w3ZjI1WnV4MFlLc1JURFRMNkhOdERmaXYvcFQvWlJ3?=
 =?utf-8?B?bEU5bG9tSzZHandMYWRVazY0NUY2TEk3TnYvS2NkclFzUnU2VUNzSllQd3JD?=
 =?utf-8?B?RE5MRVE1OUttUjQrN0dEbTNydE12YzYzZFY1cjFXYWR0bVpra3laZDlqVjFp?=
 =?utf-8?B?Q0xrWVVKalFHYnRsT0RVaHJDclpsclBsYmVDUUFQZFFnSW1nN1poSWk1L3Uz?=
 =?utf-8?B?U0JiS2dRQXdLTzh5Yzd6SXluQnRTMU9RZlRiUWt5TDBwazAvaGxPY0c5anNB?=
 =?utf-8?B?QWRNMGFxNHltMUcvUWQ1Z0o5V3k0ZGx4ZnZEL05WRVpFcUpVaGppSlY3NHFx?=
 =?utf-8?B?RUNGZFhtcVQ0Vk1ucExwa2I4MmZBRnRIb29hQWh4eHFwdmR6b2dQdVVyaytC?=
 =?utf-8?B?UHRvelV4R3BXZmU3bVdKZXBBS29jN0pXRm9mQ0hxUy8rQk03OTBOVVR3cmky?=
 =?utf-8?B?a0NiSUs2MmwvSHp0YWRGZkVBaFQ0MzVlNDhZL05KU0dHZjZ3dWp4bHBDWHh3?=
 =?utf-8?B?aDFrNjN5ckFFT0ZhdmE0QmwwQWl4Wnk3aktuTXI4ekh4ZExOSnNkNHdPeVNy?=
 =?utf-8?B?d3VOZ1FhMElKTldkSkZsN1pKZDQyMVhOOE12Si9CZ2owRzMycys4WTZHSlJQ?=
 =?utf-8?B?SUFudGl3OUFEWGhDUHczcGlGNm5SVy9IazI4ZmhSY0lNWjFXbU9YcmRXTnlM?=
 =?utf-8?B?YmVqZXBORWlUYklBKzFuc3FXcGNWNkxYNnRYWDRYM1Rad3NFREFJY1luNVZO?=
 =?utf-8?B?TG1uVHZsdU9YUEs3MnpqbW1SSnAzY2Zqc2xvYWxBUkdMUTllU2xTV1ViTWdt?=
 =?utf-8?B?NFdXanJ0ZDF1akVIV09QSEFIME5PYjBTS0FQeHNwcDloVm1rTmRranBoNzYy?=
 =?utf-8?B?OU1BL0h0TnNDaGxsaDEvZzM4Nm9qZlZUQTB4THAvendTNjVlZlRhRnNsV1VN?=
 =?utf-8?B?ZVZJM3N5QWtjYkwwSDRSOVFpbVZxTjlEYTlkVEhaTmg1VnYzVkwvUlRXUWxU?=
 =?utf-8?B?TytCOTFFT3lqZG9leENJYkRsc1BVbFZDeFpDSXlpV2IrZ2o4MmdhbzFNZDN6?=
 =?utf-8?B?czJYMWlaS3JFTEZmNStLaUFIa1JaY2MxNW1EdTNWektRMGZWNzY0ek5Kbldq?=
 =?utf-8?B?KzNxbHVncTdRQUlhQy9zOXJzMWJET3ZmU0RPQm5YYU55c2VteUI3dk54T1B3?=
 =?utf-8?B?S0tBUHg3VjJOd0dkMVQ0dlhwNGFUdUVMRnJJbjJSSUlrZFpQWHRRSXJqNDl2?=
 =?utf-8?B?NXRUU2JMeXFTWlQ5SjdKampxM2VweC8zRjdRR3hVWVptOVcxWCt3NkxiYWh0?=
 =?utf-8?B?bFZKY3l3U243Ty9EQk9LaUM4b3FpVXh3RmFtd3VwRG9NaXZRb0Z2ZEdEUU1a?=
 =?utf-8?B?U0J0M2FEcnJZN0dLL3oreGkyTXJZaEdLUDd1bzQ0RUx1UDhjMnVOZndnTFRl?=
 =?utf-8?B?ZUVFajdjKys0Z2lmU0xvZUx0b1QrWGRMcWpsazJQdFRtZ0ZjMVdYL0NqNDhu?=
 =?utf-8?B?NlduSklJc0tPOXlFQjVMQk1oeEFGRW0yZCtmWlZMQU04clJENFJMTTlEdFhx?=
 =?utf-8?B?aHRqN01mb2c4cEFaMlh5OUFKbE1GZ2tDTUZubXc5aEppNndIa09YczRYN294?=
 =?utf-8?B?cDQ4cFZTMUZueXJvRFZ1UDZEVUI1ODlhK0xZblJYcmkyQi84dnhxTXh3UTNk?=
 =?utf-8?B?ZzVnZ3h4clBvdGdzalRlcSs4emtzaXR6dE16SFRRalI0QWl4dS81VjJJK0Ev?=
 =?utf-8?B?WkV1SUxWS1VOYTBhNmJ4SkEwMTZuWUZ3SEV5QWNBZ01lZWV2Z09yYUs5dU01?=
 =?utf-8?Q?fd+zrEmGo5UsSW4uxS9Hdvkx8nduNjb83LGS8vSOR2BO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A580F99419BFD4AA63C035F34807157@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8961c3-31f0-4c0f-2760-08dcec7de3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 18:27:41.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFia2fohuoibcQ8XwuogYDEhuC7QLw4yTR76HpuN7HaLMMbelgsaeMeYb0d0JI0skHU3q9po5NMCy5wDDC8xZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_112756_105692_24B774F3 
X-CRM114-Status: UNSURE (   7.67  )
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

T24gMTAvMTQvMjQgMDM6MTQsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IEFkZCB0cmFjaW5nIG9mIHJl
c2VydmF0aW9uIGNvbW1hbmRzLCBpbmNsdWRpbmcgcmVnaXN0ZXIsIGFjcXVpcmUsDQo+IHJlbGVh
c2UgYW5kIHJlcG9ydCwgYW5kIGFsc28gcGFyc2UgdGhlIGFjdGlvbiBhbmQgcnR5cGUgdG8gc3Ry
aW5nDQo+IHRvIG1ha2UgdGhlIHRyYWNlIGxvZyBtb3JlIGh1bWFuLXJlYWRhYmxlLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBHdWl4aW4gTGl1PGthbmllQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

