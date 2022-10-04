Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D546C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inDVVTU0VmwGx8e0qK4BB2L0eScELSI2gq+7TIa/RFg=; b=zbaYA4iLKLP/M/W0Upt1d7EvuI
	w6ib6VybJmVLqHq5j+/7CRZOJ+dw9LCmeZS0zz5DOog4ECp3DrgFNWcUIRry51roso+4DIdjjqAlz
	rHYBFdZ5cVb0PHZWHK3xYK6N36aQaPwR+54zW3fc9TT7FWgIVq+dHfOr82cJxo7bpZ53FwVwGEfXu
	rUBBH95Ag2PWIu3KgTEjf3EYStUTYgKYaXVJbbIo13xL2vs+4V1DDIrJKJ1CPiAFCQZBu192d0fSV
	6jWzLvC9PNZtndY67pnlRF360ekp1DqpSVpyUJ+87tvfRx8XNoiFYqwbh1f+E3drS49iRYIlJwkh+
	k5owp0DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofnIv-00AkwG-4l; Tue, 04 Oct 2022 19:10:09 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofnIr-00Akqv-UO
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 19:10:07 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 12:09:41 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::4518:affe:df36:adc9%3]) with mapi id 15.01.2375.031; Tue, 4 Oct 2022
 12:09:41 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: RE: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Topic: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Index: AQHY1FTkfGYaIXwsQECopyvrDRJ6WK3984GAgABxjaA=
Date: Tue, 4 Oct 2022 19:09:41 +0000
Message-ID: <6709778688ba4c58b21f832b96ddc73a@kioxia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
 <1cef55e7-26a3-abac-315c-5f7f56f4771e@nvidia.com>
In-Reply-To: <1cef55e7-26a3-abac-315c-5f7f56f4771e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_121006_021338_03E0D532 
X-CRM114-Status: GOOD (  15.77  )
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

PiBGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YWtAbnZpZGlhLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBPY3RvYmVyIDMsIDIwMjIgNjo0OSBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IFYyIDAvMl0gbnZtZTogU3VwcG9ydCB1c2VyIG1vZGUgcHJvY2Vzc2luZyBvZiBaTlMgWm9uZQ0K
PiBDaGFuZ2VkIEFFTg0KPiANCj4gT24gOS8yOS8yMiAxNTozOSwgY2xheS5tYXllcnNAa2lveGlh
LmNvbSB3cm90ZToNCj4gPiBGcm9tOiBDbGF5IE1heWVycyA8Y2xheS5tYXllcnNAa2lveGlhLmNv
bT4NCj4gPg0KPiA+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgWk5TIFpvbmUtRGVzY3JpcHRv
ci1DaGFuZ2VzIEFFTiwgd2hpY2ggaXMgb2YNCj4gPiB0eXBlIG5vdGlmeSBhbmQgdXNlcyBDUUUu
RFcxIHRvIGNvbnZleSB0aGUgTlNJRCBvZiB0aGUgbG9nIHBhZ2UgdG8gcmVhZC4NCj4gPg0KPiA+
IFBhdGNoIDEgYWRkcyBub24temVybyBOVk1FX0FFTl9EQVRBIHdpdGggdGhlIHZhbHVlIG9mIENR
RS5EVzEgdG8gYWxsDQo+ID4gTlZNRV9BRU4gdWV2ZW50cy4NCj4gPg0KPiA+IFBhdGNoIDIgZ2Vu
ZXJhdGVzIGEgdWV2ZW50IGZvciBhbGwgdW5oYW5kbGVkIEFFTiBub3RpZnkgcmVzdWx0cyBpbnN0
ZWFkDQo+ID4gb2YgaXNzdWluZyBhIGRldiB3YXJuaW5nLg0KPiA+DQo+ID4gVGhpcyBzdXBwb3J0
IGlzIHBsYW5uZWQgdG8gYmUgdXNlZCBieSBib3RoIHpvbmUgYmFzZWQgYXBwbGljYXRpb25zIGFu
ZA0KPiA+IGFub3RoZXIgdW5yZWxlYXNlZCBkZXZpY2Ugd2l0aCBhbiBhbHRlcm5hdGUgY29tbWFu
ZCBzZXQuDQo+ID4NCj4gPg0KPiANCj4gUGxlYXNlIHdyaXRlIGEgdGVzdGNhc2UgaW4gdGhlIGJs
a3Rlc3QgdG8gdGhpcyB3aWxsIGdldCB0ZXN0ZWQgZXZlcnkNCj4gcmVsZWFzZS4NCj4gDQo+IC1j
aw0KDQpPayAtIEknbGwgZ2l2ZSBpdCBhIGdvIHRvIGltcGxlbWVudCB0aGF0IGJ1dCBBRU5zIGJ5
IGRlZmluaXRpb24gYXJlbid0IGENCnJlc3BvbnNlIHRvIGEgcmVxdWVzdCAobW9zdGx5KSAtIHRo
ZXkganVzdCBoYXBwZW4uICBUaGUgY2FzZSB0aGF0IEkga25vdw0Kb2YgdGhhdCBjcmVhdGVzIGEg
em9uZSBleGN1cnNpb24gQUVOIHRha2VzIG1hbnkgaG91cnMgdG8gbWFuaWZlc3QgYW5kDQp0aGF0
IGR1cmF0aW9uIHdvdWxkIGJlIEZMQVNILXR5cGUgc3BlY2lmaWMuICBJIGRvbid0IGtub3cgaG93
IHlvdSBjb3VsZA0KdXNlIGEgcmVhbCBkZXZpY2UuDQoNClRoaXMgcGF0Y2ggd2FzIHRlc3RlZCB1
bmRlciBRRU1VIHdpdGggb3VyIGN1c3RvbSBlbXVsYXRvci4gIFRoZQ0KY3VycmVudCBRRU1VIE5W
TWUvWk5TIGRldmljZSBkb2Vzbid0IGVtdWxhdGUgem9uZSBleGN1cnNpb25zIHNvIEknbGwNCmhh
dmUgdG8gc3RhcnQgdGhlcmUgdW5sZXNzIHNvbWVvbmUga25vd3Mgb2YgYSBiZXR0ZXIgd2F5Lg0K
DQo=

