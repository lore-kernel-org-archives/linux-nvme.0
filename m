Return-Path: <SRS0=PT9J=YU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C01CA9EAF
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2019 16:07:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F1020679
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2019 16:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VMN8nu6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F1020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onestopsystems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yI5NFqWUDCICcXirSyM2Et0c8ygovAgKoT0DYU+YypY=; b=VMN8nu6r4/2OD0
	FppjFvtKkB3OR0v4UMTz07bBFcB2V9pmgVPr9BiU33XeApZ//O5Hq0XOfyNG+Oaqpohev8l+gIzP6
	S8Y08GEHpjRDQzwKAD2b845B+FYAB8Bl6eEPQDxaTw3gtpCGrzNoRLv4sho3I6VfR3qAyy0Wd5LIw
	4NUibmqlJcB15y3qXdAqnsuKiYQr8JbICP3D3QhFJt6pU7qF05Y/6pJutsxKFMvGApnzXKM/2mrBL
	mNia9rwGTVKaEJzFBcQ/vZ/ThzI9YCQ68DBVeEH+ao3IXWFg63c1c/W99zEP41JaiAPFoGrdDayYy
	z0ZCQ/9ayhAp1GMzRcZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOl4H-00031T-UL; Sun, 27 Oct 2019 16:07:01 +0000
Received: from cox.onestopsystems.com ([98.187.250.34]
 helo=osserver.onestopsystems.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iOl4F-00030f-BR
 for linux-nvme@lists.infradead.org; Sun, 27 Oct 2019 16:07:00 +0000
Received: from OSSERVER.OSS.local ([fe80::792d:7e8d:4995:9203]) by
 OSSERVER.OSS.local ([fe80::792d:7e8d:4995:9203%10]) with mapi id
 14.03.0468.000; Sun, 27 Oct 2019 09:06:55 -0700
From: Mark Ruijter <MRuijter@onestopsystems.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7lEGozSmO4UUiQP6G5ZvB8eadpfxqAgADA2ACAAPSWAIAABfMAgABpVQCAA20tAIAAEbaA
Date: Sun, 27 Oct 2019 16:06:54 +0000
Message-ID: <472AE18F-C9C8-4251-A81F-7B8BBF82F3C9@onestopsystems.com>
References: <20191027150330.GA5843@lst.de>
In-Reply-To: <20191027150330.GA5843@lst.de>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-ID: <4C6919275BCAF9479C4183B0B7828C8A@onestopsystems.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191027_090659_415283_B6881B67 
X-CRM114-Status: GOOD (  24.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.com>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQpJIHdpbGwgaW5zdGFsbCB0aGUgcGF0Y2ggdG9tb3Jyb3cgb24gdGhlIHN5c3RlbXMgdGhhdCBJ
IHVzZWQgYmVmb3JlIGFuZCBydW4gc29tZSB0ZXN0cyBzbyB0aGF0IEkgY2FuIGNvbXBhcmUgdGhl
IHBlcmZvcm1hbmNlIG51bWJlcnMuDQoNCk1hcmsNCg0KPiBPcCAyNyBva3QuIDIwMTkgb20gMTY6
MDMgaGVlZnQgImhjaEBsc3QuZGUiIDxoY2hAbHN0LmRlPiBoZXQgdm9sZ2VuZGUgZ2VzY2hyZXZl
bjoNCj4gDQo+IO+7v09uIEZyaSwgT2N0IDI1LCAyMDE5IGF0IDA4OjQ0OjAwQU0gKzAwMDAsIE1h
cmsgUnVpanRlciB3cm90ZToNCj4+IA0KPj4gSGkgS2VpdGgsDQo+PiANCj4+IEkgYW0gaW5kZWVk
IG5vdCB1c2luZyBidWZmZXJlZCBpby4NCj4+IFVzaW5nIHRoZSBWRlMgaW5jcmVhc2VzIG15IDRr
IHJhbmRvbSB3cml0ZSBwZXJmb3JtYW5jZSBmcm9tIDIwMEsgdG8gNjUwSyB3aGVuIHVzaW5nIHJh
aWQxLiANCj4+IFNvIHRoZSBkaWZmZXJlbmNlIGlzIGh1Z2UgYW5kIGJlY29tZXMgbW9yZSBzaWdu
aWZpY2FudCB3aGVuIHRoZSB1bmRlcmx5aW5nIGRyaXZlcyBvciByYWlkMCBjYW4gaGFuZGxlIG1v
cmUgaW9wcy4NCj4gDQo+IENhbiB5b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdyB0byB1c2UgYmxvY2sg
bGF5ZXIgcGx1Z2dpbmcgaW4gbnZtZXQ/ICBUaGF0DQo+IHNob3VsZCBiZSB0aGUgb25seSBtYWpv
ciBkaWZmZXJlbmNlIGluIGhvdyB3ZSBkbyBJL08uDQo+IA0KPj4gMS4gQ3VycmVudGx5IGEgY29u
dHJvbGxlciBpZCBjb2xsaXNpb24gY2FuIG9jY3VyIHdoZW4gdXNpbmcgYSBjbHVzdGVyZWQgSEEg
c2V0dXAuIFNlZSB0aGlzIG1lc3NhZ2U6DQo+Pj4+PiBbMTEyMjc4OS4wNTQ2NzddIG52bWUgbnZt
ZTE6IER1cGxpY2F0ZSBjbnRsaWQgNCB3aXRoIG52bWUwLCByZWplY3RpbmcuDQo+PiANCj4+IFRo
ZSBjb250cm9sbGVyIElEIGlzIGN1cnJlbnRseSBoYXJkIHdpcmVkLg0KPj4gDQo+PiAgICAgICBy
ZXQgPSBpZGFfc2ltcGxlX2dldCgmY250bGlkX2lkYSwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOVk1FX0NOVExJRF9NSU4sIE5WTUVfQ05UTElEX01BWCwNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBHRlBfS0VSTkVMKTsNCj4+IA0KPj4gU28gdHdvIG5vZGVzIGV4cG9y
dGluZyB0aGUgZXhhY3Qgc2FtZSB2b2x1bWUgdXNpbmcgdGhlIHNhbWUgcG9ydCBjb25maWd1cmF0
aW9uIGNhbiBlYXNpbHkgY29tZSB1cCB3aXRoIHRoZSBzYW1lIGNvbnRyb2xsZXIgaWQuDQo+PiBJ
IHdvdWxkIGxpa2UgdG8gcHJvcG9zZSB0byBtYWtlIGl0IGNvbmZpZ3VyYWJsZSwgYnV0IHdpdGgg
dGhlIGN1cnJlbnQgbG9naWMgc2V0dGluZyBhIGRlZmF1bHQuDQo+PiBTQ1NUIGZvciBleGFtcGxl
IGFsbG93cyBtYW51YWwgdGFyZ2V0IGlkIHNlbGVjdGlvbiBmb3IgdGhpcyByZWFzb24uDQo+IA0K
PiBXZSBjYW4gYWxsb3cgc29tZSBjb250cm9sIHRoZXJlIHVzaW5nIGEgbmV3IGNvbmZpZ2ZzIGZp
bGUuICBCdXQgd2hhdA0KPiB3b3VsZCBiZSBldmVuIGJldHRlciBpcyBhbiBhY3R1YWxseSBpbnRl
Z3JhdGVkIGNsdXN0ZXIgbWFuYWdlciwgd2hpY2gNCj4gd2UnZCBuZWVkIHRvIHN1cHBvcnQgZmVh
dHVyZXMgc3VjaCBhcyBwZXJzaXN0ZW50IHJlc2VydmF0aW9ucy4NCj4gDQo+PiAyLiBUaGUgTW9k
ZWwgb2YgdGhlIGRyaXZlcyBoYXMgYmVlbiBoYXJkIHdpcmVkIHRvIExpbnV4LiBBcyBJIHNlZSBp
dCB0aGlzIHNob3VsZCBiZSBjb25maWd1cmFibGUgd2l0aCAnTGludXgnIGFzIGRlZmF1bHQgdmFs
dWUuDQo+PiBJJ2xsIHByb3ZpZGUgY29kZSB0aGF0IG1ha2VzIHRoYXQgd29yay4NCj4gDQo+IFll
cywgcGxlYXNlIHNlbmQgYSBwYXRjaC4NCj4gDQo+PiAzLiBBIE5WTUVvRiBjb25uZWN0ZWQgZGlz
ayBvbiB0aGUgaW5pdGlhdG9yIHNlZW1zIHRvIHF1ZXVlIGZvcmV2ZXIgd2hlbiB0aGUgdGFyZ2V0
IGRpZXMuDQo+PiBJdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGhhZCB0aGUgYWJpbGl0eSB0byBzZWxl
Y3QgZWl0aGVyICdxdWV1ZSBmb3JlZXZlcicgb3IgJ2ZhaWxmYXN0Jy4NCj4gDQo+IE1ha2luZyB0
aGlzIGNvbmZpZ3VyYWJsZSBoYXMgYmVlbiBhIGxvbmcgdGltZSB0b2RvIGxpc3QgaXRlbS4gIEF0
IHNvbWUNCj4gcG9pbnQgaW4gdGhlIHBhc3QgSGFubmVzIChhZGRlZCB0byBDYykgc2lnbmVkIHVw
IGZvciBpdCwgYnV0IGl0IHNlZW1zDQo+IHRvIGhhdmUgZHJvcHBlZCBvZmYgaGlzIHByaW9yaXR5
IGxpc3QuDQo+IA0KPiAtLS0NCj4gRnJvbSA4N2FiMGQ2ZjllMDkyY2RlMDQ3NzU0NTIxMzFmOTBl
OGI0YzQ2YTY2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPiBGcm9tOiBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGxzdC5kZT4NCj4gRGF0ZTogU3VuLCAyNyBPY3QgMjAxOSAxNTo1OTowOCArMDEw
MA0KPiBTdWJqZWN0OiBudm1ldDogdXNlIGJsb2NrIGxheWVyIHBsdWdnaW5nIGluIG52bWV0X2Jk
ZXZfZXhlY3V0ZV9ydw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+DQo+IC0tLQ0KPiBkcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMgfCAz
ICsrKw0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jIGIvZHJpdmVycy9udm1lL3Rhcmdl
dC9pby1jbWQtYmRldi5jDQo+IGluZGV4IDA0YTljZDJhMjYwNC4uZWQxYThkMGFiMzBlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMNCj4gKysrIGIvZHJp
dmVycy9udm1lL3RhcmdldC9pby1jbWQtYmRldi5jDQo+IEBAIC0xNDcsNiArMTQ3LDcgQEAgc3Rh
dGljIHZvaWQgbnZtZXRfYmRldl9leGVjdXRlX3J3KHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCj4g
ICAgaW50IHNnX2NudCA9IHJlcS0+c2dfY250Ow0KPiAgICBzdHJ1Y3QgYmlvICpiaW87DQo+ICAg
IHN0cnVjdCBzY2F0dGVybGlzdCAqc2c7DQo+ICsgICAgc3RydWN0IGJsa19wbHVnIHBsdWc7DQo+
ICAgIHNlY3Rvcl90IHNlY3RvcjsNCj4gICAgaW50IG9wLCBvcF9mbGFncyA9IDAsIGk7DQo+IA0K
PiBAQCAtMTg1LDYgKzE4Niw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X2JkZXZfZXhlY3V0ZV9ydyhz
dHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+ICAgIGJpby0+YmlfZW5kX2lvID0gbnZtZXRfYmlvX2Rv
bmU7DQo+ICAgIGJpb19zZXRfb3BfYXR0cnMoYmlvLCBvcCwgb3BfZmxhZ3MpOw0KPiANCj4gKyAg
ICBibGtfc3RhcnRfcGx1ZygmcGx1Zyk7DQo+ICAgIGZvcl9lYWNoX3NnKHJlcS0+c2csIHNnLCBy
ZXEtPnNnX2NudCwgaSkgew0KPiAgICAgICAgd2hpbGUgKGJpb19hZGRfcGFnZShiaW8sIHNnX3Bh
Z2Uoc2cpLCBzZy0+bGVuZ3RoLCBzZy0+b2Zmc2V0KQ0KPiAgICAgICAgICAgICAgICAhPSBzZy0+
bGVuZ3RoKSB7DQo+IEBAIC0yMDIsNiArMjA0LDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfYmRldl9l
eGVjdXRlX3J3KHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCj4gICAgICAgIHNlY3RvciArPSBzZy0+
bGVuZ3RoID4+IDk7DQo+ICAgICAgICBzZ19jbnQtLTsNCj4gICAgfQ0KPiArICAgIGJsa19maW5p
c2hfcGx1ZygmcGx1Zyk7DQo+IA0KPiAgICBzdWJtaXRfYmlvKGJpbyk7DQo+IH0NCj4gLS0gDQo+
IDIuMjAuMQ0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
