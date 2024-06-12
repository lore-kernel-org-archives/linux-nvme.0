Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B5FC27C77
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yu/filk1qN6DibW1OVv+gtvy2sw1b/p2R9gmtBo/bI0=; b=nP7Jm57pzjR9rwSIojbrGeQUoN
	PdvDOYgcu0Y90yybrRLiMeHAmaQJDjo/DH8UJ3AACpC5l3YCdzeL9UMTkElKP3b10G607zY2LXB18
	DwSGHXoQ1QcUuxMGqUqctRO/TTiXI8sFikWSeuyn0CY8Hpbe1iqlg6fEexMvzyLGR9s4YhEBG+Oya
	opMyvsw9XcYIs8XQV6cJrJJ3dqMhEULaPV3+NR8jADVPYRAc9wsHCyz/2fKmMk1cJc67MgQGXn8EX
	laQyQWY52Go1UYAVtwBKdQf8wv9DLm4zCqaAmlti1Bk9L+hqJKWlOa7GhmFmS8vDCaRkQjJYhg1rw
	cBfu5F+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHPQg-0000000D2wu-01F0;
	Wed, 12 Jun 2024 14:58:26 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHPQd-0000000D2uk-1JRe
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 14:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfCDjIK2II/DtqeWC92n64yv68D9vpieCnpg/Khtzh5YmhNACRAVxsMdnVHSHhY1XQuM3Q9/3L8D4t3QTKYnDy0InZ+2Lt9pOvsHAxb0lNuTOj8RR8IhvRBIbfTi2KMZe4lTN5+YSK0cVaJfrWcf7w0cDC3qj/fnWQTEqUB+9WbcC9uwxr29L1ki7JRbX4Xq0AxAoOxQWS77LhvCQzcKWKh5wnu2t6JUzharcHIczrBWp7n4eSfx9z0EmHCn3tYoZUQXX8TJ/folkpaOOeIATkKwff3bsKPvD0r8K9RpuxSnDNfKGuMf59T8q4Gao3c3W5FeutvjXYIXnKlxZBzwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yu/filk1qN6DibW1OVv+gtvy2sw1b/p2R9gmtBo/bI0=;
 b=mP7twl68FpHyhwenP4NiLL4R+0b0GhQTvWQuaJGJntU5B5jxAvl7lCsHzAf5kMwkO09zi+PFyoEOmxyu165mtnaGdbcj7ueEsZdb+Txtrr7L9J6aAL0+QkMu8yUlb00iMryS9Nk2Pej/DBeLiPRnbssYvyiVIxTZuL9dJAguUjdskhdFdNhdoHc3JfdDoFppLGekxA9F4jBRrTJk8lotKIohZ1IWcjTUZYrg0co97Y5uox2xXIDAwRHcbk63l3HDyPWaaoTWWbU7VHZj/+03Zu1Q+/vbGPPU8GmFTjhAE9ZiAzM0kbc4vXXr9gATUYS0veHDtuKQWSJeper/xZi6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu/filk1qN6DibW1OVv+gtvy2sw1b/p2R9gmtBo/bI0=;
 b=cc5/pyDWyutl3WLkICRzYjJ64q55Vl3wvaPRdkxEQFJqOK0SQIVuRkfR4esqD6uXbNAok56Jgu9aqoAGTMGDH6ailWjWMv097z8iko6TrbApWbEm7cVtq7S6qBS4ZBVTyNrztR8JM0dbaShCh3Q2oWhGZI0F/vv1bLKzUc2F80CE2/ByUsfiPNR4j3CiR3yLtGOMnsNrt7FjSqSQihXD96iZqFOsQQcTaPL6nwDz6dPTN+9RomxY9kt/KkKPPBU3JOvE7Dmbeh/p8azoPC0m4xEIAlo6FEd7PC0PYhKYG5mEstfDjOeq94Gu44xgYczg+RcP+bBq0b8hAyR9iU81MQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 14:58:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 14:58:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet-passthru: propagate status from id override
 functions
Thread-Topic: [PATCH] nvmet-passthru: propagate status from id override
 functions
Thread-Index: AQHavNKQtY6Z23tOBk2TnEX0d80yYbHEOEKA
Date: Wed, 12 Jun 2024 14:58:15 +0000
Message-ID: <8c328a67-cef5-4c89-a9ba-22bba97a352b@nvidia.com>
References: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
In-Reply-To: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB7764:EE_
x-ms-office365-filtering-correlation-id: c8d026f8-7635-4845-8473-08dc8af016de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|1800799016|366008|376006|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?Q0JQM2p2cHN5NjNiR1BaUmtnTUFhZ2JjQWJXYWxkdlBqWjhCc0YrQjRsZ3N6?=
 =?utf-8?B?TDErWW1DOU9DWlRQcEtrUExIWUFBR3o2MjRwOTNlUzNISXA3akZab09qUjRx?=
 =?utf-8?B?VTZWNElCQzdXdmg5RkRmTFJRNTdGOGh5ZmtBTUhSc3BaUThsZm9nRFdYV3RC?=
 =?utf-8?B?cnBWNHkrL3VTNnUybHJJV3JqOUdpcnRSREhCaHZXNGhJRVJFWG9wRU1jc1RO?=
 =?utf-8?B?YmErdVh2anpUZENwNTJFSEVrOWo0NUh1VllhNEtyWUNJNVRYMXFnS3R0RzdQ?=
 =?utf-8?B?TktSZ3M2ZEpxY2JkZDNoTk5KMWJZN1ZFRmJVbHRMM1Ntckt4TUFLRU1rcXBU?=
 =?utf-8?B?OWNIbFZ2TXkxRVVRV2NkQVlldE0vc3lMQ2IzN255OUdIaFIzeEprc21sREFo?=
 =?utf-8?B?TVlDOVBxUUdmRDBwZW84NkJKV1Q1UVdObXE1NWx6UnhxNlphTnRvckxPMTdm?=
 =?utf-8?B?R1ZwWFZHMEN5Yy84N1E4VVorWXo0WHZlOVE3L0JVc09XZnJWUEFNOVFaMEJw?=
 =?utf-8?B?USs1VlBIRUFuWXNqc0ZGdDg4WSt6Z2RYMkNhT2o5bjFBcHgybDk3QXVGOGgy?=
 =?utf-8?B?ZHJBakN5UldCS3dnVmFHUE5yR0xpTERoWXVINVdZaWlWMTdkR1ZyWWxHa1Vs?=
 =?utf-8?B?OFRjUFJTQm4yZmFnV21YWGxXaDAycnN0clkzVDExTSt0TFBRRUtLbTNBd3p4?=
 =?utf-8?B?ZWtySFVPVmx3OHNLOTR4dFk2UVRIWTlsOUQwNFU3Qzd2WWVlU01MK21MS2JU?=
 =?utf-8?B?dE1YUEorTk9XZUtHNTdsRmIwVnd0YXRLL0xrSThPSDIxWkcxQXhiYVE1UWlU?=
 =?utf-8?B?YlFkQXlzYzYzd3pyZWxOVDI2bzZGZ1cvcG8wcHRZVWFpSGl3cC9CeHBLZGhn?=
 =?utf-8?B?ZUZWRjlicVNCRzBmQURkZlNjVERSYVNqV2RHZmNveFhLUU5OcmdFSVA3NjhK?=
 =?utf-8?B?WE5kRFV4OUR0b3Rmb3R6WnhMaitYOUJTZHdiZi9WakZUYUNFcWM4SzZFck5P?=
 =?utf-8?B?bkdNMGtEWTVWTUFld3pRTFF2Z0p6N21zaG13VUVteTFvUjA0UUVsRjFMR2lN?=
 =?utf-8?B?WnVJL1BrOExoeGlIWXc3QUtKK0tzeC9rRmZkdmt1K3c5NDlFbWtkdzJvcXg5?=
 =?utf-8?B?QUpIb0NqWjJMaHZsR3prZVZQWWE3UFk3cWNvWWZSZGVIb0tRRHJMSGlqdXI0?=
 =?utf-8?B?R3JhWjAwek9FZDl4MSs5cjRuRzg0M3dES1lLVGFOOVVZR0N4WEw5eXRCczVy?=
 =?utf-8?B?cjc0bThCN2ZpMmxYa0YybHJVcmRqbGVzQnRYZnNlN3pjRHREZlNOalNydEpW?=
 =?utf-8?B?eUJLVlNrTTIyY3BUMGgxWTdmSUliNml3QWNxNCt5ZlBhK1RPdjYvSnNRczVS?=
 =?utf-8?B?dThKbEtnL040SjdSYjhuNEpld3pOY2pmQXEvMFFHclNOU3lTaENLbHhhK25D?=
 =?utf-8?B?VWZ6c1RzSHFRb0krR2MvVm1NU2JmTzJQR0lTdy9mZUk0MkZtMkZnb29mbG9p?=
 =?utf-8?B?OEY2ZkVZM2huVzhhd2JTQ21qbElzT04rWXNzMEowZm11emZEN0F2Zks4Ui85?=
 =?utf-8?B?bHd2b0ZITzRjK2VFOCt2WUJyKzFVeTBpbisyRlJ0VkdUck9veVRtTDRHUzdh?=
 =?utf-8?B?NVV5Z1g2TUNOOFl0QWlHUzJnV3NSdmdJQk5lV2RxOXUyMzVtM3YwUEY0a1A0?=
 =?utf-8?B?eWoyV2wzWkpiYzJzbjVUZ2E3TGw4c0N2cDZZa1Y3TTR6Q25lTVN0ckdPNWxk?=
 =?utf-8?B?NUdiTDR0NGkyclpWTGpmRlBsa0kzM3BKNFNkL3FVK1NBOFV2K0FsNkhDelRj?=
 =?utf-8?Q?O2qc9XcWObzH2QeZWy6RO8ELyarly2+/JTqpA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OURyU05nc2NIVnU4RzdhQnloUDVJbThiTXY5ZnI5akxJKzFlTVlSM3pQRXNz?=
 =?utf-8?B?bklxdDh5NEExVG9oLytQNEhLNHphd01HaWZqanZvQ3BOUkF0RUZZaitFMlEw?=
 =?utf-8?B?ekdQMXJ3NEQ0UlFLS3BKRmNGN3BLa0pISkZWY3JHMWFmVk94azdVSXhSNExO?=
 =?utf-8?B?dDhYc3lnYTNYYXRnOElSak96N1BmMnJuQ3ZVbFJxaDlWMjM2NXZtTTREdW5j?=
 =?utf-8?B?R291WHBVU3Jvd2ptcFBLN3FVQUF3cm55RVdiNnBISTJ5SW5jaU5zYnR0Z2Nl?=
 =?utf-8?B?cTZRakxqLzJoSUo4cUxxa2YvZjMwWnBITUkrUTllSXpjNmxzZWNlaGpOdTZm?=
 =?utf-8?B?VFhSYmovKy9aMStSV2gvb1FMbUIyNWQvaTRmZDNDa2puQnRVZDBIRStPRW1v?=
 =?utf-8?B?Y0hPaHFsa0JuWjR6RUQycmpKRlMxYUovdWl2WWcydXRNM29xZThGM1V3UFEw?=
 =?utf-8?B?SFlWZGFNNTR6UzRseEhCT1FJMjVPZ0JtRmUwSkRpVSs4aTdoQjVoWG5NL0lw?=
 =?utf-8?B?eDZoMGYyQXgrOWJ2TnU3a0VlOE8zNnFmZHk0R0Z6Vm54UDZDQ01wQUlFWkNu?=
 =?utf-8?B?enM4OFdaeXBiWU56cjg2enpYTVp2YjlDSjZpckt6VEZsaHNkMVNHaWh4RVZr?=
 =?utf-8?B?UGpyam4wZHVya3VqTDdjamVPYkE0bktwQTNuUkt0djRYTlBkT21EY1dNa1kz?=
 =?utf-8?B?bjl2L3MyTzdzR2FIanlEaWV4NC9TUnhPZzhRRi9Gb29pN25QYTlpTWtnUnF3?=
 =?utf-8?B?aG0xZ1c0Nk84T21OTUxIYTlVQS9KeGorUmtWYlhzaU1wUnl1cUU3NnBGNUMz?=
 =?utf-8?B?dzF1Z2VXYVRycVlzSU54NnhCek56NXJKMys1S0NSY1pUdDBpWHZYeFdrNUVk?=
 =?utf-8?B?UVBTQ1U1anJvS0FISDZjQnBsYjdaakg3V1lLaUtpbTJYQkxTR3gzb1IwTytE?=
 =?utf-8?B?QWl2S2ppVEUzNFpWSzBqanZiS21KT1NGdEFUa1lYdFhuMUUxSFlncXJLRGda?=
 =?utf-8?B?WWN4ejh1QXFzSWpDVzdjOGpjNjVmVU5vZVR6QlVINURjSGFDdDM1T1JtUW5l?=
 =?utf-8?B?WjZ6aVRIMStVb2VNN3Fsb3dCeWR3MjNORmFYRUFGTGNudkNzb2NNdTE5ckFw?=
 =?utf-8?B?NGRHMjVEOEIvcW5leDBUbkJ4VVRHQ1ZLMkk5M0hKRVhXalgrT01sUHI1VjVj?=
 =?utf-8?B?S3U5SCtUODdIR3c3ZnY5MTVOQUY4bFpBbU10WUF0bWxZOFpyYk1lTUtvMTN6?=
 =?utf-8?B?T0t2MTFFUmo2N0txWnIwdWU4T01XSnhUQ1dVVTcvTzkzdmtOUnFUTkkxZENj?=
 =?utf-8?B?Mkh2U0I3RGxqMHA3WDJnR01GZWJJSi9lYTNWdTJiS211aUtuc0ZvakRBUHZN?=
 =?utf-8?B?Mk1mY3RzOXpKZUdnRm1SdkV3bWxDVWkzOGRKT25XbldBUVRlLzZQK2xqdDR4?=
 =?utf-8?B?YnNoOG1mRnRFbWI2TTNzRFBzN1ZNOXBqQVo2V2lhKzNHMFhKVjJReDN2S1Vv?=
 =?utf-8?B?QjM5Qm1FalNMUEJYOVNZNkVCdkRoWDFSbS9ra3ZndHp5TEZpMU16c29zbXpJ?=
 =?utf-8?B?aE5ESFJqZExSa0RUdzgyTTBiR29WaVE5RVdmQy9WT1IzOVNhdjE5VytwMzg0?=
 =?utf-8?B?M0c0Y3h6UWEreEdyc0p3SFhvRkRjN1pVdiszSFhTT0tTQVRCZS85Y3J0ZDJu?=
 =?utf-8?B?VlNqZ1NSeEY5SVlSaSt0aFhLMGRVRnNnNjZaanVZdVlSWkg2SGpPY0dHQWZ4?=
 =?utf-8?B?eUJIdzJBUXZiMm1MdkJsZG93b0UrTGZ0V0prS2o4K3M4ZDdtbkovQ2QwaHEy?=
 =?utf-8?B?UEl3SWNuSmtoY05pblFFR0tJYVBzWStYaWUrTm5weGxzZ0VWRS9jV0NYV0l5?=
 =?utf-8?B?TnhLSkhNZlI4Z1QrK0xUaXZ0REdPQkQzaDE5bng5OThzdG9CZysxeXk1UUFV?=
 =?utf-8?B?clkyNkFReGJBK0duS3VOc2NxYkRDaHk4ZFk4VmMxb0p2V3hJUEk5UklZb2J6?=
 =?utf-8?B?WGNBUzRnbUJUMHkySjdZQlNKK3lJeDZyYUhqMW45TmdXK01BK05qdXBtV05S?=
 =?utf-8?B?cWF4ZmNLeGFaME1DZTAzOFN0QWgxeENwT0lEZFR1dzBMQ0ZZMGpvdXFzeTht?=
 =?utf-8?B?aC81V0dta2hlVkx1Y3pCVmxMZ3gxZmlBak1mMzRPV3VmUzZwd0tuQmdoaisy?=
 =?utf-8?Q?YIKqAw7q+D0q9HWyteowntQO5aL7rMmwe4C/cw6ZDDEy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A93D45179ED43E448D67EE2801816847@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d026f8-7635-4845-8473-08dc8af016de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 14:58:15.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKWEK2GluVJQAasI0O4ah4NUJptSq1KvZeHGdexH5pOsoCjQQIxTEI1Dr1t8jSUtDTMnOkyR4Tb76tDtj1EltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_075823_469039_64C63081 
X-CRM114-Status: UNSURE (   9.05  )
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

T24gNi8xMi8yNCAwNzowMiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gVGhlIGlkIG92ZXJyaWRl
IGZ1bmN0aW9ucyByZXR1cm4gYSBzdGF0dXMgd2hpY2ggaXMgbm90IHByb3BhZ2F0ZWQgdG8gdGhl
DQo+IGNhbGxlci4NCj4NCj4gRml4ZXM6IGMxZmVmNzNmNzkzYiAoIm52bWV0OiBhZGQgcGFzc3Ro
cnUgY29kZSB0byBwcm9jZXNzIGNvbW1hbmRzIikNCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdh
Z25lcjxkd2FnbmVyQHN1c2UuZGU+DQoNCnRoYW5rcyBmb3IgdGhlIGZpeCwgbG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==

