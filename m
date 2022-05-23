Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8762C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCjlksj/AQexZOu6cir3yryW4tzD4e9Vj9Hc/GPBQoQ=; b=JLX8VpqK0LYeq18DwQ65N9aeX4
	j25Zbkp9LuJuGoJwQ9E6KbUw4XJoWhDcjhzSyH5JQU4lXp1an4YHvTG2888XafOMnJ5RKf9sXBrXa
	q9FAds5bDBEjdcknEhOeQx4rp8x8fcNhnLkzNFftAZ6+xms7vJ0qx2l/rIfkg6Yhwc+dBvj3Z7KZT
	ZPcmXqjmtFCxKHRk1IACBgdPW2K2gOPN3OgujC+X9KkZawNwCuHzTnB7f0+Azmlt7t2ksiVBUARuU
	XTPY4qOivMQt3oMzugxnMDHR8NeKeMbrzLeV2SXMduJfxP0qeNrk3htcqLLiTK7UEW5ysd4BnYtv5
	Q3SSr/Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntCsP-005Yix-Fv; Mon, 23 May 2022 18:33:57 +0000
Received: from mail-am5eur02olkn080e.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::80e]
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntCsN-005Yia-9m
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 18:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkuiYGchoAIKfQ9suefkxlH+HcBZoHqtsA8wQhlW5xfL1xga8fsxe+gdLwltW3JWPdDOEXxR41TtzkzUVTOM3b6ZQKyPRjZ9xuu8yxvuEhGKAa+d+0WiKFFU/R8PrRaSmJa2/jrYpJh2Rs5TTp3R6BKTmsjnGkgJfvhtY6XSdmM85CPPaBe7mXObmshngMgx52PhkzyYOeKZYF1DY76V/N1AJTkfRvO7QmFKg21uHn2awY6MUYHQ0mQgR05M1kRqn0Sw4cakH5K1AZC3YY19hMN2sSsm3frP1kOKZAdHwGciOHo9M3zVWuEeaUmI0ggdqyMkDEl4s6VlJzcCEGquAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCjlksj/AQexZOu6cir3yryW4tzD4e9Vj9Hc/GPBQoQ=;
 b=el+9eIUT4BeHRAH4MlI4k+KZ3r4bFZzn0Ia2SHZwxwAB1cHeQSRJYWpOubnWWKivNrcfufxZ52Im7dqeROWqXJ9vCgj4RXugjOKqJgfE+IKL80aFWWewN3CCeGOSESHbfTWH/TKxQm8C+65PlFsBXwQEBAf07aUNzeJO1NyDYeZWt6DrmIK4/J/V0+j0Qh88vGbGfzZr5uuWh5jvfFZU+DZk/fFL/dAxk9F7tm4KjRqRM9ZfdCX7H640bUrMYNGf13Cy8dOtYlrsDxunmj/gh44ieKIVkNRC5OnjW3drJAW01/M12cLNTT+LyCF5HXe51M5g8yaq+Q3k6tLSgYbf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCjlksj/AQexZOu6cir3yryW4tzD4e9Vj9Hc/GPBQoQ=;
 b=BxCzmOX0MjbSRXW/vQ9whfLl8NK+Jfa8/nLpOcCmyE7GvFvt7A7Q6HUWQjFHxP7iV4eixeLoB7kAbdZKPlJjKOiz3mXP21iD3vUC/I+7NV/VF8fNwzYqqP+2nhQ862il1hjCAoaNFPn/w2w5OSHrYpwnt/xZ7tb7/Biz+sE5MGLHG/5rXH/2IBtIOxPsDXNkq0Q7ruP9kUgTj1ppvLpqHy/XuRld38zDs7YYUEcQFiUl8w6GCaW0emRhwnv4bfm8kj1gEy6x8eX7Swidz8IFFHmkVZtT5d/3QWlvoShn+gbn3M2At0lAO6FPU74mIoeSyGtD+C5ZT2BGyckxQ39O2A==
Received: from AS8P194MB1206.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3ca::17)
 by DB9P194MB1468.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Mon, 23 May
 2022 18:18:01 +0000
Received: from AS8P194MB1206.EURP194.PROD.OUTLOOK.COM
 ([fe80::f501:f36:31a7:50ee]) by AS8P194MB1206.EURP194.PROD.OUTLOOK.COM
 ([fe80::f501:f36:31a7:50ee%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 18:18:01 +0000
From: Arman Hajishafieha <arman.hajishafieha@hotmail.com>
To: "hch@lst.de" <hch@lst.de>, "me@kingtous.cn" <me@kingtous.cn>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "kingtous@qq.com"
 <kingtous@qq.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Thread-Topic: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Thread-Index: AQHYTirR2pPWU50/A02wBa1FG8gaG60tBogA
Date: Mon, 23 May 2022 18:18:01 +0000
Message-ID: <741c80abb8a443c4745f213e9ecd413f6a6a7467.camel@hotmail.com>
References: <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
 <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
 <20220412050441.GA5311@lst.de>
In-Reply-To: <20220412050441.GA5311@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [EO1cx5Ksj7OG/zuHPp/6mEVa2edML43CMJiizsUtLEuv/sNv/btOpQ==]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65326457-c248-4c24-4853-08da3ce8928f
x-ms-traffictypediagnostic: DB9P194MB1468:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLmv57JQ4n9/ChA5dS/TtS/m4x05PlmowhRkan+gn2lpHDp7jHi9ot6rEqOcS3VmjeMSkA+IhPgfFOaN2snqW+Akxi62cPMFo/1ztyILpI04WiMQc3LWu+dTs0s8OwK3wOc88EMGUvTtlMPv/lawysR+3eKN1+OFqc0JrBX+mQQmzFTT0MtnuPJ7m2jK/83VEmMT1iIv45igEGXb3WMwMh3VIQATSEozR1gh08S0U3cl4corn7k1V0kjlZTfT+y1K4Mf+2Jzv7xgvCDZlzU94bIJ+NVBbadqNqbnnuT3/I2F+r6QkDQTFqdhJI+AX/TVWVY/ezDYDnEZbuT2Xgom3h9Nf6OfVS0WcrH/Tkklg4rzGTI8BL4ywwauQGX+gR+MwPdIfA37XmJ38/6wFJwvZ7/+NleEOjIuesBzn9wVdy1A6iiGxkZFB7t5lS//+JVmM2JHcBE5ieXE2X2MlKGBrJ5XqiJMXLJYet6sw1cIeDcn92GJDsFw1eMYSOmjS7Oc+NB74WljpXlgsLt3YiLQl18nBNWbJHY2snHvPhLh6c2abO8i0F2L+JKc78y6BYVRxzAkWQn1w/bu2WoRwyW3Jg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emhnUFJqRkNPb0s0THBPcXNrY3VDS2JHakQrUVI5S1cyN21RUlNwOHVIM1A2?=
 =?utf-8?B?S0tVeFBzRkxiVWdQVDZ3SHpzcllIZmJod0x0OUU1NXFNUlVnTG4xdG0ycDE5?=
 =?utf-8?B?RzNSaEs0UGdMdGFEdHNyVmUvU3d1dG13aW1xaHE5dG8xZHd1cXd5STNlMVBm?=
 =?utf-8?B?SUYyeXdXSXQxaGk3RmlwZzJjdU9QL2JSWFJGRDBlbmdWNGtIQlZlY2Uycmpn?=
 =?utf-8?B?VldYOUxhYnBJb21Ca0p2VGcrOWh6TDBGSjNmNHpkWU9CVHVQWWRLMXg5QU13?=
 =?utf-8?B?TnVGbk9sYXh4Y1h1R3duQUdkWDgzUktKSGVhbWxUM1FDZkdxUjNZcjNHODVp?=
 =?utf-8?B?czZudld6RytZaWNnV0xWcjd4Nis0dVdBdmV4MUsvS1lTeHVxTXJrS1dqNEl3?=
 =?utf-8?B?cTh6cDZDOHB5cFZIVHF6QWdwencwano0OWlBV05tRHhwMzZyWWhmd1FQSUdv?=
 =?utf-8?B?VWt1dU0wekY1WkNzTmNxWTFOYTE4bGtyNTU4UnBDeERLQjF6bXFnOGdXS3k4?=
 =?utf-8?B?K1M0OE5Tc0QwVURnS2FJdWc0aElBNzk0QkVhbnA4dUlHMEx6cnF6b3pJaFlS?=
 =?utf-8?B?dHZpZ2FkWC84Q0J2QmNIQnJjOFRya3VBMTkwRzFSS2hQZHFKRHdWeHM2Mmla?=
 =?utf-8?B?UXg1azN4ajRac3RJdkZZU2FMYlZsblg0Zi8xQzUvZ1RUemJkODBPNFRrTmhk?=
 =?utf-8?B?SlcyZ3hwTGw1dWpsLzZmcTNXMXMvM3pPbUErYU1kbWwrbWJ3N0RRYzVaRTY1?=
 =?utf-8?B?blk0V04rblAyMHhqM1dVcVNVQmpEM3MzelVydVZRMW81QjBTWUk1cThsbGwz?=
 =?utf-8?B?TFRhUnZjOE1mTFBJQ2VtM0ZFcmNhajl1bWszYTVEcEZLaFpkRCtrUk9TOVhO?=
 =?utf-8?B?bm9acVNTRjdHY0Zuc3I3WEZtZzRZSjg0eldzRG5YQXhMdThPSjRCQWxIT1pC?=
 =?utf-8?B?eGh5S0VSNUdyRzlVK2hzOW9rRWliQWZKOXJRQlNoOEowT1N2Q0ZvUXA5Z1NB?=
 =?utf-8?B?bkRVZGtmeE4ydzZjT1NtcVhZRkJkSW1pMG5TZHc0TGtZRUpDbmpEZCtodUtx?=
 =?utf-8?B?a1pUbUcxUjFhbVUvTnhzN29BdUlmWXZFdGNzd09WL1lzTG5XdHhNdndjbDNH?=
 =?utf-8?B?THNmcEk0cGw0RkV0ME45VG9HOXI0U1REakcwck1kS2NockxKWmNTZnFIMklr?=
 =?utf-8?B?Vnl5RUdNdTErdHFkM3pPSGFPY0pmQU1pYW5HaUlXekxWbkNHVzVCaXlhTm96?=
 =?utf-8?B?NGtiSnVlRi9mZFNpZFh3Q05TcWROR0svTUlIS2lqWlhRaVVxTUdyNTdjbFoy?=
 =?utf-8?B?cTRrNTBybkxYNFVjU1RrcC9Jdk80dEtEOUxGQXA2bGxHcE5LQlFVd2IxWlhu?=
 =?utf-8?B?RFlLNjdoaXJlZ3o0THM1RGxOVE1RTjFWL1RROXlRVUZ4b3NaOXJOaDZjcE5l?=
 =?utf-8?B?MHZBTjlhWFhKbXdhdE9Bd3M0cUpqaXlqejlOWXNOa3I0MDlwRThrSEZ2V1Zz?=
 =?utf-8?B?NC9KVlJMMVBxaEgzekhrRTh6Rjl6YXJSMzl4U1BWdUVOUHBDUFAvVnJ6Z1BB?=
 =?utf-8?B?ZG42OTVRejNJaUNOMU4xUTEyd2VCM0NlOWV0UzNBRXorSzlLc05lZ3QrcE1n?=
 =?utf-8?B?WFVhTmYvdTRSWU5rYmF1UlNocHdaU01IWXJQWEp2VHdrbzBuVUNLQ3JNVkRo?=
 =?utf-8?B?ZTlEVWt1NE1lT0VXb1FLL0xpNjBSK1k1WXRSc1NyTkhwb1kzTkxCc0QxK0g5?=
 =?utf-8?B?VCt1TGtvbkpXWFlYOVROOW53a0hyYS9RbFova2dDdUdRUDlJL1hUUFl4MlZu?=
 =?utf-8?B?Y2xrMVIraTJmNERMZ0Znc3NLQnQ4YWloMU5hWTFick4yb04vVlVCSFRsZXRk?=
 =?utf-8?B?eVBVN0UxTUVUeEE0T2Y3d3ZjN05OMHp1aGxJQnBTYkZ2a1FvQm5JUnRDQlZn?=
 =?utf-8?B?YnN4K2FtQ28xYXlETGRVeEtwS05CNE1OSzUvbVNLMHdCdXdEYVR5cE9oQzNa?=
 =?utf-8?Q?C+tEbkdCiIssXnZnhcqbNTLUUHHPEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AB5DE96D8E3A340B2D49E25D28594BC@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-84264.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P194MB1206.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 65326457-c248-4c24-4853-08da3ce8928f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 18:18:01.4664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P194MB1468
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_113355_377756_7EB8D414 
X-CRM114-Status: GOOD (  18.54  )
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

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDA3OjA0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgMTA6MjA6MTNQTSArMDgwMCwg6YeR6Z+sIHdy
b3RlOg0KPiA+IGJ0dywgSSBjaGVja2VkIHRoZSBwYXRjaCBjb2RlLCBJIG5vdGljZWQgIk1BWElP
IE1BUDEyMDIiIGlzIGhhcmQNCj4gPiBjb2RlZCBpbiANCj4gPiBwY2kuYy4gSSB0aGluayBub3Qg
b25seSBNQVAxMjAyIGhhcyB0aGUgcHJvYmxlbSBtZW50aW9uZWQgaW4gdGhpcw0KPiA+IHRocmVh
ZCwgDQo+ID4gYnV0IGFsc28gIk1BWElPIE1BUDEwMDIiKEdsb3dheSBCYXNpYyAxVCBOVk1lIFNT
RCwgd2hpY2ggaGFzIHRoZQ0KPiA+IHNhbWUgDQo+ID4gc3VzcGVuZCBpc3N1ZSkuDQo+IA0KPiBJ
ZiB5b3UgY2FuIHZlcmlmeSBpdCBoYXMgdGhlIGlzc3VlIHdlIGNhbiBhZGQgYSBxdWlyayBmb3Ig
aXQgYXMgd2VsbC4NCg0KSGVsbG8uDQoNCkkgY2FuIGNvbmZpcm0gdGhhdCAiTUFYSU8gTUFQMTAw
MSIgKDFlNGI6MTAwMSkgY29udHJvbGxlciBmb3VuZCBpbg0KIkFzZ2FyZCBOMiAxVEIgU1NEIiBz
dWZmZXJzIGZyb20gdGhlIGV4YWN0IHNhbWUgaXNzdWUgYXMgd2VsbC4NCkFmdGVyIGFwcGx5aW5n
IHRoZSBwYXRjaCB0byBkaXNhYmxlIGNoZWNraW5nIG5hbWVzcGFjZSBpZGVudGlmaWVycyBpdA0K
Y2FuIHJlc3VtZSBmcm9tIHN1c3BlbmQgbm9ybWFsbHkuIEl0IHNlZW1zIGxpa2UgdGhpcyBpc3N1
ZSBhZmZlY3RzIGENCndpZGVyIHJhbmdlIG9mIE1heGlvIGNvbnRyb2xsZXJzLg0KQ291bGQgeW91
IHBsZWFzZSBhZGQgYSBxdWlyayBmb3IgdGhpcyBkZXZpY2UgYXMgd2VsbD8NCg==

