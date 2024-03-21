Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C7FC54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kde25xSabur1jt5IkhvuBjZqnGk2NP9l+hudvjv9i3U=; b=jlGmrdCZDI0e0XZs1ueNP12QSC
	PeuQxjblD1G+KDUBjvLTDpWXXynmO0p62nwxHxvcmPJx7GvNwYWDOfmFhxfhHRl+qwEHKmo/RyzXv
	kObkGQsLFEH8HH45UXO7gEKZcKiViUhVDOF+im7maNwANrdC3jPopd5euHdVBOUQ3A1NNh0k4mgv4
	ySYjHx3yBw5RBhlKEJedLuBfQ+L9hrhasdTIHIjcYPAeS9FeJ+5ntisPnQ1UrIKFGloIZ+KolAmd3
	HbmnCyJmALtAOf8No3EtIg15WiVT7hYLZf7RJefzMPp+VZPJpIFmLDgxwZo2tJnY551KxaWAOF72h
	mbobT+Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnDRc-00000002F8c-2Sn3;
	Thu, 21 Mar 2024 08:06:36 +0000
Received: from mail-dm6nam10on20618.outbound.protection.outlook.com ([2a01:111:f400:7e88::618] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnDRa-00000002F7y-1PAG
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 08:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8fcNg1rXQqgh1oXdylMgwjXoU9CexRHgxTFlztfW1yf0eHXYkl+xY8O5C8tkDu8i76YMWQ+o1rPqP3j842Eo6LSh8QSSV1HEbOpp1bribqGZGFg72wT0DIF4XyjEdanDyUj6xR+MBbftEJfOOgWRa1xcU5n0ONhBPJUg92H9h1sM6L4Nxsoa0NP5rMH+ctqy8WyJTYaR/YVTL9wMEo2P+lD82earQjF1RqbGDGcy3KApHRoN0wUyQuEGYBKyMdQZuRa8oBieJnu44J3u+zMF3y4c7HOMKdX4sMPKMU+yrQKsi3SB6Ihh9mpg/c0hzi2L/BheGDcONpikeaAdEmlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kde25xSabur1jt5IkhvuBjZqnGk2NP9l+hudvjv9i3U=;
 b=kK8oGMzyXHI/8uZn+H+9jxR4Hbd6fy1xY6Rs9nfZNdoO6/GoPugX8W1yTEct1/Pf/DXDBpYH9tafBAk8E60Z4fMqZevdzURNYKqMfwl55w1fc2X4zAuoZV9sjBq0xBh7jv2kwVkte6e2rL76hc2K/uVZ16ofzQnuIJPlNRAzsnGpYD3Bma69H7tiMHFCzqEoyo6Y/r6oQdcKrfvaCCauOPYgEUcBfOFzcYVSn3ZzTgWAAYZk6mzhM5X52QgO7QnmOVpUdzMQ0tD1hcan2RJCqHuJEZ5xMAXbLxKRtYF8BcXsbQiTIblx4j/rgotNDGJaAMWtgApIP8g3Ss9/EvJGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kde25xSabur1jt5IkhvuBjZqnGk2NP9l+hudvjv9i3U=;
 b=LO7sZJGoTWMRbss/v6PsLexW/qnRalIeyKNyQbBuC9lQXHZdGZPevHicBgW9kAKiapV0NKExrzXeWqk4sd19Ef2y5Y8iL69mJ64laDwop3fv6PkuuviS68pJV0oVF2/CyOMgXureKl9N8wTxyab3C/BgGCSzFsc7FuM8P+bi9oHUHbwzVlTQSyetMi4feZnBGTZjKbf+7iFayP2ZZ6px3LEdhwoVj6muZ/APutQ9IMciys6it81ZxBDfuv6GmO1pf8R4TCw7aQ3SB5QdcD0+eoN0ja7gfQe+1nc/mSL2JKlMbQ1W7EMKBJMdVaaGhPF7ZDYPr+lAr+HjM/Ix/BmIDw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:06:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 08:06:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Thread-Topic: [PATCH v7 1/1] nvmet: support reservation feature
Thread-Index: AQHaVLbjkz0QMzGO+UKZIHEcqOuwNLEfFBgAgAAcSICAABCaAIAABVMAgAzzpYCAAY7vgIAADqcAgATLIQCAAj1AAIAAZ4YAgABoGoCAACIJAIAACzsAgADhQACAB+twgIAABa8AgAF75gCAAHoVgIABfsSA
Date: Thu, 21 Mar 2024 08:06:28 +0000
Message-ID: <412afde6-db7c-450b-b8d8-bd461b4d7b72@nvidia.com>
References: <d6073345-ceef-49b2-834e-618bbbb78de3@grimberg.me>
 <8fccdd92-9055-45ba-8edb-8b2b647343b3@linux.alibaba.com>
 <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me>
 <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com>
 <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me>
 <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com>
 <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me>
 <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com>
 <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com>
 <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com>
 <20240320015932.GA14551@lst.de>
 <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
In-Reply-To: <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB7033:EE_
x-ms-office365-filtering-correlation-id: d45179ce-26c6-4bdc-2846-08dc497dcf90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYabV4IKY9hD6una1qCPvwOIzqz1PM0pzjpbpEavAq0BGA22Lrc+VS9F0eb7eji6gPNMiWb/wUOkZmgoGfrsp47Vq3HCrWWbCdZPRG/us+DMqefm6QTTY7E6BM9QLtpfIZkVMoH500AAfswYDn34/7z4nKZkX9FEHr8nyMy07s3yuWCwxFD9WEKGV1guASqNgqOeByW9GNpRejhBEl+dmEXJwsZfphNUe4tMBIxm1kUqcHSbz6Qj7OrpLNcuNtpTeg4LXm1DB047VZXQnOguTwR14Zcwk3X4h6ZCV2Pl557PY5ChzbuPirArjXLvSwftxjfag4y4noa76B5oC91wQy9BnIZCmw0xZf/sR8EZpXyJmQxR/PDl0HiS2oyYmKdRz8uJ/EKBRUjeOzWLpsT4kZ243zLZYfMrAOuPS6btpkB9OPvr4mqFHFyF93rSAMeWAeTM347zWXSb8KpR8FLEGwLLptkG0FLoZhb7DVEFssO/ZM3EYy40xWBDAcMrgRubNkt7hetmr1UIzVeowjAF3M2SqEqHAdFLJ6SEtJ2eoBB2kTpcu/p/HWqSq0lerITXOM0NIOxhzYXvtckWTToO2ssa2AC6y0HthfP5ck2urzB4wx142Bc7FtsvfnPiwigHu5zZMM128v/thb5BJ27YkghY3uDbG6xBE1/khN0exCzqG6eLIwVNS+LMxE9K7X8LCVBGOLS6Tt2Uqcp4c3S/nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFAzOFpTcndjQTdDbUFkaUE0OVhNRU9tQkZhNXRYTHhZREFPaVZMbkRCbG5s?=
 =?utf-8?B?WGxITXF2N3dPTnFwVnJnQ0NhT2JuVkljeG9Wb0xGRTV6SkEwZFNVSmcrZWx5?=
 =?utf-8?B?Q05iS3BESVdPOUNjN0FxWWI0dWsrWmM0WmN5TVYwYnZVZXN2TDZlS0J0OFpx?=
 =?utf-8?B?Nyt5dUxOcElMWFA4Sm5LbGpXRnZGZE5VMTMzY2RCMHZFSjdQVE9hVHhkTGx4?=
 =?utf-8?B?Z2E1N1NVMlZnRHVoTDFtQ1cvYkVMZ3B5Nlo3UmxJV09GYmtOdFlzRklKaFkw?=
 =?utf-8?B?SkZLN2xkcTVISFJqRTZpUlMveEtlcUs3VW96WUxIM2Vsc2NOek4rN0hrR2ZU?=
 =?utf-8?B?MUlIVnpQakkvRDVUTmxnRUpDbDcxRTFxRVhZTXorQ3RTQTY1L293WHZQOWJE?=
 =?utf-8?B?OHV1b1BrdytPR2Q3dkhuOFJPOGh1d1JjRHRxTlVDdEthQndQKzMwSnJKdmVl?=
 =?utf-8?B?L0VLT1RlQ3R1aUhRUHU2ME8yNTRCb3RNZ052TlpYY09HYWZYSXFpd0RtcEQz?=
 =?utf-8?B?L1hBckV3ZkNPcU9WT0x4R3pTYXFvYTdvMzVMMktMZFpLMHlPbCtEak1OZmlB?=
 =?utf-8?B?b0xIMmRRWnJUbU42MG9VMVdtVjBEUGN6VXhTQnJqTVpmV3lFOG9nNXdTcGpT?=
 =?utf-8?B?VStDWTNVeGw5NlhTZEpYRTZZT09OUldCZ01hSjVMWmVheE9VbEo1cFhPTXZS?=
 =?utf-8?B?RUtUZmFlYktSNkRCNWk0SFh2eGJJa2tqSDF6UUxJZ0FrWE1IaHQ0RHB2UEV0?=
 =?utf-8?B?VFFMbUh2OVBPSUI1dW1GSW5VQjRkSFdaNEMrRWpNTkhrWFA3QTZxQVpDeGNr?=
 =?utf-8?B?bE8xTUxmVmxHcU5BM0YvR2s0OG9DdkpKUHlQdWhuN3pYTW80YkY1YnU5RTJN?=
 =?utf-8?B?TVoxRmdHVHYzRWJIdFVoQkhHeVJXSzkyQmpPV0dVYzQwaVArRk0zRlVuL0sz?=
 =?utf-8?B?djVNRUEzSkVZdjFReUdOODRIeDlKU0d1OFJ2WlRJd2xGL2FJKzk1TU5Na0lZ?=
 =?utf-8?B?VkllTzFEMHcyS3h5QVhqclBDbnhMc0JpR1pLN2ViZDJZeDhCeEZWd3k3cWRV?=
 =?utf-8?B?U0ptaXJaWkJQN2xKQTJaSmFFb1g4eUw4cGM4ZnBMUWFwUjVHckt1bjJ0Nkxi?=
 =?utf-8?B?QUVCWDlkU0NlVFFJbk1sWXZmVEFEdm8wM2JGSlRTa1VmcG13b0xUeURwMnRK?=
 =?utf-8?B?Qnp2WVpOb05NSHBjSitLMXlpV2RrODJHZTJ5WHZ4eHhWNEV3eXpSclJ0NkRy?=
 =?utf-8?B?OWtwT1B4bkxBMDh0UzRoS2hyb1ZTdHg3SEkxNzNVTnRpS3RaNDBtNzVjaFcv?=
 =?utf-8?B?bXF5RVhubHZkblhMT2V2ckpxdG5qRnIyQ1Fmc0ZDWnpHWi9HaUVDdWFwL2Jq?=
 =?utf-8?B?UnRVVUNIWEFSYURrSDhDR2NQTkVocnVYVytObHI4cXRvNXByNHVFdFNlSzJh?=
 =?utf-8?B?bUNhb3VTWDdRcTdaUEpCMmYwSjBDMXIwZXFFNno5QUpRQTF2aFdYQTJ5a1d6?=
 =?utf-8?B?Z3QyWXh5Q2VmSE9GUnllV0l3QnIyZGQvakxrcG0weFFlb1UvZXZlTWs1djdC?=
 =?utf-8?B?TUtLMStFYXlKYk5mb2llTmJKY09McUx1OHk4YTRtRjZ2c0VydDRwZW1aU2FD?=
 =?utf-8?B?UHFvS3JZb1g0b2U5ZGpBWU5hNDRzMm1JSUF4QUp5WUluOGIyZUVielVvVW5U?=
 =?utf-8?B?QWpvVldzMk9qYkY0ci9GNXVGN29XSDRCNW9CSDB5N0todmE5alM0cW9oUnFM?=
 =?utf-8?B?b2lKbWVIeWNQb3lNZGN5RWpCNFNEaFJPQXVBaHZGL2IzTktNeHIxUGc4dzJ3?=
 =?utf-8?B?M3ZUajR5akpBN3lXVWhSWnRtUUo3dXBGQVFQUmY4TUxONzFVa2JEY1duWlRt?=
 =?utf-8?B?SEV1ZzdudDJKMGJ2ZlNSbjBlMmJ3cG9QM0p1TjVtWUxobGRiQnFseG9tZlhr?=
 =?utf-8?B?NUVGcFQrbk8wSTRHclAzSU05b04wbGFNRVNCNVJXTCtNR053NUtWQXBpR3Jw?=
 =?utf-8?B?VFg4VjVORWJOcnJHNjRtTDE0cTBrbnNhVEpvdzJHUE5LSmo4SDBkRVBibXNT?=
 =?utf-8?B?dlBlT2txVWVudkl4dHlweTl1UzlQY1FBa05mOW9OM3NGYVI1dXZld3pZWjE0?=
 =?utf-8?B?UE1hR2tTYkZ0T05hVGJXQ0t2NUE5cFU3RDREMUhqYUdseG9TcEtGbERwVkRw?=
 =?utf-8?Q?2ND9NXwRo0DoQWS6NM5dEIyCfQeSCqjg+PFseK3RGb4H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4009390EA7E2C4E8F20ACE0D6F7EA9E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45179ce-26c6-4bdc-2846-08dc497dcf90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 08:06:28.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tg9rbKnaSeahVkBInAMeXK8X+zKC2EKZrnEi0QSrU5+pGScqbY2Pl7SQCgkHTFkebRVLbZykCQBDdo18K0NJEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_010634_410975_3AD41C4F 
X-CRM114-Status: GOOD (  12.96  )
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

T24gMy8yMC8yMDI0IDI6MTYgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IA0KPiANCj4gT24g
MjAvMDMvMjAyNCAzOjU5LCBoY2hAbHN0LmRlIHdyb3RlOg0KPj4gT24gVHVlLCBNYXIgMTksIDIw
MjQgYXQgMTE6MTk6NTBBTSArMDgwMCwgR3VpeGluIExpdSB3cm90ZToNCj4+PiBJIGFtIGFkZGlu
ZyBhIHBlci1jb250cm9sbGVyIHBlcmNwdS1yZWYgdG8gbnMgdG8gaW1wbGVtZW50DQo+Pj4gcHJl
ZW1wdF9hbmRfYWJvcnQsIHRoZSB2OSB3aWxsIGJlIHNvb24uDQo+PiBEbyB3ZSBuZWVkIHRoYXQ/
wqAgRm9yIGJsay1tcSBiYXNlZCBiYWNrZW5kcyBqdXN0IGRvaW5nIGEgcXVldWUgZnJlZXplDQo+
PiB3b3VsZCBiZSBlbm91Z2guwqAgVGhhdCBkb2Vzbid0IHdvcmsgZm9yIGJpbyBiYXNlZCBkcml2
ZXJzIHlldCwgYnV0IEknZA0KPj4gcmF0aGVyIGltcHJvdmUgdGhlIGJsb2NrIGxheWVyIGZyZWV6
aW5nIGZvciB0aGVtIHJhdGhlciB0aGFuIHJlaW1wbGVudGluZw0KPj4gdGhlIHdob2xlIHRoaW5n
Lg0KPiANCj4gVGhhdCdzIGEgbmVhdCBpZGVhLCB3ZSBhbHNvIGhhdmUgZmlsZSB0byB0aGluayBh
Ym91dCB0aG91Z2guDQoNCkkgZmFpbGVkIHRvIHVuZGVyc3RhbmQgaG93IHRoaXMgd2lsbCB3b3Jr
IGZvciBub24gYmxvY2sgZGV2aWNlDQoocGFzc3RocnUgb3IgYmlvIG1vZGUpIGJhY2tlbmQocyku
IFVubGVzcyB0aGVyZSBpcyBhIHBsYW4gdG8gY3JlYXRlDQpzaW1pbGFyIEFQSSBmb3Igbm9uIGJs
b2NrIGRldmljZSBiYWNraGVuZChzKSBhbmQgaWYgdGhhdCB0dXJucyBvdXQgdG8gYmUNCm92ZXJr
aWxsIHRoZW4gd2h5IG5vdCBnbyB3aXRoIGN1cnJlbnQgcGVyLWNvbnRyb2xsZXIgcGVyY3B1LXJl
ZiA/DQoNCi1jaw0KDQoNCg==

