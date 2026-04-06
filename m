Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9923FB5166
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 22:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYNYQEqBa7GSc2gjftChZ7qq/xHjHYInG3l3Uj7aSKM=; b=GMdEzjy7+IjwlXlIIeK7yBnszQ
	vaPxg85ttJ8E4Ez/2HvD6k/Pw71JeXNITwTV6VNf+TIapXPSyF9A59iF4OPi/CArSTLv4tgk1Yux7
	T4q2A37UXMRoWL8+KI925kBZN1bje79B5tVfh8TjlrKfy0mY/fVoZ5gKnRV2+8S+OXVZP03f2FxUO
	vKy1p4Qrv9tB7NceHrVyJ+dLO+ew2r4BdSvThSUdZAeBFajaC9OY+hOgrrQpIe+pkUI/T5SbaOyym
	e89jIgxMWp2WtWfXoiSDKNfJV5snM+zxlS7/kLZWI9o+2z5CeWswAoswszd827ig1GU6ijeqkjLNp
	cOj2/UUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9sF1-00000005ZCk-2Z6P;
	Mon, 06 Apr 2026 22:16:19 +0000
Received: from mail-northcentralusazon11013002.outbound.protection.outlook.com ([40.107.201.2] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9sEy-00000005ZCJ-2g11
	for linux-nvme@lists.infradead.org;
	Mon, 06 Apr 2026 22:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeR+oeONrWABjCY3OsTx/ldw9xKdB/R61JRSmUzqtQkxu+/2D7Tlo5SXYMbTwQyV51yHhxNlv5NDVFTgTFsWtoorUuUjiYXTv4WPZFO2EpABUXCh3oWPxcAxLmx482QYaLemxmLzDTvtMovLe+ryRMWCQPNus2yQVv6kksVA0FMbfgq0SEphKVPVEK7W3/4nLYkFZCvm7pFfsa8fL3OeEGv8tkSdA464KElqTOhNXIOUq22NrzkzV+nZmobcRv5yqE45Fzh4iQRa7PoCucqpB1jk6vZxAecSNBuaoN14we3NwVQMyh1UgPEF3HMDPJVldtpLzmC7K/0AuoizmyD82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYNYQEqBa7GSc2gjftChZ7qq/xHjHYInG3l3Uj7aSKM=;
 b=e7I+KpcF0nuRzvjNArfDg06AY7P2ZUM6akQq56CfJ6D8SrT3qyAfcs8+K8m+qIv0YbtSQo4YcKuwyO2QBtSUKt4GDkEs5tbnazJZpzHuEDx9rBUSxiYXP2zo2bvhSBktmKdTs/9CP1ALDXy7h9agHzNyCGY+2eryEp6Xm8ZJKn3Rh1rRG27zoq8qN6CL1ncgPPwjYDmjQRsjQ9J/OfH/v1CbKkExxciKSRYdAxMRSws6xSDbTh9Kf8YdzOLo2pvuVmldxev38Ki3XwQH/+YIL8tMsI33bEWuI6er92wWATyaNvI+2Yph/rkISfq5Cn85slM7D/E7QJ+5M2SmowMpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYNYQEqBa7GSc2gjftChZ7qq/xHjHYInG3l3Uj7aSKM=;
 b=RgFYrMaSBs0ohjgLcDZPMBZ/wvwhhYazMiRkQcXmKIO6CAGdIG6XFzVrcJ7HQvp4pwYwRYP5PsXy+yVdl1X0teiJHTIDId56HtMhPzpL+eve8bZPz4P5cHA7hiq623r1kKYqz9UbhIpF7vgNrj/cVS0fPqEXxm8X8SWb61/but0dDts2vchkMo1/u1bT3q9lkFqXF8e95u2yhTxhxvr6sP2FECzYKbqTgRN/qPZKhbDdJ31kzFwiL8M5D4eb+WXhBQUn1eSPQprSpaI1BcBIvCbTKwNuhIyHW4gSm3QjShuAsUpKd5ZFQ2BLYtzdCPnvrQ3GrvUha7lb2d3P1uGrLQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 6 Apr
 2026 22:16:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 22:16:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>
CC: Greg KH <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
	"security@kernel.org" <security@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Shivam Kumar <kumar.shivam43666@gmail.com>
Subject: Re: [Bug Report] nvmet-tcp: unbalanced percpu_ref_put on data digest
 error after nvmet_req_init failure causes refcount underflow, use-after-free,
 and permanent workqueue deadlock
Thread-Topic: [Bug Report] nvmet-tcp: unbalanced percpu_ref_put on data digest
 error after nvmet_req_init failure causes refcount underflow, use-after-free,
 and permanent workqueue deadlock
Thread-Index: AQHctsxYEWdvvhFS8kCS6Lje/KxiZLW0KxqAgABOnACAAJPwgIAJoraAgAAB8QCAEkxcgIAAjg0AgAD7/ICAAC+mAA==
Date: Mon, 6 Apr 2026 22:16:10 +0000
Message-ID: <3f15b127-0052-4cdb-b720-112aeda71163@nvidia.com>
References: <CA+ysrS+QrbGfOLk=e0=PZ-py-KO_xZgn827nEg7mh7hGhdUAAw@mail.gmail.com>
 <2026031827-carving-overdrawn-5b1f@gregkh>
 <CA+ysrSLcSJSgEC7i0GYXPiRY9sbbyEGT60Nh1SJ6PqXWENgSOw@mail.gmail.com>
 <CA+ysrSL+3YVGvTKhJ=jL92XZPwjoDpt5D2BK-HeCU975vO-fCQ@mail.gmail.com>
 <CA+ysrSJQ2tDiB=zL+GwF=ckhmO62v6GC2bWVUVVDVn7d8Km1mw@mail.gmail.com>
 <27f3f1b4-5f27-41d6-aa5e-646e5f3ce1e9@nvidia.com>
 <CA+ysrSLqMrw0wY8WGcfCxTi=G54v4Gg-jUcEvkw5tyr6J7cLWg@mail.gmail.com>
 <e39c9bfa-6b53-4517-a00f-f0068ef0b290@nvidia.com>
 <CA+ysrSL_cRe4z6ey+W+LodVF-HXSg8jifGa_wLD3sHT2PLoMDQ@mail.gmail.com>
In-Reply-To: <CA+ysrSL_cRe4z6ey+W+LodVF-HXSg8jifGa_wLD3sHT2PLoMDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS2PR12MB9773:EE_
x-ms-office365-filtering-correlation-id: a566b5b2-e367-497b-54c6-08de942a1b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 5OAbXLhRHeMvE6iOwcNpuQSxCY5hgKnsKEhGXGoXarVjE7i2J9rGVA6eVqyav6+l7bOrtr1aZF2OEF2CVnyHQWCCNIJwu1Mhx+MQzugOE0LRXa7TkRxxwMc5l46t/dqJds1FlctXqx2QqQRC75/NmMBd96twTGuZ/cOM1/4zPOCpi+/y6KSnjYBGK2695aUXT86bHYo8EHuEZJI/4rVcGFl8yba+puuT7YXQGgvroPaMiS2OnDiparu8dRm0rN5p178aKq1rsFO8nR6C+c5wEhEKw3IzNXepnIP5ggUcIF0SVenYgaTJ+IYxublGV/02j231W+Ll75X26BGP6LlU3YhV7TRwnOI9q2vXah0Xv0MaEeI/CujrXnP2yh8j/nVBusptLBf2MO7hS3VhJ0JNRKlYwOR7MasWLKOQBz5HY2aHINDhml1oKDnZsjpA99jKdovqlXCkcRkqZdcaVWFbo1rHQLixhvURj7X6RIVTvMfeiZqrTKkThpYrD21tCvC+Zwre9a56u6rVlQWHSYMwE/KmIWXr2jdv9CDujpgRpCyk/kwxg5PL4J8R/46rAwuVfxi/yUWnwNwcqWfz7uJYRjpDWAuOZtJ2mjDHT+2PE6qFN8SEcnchmFVz+0SwWr3FYwtEYVnCKRaNMlXQMc/aEGpyfbt1QJCrzjDBYSBR8BDDfQlTzIQOG65t7GkfB+h04hmmnT0JEeoIjZW82DbT64VWK3NwQ0OFGtpkBZs2SePoakL50LeLIQgNYJJ3bdTl6Rh1EdZqUWLYfzPsaUmUCl8AQRaBC393PoZX77pgE4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjNjSE5XcHBmVXN5UzJSTHNjOTBORE1aZVk3TEFIc2xCMUF2bER6WmxzWkRH?=
 =?utf-8?B?NFdTTUdyU3A4WVd5NWpTTTdtMGJyaFZLejdGSjVSUlJiMTZ4M0NiaFJMaE9K?=
 =?utf-8?B?ZTFkdTZyRnBYSjZoMHdpTm9KZjcwTkU5cUpEc2UwNTQzbndjbVk2SG5INTNR?=
 =?utf-8?B?VzB4SEw2TklRa05DL2phdmZBWURPSXk2YlZyY3d3S1NNVzM1U3VZTFdkYWFy?=
 =?utf-8?B?YkJvLzY3VGUrdE40a1BCWWU3Nm4yWDhwaFFZSnFwUUJ4L3ZzaHkzSSs4TUZa?=
 =?utf-8?B?MlFnZE1MRkM0cFJBa3JKUUhXRG5HTE5GdFU4dmJ6Z3h2SDY4UVhIQktabzVt?=
 =?utf-8?B?UUJxNjFwb0FZTzUwTEd2bnRNRlNRbE1XNURleDZzaDVuaU1JSjJYTjFVWG1j?=
 =?utf-8?B?bWtFME5VWWNQYkpIRm4zS2dRdTlmblRSMXEyQjgvMkMvMHJ4clZrVkQ4VzR6?=
 =?utf-8?B?Y0NlL3BvdElzWXJvYkJ0bXRqQ3RoVnFxb3A2ckduQ0p2ZWpPSlNqVllnRUJi?=
 =?utf-8?B?MUU5Qk1udGoyaTlLei9adTI1VERJL0NEeEcvTWRuK2o0amxTcmxQVTduYmRU?=
 =?utf-8?B?WXMyeXhHNVBlMEw1L21aa1ZzOFBxWG9Kd2xyVXVUc2Nxa1EyVitzTmVvaW5M?=
 =?utf-8?B?RVRxbzB2V3J6L2VRYUpBcXFxTW1wWWlBQTVWcEpOODYvYlJuUW1uZG56WjVD?=
 =?utf-8?B?OXUrbUlMTkRHV2FObE1QVG1EblJ4b3NGOFplRnBVMENsMER5YlBFNDhtc04x?=
 =?utf-8?B?RGhKcHh2d3JvR0YyNWh6QVNtZWxhQzUrK3h6bklJWHVULzVNbDMxZGNiNkZU?=
 =?utf-8?B?Y1VZQXlPamMxMFVVZlRYSmFha0d0c3BmRVlMcTk2bG9abUdvYnZXY3VrQWVq?=
 =?utf-8?B?ck5NMENOYUY2TVYrcVRiNU9aUE02cTYrcmlZRWo2Z0hHZ1cyaWlkMHNXYzRQ?=
 =?utf-8?B?UTk4Nll3NWo5dGZKd010cGZNd09nekhxcHdGZU1sa3k0ZWd0ZUhJSHNUTHNR?=
 =?utf-8?B?YWJ5ckY5cjNHN2NVMm9SbkN0dUlzbGdKcTh1RHZkV1RBazJ2RHpIOU5EblIy?=
 =?utf-8?B?b2hVdWpFK0RqTkNuWVpvaXYvSDVYdGV3djBYV3gvMjV5Q0V5K283RVNNVUl1?=
 =?utf-8?B?a09MNmVpdXBycUcremNLSGZqbFZqVUpCZzhyalVXTWRHeCtxOHR5dmRZNnVB?=
 =?utf-8?B?RGI3bzIzQzJaOWhFR3lGa2VQdG1QK1N6SzJNc1dNeHhYd3UrcUc2VWNGMWgy?=
 =?utf-8?B?Q3V1SDlmN09qWUFZWWwreGRaR3dKT0ZCT0I0am80MUI4MXV2STBnK0duUHpS?=
 =?utf-8?B?bFpQSjdOU09jbXJrcEJaMno4bERKcU85K2cvWE9sTmo0UHNsWm81dmZlZ0tr?=
 =?utf-8?B?eUFHYXZEbGJGcnR6QVNGK3ZkWEhIdmoyMTB6cHdZWmppVTZOZW5aQTYrVXlF?=
 =?utf-8?B?bjdYMzF6eDlUbDBjNElVL2FROWhneXpWOGNjZWhqekl6Slg4Mld0czAvV210?=
 =?utf-8?B?QngxVy8xNTRoVXVHenUvTHFpMlNxREZETlptYUxSSXZLV2J0OElKUXg5Q1o0?=
 =?utf-8?B?TTlhWGd1WC8rWXFLL2MvQ2dMYU9mL3EyNHZXWVhIc2tTa3BtdFlDNnpGREVL?=
 =?utf-8?B?Wi9CZUJEaGc5dnp0cytoQkNWYmxTRVpDaXg4SSszMHIvSy9Td2w3d3FjL0JM?=
 =?utf-8?B?T09WL3VIUWdvRzhwWDhhemRVT3BWSm9MbW01anhCekpkcldiWjA5V0lhaHhs?=
 =?utf-8?B?am53ZjFPTTUvQjJGTHprYW41bGhCUmNickZXb2hYdVpZS290OU5qOWJraDd6?=
 =?utf-8?B?blQwL3RlaFZ0NTZWdEpCUERNdFZ1ZEE5MWMyWXNISFFud1E5TXBEOStiNk5u?=
 =?utf-8?B?WkhlN2hNRGlVanpBQkpHYmZNb25jUDF2ZXRqbm9YaXBLM0NOUFc3NTlxZEtE?=
 =?utf-8?B?aVNVbUE4cUl2WDhqWE5KUTU3UlZ4T1pSbFNzaXlLSkZOdXUycDJMRitTQWFZ?=
 =?utf-8?B?VTdLZnZjVHZhdHNJTC8yZXozRkpmNUhOaEk3ZEVuQ2htRXpheGJ6Sm1FQkM0?=
 =?utf-8?B?cUdaTEh6UUpXYVhtcW1aaVRNWkcyOU8rS3JpampFdWpMdm5lc3dOcWJYdEEz?=
 =?utf-8?B?ZHBKMkc1dWFnRm9ON2FLdmZZY3g0VDk5ZUgvWTV1NzhHRFBjRWVCUVV1dE9V?=
 =?utf-8?B?V0tidTdoeFMrOEk4WkNHbDFmWjNDSVFmM29OQ0VFejFPci9YbE53NVlYK1lF?=
 =?utf-8?B?cGd1b3hhRFR6elM2WUdrUFNyQzJ3NzFxc3dqcVVBQlZQRG9sUDY5OGhWcFBU?=
 =?utf-8?B?QTdpMVNKaEVyc2g4OThjYXJySlVLa0FUZFZ5TTJsbmlDM2s2QVVDb3h2QVE1?=
 =?utf-8?Q?WzFhZO53AdRawSjIxT/DXuuWwCTvooIYN7nOBuuVKVi3l?=
x-ms-exchange-antispam-messagedata-1: puSlMeRjsDkc6Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D24D8F3696B54F855F6A8112BC2B16@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a566b5b2-e367-497b-54c6-08de942a1b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 22:16:10.3440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahe1Cpf0e2NFaFN66TL4tn2fiHzUPWpAAQ2jsipbUlhjTRxBYzL/KbuJ4i36EEqknFaICzBY/A6sgpFzwP9Tew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_151616_680205_55F17FB3 
X-CRM114-Status: GOOD (  17.83  )
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

U2FnaSwNCg0KT24gNC82LzI2IDEyOjI1IFBNLCBTaGl2YW0gS3VtYXIgd3JvdGU6DQoNCj4+IENh
biB0aGUgZm9sbG93aW5nIHBhdGNoIGZpeCB0aGUgcmVmIGNvdW50IHVuZGVyZmxvdyBpc3N1ZSA/
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L3RjcC5jDQo+PiBpbmRleCA0YjhiMDIzNDFkZGMuLjY5ZTk3MWIxNzlhZSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMNCj4+ICsrKyBiL2RyaXZl
cnMvbnZtZS90YXJnZXQvdGNwLmMNCj4+IEBAIC0xMzEwLDcgKzEzMTAsOCBAQCBzdGF0aWMgaW50
IG52bWV0X3RjcF90cnlfcmVjdl9kZGdzdChzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVlICpxdWV1ZSkN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZS0+aWR4LCBjbWQtPnJlcS5jbWQtPmNv
bW1vbi5jb21tYW5kX2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHF1ZXVlLT5wZHUu
Y21kLmhkci50eXBlLCBsZTMyX3RvX2NwdShjbWQtPnJlY3ZfZGRnc3QpLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIGxlMzJfdG9fY3B1KGNtZC0+ZXhwX2RkZ3N0KSk7DQo+PiAtICAgICAg
ICAgICAgICAgbnZtZXRfcmVxX3VuaW5pdCgmY21kLT5yZXEpOw0KPj4gKyAgICAgICAgICAgICAg
IGlmICghKGNtZC0+ZmxhZ3MgJiBOVk1FVF9UQ1BfRl9JTklUX0ZBSUxFRCkpDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICBudm1ldF9yZXFfdW5pbml0KCZjbWQtPnJlcSk7DQo+PiAgICAgICAg
ICAgICAgICAgIG52bWV0X3RjcF9mcmVlX2NtZF9idWZmZXJzKGNtZCk7DQo+PiAgICAgICAgICAg
ICAgICAgIG52bWV0X3RjcF9mYXRhbF9lcnJvcihxdWV1ZSk7DQo+PiAgICAgICAgICAgICAgICAg
IHJldCA9IC1FUFJPVE87DQo+PiAtLQ0KPj4gMi4zOS41DQo+Pg0KPj4gYW5kIHNvbWV0aGluZyBs
aWtlIGZvbGxvd2luZyBjYW4gZml4IHRoZSByYWNlIGJldHdlZW4gSUNSZXEgaGFuZGxpbmcNCj4+
IGFuZCBxdWV1ZSB0ZWFyZG93biA/DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvdGNwLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3RjcC5jDQo+PiBpbmRleCA2OWU5NzFi
MTc5YWUuLjVjMDNhNjUwNTMxOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
dGNwLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvdGNwLmMNCj4+IEBAIC00MDgsNiAr
NDA4LDggQEAgc3RhdGljIHZvaWQgbnZtZXRfdGNwX2ZhdGFsX2Vycm9yKHN0cnVjdCBudm1ldF90
Y3BfcXVldWUgKnF1ZXVlKQ0KPj4gICAgc3RhdGljIHZvaWQgbnZtZXRfdGNwX3NvY2tldF9lcnJv
cihzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVlICpxdWV1ZSwgaW50IHN0YXR1cykNCj4+ICAgIHsNCj4+
ICAgICAgICAgIHF1ZXVlLT5yY3Zfc3RhdGUgPSBOVk1FVF9UQ1BfUkVDVl9FUlI7DQo+PiArICAg
ICAgIGlmIChzdGF0dXMgPT0gLUVTSFVURE9XTikNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47
DQo+PiAgICAgICAgICBpZiAoc3RhdHVzID09IC1FUElQRSB8fCBzdGF0dXMgPT0gLUVDT05OUkVT
RVQpDQo+PiAgICAgICAgICAgICAgICAgIGtlcm5lbF9zb2NrX3NodXRkb3duKHF1ZXVlLT5zb2Nr
LCBTSFVUX1JEV1IpOw0KPj4gICAgICAgICAgZWxzZQ0KPj4gQEAgLTkyMiwxMSArOTI0LDIxIEBA
IHN0YXRpYyBpbnQgbnZtZXRfdGNwX2hhbmRsZV9pY3JlcShzdHJ1Y3QgbnZtZXRfdGNwX3F1ZXVl
ICpxdWV1ZSkNCj4+ICAgICAgICAgIGlvdi5pb3ZfbGVuID0gc2l6ZW9mKCppY3Jlc3ApOw0KPj4g
ICAgICAgICAgcmV0ID0ga2VybmVsX3NlbmRtc2cocXVldWUtPnNvY2ssICZtc2csICZpb3YsIDEs
IGlvdi5pb3ZfbGVuKTsNCj4+ICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+PiAtICAgICAgICAg
ICAgICAgcXVldWUtPnN0YXRlID0gTlZNRVRfVENQX1FfRkFJTEVEOw0KPj4gKyAgICAgICAgICAg
ICAgIHNwaW5fbG9ja19iaCgmcXVldWUtPnN0YXRlX2xvY2spOw0KPj4gKyAgICAgICAgICAgICAg
IGlmIChxdWV1ZS0+c3RhdGUgIT0gTlZNRVRfVENQX1FfRElTQ09OTkVDVElORykNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHF1ZXVlLT5zdGF0ZSA9IE5WTUVUX1RDUF9RX0ZBSUxFRDsNCj4+
ICsgICAgICAgICAgICAgICBzcGluX3VubG9ja19iaCgmcXVldWUtPnN0YXRlX2xvY2spOw0KPj4g
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0OyAvKiBxdWV1ZSByZW1vdmFsIHdpbGwgY2xlYW51
cCAqLw0KPj4gICAgICAgICAgfQ0KPj4NCj4+ICsgICAgICAgc3Bpbl9sb2NrX2JoKCZxdWV1ZS0+
c3RhdGVfbG9jayk7DQo+PiArICAgICAgIGlmIChxdWV1ZS0+c3RhdGUgPT0gTlZNRVRfVENQX1Ff
RElTQ09OTkVDVElORykgew0KPj4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZxdWV1
ZS0+c3RhdGVfbG9jayk7DQo+PiArICAgICAgICAgICAgICAgLyogVGVsbCBudm1ldF90Y3Bfc29j
a2V0X2Vycm9yKCkgdGVhcmRvd24gaXMgYWxyZWFkeSBpbiBwcm9ncmVzcy4gKi8NCj4+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVTSFVURE9XTjsNCj4+ICsgICAgICAgfQ0KPj4gICAgICAgICAg
cXVldWUtPnN0YXRlID0gTlZNRVRfVENQX1FfTElWRTsNCj4+ICsgICAgICAgc3Bpbl91bmxvY2tf
YmgoJnF1ZXVlLT5zdGF0ZV9sb2NrKTsNCj4+ICAgICAgICAgIG52bWV0X3ByZXBhcmVfcmVjZWl2
ZV9wZHUocXVldWUpOw0KPj4gICAgICAgICAgcmV0dXJuIDA7DQo+PiAgICB9DQo+PiAtLQ0KPj4g
Mi4zOS41DQo+Pg0KPj4NCj4+IC1jaw0KPj4NCj4+DQo+IEhpIENoYWl0YW55YQ0KPg0KPiBJIHRl
c3RlZCBib3RoIHRoZSBwYXRjaGVzOyB0aGVzZSBwYXRjaGVzIGZpeCBib3RoIHRoZSBjcmFzaCBw
YXRocy4NCj4NCj4gUGF0Y2ggMSBpcyB0aGUgc2FtZSBmaXggSSBzZW50IGVhcmxpZXIsIHdoaWNo
IGhhcyBDaHJpc3RvcGgncyBSZXZpZXdlZC1ieS4NCj4NCj4gVGVzdGVkLWJ5OiBTaGl2YW0gS3Vt
YXI8a3VtYXIuc2hpdmFtNDM2NjZAZ21haWwuY29tPg0KPg0KPiBUaGFua3MsDQo+IFNoaXZhbSBL
dW1hcg0KDQpDYW4geW91IHBsZWFzZSB0YWtlIGEgbG9vayBiZWZvcmUgSSBzZW5kIGEgc2VyaWVz
ID8NCg0KLWNrDQoNCg0K

