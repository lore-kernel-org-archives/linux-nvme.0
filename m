Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586EC432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:36:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDA861056
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EDA861056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/ysDjSqXuNcfYJJXwRXkqCEQq4dW8oSxHjQc41qVOM=; b=DoRX7+WMaL5B9i
	7DEXMXCmUdn+rrLWY4W8EfZfOMSkxi8ClNgQcxwq7QFeUdpc7DLJgQtszmvS1miRsXeTyJ3Gtwg1X
	be6v/lmqfcPfd1YRtKx3HzBQ+a2htExaH+yFhYkr6DxvWcNqDytfS3eq1jgkPYIMkK6vOeZCgQEup
	+NLWMhISLfyJdkwov1PzzbdBl6bwf+fN8jEpVB5t2fBBplaaOanHIRJtfVpYwzWuN4D4RSdMg2oWf
	+HN68PSuAa4xRu63CpdP/1ZFbVMR6vzDOwNty7cFnsuWK/CRU63MQtu7mAJWlu6P8n8nKKqFcQTBM
	rCs2dQti69GlIk3bQHXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRLe-006G8x-JT; Wed, 01 Sep 2021 14:36:18 +0000
Received: from mail-eopbgr50096.outbound.protection.outlook.com ([40.107.5.96]
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRLV-006G7o-WB
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:36:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHJckhTF4nS2fv7F7ZNkleXLL6DY0T1mvS31lI4A2IGEDEoWO+tdzrvq9Wa9jrruZlTZl3UC2shokKXbK3xwGv6AcpjfUMYz0OZELPYmjF9jMc7dZeoAQnM3er4ENCDS0XAKyySpbSdr54eUYlLHaBtLcA1fNPhnZfcuHIHORm9bFjWkc997ITmsvSpvK7Lfp5zgBOSguDJCNqoYR8jlPow1L5WbY+Bi7SXC8w7uAaYBfIRLUX9D5zLldLoVDl0iQ87wXCBpARDNYlGhSdfnKBtoX97bl8v11nt1sbj/28UT6h18WrcL+Is2HbAGsUYh53m40qizvFqGIfF4KKn9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0KYLiSRY7y9Z+1cze7r5tqGO8Q2bmRwvr7QxtaxfMLY=;
 b=hJwHzcBQEln+DQMPssyGCrV2/Ah8+SBbH7aVIyW/jt1XuP0ZpSK6dsvBlKklEA8POw0MJLZWKtIVEI+jrJwsnhUf+NguOQqgXNv1OJCZ66GVHERgU7chsz2eARaH3sE4HihcPfEwWmjAhmGtBm2WwPuE3W6CpglYJRbGJRGrUuv5JP1vYBrFJXPdF+qfMMBLSuygIZmohnRmA4YsMR8p6fidgpVufBn/3CBMlyFqYJ4o8K4x1SIfP/P54XcOzdB9LrCFjKNOhLP7u39eWn6/nAFylJABy9W3UA4VtvQWNrYBDtMAn1nitQwj0sqM1qyuG/G8OSvlyGTfmJOFF7ou6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KYLiSRY7y9Z+1cze7r5tqGO8Q2bmRwvr7QxtaxfMLY=;
 b=cyF3luluhU6cLMFl+Nppc5qtevyJaqOb9zhpPIQDrZ9ltd3MNAcPFgGdtRAR2fXNsaMM6JUv8HK4wYcJk4gz+OcZKgTlzKb4wMU+j+r/x2ow6RqYcZ4XOrmhIFwE9kRbD+oo7RWDKxg3UrmGrjOTMU4fNAuO64A2h3+yK5FB/5k=
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com (2603:10a6:208:c1::28)
 by AM9PR03MB7396.eurprd03.prod.outlook.com (2603:10a6:20b:26c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 1 Sep
 2021 14:36:04 +0000
Received: from AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::149b:9250:f59:b791]) by AM0PR03MB4211.eurprd03.prod.outlook.com
 ([fe80::149b:9250:f59:b791%5]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 14:36:04 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp crashes the system when overloading the backend device.
Thread-Topic: nvme-tcp crashes the system when overloading the backend device.
Thread-Index: AQHXnmxqX1Auh6AUnUypwfeIAEtsRKuPIrkAgAA/VQA=
Date: Wed, 1 Sep 2021 14:36:03 +0000
Message-ID: <2E0B97E4-8182-4EF5-8D90-DA4998C58295@primelogic.nl>
References: <1A17C9D4-327C-45D6-B7BB-D69AEB169BBD@primelogic.nl>
 <11cd3514-570a-8bf1-55f7-cda6cacc7124@grimberg.me>
In-Reply-To: <11cd3514-570a-8bf1-55f7-cda6cacc7124@grimberg.me>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=primelogic.nl;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45852894-90c0-431c-8ea6-08d96d55d3ac
x-ms-traffictypediagnostic: AM9PR03MB7396:
x-microsoft-antispam-prvs: <AM9PR03MB7396865A0D3B8D18DFE46B12D1CD9@AM9PR03MB7396.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gVexTBgBjb4iFswUvSChco3ZoGYa9zEbtsqGKSNXTEtf7ud3ifDjhzOO2osy4Tf2nfr4w4S5plZiTiLOtmxhYaVuxZiBtQHS9xhO5N22kXq7qmxtqBAevuGT85a6vgqWRjX1L+QW1p+d+TYQ8DqKE4tmjmMKutWaGxNxc1n7kDOtIjJA3jOs7/1K1QBnhj3X+ehnaEMPNrvSZfHUtqiUDZtx19lT6/MdyC0AcdDxzppdqXt5xSVfIxD7XD/njykkNV4GZyildZrMy+TyaXfAbhZAG/l1dfB/bbq/yumpI3xddbbAVdwyI0zZcMqIfhyPFY3emyd6fm+IWKlgea87aiz7UgihwoCuywFzQDHkzSFIwaZNP5NFC7Wb9ImL6PKhhl5LWUnOLftofqL/YPrDFzggQiO5V/Tyr7MmSOSos96wXQmJBY/s75WlYl4Mtf8pc/n1tV1N+Xtlb2fHQbtS9T8BO8JwJXYsdFAH4nrHHd2LKmhMq+RbtE1jkTIp62IEE1fi3SNnp0LjLIc3UA1VNvjKLpbn35GObxY+NFF8yorvLJYgbou+ql31M68Z+JxHUk5GR8VcwVVfhwHpPJT0tBhD9k9mpcZagoZvwH6sz0OWRO0+aCTBVh10IZicp6ILvwH83cDVEFHQSI5qB/9T++92m1+1yXCB0so75Gb4Eh+6Sqab7odc+0CnsWTskYJCTFW9KiRVPLjft3uUNeRuthOPI8UOiRCY+xM7kRSFyQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB4211.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(366004)(39830400003)(346002)(396003)(66946007)(76116006)(6506007)(186003)(122000001)(66446008)(38100700002)(26005)(91956017)(66476007)(66556008)(64756008)(38070700005)(71200400001)(86362001)(5660300002)(83380400001)(36756003)(8676002)(8936002)(6512007)(2616005)(316002)(110136005)(478600001)(2906002)(33656002)(6486002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0ZVUmpacE9obFpxUkhVSXNIa091NzNXS0tCcThpVXdhOEd2THNJNHNQNTFl?=
 =?utf-8?B?bElELzZsS0Z1d2puK0lIa2lPTlMrQWpuRmgyczVDVnNjWThjRmVVNk9VSWpx?=
 =?utf-8?B?RlFFaVhmVTlINVo4ODhWOTRUaUVVV2p0S2VQOHBqYlp3OTFRdElJak5mR2hn?=
 =?utf-8?B?bFFSN2NJZTNkSmVkWGZKYTkvbG04aVVYSXBDU21JcDNhcVJvOHFHMnIwc3dE?=
 =?utf-8?B?c0V6L2xUNCtMaGRtNmJpNWxqczZNQTZtc3M2ZXlGdERuSUNTUEJsT3lZdUZi?=
 =?utf-8?B?N0t4QUNQVjk3NWNxZENvSkVHWEd4MXRDYjAzS2ZnVmhrU1pidXYwL0E5ZWZE?=
 =?utf-8?B?VWkwTEVqajZFZVpPOGJ6aGdMRzZPcVNQcHBnYlJWcHJodUpjUSswQXQ0RmJN?=
 =?utf-8?B?N2dCcTJQM1VBU0ZpK0xqZHRHMjhoQWxoeHdTNDcyeENPejBucG5KR0xQaEhN?=
 =?utf-8?B?WXNoU1lBTzloTC9jOGdCbHZCanJXYlZpM2pOUUgrenJUR3I5L3o5TFpIM0VR?=
 =?utf-8?B?bG9lUFl1WWR5SmZ5TjN6dlFrWG1mbUtwZHluVEYxUWgxK29icjhwK1g1Y2tC?=
 =?utf-8?B?c2ZUSnJxMEhXQ0Y1ZnJ2NVlaWVdCZjBLeTdtS2FjWFVoQ0lpMHNZbXhjVm5I?=
 =?utf-8?B?ZWV6V2E2NnAyOUpEM2dHd1EzMjVlV00rdEptK21SZjVYSmNoQmpjZUJVeVF6?=
 =?utf-8?B?NWZyaGtGTXlkemR0cStFV0l0dkhDeDJVYzltWllhM2RaTG1VQnFFcXEzOHlK?=
 =?utf-8?B?NFpnOGUwWkhuK3UwcFJzakUrSFA2bmZaTlcweFUxSW1wa241Nktlc1Fibkp3?=
 =?utf-8?B?amFDdWVNcllqVWhBK2FsY2dxR1Jadlo2bG1ySmMzZFFQZXJWTVk2U0pUUjIy?=
 =?utf-8?B?THJ3bkljank2OE0xYW9ib3NUbnhRd1pnOTNCb1dDekJlcnNPYlk1MkxlTXpz?=
 =?utf-8?B?QS9CRVBNTlhoZGxPTGpKcGdRcW9mY2ZsSjRSWDI2MkxYeHFDVlFuZnJ1bEFP?=
 =?utf-8?B?K1pBQjhSOUdmZTZ4SXFRU1B6b3pnUFVhTXhtKzg2MEc2QWNtZ3VvMjdSRW5V?=
 =?utf-8?B?bmdLalZwbXQzWktSME91ZkRLajNBRGRiYit6WFJPbjVabm9sRS80Y2wreGkr?=
 =?utf-8?B?U2lrWFk4d2JqNmRSZnU2enJpVlVoM3ZzUDNiTGViQ3VKek02SDJsVDloblEr?=
 =?utf-8?B?dEk1QWE2VUtnWjA1SEV4ckYwNFpod1RKa2hhTUVycW8rQkdtd0NrL25yS0ps?=
 =?utf-8?B?ZFdYRmpNdno4bkxEZzg4Nk1qRE9ZVWg5eWFHaVZubG5kY3FPNDMwODcwSGE1?=
 =?utf-8?B?TTVlQ1RHOVlPSWlqL09LNmNuNDlRbk9LRjA1cXBVZTRNdEhaS0FiN0FMcmEv?=
 =?utf-8?B?elBBdDZiMzd6WEJHT0lXelZ0bnZ1ZlNaRFhXUWd3Rk5rQm5mTUQzSEJrL3Fx?=
 =?utf-8?B?MmZnWlZOYTZvRjBtc3RVM2ozOFY4d3hkZ0xpSXVvL3BsRnliUHRueXZldHBI?=
 =?utf-8?B?czJsdzlwSGp6NGJwYkpuUnNjV0ZkYVpMS3BiM1RWWnNpOFc2cmFBRm9PNkJ4?=
 =?utf-8?B?Q2VIMDFXRWVjSmwvTkNjc1RRTWhBaUx0ekd1cHlybEhyaU5xQXdoT3BxTXU4?=
 =?utf-8?B?Mm5Zdlpobm9vZ0creC9TOXBqbC9FbHpDRzZCQ2lmRDRzRkJrNHMvS2tnSjN3?=
 =?utf-8?B?TmlKUk1FTDhLdFhtRS9FNHFyYnhYRlJtKzU4WjlycGpZdEhOTlpxYTNFOXZO?=
 =?utf-8?Q?5vHb0x3rhoLa1Tiwb6nzFPq3if5TkIqItazF7/c?=
x-ms-exchange-transport-forked: True
Content-ID: <0893A484CBEF16499152CDDF02848D60@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4211.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45852894-90c0-431c-8ea6-08d96d55d3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 14:36:03.8186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoVMcld1pi5E4zvlns8OZIXusPH2pP2i7U98hTFvbtgvCaQckn8pN8RQiYsPqw41qnxjs+X/TGgK9JsO3l8OPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7396
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_073610_148962_24AE8628 
X-CRM114-Status: GOOD (  25.53  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaSwNCg0KSSBjYW4gcmVwcm9kdWNlIHRoaXMgcHJvYmxlbSB3aXRoIGFueSByZWNlbnQg
a2VybmVsLg0KQXQgbGVhc3QgYWxsIHRoZXNlIGtlcm5lbHMgSSB0ZXN0ZWQgc3VmZmVyIGZyb20g
dGhlIHByb2JsZW06IDUuMTAuNDAsIDUuMTAuNTcsIDUuMTQtcmM0IGFzIHdlbGwgYXMgU3VTRSBT
TEVTMTUtU1AyIHdpdGgga2VybmVsIDUuMy4xOC0yNC4zNy1kZWZhdWx0Lg0KT24gdGhlIGluaXRp
YXRvciBJIHVzZSBVYnVudHUgMjAuMDQgTFRTIHdpdGgga2VybmVsIDUuMTAuMC0xMDE5Lg0KDQo+
PklzIGl0IHBvc3NpYmxlIHRvIGNoZWNrIGlmIHRoZSBSNSBkZXZpY2UgaGFzIGluZmxpZ2h0IGNv
bW1hbmRzPyBpZiBub3QgDQp0aGVyZSBpcyBzb21lIHJhY2UgY29uZGl0aW9uIG9yIG1pc2FjY291
bnRpbmcgdGhhdCBwcmV2ZW50cyBhbiBvcmRlcmx5IA0Kc2h1dGRvd24gb2YgdGhlIHF1ZXVlcy4N
Cg0KSSB3aWxsIGRvdWJsZSBjaGVjazsgaG93ZXZlciwgSSBkb24ndCB0aGluayB0aGF0IHRoZSB1
bmRlcmx5aW5nIGRldmljZSBpcyB0aGUgcHJvYmxlbS4NClRoZSBleGFjdCBzYW1lIHRlc3QgcGFz
c2VzIHdpdGggdGhlIG52bWV0LXJkbWEgdGFyZ2V0LiANCkl0IG9ubHkgZmFpbHMgd2l0aCB0aGUg
bnZtZXQtdGNwIHRhcmdldCBkcml2ZXIuDQoNCkF0IGZhciBhcyBJIGNhbiB0ZWxsIEkgZXhoYXVz
dCB0aGUgYnVkZ2V0IGluIG52bWV0X3RjcF9pb193b3JrIGFuZCByZXF1ZXVlOg0KDQoxMjkzICAg
ICAgICAgfSB3aGlsZSAocGVuZGluZyAmJiBvcHMgPCBOVk1FVF9UQ1BfSU9fV09SS19CVURHRVQp
Ow0KMTI5NCANCjEyOTUgICAgICAgICAvKg0KMTI5NiAgICAgICAgICAqIFJlcXVldWUgdGhlIHdv
cmtlciBpZiBpZGxlIGRlYWRsaW5lIHBlcmlvZCBpcyBpbiBwcm9ncmVzcyBvciBhbnkNCjEyOTcg
ICAgICAgICAgKiBvcHMgYWN0aXZpdHkgd2FzIHJlY29yZGVkIGR1cmluZyB0aGUgZG8td2hpbGUg
bG9vcCBhYm92ZS4NCjEyOTggICAgICAgICAgKi8NCjEyOTkgICAgICAgICBpZiAobnZtZXRfdGNw
X2NoZWNrX3F1ZXVlX2RlYWRsaW5lKHF1ZXVlLCBvcHMpIHx8IHBlbmRpbmcpDQoxMzAwICAgICAg
ICAgICAgICAgICBxdWV1ZV93b3JrX29uKHF1ZXVlX2NwdShxdWV1ZSksIG52bWV0X3RjcF93cSwg
JnF1ZXVlLT5pb193b3JrKTsNCg0KSSBhZGRlZCBwcl9pbmZvIHN0YXRlbWVudHMgaW4gdGhlIGNv
ZGUgdG8gZGV0ZXJtaW5lIHdoYXQgaXMgZ29pbmcgb246ICANCjIwMjEtMDktMDFUMDc6MTU6MjYu
OTQ0MDY3LTA2OjAwIGdvbGQga2VybmVsOiBbIDU1MDIuNzg2OTE0XSBudm1ldF90Y3A6IE1BUksg
ZXhoYXVzdGVkIGJ1ZGdldDogcmV0ID0gMCwgb3BzID0gNzENCjIwMjEtMDktMDFUMDc6MTU6MjYu
OTQ0MDcwLTA2OjAwIGdvbGQga2VybmVsOiBbIDU1MDIuNzg3NDU1XSBudm1ldDogY3RybCA0OSBr
ZWVwLWFsaXZlIHRpbWVyICgxNSBzZWNvbmRzKSBleHBpcmVkIQ0KMjAyMS0wOS0wMVQwNzoxNToy
Ni45NDQwNzItMDY6MDAgZ29sZCBrZXJuZWw6IFsgNTUwMi43ODc0NjFdIG52bWV0OiBjdHJsIDQ5
IGZhdGFsIGVycm9yIG9jY3VycmVkIQ0KDQpTaG9ydGx5IGFmdGVyIHRoZSByb3V0aW5lIG52bWV0
X2ZhdGFsX2Vycm9yX2hhbmRsZXIgZ2V0cyB0cmlnZ2VyZWQ6DQpzdGF0aWMgdm9pZCBudm1ldF9m
YXRhbF9lcnJvcl9oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCnsNCiAgICAgICAg
c3RydWN0IG52bWV0X2N0cmwgKmN0cmwgPQ0KICAgICAgICAgICAgICAgICAgICAgICAgY29udGFp
bmVyX29mKHdvcmssIHN0cnVjdCBudm1ldF9jdHJsLCBmYXRhbF9lcnJfd29yayk7DQoNCiAgICAg
ICAgcHJfZXJyKCJjdHJsICVkIGZhdGFsIGVycm9yIG9jY3VycmVkIVxuIiwgY3RybC0+Y250bGlk
KTsNCiAgICAgICAgY3RybC0+b3BzLT5kZWxldGVfY3RybChjdHJsKTsNCn0NCg0KU29tZSBvZiBu
dm1lX3RjcF93cSB3b3JrZXJzIG5vdyBrZWVwIHJ1bm5pbmcgYW5kIHRoZSBudW1iZXIgb2Ygd29y
a2VycyBrZWVwcyBpbmNyZWFzaW5nLg0Kcm9vdCAgICAgIDM2ODYgIDMuMyAgMC4wICAgICAgMCAg
ICAgMCA/ICAgICAgICBJPCAgIDA3OjMxICAgMDoyOSBba3dvcmtlci8xMTowSC1udm1ldF90Y3Bf
d3FdDQpyb290ICAgICAgMzY4OSAxMi4wICAwLjAgICAgICAwICAgICAwID8gICAgICAgIEk8ICAg
MDc6MzEgICAxOjQzIFtrd29ya2VyLzI1OjBILW52bWV0X3RjcF93cV0NCnJvb3QgICAgICAzNjk1
IDEyLjAgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgSTwgICAwNzozMSAgIDE6NDMgW2t3b3Jr
ZXIvNTU6M0gtbnZtZXRfdGNwX3dxXQ0Kcm9vdCAgICAgIDM2OTkgIDUuMCAgMC4wICAgICAgMCAg
ICAgMCA/ICAgICAgICBJPCAgIDA3OjMxICAgMDo0MyBba3dvcmtlci8zODoxSC1udm1ldF90Y3Bf
d3FdDQpyb290ICAgICAgMzcwNCAxMS41ICAwLjAgICAgICAwICAgICAwID8gICAgICAgIEk8ICAg
MDc6MzEgICAxOjM5IFtrd29ya2VyLzIxOjBILW52bWV0X3RjcF93cV0NCnJvb3QgICAgICAzNzA4
IDEyLjEgIDAuMCAgICAgIDAgICAgIDAgPyAgICAgICAgSTwgICAwNzozMSAgIDE6NDQgW2t3b3Jr
ZXIvMzE6MEgtbnZtZXRfdGNwX3dxXQ0KDQoibnZtZXRjbGkgY2xlYXIiIHdpbGwgbm8gbG9uZ2Vy
IHJldHVybiBhZnRlciB0aGlzIGFuZCB3aGVuIHlvdSBrZWVwIHRoZSBpbml0aWF0b3JzIHJ1bm5p
bmcgdGhlIHN5c3RlbSBldmVudHVhbGx5IGNyYXNoZXMuDQoNCi0tTWFyaw0KDQoNCu+7v09uIDAx
LzA5LzIwMjEsIDE0OjQ5LCAiU2FnaSBHcmltYmVyZyIgPHNhZ2lAZ3JpbWJlcmcubWU+IHdyb3Rl
Og0KDQoNCiAgICA+IEhpIGFsbCwNCiAgICA+IA0KICAgID4gSSBjYW4gY29uc2lzdGVudGx5IGNy
YXNoIGEgc3lzdGVtIHdoZW4gSSBzdWZmaWNpZW50bHkgb3ZlcmxvYWQgdGhlIG52bWUtdGNwIHRh
cmdldC4NCiAgICA+IFRoZSBlYXNpZXN0IHdheSB0byByZXByb2R1Y2UgdGhlIHByb2JsZW0gaXMg
YnkgY3JlYXRpbmcgYSByYWlkNS4NCiAgICA+IA0KICAgID4gV2hpbGUgdGhpcyBSNSBpcyByZXN5
bmNpbmcgZXhwb3J0IGl0IHdpdGggdGhlIG52bWV0LXRjcCB0YXJnZXQgZHJpdmVyIGFuZCBzdGFy
dCBhIGhpZ2ggcXVldWUtZGVwdGggNEsgcmFuZG9tIGZpbyB3b3JrbG9hZCBmcm9tIHRoZSBpbml0
aWF0b3IuDQogICAgPiBBdCBzb21lIHBvaW50IHRoZSB0YXJnZXQgc3lzdGVtIHdpbGwgc3RhcnQg
bG9nZ2luZyB0aGVzZSBtZXNzYWdlczoNCiAgICA+IFsgMjg2NS43MjUwNjldIG52bWV0OiBjdHJs
IDIzOCBrZWVwLWFsaXZlIHRpbWVyICgxNSBzZWNvbmRzKSBleHBpcmVkIQ0KICAgID4gWyAyODY1
LjcyNTA3Ml0gbnZtZXQ6IGN0cmwgMjM2IGtlZXAtYWxpdmUgdGltZXIgKDE1IHNlY29uZHMpIGV4
cGlyZWQhDQogICAgPiBbIDI4NjUuNzI1MDc1XSBudm1ldDogY3RybCAyMzggZmF0YWwgZXJyb3Ig
b2NjdXJyZWQhDQogICAgPiBbIDI4NjUuNzI1MDc2XSBudm1ldDogY3RybCAyMzYgZmF0YWwgZXJy
b3Igb2NjdXJyZWQhDQogICAgPiBbIDI4NjUuNzI1MDgwXSBudm1ldDogY3RybCAyMzcga2VlcC1h
bGl2ZSB0aW1lciAoMTUgc2Vjb25kcykgZXhwaXJlZCENCiAgICA+IFsgMjg2NS43MjUwODNdIG52
bWV0OiBjdHJsIDIzNyBmYXRhbCBlcnJvciBvY2N1cnJlZCENCiAgICA+IFsgMjg2NS43MjUwODdd
IG52bWV0OiBjdHJsIDIzNSBrZWVwLWFsaXZlIHRpbWVyICgxNSBzZWNvbmRzKSBleHBpcmVkIQ0K
ICAgID4gWyAyODY1LjcyNTA5NF0gbnZtZXQ6IGN0cmwgMjM1IGZhdGFsIGVycm9yIG9jY3VycmVk
IQ0KDQogICAgVGhpcyBpcyB0aGUgdGFyZ2V0IG5vdCBnZXR0aW5nIGEga2VlcC1hbGl2ZSBjb21t
YW5kcyBmcm9tIHRoZSBpbml0aWF0b3IsIA0KICAgIGhlbmNlIGl0IHRyaWdnZXJzIGEgY29udHJv
bGxlciByZW1vdmFsLiBidHcgd2hhdCBrZXJuZWwgdmVyc2lvbiBpcyB0aGlzPw0KDQogICAgV2hp
bGUgdGhlIHRhcmdldCBpcyB0ZWFyaW5nIGRvd24gdGhlIGNvbnRyb2xsZXIgcXVldWVzLCBhbmQg
d2FpdHMgZm9yDQogICAgYWxsIHRoZSBpbmZsaWdodCBjb21tYW5kcyB0byBjb21wbGV0ZSBhbmQg
ZHJvcCB0aGUgZmluYWwgcmVmZXJlbmNlIG9uDQogICAgdGhlIHF1ZXVlLiBJJ20gd2FuZGVyaW5n
IGlmIHNvbWV0aGluZyBpcyBwcmV2ZW50aW5nIHRoZXNlIGluZmxpZ2h0DQogICAgY29tbWFuZHMg
ZnJvbSBnZXR0aW5nIGNvbXBsZXRlZCBieSB0aGUgYmFja2VuZCBSNSBkZXZpY2UuDQoNCiAgICA+
IA0KICAgID4gRXZlbiB3aGVuIHlvdSBzdG9wIGFsbCBJTyBmcm9tIHRoZSBpbml0aWF0b3Igc29t
ZSBvZiB0aGUgbnZtZXRfdGNwX3dxIHdvcmtlcnMgd2lsbCBrZWVwIHJ1bm5pbmcgZm9yZXZlci4N
Cg0KICAgIFRoYXQgaXMgYmVjYXVzZSB0aGUgdGFyZ2V0IGlzIHdhaXRpbmcgZm9yIHRoZSBjb21t
YW5kcyB0byBjb21wbGV0ZSwgYnV0IA0KICAgIHRoZXkgZG9uJ3QuDQoNCiAgICA+IEV2ZW50dWFs
bHkgdGhlIHN5c3RlbSBydW5zIG91dCBvZiByZXNvdXJjZXMuDQogICAgPiBBdCBzb21lIHBvaW50
IHRoZSBzeXN0ZW0gd2lsbCByZWFjaCBhIHdvcmtsb2FkIG9mIDIwMDArIGFuZCBjcmFzaC4NCiAg
ICA+IA0KICAgID4gU28gZmFyLCBJIGhhdmUgYmVlbiB1bmFibGUgdG8gZGV0ZXJtaW5lIHdoeSB0
aGUgbnVtYmVyIG9mIG52bWV0X3RjcF93cSBrZWVwcyBpbmNyZWFzaW5nLg0KICAgID4gSXQgbXVz
dCBiZSBiZWNhdXNlIHRoZSBjdXJyZW50IGZhaWxlZCB3b3JrZXIgZ2V0cyByZXBsYWNlZCBieSBh
IG5ldyB3b3JrZXIgd2l0aG91dCB0aGUgb2xkIGJlaW5nIHRlcm1pbmF0ZWQuDQoNCiAgICBJcyBp
dCBwb3NzaWJsZSB0byBjaGVjayBpZiB0aGUgUjUgZGV2aWNlIGhhcyBpbmZsaWdodCBjb21tYW5k
cz8gaWYgbm90IA0KICAgIHRoZXJlIGlzIHNvbWUgcmFjZSBjb25kaXRpb24gb3IgbWlzYWNjb3Vu
dGluZyB0aGF0IHByZXZlbnRzIGFuIG9yZGVybHkgDQogICAgc2h1dGRvd24gb2YgdGhlIHF1ZXVl
cy4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
