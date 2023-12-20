Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1103C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 06:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Eg4UvCJNj9VsncgziHOjF0m0lVn3HOBsKWV7NCr1LMY=; b=Xwbtqf/QyuNANNWCcSQK9g9aBT
	7z+iGZaxkaOym1/NdYkjOQVPKNt/QaWrB9uVAX4Zh4RvurDZnaZtFTKmp6RUKKlHJjoLM5QE5q8Rr
	cgwigc46u9GBnz2KMJhv3d9aqZxaQO4xGsvZTtlQD+V5bYEEIvio7qGTdJZ8l6Ch2hvEjakovVmbX
	yhFY1haNBhtFF7G1UXy78hOPsUSZObJiIDoxBoUIqERLmPBLPn29bzPPG/nDMuOAzXnSw20VIq7R7
	fg+t9iTHJJSpaBdhBTX0Rp8rP5EJGaF0YdYhF4S6lAHCgdaCcW9Zae2SrnbPE4AoTUz+IK6kcZR3z
	5Xd+Gmnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFphX-00GGDU-1f;
	Wed, 20 Dec 2023 06:05:03 +0000
Received: from exvmail4.skhynix.com ([166.125.252.92] helo=invmail4.hynix.com)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFphP-00GG5X-31
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 06:05:00 +0000
X-AuditID: a67dfc5b-d6dff70000001748-9d-658283f861a7
Received: from hymail23.hynixad.com (10.156.135.53) by hymail14.hynixad.com
 (10.156.135.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.42; Wed, 20 Dec
 2023 15:04:40 +0900
Received: from hymail23.hynixad.com ([10.156.135.53]) by hymail23.hynixad.com
 ([10.156.135.53]) with mapi id 15.02.0986.042; Wed, 20 Dec 2023 15:04:34
 +0900
From: "hardaway.tseng@sk.com" <hardaway.tseng@sk.com>
To: Keith Busch <kbusch@kernel.org>, =?utf-8?B?SmltIExpbiDmnpflv5fono0=?=
	<jim.lin@siliconmotion.com>, =?utf-8?B?RGF2aWQgWWVoIOiRieWvsOiejQ==?=
	<david.yeh@siliconmotion.com>
CC: Jim.Lin <jim.chihjung.lin@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q0ogQ2hlbiDpmbPnvqTlgpE=?= <cj.chen@siliconmotion.com>,
	"sangan.han@sk.com" <sangan.han@sk.com>, "ives.lu@sk.com" <ives.lu@sk.com>
Subject: RE: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Thread-Topic: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Thread-Index: AQHaIabItSYv0AoU6E61/0TaLKTrOLCOdLOAgAHxkXD//3BOAIAAn7AggCFT0YA=
Date: Wed, 20 Dec 2023 06:04:34 +0000
Message-ID: <d468b3530c2442fcadd89b5b3bcc665d@sk.com>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
 <SEYPR01MB4341EFAA7D4B563BFF903B45FDBCA@SEYPR01MB4341.apcprd01.prod.exchangelabs.com>
 <71aae1b4cb0441d0940a5e536f4ffce0@sk.com>
 <ZWaBULOgInxbp6JQ@kbusch-mbp.dhcp.thefacebook.com> 
Accept-Language: zh-TW, en-US, ko-KR
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.8.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnoe6P5qZUg02LJS1W3+1ns/jxZy+L
	xZedl9ksVq4+ymRx+eIqFosr93+zWkw6dI3RYv6yp+wW616/Z3Hg9Ng56y67x/l7G1k8Lp8t
	9di0qpPNY/OSeo/dNxvYPJ7ff8oWwB7FZZOSmpNZllqkb5fAldG1+xVrwQOdiu7tz1kaGM9o
	dzFyckgImEhcPvybBcQWEnjNKPHqoUIXIxeQvYBRYtHRGUwgCTYBU4mOzc9YQBIiAhsZJSYe
	+MAOkmAWWMkssaKnDMQWFnCT+HniNyOILSLgLtH4to0ZwvaTmLl8DdAgDg4WAVWJ5x+4QUxe
	oJmX1rlD7PrBKPHsQBfYSEYBFYn3h58zQowXlzh3sZUd4lABiSV7zjND2KISLx//Y4WwFSRe
	vNoKNp5ZQFNi/S59iFZFiSndD8FaeQUEJU7OfMICUS4pcXDFDZYJjKKzkGyYhdA9C0n3LCTd
	CxhZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIERuSy2j/ROxg/XQg+xCjAwajEw3ugtTFViDWx
	rLgy9xCjBAezkgivy6L6VCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtS
	i2CyTBycUg2MAdNkX85dPkUh+23q3aikGdfOaD4+dodblu2046SHfvdYZlmwPd1QasgceH5W
	pTHnMX311u/G9mF/l8gkH76Uf3n3Br+L+2bFSL/0Pd1y4/e5HR2Ppmcs+mB59kuy3KLgngSu
	88e9A14G775c8TvtpWNpX4nb6tisgK1RmUu4ltXM5lLwahHbp8RSnJFoqMVcVJwIACIApQ7E
	AgAA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_220456_102964_0ACF80F1 
X-CRM114-Status: GOOD (  15.04  )
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

SGkgS2VpdGgsDQoNCkhvcGUgZXZlcnl0aGluZyB5b3UgYXJlIGRvaW5nIGlzIHdlbGwhDQoNClRo
ZXNlIGRheXMgb3VyIHRlYW1zIHRyaWVkIHNldmVyYWwgd2F5IHRvIGRvIGZ1cnRoZXIgdmVyaWZp
Y2F0aW9uIG9mIHRoaXMgZGlzYWJsZSB3cml0ZSB6ZXJvIHBhdGNoIGZvciBCQzkwMSwgbGV0IG1l
IHN1bW1hcml6ZSBhcyBiZWxvdyA6DQoNCjEpCVRoZSBjaHJvbWUgaW1hZ2Ugd2l0aCB0aGlzIG5l
dyB3cml0ZSB6ZXJvIGRpc2FibGUgY29kZSBidWlsdCB3aXRoIDUuMTUsIGhhcyBiZWVuIHZlcmlm
aWVkIGFuZCBwYXNzZWQgKDwgMjBtaW4gbW9kZSBzd2l0Y2hpbmcgdGltZSkNCjIpCUR1ZSB0byBz
b21lIGxpbWl0YXRpb25zLCBHb29nbGUgdGVhbSBjb3VsZG4ndCBidWlsZCBhIG5ldyBjaHJvbWUg
aW1hZ2Ugd2l0aCB0aGUgc3VnZ2VzdGVkIDYuNSBvciBsYXRlciB2ZXJzaW9uICsgdGhpcyBkaXNh
YmxlIHdyaXRlIHplcm8gcGF0Y2ggZm9yIHZlcmlmaWNhdGlvbiB0ZXN0Lg0KMykJVHJpZWQgdG8g
YnVpbGQgaW1hZ2Ugd2l0aCA1LjE1ICsgZGlzYWJsZSB3cml0ZSB6ZXJvIHBhdGNoICsgREVBQyBt
ZXJnZWQsIHN5c3RlbSBjYW4gcnVuIGJ1dCB0aGUgdGVzdGluZyByZXN1bHQgaXMgZmFpbGVkICg+
IDIwbWluIG1vZGUgc3dpdGNoaW5nLCBhY3R1YWxseSAyN34yOW1pbnMpLg0KDQpBYm92ZSBpcyBh
bGwgd2UgY291bGQgZG8gaGVyZSBmb3IgdGhlIHZlcmlmaWNhdGlvbiBvZiB0aGlzIHBhdGNoLCBj
b3VsZCB5b3Ugc2hhcmUgdXMgeW91ciBjb21tZW50IG9yIHN1Z2dlc3Rpb24/DQoNClRoYW5rIHlv
dSBzbyBtdWNoIQ0KDQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpIYXJkYXdheS4NCg0KDQpIYXJkYXdh
eSBUc2VuZy8gU3IuIE1hbmFnZXIgfCBTTi1GQVFFIHwgU0sgaHluaXggU2VtaWNvbmR1Y3RvciBU
YWl3YW4NCkFkZHJlc3M6IDEwRi4gTm8uIDMwOCwgWmhpZnUgUmQuLCBaaG9uZ3NoYW4gRGlzdC4s
IFRhaXBlaSBDaXR5IDEwNDY2LCBUYWl3YW4NCk9mZmljZSA6ICs4ODYtMi0zNTE4LTIzMTMvIEZh
eDogKzg4Ni0yLTM1MTgtMjM2Ni8gTW9iaWxlOiArODg2LTkxOS04MDMtNDU4DQpFbWFpbDogaGFy
ZGF3YXkudHNlbmdAc2suY29tDQoNClNLIGh5bml4IENvbmZpZGVudGlhbA0K4oCcVGhpcyBlLW1h
aWwgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZC9vciBwcml2aWxlZ2VkIGluZm9ybWF0aW9u
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KG9yIGhhdmUgcmVjZWl2ZWQg
dGhpcyBlLW1haWwgaW4gZXJyb3IpLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRlc3Ryb3kgdGhpcyBlLW1haWwuIEFueSB1bmF1dGhvcml6ZWQgY29weWluZywgZGlz
Y2xvc3VyZSBvciBkaXN0cmlidXRpb24gb2YgdGhlIG1hdGVyaWFsIGluIHRoaXMgZS1tYWlsIGlz
IHN0cmljdGx5IGZvcmJpZGRlbi7igJ0NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogSGFyZGF3YXkgKFNoaWggSHVuZykgVHNlbmcgU0tIWVQgDQpTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDI5LCAyMDIzIDExOjUxIEFNDQpUbzogJ0tlaXRoIEJ1c2NoJyA8a2J1c2NoQGtl
cm5lbC5vcmc+OyBKaW0gTGluIOael+W/l+iejSA8amltLmxpbkBzaWxpY29ubW90aW9uLmNvbT47
IERhdmlkIFllaCDokYnlr7Dono0gPGRhdmlkLnllaEBzaWxpY29ubW90aW9uLmNvbT4NCkNjOiBK
aW0uTGluIDxqaW0uY2hpaGp1bmcubGluQGdtYWlsLmNvbT47IGF4Ym9lQGtlcm5lbC5kazsgaGNo
QGxzdC5kZTsgc2FnaUBncmltYmVyZy5tZTsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBDSiBDaGVuIOmZs+e+pOWCkSA8Y2ouY2hl
bkBzaWxpY29ubW90aW9uLmNvbT47IO2VnOyDgeyViChIQU4gU0FOR0FOKSDrjIDrp4zrspXsnbgg
PHNhbmdhbi5oYW5Ac2suY29tPjsgSXZlcyhIc3VlaCBIc2llbikgTHUgU0tIWVQgPGl2ZXMubHVA
c2suY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gbnZtZS1wY2k6IGRpc2FibGUgd3JpdGUgemVy
b2VzIGZvciBTSyBIeW5peCBCQzkwMQ0KDQpIaSBLZWl0aCwNCg0KVGhhbmtzIGZvciBoZWFkIHVw
IENocmlzdG9waCdzIHF1ZXN0aW9ucyENCk91ciB0ZWFtIHdpbGwgaGVscCB1cyB0byBhbnN3ZXIg
dGhlbS4NCg0KSGkgSmltIGFuZCBEYXZpZCwNClRoYW5rcyBmb3IgeW91ciBzdXBwb3J0IQ0KDQoN
ClRoYW5rcyAmIFJlZ2FyZHMsDQpIYXJkYXdheS4NCg0KDQpIYXJkYXdheSBUc2VuZy8gU3IuIE1h
bmFnZXIgfCBTTi1GQVFFIHwgU0sgaHluaXggU2VtaWNvbmR1Y3RvciBUYWl3YW4NCkFkZHJlc3M6
IDEwRi4gTm8uIDMwOCwgWmhpZnUgUmQuLCBaaG9uZ3NoYW4gRGlzdC4sIFRhaXBlaSBDaXR5IDEw
NDY2LCBUYWl3YW4gT2ZmaWNlIDogKzg4Ni0yLTM1MTgtMjMxMy8gRmF4OiArODg2LTItMzUxOC0y
MzY2LyBNb2JpbGU6ICs4ODYtOTE5LTgwMy00NTgNCkVtYWlsOiBoYXJkYXdheS50c2VuZ0Bzay5j
b20NCg0KU0sgaHluaXggQ29uZmlkZW50aWFsDQrigJxUaGlzIGUtbWFpbCBtYXkgY29udGFpbiBj
b25maWRlbnRpYWwgYW5kL29yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24uIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQob3IgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBl
cnJvciksIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVzdHJveSB0
aGlzIGUtbWFpbC4gQW55IHVuYXV0aG9yaXplZCBjb3B5aW5nLCBkaXNjbG9zdXJlIG9yIGRpc3Ry
aWJ1dGlvbiBvZiB0aGUgbWF0ZXJpYWwgaW4gdGhpcyBlLW1haWwgaXMgc3RyaWN0bHkgZm9yYmlk
ZGVuLuKAnQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+DQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI5LCAyMDIz
IDg6MTAgQU0NClRvOiBIYXJkYXdheSAoU2hpaCBIdW5nKSBUc2VuZyBTS0hZVCA8aGFyZGF3YXku
dHNlbmdAc2suY29tPg0KQ2M6IEppbSBMaW4g5p6X5b+X6J6NIDxqaW0ubGluQHNpbGljb25tb3Rp
b24uY29tPjsgSmltLkxpbiA8amltLmNoaWhqdW5nLmxpbkBnbWFpbC5jb20+OyBheGJvZUBrZXJu
ZWwuZGs7IGhjaEBsc3QuZGU7IHNhZ2lAZ3JpbWJlcmcubWU7IGxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ0ogQ2hlbiDpmbPnvqTl
gpEgPGNqLmNoZW5Ac2lsaWNvbm1vdGlvbi5jb20+OyBEYXZpZCBZZWgg6JGJ5a+w6J6NIDxkYXZp
ZC55ZWhAc2lsaWNvbm1vdGlvbi5jb20+OyDtlZzsg4HslYgoSEFOIFNBTkdBTikg64yA66eM67KV
7J24IDxzYW5nYW4uaGFuQHNrLmNvbT47IEl2ZXMoSHN1ZWggSHNpZW4pIEx1IFNLSFlUIDxpdmVz
Lmx1QHNrLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG52bWUtcGNpOiBkaXNhYmxlIHdyaXRl
IHplcm9lcyBmb3IgU0sgSHluaXggQkM5MDENCg0KT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMTE6
NTE6NDJQTSArMDAwMCwgaGFyZGF3YXkudHNlbmdAc2suY29tIHdyb3RlOg0KPiBIaSBLZWl0aCwg
SmltIGFuZCB0ZWFtLA0KPiANCj4gVGhhbmtzIGZvciBlZmZvcnRzIQ0KPiANCj4gVGhpcyBpcyBI
YXJkYXdheSBmcm9tIFNLIGh5bml4LCB0aGlzIHNvZnR3YXJlIGNoYW5nZSBoYXMgYmVlbiB0ZXN0
ZWQgYW5kIHZlcmlmaWVkIGJ5IE9ETSBDb21wYWwsIHRoZSB0ZXN0aW5nIHJlc3VsdCBpcyBwYXNz
LCB0aGVyZWZvcmUsIHdlIHdvdWxkIGxpa2UgdG8gYXBwbHkgdGhpcyB1cGRhdGUuDQoNCkdyZWF0
LCB0aGFua3MgZm9yIGNvbmZpcm1pbmcuIEkndmUgZ290IHRoaXMgcXVldWVkIHVwIGludGVybmFs
bHksIGJ1dCB3YW50IHRvIGNoZWNrIGlmIENocmlzdG9waCdzIHF1ZXN0aW9uIGNvdWxkIGxlYWQg
dG8gYSBiZXR0ZXIgb3V0Y29tZSBmb3IgZXZlcnlvbmUuIEZvciByZWZlcmVuY2UsIGFza2VkIGhl
cmU6DQoNCiAgaHR0cHM6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1l
LzIwMjMtTm92ZW1iZXIvMDQzMjk4Lmh0bWwNCg0KSWYgeW91IHdlcmUgYWxyZWFkeSB0ZXN0aW5n
IGNsb3NlIHRvIHVwc3RyZWFtLCA2LjIgb3IgbmV3ZXIsIHRoZW4gdGhpcyBwYXRjaCBpcyBhbHJl
YWR5IHRoZSBiZXN0IG9wdGlvbi4NCg==

