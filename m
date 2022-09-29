Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A8C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xHpsSerez5Hk9tJqro4/snzhdDICi4flpuJeCSqarug=; b=hz5r3kOju4cBE/tclo3IcGKIWA
	ManThUjbP8pcMLO3GBsk6mZ0mpQo2kEenP/or052bgChOcF+9sPqsXXN+Oy43/PxrVHvrz+ISA9Ti
	ouLkmCAjN0qs2uHEUv0XZx4H7NVEG2lLwbTokA/mWEkaE0IcIFB7NNxxei5P+A0LMpJr+f3lymA8o
	wivx0JMeghWT7uRa+bIBUkGC7zLSyHIW0NXZdy1ROb9baLeeqx+qxDDpRkP0rzLUn7m1hcyCG8/mb
	kqvRh9rW+6OFL4D36vInUCSph2sOTbFU+3k7Z3QBw2HXp+gPYcBBx99Hyo+hPk9lYbCOoOzyc8Yey
	uYKPQLrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe1tw-005fgh-6s; Thu, 29 Sep 2022 22:21:04 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe1ts-005ffG-QH
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 22:21:02 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:20:55 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::4518:affe:df36:adc9%3]) with mapi id 15.01.2375.031; Thu, 29 Sep 2022
 15:20:55 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>
Subject: RE: [PATCH] nvme: Support user mode processing of ZNS Zone Changed
 AEN
Thread-Topic: [PATCH] nvme: Support user mode processing of ZNS Zone Changed
 AEN
Thread-Index: AQHY05lVCQJYxWZAbU23XSNgsdEqRa32hkuAgABty8A=
Date: Thu, 29 Sep 2022 22:20:54 +0000
Message-ID: <5c3c343d178746d99a10b4543579ad29@kioxia.com>
References: <20220929001629.2024067-1-clay.mayers@kioxia.com>
 <33c9d202-550f-1cd7-3ff4-11559110d672@grimberg.me>
In-Reply-To: <33c9d202-550f-1cd7-3ff4-11559110d672@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_152100_872105_529B7399 
X-CRM114-Status: GOOD (  14.09  )
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

PiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBTZW50OiBUaHVyc2Rh
eSwgU2VwdGVtYmVyIDI5LCAyMDIyIDE6MTkgQU0NCj4gDQo+ID4gVGhlIFpOUyBab25lLURlc2Ny
aXB0b3ItQ2hhbmdlcyBBRU4gaXMgb2YgdHlwZSBub3RpZnkgYW5kIHVzZXMgQ1FFLkRXMQ0KPiA+
IHRvIGNvbnZleSB0aGUgbmFtZXNwYWNlIG9mIHRoZSBsb2cgcGFnZSB0byByZWFkLiBVbmhhbmRs
ZWQgbm90aWZ5IEFFTnMNCj4gPiBub3cgZ2VuZXJhdGUgYW4gTlZNRV9BRU4gdWV2ZW50IGFuZCBp
bmNsdWRlIHRoZSB2YWx1ZSBvZiBDUUUuRFcxIGFzIGENCj4gPiBuZXcgcHJvcGVydHkgd2hlbiBu
b24temVyby4NCj4gDQo+IEJ1dCB5b3UgYWx3YXlzIHNlbmQgaXQuLi4NCg0KVGhhbmtzIGZvciB0
aGUgcXVpY2sgcmV2aWV3IGFuZCBjYXRjaGluZyBteSBtaXN0YWtlLg0KDQo+IA0KPiA+DQo+ID4g
QWxsIHVuaGFuZGxlZCBub3RpZnkgZXZlbnRzIGFyZSBpbmNsdWRlIHRvIGF2b2lkIGNvbW1hbmQg
c2V0IHNwZWNpZmljDQo+ID4gY29kZSBpbiB0aGUgYWVuIGhhbmRsaW5nLiAgVGhpcyBzdXBwb3J0
IGlzIHBsYW5uZWQgdG8gYmUgdXNlZCBieSBib3RoDQo+ID4gem9uZSBiYXNlZCBhcHBsaWNhdGlv
bnMgYW5kIGFub3RoZXIgdW5yZWxlYXNlZCBkZXZpY2Ugd2l0aCBhbiBhbHRlcm5hdGUNCj4gPiBj
b21tYW5kIHNldC4NCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUgc3BsaXQgaW50byB0d28gcGF0Y2hl
cy4NCj4gDQoNCkl0IHdpbGwgYmUgc3BsaXQgaW4gdHdvIGZvciBWMg0K

