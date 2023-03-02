Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAE2C6FA8E
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vg8z3RiGFQlQ7kzghQOrexW2g3KzzbydSjHtv2lqC9s=; b=K837Kj1aOMsareOPwhxTypuZRm
	ixanr0Z5SFcTFCmGMX47/J49KMQrRDmV3WbLdCM5tiZwS1hM0keP0TY/ipDoTqA65bi+25Vybncr4
	9x8KSp1ORDt4feGckp3AdOc6th9vXIo2wjGcpgH09n8KwwIBg1XC7DYPX8Uf4zC/YPI4i1L8QQq2m
	peenTzKhDKixCS/+2mQGgrOaYNSRs+3ZovIJ1KlBwy+QZig9V+QAbg5f/6m+1jH4bzNEBvYycUtag
	77z+QVeMGzvcDCksx3lXIEZiy045zWs/J/Hg6QWtoH4HGjIbL2RIVQvhlxyKfPBniT9w/+PzO7uEZ
	pQdT+TVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXnu5-0035UG-U6; Thu, 02 Mar 2023 18:43:45 +0000
Received: from mail-dm6nam12on2061d.outbound.protection.outlook.com ([2a01:111:f400:fe59::61d] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXnu0-0035Tg-0S
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 18:43:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZGDEQMWY1KepbC01oUXgoB6S8u6neqr6y2swy6OhHIR+WQU99/sv+aQcAhe/o8v7d9E48ZhvGwE8XLT6TyAOcEwe4zNgU7MTQKkaDiXq3ENCDsRbcogEyq0AxdBtK5EEOYYKHYxwP6mp4943+XHMLh/v+9bSKInO8WOkU5TyOQpKTxNioR9f41s3XKry4slWbxj8ws8aCZmJXn/dtqWOffNvpGs4Sw9UgIS9s4/OCT30q00MA89eLZQiVz1e5COGkE9LpXv4t2GDKm/hsNGweLlc8D3FgBz8QumCp0LZnE1qo/vpctGe53oiuhYoAeBbLMpOUx3B3gSSRexPeh9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg8z3RiGFQlQ7kzghQOrexW2g3KzzbydSjHtv2lqC9s=;
 b=divRHgQUmAVpcZnuwL3an6dsCGT0ijXjgW7a+WVDS9PUp/E+9X6zaj9Aiumr2BzM8VeI4YgVYCG3FjinuaT6HgaYjjLMntLuEg0T8DqWa1/QdjGPBxvKHqupRSzA/6G0xzw4q0gfd6leOSGT85j5qD2nIsGvAuqa80HCbKeIiCz6LmzDfT1f//5zrKgVePDsDopek+s6UfrpROsJAhV8Ob1awYj5D89wGNxKXrIfJ+61uD+3eDG7ZQQc/bLVOH3fuDTqdlhHBkBWHnSy80Rhx1tNpwEkDFB0LY6P2F16no/yvw6qa6YNU8molIgAZPMiWWKttA4zsEkg48mUiXZn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg8z3RiGFQlQ7kzghQOrexW2g3KzzbydSjHtv2lqC9s=;
 b=OwO0XODUcSMpWBgaTYz/kNITjp8wcr0ZfWIlJzDP+H8q1NTeTWDfF7EiF2a7BPUXAdiibv/IUtOlaDqMZ7pLRQyosVEVHZ813jwHljoaaRiUk00L2fWoaixtva7hD9d/fXduwyZsQxtUebkKoTbELdOhnPxAbvlBGBs/GQ+r8rTmYkQIgoOyD+eHvJ5YznzcfH9A5wc1AokiJOqsPaW6XXEeMKYne443cil9fqFmcPB4tmrGBndxK5IvpsPceEJHg5cWJ6tMD4wfxW/KI+Sd6Womai1LaKbvXrS77p5NvZgfvCpTUastEgmBZklWv7BTXcOajL6luYPwMkRho2sBvg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 18:43:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 18:43:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "nh@edgeless.systems"
	<nh@edgeless.systems>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Thread-Topic: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Thread-Index: AQHZRkM4BBkcG7J0o0+Vg8WYjKa+Ja7n4T6A
Date: Thu, 2 Mar 2023 18:43:31 +0000
Message-ID: <5d934d09-c1a3-f05e-596c-67294db4c59f@nvidia.com>
References: <20230221222307.557935-1-hch@lst.de>
In-Reply-To: <20230221222307.557935-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB7245:EE_
x-ms-office365-filtering-correlation-id: e6178596-f61c-4a31-7917-08db1b4e05ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  HPKvNrs5j1lz+gaOgmW0aJzlKpHH9nSXAuXbGDUZxUenPEC5NcdBHaKswn/gMHXCp3K/+PYQL5IpgzzXfvbkOaaIS3Okpq/b23Ako6rMsc7WWb84H4bgBgZahiZD/yc4U0QJHo7/I4p3FKRXJQPer3oWRDqQitvxI1He+zTLUp3zW9NB4yjxVaG+zHywsLEcS9K0etTWF9iRxA535lgICSGWmvb8r08Mhn72L4rkyxv3JtEnHc219cCUypAXncOnzIuLOqLKtk/d9TdAvXsUKRwa/X7ols0sa1J1OaozVSRdoqnL3cG5ojWbIVJdKYKNMzLcJsc6xZxXOZUQc0Mz9hw0uD89tljW4K8KxIj8wQVZtViFCH8opUQivbBkqiYAEvcIAwUtb8cpQlzb52DqXp6uUr5f91J7gPPAh06Z5m7s8jGn5G04gx7V7kS9R4zGSlaTfwHFQ3ZOuo2P2ofn1eYgmok4JYtuP8rt6DJVYfUboQSf2v1gV2REM1iHD7VeFgG0E4EuHPXpPp8rx0GpTlBMB0xBE3w/tLf/Ijo2NGhBFbqcKXWdH10mA6+kmHZBc1/5Sw9f3nt0B7gpuHA14sr/VlVAiP9vtsxAsTYHWSYJWn2W8u1nAjEhqdD1GmDf0yobYRxllWUF/9MBW06cMoyt/sFlyv3ZAxdIXt57RAVAn/Euno3FS/Ztwn0b8hS/TwA+6NG5YPpYzYyYi7xHDXX/bUx14Su67okCEUUE1E906ANpFGFz+evRgCaYE3xd0nJiRn5XLst3pLW1RbQfuw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199018)(31686004)(5660300002)(41300700001)(8936002)(8676002)(38100700002)(64756008)(6916009)(66446008)(4326008)(91956017)(2906002)(186003)(66946007)(76116006)(66556008)(38070700005)(2616005)(54906003)(66476007)(316002)(122000001)(4744005)(6486002)(86362001)(478600001)(36756003)(71200400001)(53546011)(6512007)(31696002)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ekRBYnE1OGM0SzJmcTZCTElDTUlpNEE5RXl1TWlKNmJ4ciszU1hpZ3JKUzZ6?=
 =?utf-8?B?MzVMcVJXcUtwMGRpU2RUY0NsdkNVcjlQMUNUY1NLWFpGN0lyNWgrQkxCY1A4?=
 =?utf-8?B?bEZIenB2Y01Na0ZZSUxKclZ1dGgyTlIrNE1lL3FOeFVmRENKclM3M1F0ME50?=
 =?utf-8?B?VnJZU1NHRTdMSEpkVnFKbzlPTmJCR01ZVGw3SHNFeEkyN1oxMEw0QkVQdVJo?=
 =?utf-8?B?WVdNMUt5VHhtVGdoVFJ0SDd2WGlVY25CNzhJQkd1TUEwVS9MMHAyNmFzQW9s?=
 =?utf-8?B?MUIyc3lWREZVTnVlSlFXS21GN2dKN0ZtbE5VaExnSjZSWWdJR2dBbU00Z1hn?=
 =?utf-8?B?aThkWkpwZTBwLy9aZ3crbmNtcHp4OTZaQ0s1YnIxQ1J6cEIxWG44OXJHSVJi?=
 =?utf-8?B?TUdtTDZELytTV2FORXdxYXg1aldRdUUxR2drWE05cGpnd3JSZ2NITHFFVTY4?=
 =?utf-8?B?RlZzZWZnVVlZM0R2aHdjQnJ6dXJSK3NqaCtSQ29JeG5JQXNGZSt5aHdlYzBq?=
 =?utf-8?B?TkZLZGZwMEtUTlM0c01zTDd1Q0UwMzBESHg2SmdxeUcyUU1VUnlwcmZnK2Ux?=
 =?utf-8?B?OW1senZCbU9XTktDcDhkanZHNEVwVVcvRE5wL2NrUCtyS2NuM3NGaERGUE9z?=
 =?utf-8?B?L3YyRlNGTTNNaFJuNWZPR3ZQV2JhNlcybENGMEhQMVpZSkFzYWNuSFdyVGpO?=
 =?utf-8?B?WTJzQlVWaTNXeE14cTJhbHg3Rkt2RDBIVDhYM3FyZnFObmJPc0lZTHl1dml4?=
 =?utf-8?B?czM3R3kydVRVR2JWeGY3b3A3blJNM1VXN0pqSjVmL0Y4N2FTMEI0emtJMXBV?=
 =?utf-8?B?VWR1M3pYZHpzVDZPcTBkTFJsV01wRE1PaDhmdFpOenFGTk1NNjBESUdqSGhG?=
 =?utf-8?B?NnlkMmRsaDJVUHRlS2VBNHRKcUEyM1FOek4wU0hKdWV3Y1Izc0dYdFpCNzJ0?=
 =?utf-8?B?UTZTL1ZmVEY5WXpvdjI5Z3NYYWJnY1c5cVJ3WUhnNFNqeFVoczZ4TURFR3FL?=
 =?utf-8?B?MWV0WWNIOFRCS1RpYlRERGE3MnRMUFFBOWQ3S2hPeGhxNlRENFdId3pKdHpn?=
 =?utf-8?B?bXhMblpRb2VXUk82VCtyVEZIM25OQUU1MWhGd09Sb0I0TjJjcEhQNkhoMkdu?=
 =?utf-8?B?VVh4cmlsYTQ1cVRHcXFzY2pBeDJ2T1B6TDMxNGExWTZUM2xxVkFiUFh2cWNL?=
 =?utf-8?B?T3k2OHJ0aGhxekFQeWJVZkt4RVE5b20vUXV3SW8yZXNuQmNsbDh4ZU5BVGhz?=
 =?utf-8?B?a2tXY1UwaUJhWWRjaUtCQVN0NUQ0NTJZVzBTeVBpczlqekVYT0ZzOENjWkVQ?=
 =?utf-8?B?WUV5TWswWGRQbWh6NWNHdWFrNDhwd0hjanBpR1hzOGZnUVJJdnVCcE1wMEFr?=
 =?utf-8?B?ZVp0a0J0S3crckZweEZUa3hiQk1DUXdXdUJad290dHQxTWRET0w0N092dW55?=
 =?utf-8?B?ZVRielJGbHdGSERIazAraTBzYUhESDY2TGYvUGpRZmJ4RXRSY2tNMGs3cmR0?=
 =?utf-8?B?aEd0TWUyanJkOXY0WW4zV0pKaGY5Y29WT2hlQ2NWOCs4eHBueHF3Zm5Bd2VD?=
 =?utf-8?B?NG5pa3lCNWZaS1FReXpNVEw5NmNHd05qN2x6eWpJWWhFWTdXVHVMSEh5ck9U?=
 =?utf-8?B?dVV4Z21hd2haZTNiZk41ZDdKYXdXK2E3RTFNOFVhclRjVTRGZk9WSmRabjAy?=
 =?utf-8?B?R1M5QlBIMVRNc0JlSTVDQTJFTzNxeTR0Qk8yWHFBSUx1bG5YZFl6RFhVUldX?=
 =?utf-8?B?cllFMy9BMXZtY01PczdOS1cyTSt4alRudkYwN2VSN21hd01GN1dsbSs3NHFL?=
 =?utf-8?B?NkVhdFgvMGlsdmh6RkdjcFhMdlVWcFVnWjFWRzlUN3BEaUZteUk1OTByRHFC?=
 =?utf-8?B?VGhTcG0vaTNSUC9TdSszQy9SNWE2YXI2a2E2YW1CUHVHeUVFakRkRmo0UVhI?=
 =?utf-8?B?N1UrNHZ1OURNeXdxUCsrdFJqL0F2dUtPQXJSZTBESVFRTmxZeFQ1RHc4UGh2?=
 =?utf-8?B?SmlxTE5VbkRTSS9tTjN3N1huajQ1MFBveStiTGtSY0xhKysyMzBjZWQ5MXBW?=
 =?utf-8?B?dGJvbjdjR2pjay9FYitXeGZvbWNITGZCNEkxaG1PUk9WSUNhNHE3d3l6K2ov?=
 =?utf-8?Q?WDPXtTBgxMUN5U3cDr0DWQKHl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E21753C49EC4CA46B98B5BCCDF191FD4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6178596-f61c-4a31-7917-08db1b4e05ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:43:32.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c0JJygCER7W+j0RuQVh7JH5qMDlTIOMC28kTBUIanC1bG8nNIEHl5plRPkU9HOpU4IaYwDEbFi+H9+V4/KStWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_104340_092870_0646EA80 
X-CRM114-Status: GOOD (  13.49  )
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

T24gMi8yMS8yMyAxNDoyMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEJyaW5nIGJhY2sg
dGhlIGNoZWNrIG9mIHRoZSBJZGVudGlmeSBOYW1lc3BhY2UgcmV0dXJuIHZhbHVlIGZvciB0aGUN
Cj4gbGVnYWN5IE5WTWUgMS4wLXN0eWxlIHNlcXVlbnRpYWwgc2Nhbm5pbmcuICBXaGlsZSBOVk1l
IDEuMCBkb2VzIG5vdA0KPiBzdXBwb3J0IG5hbWVzcGFjZSBtYW5hZ2VtZW50LCB0aGVyZSBhcmUg
Im1vZGVybiIgY2xvdWQgc29sdXRpb25zIGxpa2UNCj4gR29vZ2xlIENsb3VkIFBsYXRmb3JtIHRo
YXQgY2xhaW0gdGhlIG9ic29sZXRlIDEuMCBjb21wbGlhbmNlIGZvciBubw0KPiBnb29kIHJlYXNv
biB3aGlsZSBzdXBwb3J0aW5nIHByb3ByaWV0YXJ5IHNpZGViYW5kIG5hbWVzcGFjZSBtYW5hZ2Vt
ZW50Lg0KPiANCj4gRml4ZXM6IDFhODkzYzJiZmVmNCAoIm52bWU6IHJlZmFjdG9yIG5hbWVzcGFj
ZSBwcm9iaW5nIikNCj4gUmVwb3J0ZWQtYnk6IE5pbHMgSGFua2UgPG5oQGVkZ2VsZXNzLnN5c3Rl
bXM+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAt
LS0NCj4gDQo+IE5pbHMsIHRoaXMgaXMgYSBzbGlnaHRseSBkaWZmZXJlbnQgdmFyaWFudCBmcm9t
IHRoZSBvbmUgeW91IHRlc3RlZA0KPiBlYXJsaWVyLCBjYW4geW91IHJldGVzdCBpdD8NCj4gDQoN
Ckl0IGRpZCBwYXNzIHRoZSBOaWxzIHRlc3QsIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBD
aGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

