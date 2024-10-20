Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCBDD3C92E
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9HZTy72Z0RdbiCW5m0tie/HohlJquYpcWrhPkMitHpk=; b=PWMTK3Ob4FgMHz6wAgGFQXe+n9
	7XuDZ5I77h4hLkdC0KdrEf6ub/QWilFfo1aEhapfBXBucrDYDeZBnH+sRWYz+is1EX70LXisy4riz
	DSaCL+qwOdPsoVmGmXfDiZC/hs2W0K9NmHQV1Ac3GQY8QaG/wFOgoqEdsFyEF1HmuMt83+UINNb4i
	4FeieilAK6Wtag5CnynbePvuPleocQWKTiE5W1V8CDnm1pRcYVO70UZClaIdirWJUcKIRRydyP1zJ
	eHGvSDyUJ2x/Ii21sWpaRBmH7NreJDs51bm1xAr0gqcfcjbElhL82SPSnFGb6/Fgw31P/1oGqE2jk
	u99VmQTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2Jko-00000004ADo-03dC;
	Sun, 20 Oct 2024 00:25:06 +0000
Received: from mail-northcentralusazolkn190130003.outbound.protection.outlook.com ([2a01:111:f403:d111::3] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2Jkf-00000004ABX-0Bln
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 00:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4YwQerBqru5+Q8/t7VS0wEa0/2E+ceuu1MtUAMNpnXSIY3yzoAvy9uBcW65Xt0WMSHYjKfDXNz9rO+/4mfhGAr3JVHDeHYNGFw3nzkqEtN1avTcDz2YFCzOzmqZfTKzM+Ut1Mcpiet0i9kzxAbesWwzNq9QgHbnP70Yh2Xr8z0n0jxG07YTxry2/7XzY1mIChQ1pynWH5jqgiLiBZ02WaltnquOiE6Ef5CfQR8/a1lA1ppHstdLIz/KlZ0bVSm/y8peWKQ1yhPf07RrwNNZCMSrv0LqAGFZAyBvlPEeB/170gohCRebeM5svBci46oyOksCc++zE+cW6xNX4+pfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HZTy72Z0RdbiCW5m0tie/HohlJquYpcWrhPkMitHpk=;
 b=e3sIjJNOzWdRHPBgJvQxzGRO5s0x4hf6wNxjdfkzeKKpjJ7XMG8z6CPTaLj5yb2mhEyMPn5qxybsejuhWzhRX8cCwdmM5tv5i4l67IVfLO6vVOb5gIX7QB0p13UeXQp8xU5YgOdkUEn5Rpp2GfRTcyfDT0pp7vVWtfSEVqq+1O0UJ8W8Ba196NEOCeyEhQ4jGtD5bqzL814Woxv1R7xZlt5BuA9vYuN95EtoTNNSfHnbB+yYX2iHxTD0cGflPslbDdcLv+EFehSdL9/sE19KbCxsfbTkNd52V47eZB1AH1Ss++euAYObuCb+YiL4/MKCitXPkwIAkuRxivbNY6Ny3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HZTy72Z0RdbiCW5m0tie/HohlJquYpcWrhPkMitHpk=;
 b=ZusER0yNjnapZ91G8tqMvmAzd0itasii9XRDAyWK1DCzloomNW+pDq52plPYS/HHnJ+CVXMyhCFRe9OiAPt7lJRH/20Ug5FbgudUctRLrWRXfnlKMbz0azQUD1xBS0bk03rwaIl7t66bQ2VRtKw5DgDLh0ADrpgf/6YT1Olkh0dJpRT4fAIrhZlr4TslshjaVmLh37U3SNktl2td0REoZPPFfOWPkVWEaiOQKqwytNXPL5kuEZKepxzi71JCOX6Qo/95k5JRws3ApH5Nb6VhggBQ4dyUS0/rGV+bBT4fxEOJaeqS1otoETQUIKj2MxZNe9E3a7Qe0ZitKruMWQzYVA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7702.namprd02.prod.outlook.com (2603:10b6:510:56::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 00:24:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Sun, 20 Oct 2024
 00:24:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: stuart hayes <stuart.w.hayes@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith
 Busch <kbusch@kernel.org>, David Jeffery <djeffery@redhat.com>, Jeremy
 Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nathan
 Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>, Bert
 Karwatzki <spasswolf@web.de>
Subject: RE: [PATCH v9 0/4] shut down devices asynchronously
Thread-Topic: [PATCH v9 0/4] shut down devices asynchronously
Thread-Index: AQHbGnTLCx/N5yqLpEGGHHPLbQxGQrKA6nvggAr0qtCAAC8KgIAAOUaAgAAGUgCAAPiKgIABjJ8g
Date: Sun, 20 Oct 2024 00:24:32 +0000
Message-ID: <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2024101809-granola-coat-9a1d@gregkh> <ZxInC1U7WiB7FNkJ@wunner.de>
 <2024101808-subscribe-unwrapped-ee3d@gregkh>
 <7ec51cc8-b64f-4956-b4e6-4b67f1a8fa76@gmail.com>
In-Reply-To: <7ec51cc8-b64f-4956-b4e6-4b67f1a8fa76@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7702:EE_
x-ms-office365-filtering-correlation-id: 85541840-ce4e-4ea4-efb8-08dcf09d91a1
x-microsoft-antispam: BCL:0;ARA:14566002|8062599003|8060799006|19110799003|15080799006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: uMylS/X3J2QYjsUbOwglz1ev1lcdnB7C/QTUBOVZ0PIVmXiGHfhxBZuA9JZqw78h8tbG8iu3+1/9UysifZLvip3QUzq8KNfPdYp+xeUUYV/zAMiBEWMbo/bpC37TZOqpN7ufQjXRETaybYPgn7Rc4uf+tPyMG6ri4DhqkiajHsSOCZNgFrVRve+jrUMutw5R4suvI7Nn3gzLCWJCWKKVY6vKR7hTlJ1WwtYWF1wJ3eHbdm9DcSAmsYegADpxSprJLA3XTx50WEccGveimfZspohm6O14DchcihaH+QbYv9WjoHlcLIMa4P2NtgQo+STDj/upMO7QKXb8Ld+yaHqN6E4dQT0/cfdF/vWEIGq9mvybQl4EjXDcQfOvDpNZMZxtQZxO6myML3+w9QQfWAcYo+du/HrlFyEmld01rDa96Op9hJparIKXUkrzkPgg9NFZUR+liDxG21+PHDvOQZ27BaNSVXV7oGcGB348f8bT20X2ZVhR5PJGeqbaytXB176lniaW2Axw4+J+vK+fCikcn1tPRe5Anxx3zknz81Yd8/QD09mn1JMMtWLaDjQ07ylWF3kY59E/ulGWQ67Q5BO8sF6M3vhBSAwEZXRiz89fUCviWLu23jdi7XBv8MMgNCtb3Be4dws1gIqiyJ4swW4sWPPskKXDy8YjAY4dJbqWQo/UWrdedgBX/bqssyjHVFDDmzyPvBqkgykbBObpGqLteA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akhTWk5HR0FxTFoyR2lLQ3FjN0dTWlNUNnlUT3pzeU1KSTB6dEUxTmkwK3dv?=
 =?utf-8?B?akVnMTF2YzNjYWsrRjNTVHU2RFhZRkxlVEdoWHhqVE1EWUNzbGY1WThJVjQ2?=
 =?utf-8?B?alJyL09hRUFTMXVLREVtcWlXYUxLY3BhTzZkV0pUcS9xNFdrTXRCYlNmVWlK?=
 =?utf-8?B?ZmFDZjRaZjVaTzBSU3JzNFJvQ3NOckh5SDlkN0RqRW5xSG5QQVZnK0JhUUxp?=
 =?utf-8?B?RkYyT1p6WUVxQzZpNU53eS9tVDRsQUVwWXc4TnQwSnJhN3BYeFJRWG9TZmpH?=
 =?utf-8?B?cG1GU2lXeUJDRVBUVDc0cWFJSERVYzNLVGNSeUNsR1BrVFB5YU0raGV4cFB5?=
 =?utf-8?B?REZtMXFuNml1SzF4TEppVG9pOE9kWG1JbGE3VWllN3VuSmFzOUFKK0t5NFhq?=
 =?utf-8?B?cllGZExremI2bUtNNXVLaUlaWlR1aEdiTDJ3TlRMaW1iYVhzUzBLc2dWektn?=
 =?utf-8?B?QUhTU2dIMXlrajdHcDB2bDBLc1ZmRU5TZjBaOVQ4a1hUWU03ZHZuSW9kTk42?=
 =?utf-8?B?WnA2NHlTbXdzdkJZYTlQQU1idlNvdVVQTi9GbEVIYzkwN05aUmhNeGVRbWFt?=
 =?utf-8?B?TENSbEJDRm5ZdnpDenM5ZlorUkFBSllKU3V6emdDWkhtaEE0c1VJRzJZSCsv?=
 =?utf-8?B?MHo2cnVQVkxYellKSy9oT0VhZERkZUVLdzgwNTJzVXNpdnVGV3FWSWVpUWRV?=
 =?utf-8?B?aldCbGdCNkl1OFFPOEljSlU0c0RkNXBWbjZ5azd5Q2FTaWxjU1daaTdiY1Nu?=
 =?utf-8?B?cFRmUG0ydm9OdWIzSGhrWGM5dEF1VFZuZmdKWWhFSmJQbzMwZzM2bVVtTGRE?=
 =?utf-8?B?VXFja1BDYmcyd0YxS2dib0M2emwvSWtxYjQ1c1J4WDRZOE5NeXNQVXBwVnBN?=
 =?utf-8?B?SVdXeTR1VmpjVitBeExVNllDN1VvZnB3VTg3aEsrMFFxUlZDOVh2QktoY2pj?=
 =?utf-8?B?a0tBelkvcWQybDYzNXRBaUhXRUNHckkwQmFKMkJyOGE5ZmN3dHJSblRvN2Ux?=
 =?utf-8?B?SjVlZWJxZnJBcTJNQzN2UnF2MmRhL251YWZCeDc2b1BGaTNjalZXN3NmZmNo?=
 =?utf-8?B?czk2Tm5EMzl4OSswcmdtMHJDbEw0UGZBSUVRS1ZwMWNnLytQa0FLdWNsVmp1?=
 =?utf-8?B?Zk11N2ozOW9iWEFBc2VUZHlKM2hzNTA2NEd3S3BqTXJpbjdGdGFBcDVtdlFa?=
 =?utf-8?B?R2JHOGlkdDZhVHJVSWMwcDNCZ3dieFJYNUV6bmlaZStONUhzYlNYNklWaUp4?=
 =?utf-8?B?YmljQVFjZjlCdnRaUUpHbmZrcUZpSGluNEw5cjd3VFA3dW9KYU1zbHRJUGFZ?=
 =?utf-8?B?dXNMUFR6ckdnQk9OYzZ1cFNqc0J5YkJRcDBvblVvTVpKTkRrRWhab2tXeTB6?=
 =?utf-8?B?WVhOTkV0ZWJQQitKUUVmb1RlVnlIUXpHUWVBOWNvVi9XckdyNmVoQjJ1RVlL?=
 =?utf-8?B?NXZGTWg3cExHUkMxNVcrOTBXUjdTWHdtR1Y1VnhHSmRHdlhOMWJaVjdlWEgv?=
 =?utf-8?B?Y3lYNUVNczROajlPSjZDS0FvdytpUGkzdzlOQWtaSWFuaFI3OCtLc0JXWURQ?=
 =?utf-8?B?WFduNEFjZzNoejNWam9hZjhTWjY1NnR5YWFlR09uaVdna1Y2bXloRnRqRzlZ?=
 =?utf-8?Q?4iPnSzVXkmTebn+V7uH4F99pcyy0a/yClgdmpHNzPLCE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 85541840-ce4e-4ea4-efb8-08dcf09d91a1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2024 00:24:32.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7702
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241019_172457_106289_6B47F272 
X-CRM114-Status: GOOD (  38.94  )
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

RnJvbTogc3R1YXJ0IGhheWVzIDxzdHVhcnQudy5oYXllc0BnbWFpbC5jb20+IFNlbnQ6IEZyaWRh
eSwgT2N0b2JlciAxOCwgMjAyNCA1OjI3IFBNDQo+IA0KPiBPbiAxMC8xOC8yMDI0IDQ6MzcgQU0s
IEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBGcmksIE9jdCAxOCwgMjAyNCBhdCAx
MToxNDo1MUFNICswMjAwLCBMdWthcyBXdW5uZXIgd3JvdGU6DQo+ID4+IE9uIEZyaSwgT2N0IDE4
LCAyMDI0IGF0IDA3OjQ5OjUxQU0gKzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4g
Pj4+IE9uIEZyaSwgT2N0IDE4LCAyMDI0IGF0IDAzOjI2OjA1QU0gKzAwMDAsIE1pY2hhZWwgS2Vs
bGV5IHdyb3RlOg0KPiA+Pj4+IEluIHRoZSBwcm9jZXNzLCB0aGUgd29ya3F1ZXVlIGNvZGUgc3Bp
bnMgdXAgYWRkaXRpb25hbCB3b3JrZXIgdGhyZWFkcw0KPiA+Pj4+IHRvIGhhbmRsZSB0aGUgbG9h
ZC4gIE9uIHRoZSBIeXBlci1WIFZNLCAyMTAgdG8gMjMwIG5ldyBrZXJuZWwNCj4gPj4+PiB0aHJl
YWRzIGFyZSBjcmVhdGVkIGR1cmluZyBkZXZpY2Vfc2h1dGRvd24oKSwgZGVwZW5kaW5nIG9uIHRo
ZQ0KPiA+Pj4+IHRpbWluZy4gT24gdGhlIFBpIDUsIDI1MyBhcmUgY3JlYXRlZC4gVGhlIG1heCBm
b3IgdGhpcyB3b3JrcXVldWUgaXMNCj4gPj4+PiBXUV9ERkxfQUNUSVZFICgyNTYpLg0KPiA+PiBb
Li4uXQ0KPiA+Pj4gSSBkb24ndCB0aGluayB3ZSBjYW4gcHV0IHRoaXMgdHlwZSBvZiBsb2FkIG9u
IGFsbCBzeXN0ZW1zIGp1c3QgdG8gaGFuZGxlDQo+ID4+PiBvbmUgc3BlY2lmaWMgdHlwZSBvZiAi
YmFkIiBoYXJkd2FyZSB0aGF0IHRha2VzIGxvbmcgcGVyaW9kcyBvZiB0aW1lIHRvDQo+ID4+PiBz
aHV0ZG93biwgc29ycnkuDQo+ID4+DQo+ID4+IFBhcmFsbGVsaXppbmcgc2h1dGRvd24gbWVhbnMg
c2hvcnRlciByZWJvb3QgdGltZXMsIGxlc3MgZG93bnRpbWUsDQo+ID4+IGxlc3MgY29zdCBmb3Ig
Q1NQcy4NCj4gPg0KPiA+IEZvciBzb21lIHN5c3RlbXMsIHllcywgYnV0IGFzIGhhdmUgYmVlbiBz
ZWVuIGhlcmUsIGl0IGNvbWVzIGF0IHRoZQ0KPiA+IG9mZnNldCBvZiBhIGh1Z2UgQ1BVIGxvYWQg
YXQgc2h1dGRvd24sIHdpdGggc29tZXRpbWVzIGxvbmdlciByZWJvb3QNCj4gPiB0aW1lcy4NCj4g
Pg0KPiA+PiBNb2Rlcm4gc2VydmVycyAoZS5nLiBTaWVycmEgRm9yZXN0IHdpdGggMjg4IGNvcmVz
KSBzaG91bGQgaGFuZGxlDQo+ID4+IHRoaXMgbG9hZCBlYXNpbHkgYW5kIG1heSBzZWUgc2lnbmlm
aWNhbnQgYmVuZWZpdHMgZnJvbSBwYXJhbGxlbGl6YXRpb24uDQo+ID4NCj4gPiAibWF5IHNlZSIs
IGNhbiB5b3UgdGVzdCB0aGlzPw0KPiA+DQo+ID4+IFBlcmhhcHMgYSBzb2x1dGlvbiBpcyB0byBj
YXAgYXN5bmMgc2h1dGRvd24gYmFzZWQgb24gdGhlIG51bWJlciBvZiBjb3JlcywNCj4gPj4gYnV0
IGFsd2F5cyB1c2UgYXN5bmMgZm9yIGNlcnRhaW4gZGV2aWNlIGNsYXNzZXMgKGUuZy4gbnZtZV9z
dWJzeXNfY2xhc3MpPw0KPiA+DQo+ID4gTWF5YmUsIGJ1dCBhcy1pcywgd2UgY2FuJ3QgdGFrZSB0
aGUgY2hhbmdlcyB0aGlzIHdheSwgc29ycnkuICBUaGF0IGlzIGENCj4gPiByZWdyZXNzaW9uIGZy
b20gdGhlIHNpdHVhdGlvbiBvZiB3b3JraW5nIGhhcmR3YXJlIHRoYXQgbWFueSBwZW9wbGUgaGF2
ZS4NCj4gPg0KPiA+IHRoYW5rcywNCj4gPg0KPiA+IGdyZWcgay1oDQo+IA0KPiBUaGFuayB5b3Ug
Ym90aCBmb3IgeW91ciB0aW1lIGFuZCBlZmZvcnQgY29uc2lkZXJpbmcgdGhpcy4gIEl0IGRpZG4n
dA0KPiBvY2N1ciB0byBtZSB0aGF0IGFuIGV4dHJhIGZldyAxMHMgb2YgbWlsbGlzZWNvbmRzIChv
ciBtYXhpbmcgb3V0IHRoZQ0KPiBhc3luYyB3b3JrcXVldWUpIHdvdWxkIGJlIGFuIGlzc3VlLg0K
PiANCj4gVG8gYW5zd2VyIHlvdXIgZWFybGllciBxdWVzdGlvbiAoTWljaGFlbCksIHRoZXJlIHNo
b3VsZG4ndCBiZSBhDQo+IHBvc3NpYmlsaXR5IG9mIGRlYWRsb2NrIHJlZ2FyZGxlc3Mgb2YgdGhl
IG51bWJlciBvZiBkZXZpY2VzLiBXaGlsZSB0aGUNCj4gZGV2aWNlIHNodXRkb3ducyBhcmUgc2No
ZWR1bGVkIG9uIGEgd29ya3F1ZXVlIHJhdGhlciB0aGFuIHJ1biBpbiBhIGxvb3AsDQo+IHRoZXkg
YXJlIHN0aWxsIHNjaGVkdWxlZCBpbiB0aGUgc2FtZSBvcmRlciBhcyB0aGV5IGFyZSB3aXRob3V0
IHRoaXMNCj4gcGF0Y2gsIGFueSBhbnkgZGV2aWNlIHRoYXQgaXMgc2NoZWR1bGVkIGZvciBzaHV0
ZG93biBzaG91bGQgbmV2ZXIgaGF2ZQ0KPiB0byB3YWl0IGZvciBkZXZpY2UgdGhhdCBoYXNuJ3Qg
eWV0IGJlZW4gc2NoZWR1bGVkLiBTbyBldmVuIGlmIG9ubHkgb25lDQo+IGRldmljZSBzaHV0ZG93
biBjb3VsZCBiZSBzY2hlZHVsZWQgYXQgYSB0aW1lLCBpdCBzaG91bGQgc3RpbGwgd29yaw0KPiB3
aXRob3V0IGRlYWRsb2NraW5nLS1pdCBqdXN0IHdvdWxkbid0IGJlIGFibGUgdG8gZG8gc2h1dGRv
d25zIGluIHBhcmFsbGVsLg0KDQpPSyAtLSBtYWtlcyBzZW5zZS4NCg0KPiANCj4gQW5kIEkgYmVs
aWV2ZSB0aGVyZSBpcyBzdGlsbCBhIGJlbmVmaXQgdG8gaGF2aW5nIGFzeW5jIHNodXRkb3duIGVu
YWJsZWQNCj4gZXZlbiB3aXRoIG9uZSBjb3JlLiBUaGUgTlZNZSBzaHV0ZG93bnMgdGhhdCB0YWtl
IGEgd2hpbGUgaW52b2x2ZSB3YWl0aW5nDQo+IGZvciBkcml2ZXMgdG8gZmluaXNoIGNvbW1hbmRz
LCBzbyB0aGV5IGFyZSBtb3N0bHkganVzdCBzbGVlcGluZy4NCj4gV29ya3F1ZXVlcyB3aWxsIHNj
aGVkdWxlIGFub3RoZXIgd29ya2VyIGlmIG9uZSB3b3JrZXIgc2xlZXBzLCBzbyBldmVuIGENCj4g
c2luZ2xlIGNvcmUgc3lzdGVtIHNob3VsZCBiZSBhYmxlIHRvIGdldCBhIG51bWJlciBvZiBOVk1l
IGRyaXZlcyBzdGFydGVkDQo+IG9uIHRoZWlyIHNodXRkb3ducyBpbiBwYXJhbGxlbC4NCg0KWWVz
LCBJIGFncmVlIHRoYXQgYSBzaW5nbGUgY29yZSBzeXN0ZW0gc2hvdWxkIGJlIGFibGUgdG8gZ2V0
IG11bHRpcGxlDQpOVk1lIGRyaXZlcyBzaHV0dGluZyBkb3duIGluIHBhcmFsbGVsLiBUaGUgcGFy
YWxsZWxpc20gd291bGQgYmUNCmdvdmVybmVkIGJ5IHRoZSBudW1iZXIgb2Ygd29ya2VyIHByb2Nl
c3NlcyB0aGF0IHRoZSB3b3JrcXVldWUNCmRlY2lkZXMgYXJlIG5lZWRlZC4gSSBkaWRuJ3QgbG9v
ayBhdCBob3cgaXQgbWFrZXMgdGhhdCBkZWNpc2lvbi4NCg0KPiANCj4gSSdsbCBzZWUgd2hhdCBJ
IGNhbiB0byBkbyBsaW1pdCB0aGUgYW1vdW50IG9mIHN0dWZmIHRoYXQgZ2V0cyBwdXQgb24gdGhl
DQo+IHdvcmtxdWV1ZSwgdGhvdWdoLiAgSSBjYW4gbGlrZWx5IGxpbWl0IGl0IHRvIGp1c3QgdGhl
IGFzeW5jaHJvbm91cw0KPiBkZXZpY2Ugc2h1dGRvd25zIChOVk1lIHNodXRkb3ducyksIHBsdXMg
YW55IGRldmljZXMgdGhhdCBoYXZlIHRvIHdhaXQNCj4gZm9yIHRoZW0gKGkuZS4sIGFueSBkZXZp
Y2VzIG9mIHdoaWNoIHRoZXkgYXJlIGRlcGVuZGVudHMgb3IgY29uc3VtZXJzKS4NCj4gDQoNClll
cywgYmFzZWQgb24gd2hhdCBJIHNhdywgdGhhdCBzaG91bGQgZWxpbWluYXRlIHRoZSBleHRyYSBv
dmVyaGVhZA0Kd2hlbiB0aGVyZSBhcmUgbm8gTlZNZSBkZXZpY2VzLCBvciBvbmx5IGEgc21hbGwg
bnVtYmVyLiBJZiBhIHN5c3RlbSBoYXMNCm9ubHkgYSBjb3VwbGUgb2YgTlZNZSBkZXZpY2VzIChw
bHVzIHNvbWUgZGVwZW5kZW50L2NvbnN1bWVyIGRldmljZXMpLA0KcHV0dGluZyBhIGZldyBlbnRy
aWVzIGluIHRoZSBheXNuYyB3b3JrcXVldWUgc2hvdWxkIGJlIG5lZ2xpZ2libGUuIEFuZCB3aGVu
DQp0aGVyZSBhcmUgbWFueSBOVk1lIGRldmljZXMsIHRoZSBleHRyYSBvdmVyaGVhZCBvZiBtb3Jl
IGtlcm5lbCB0aHJlYWRzDQppcyBtb3JlIHRoYW4gb2Zmc2V0IGJ5IHRoZSBwYXJhbGxlbGlzbS4N
Cg0KTWljaGFlbA0K

