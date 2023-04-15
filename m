Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDA2C77B77
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Apr 2023 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1+LyK8XFIkYUCP6mw818M7jV5wNaxKEgyEqfw4hKIo=; b=uJ28Zdxf+aH5dQAwPIuJv34mxt
	wr8BQ6b+4H1YsPOSNyTw7MQ0fiWdbpEqFOp901jDHycwjHrFkjEbhvUL9tkgVRlnmZJzM+XiAdTvg
	i86uPmDfE5WXY8qZT1OgmX2i9AMGPGiVSVywtebWrQnzRERzYb2XMeKZ5WomT5xGw2vtoopv3xMX6
	pzeV844fHuGmejBuhZg7gEyQtwS4D5d1i+qrbKWa13dHE8PD+mrsabCveksNzuZAgzfMbL2OsdwFS
	vOQwtafsJ5Mu6iR8iKSpLxhEo71HVhZgG/OxpZhfBczrCJT6mwxLjJL4g9qYClqjnHCFx2A+VlQtj
	u+qaHQVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnn6e-00CitO-0o;
	Sat, 15 Apr 2023 21:06:48 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnn6b-00Cir2-0n
	for linux-nvme@lists.infradead.org;
	Sat, 15 Apr 2023 21:06:47 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-98-IlASUaQeNLOMF2jXqq4jlA-1; Sat, 15 Apr 2023 22:06:39 +0100
X-MC-Unique: IlASUaQeNLOMF2jXqq4jlA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 15 Apr
 2023 22:06:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 15 Apr 2023 22:06:37 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Li Feng' <fengli@smartx.com>, Hannes Reinecke <hare@suse.de>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "open list:NVM
 EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Subject: RE: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Thread-Topic: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Thread-Index: AQHZbrRyNQu7a+qZXEauaari1TVlXa8s2+nA
Date: Sat, 15 Apr 2023 21:06:36 +0000
Message-ID: <3e45f600db2049c4986fd8bb6aea69f4@AcuMS.aculab.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <94d6a76c-8ad1-bda1-6336-e9f5fa3a6168@suse.de>
 <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
In-Reply-To: <CAHckoCxcmNC++AXELmnCVZNjpHcaOQWOGcjia=NBCnOA7S7EeQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230415_140645_573850_99B3B7D4 
X-CRM114-Status: GOOD (  27.45  )
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

RnJvbTogTGkgRmVuZw0KPiBTZW50OiAxNCBBcHJpbCAyMDIzIDEwOjM1DQo+ID4NCj4gPiBPbiA0
LzEzLzIzIDE1OjI5LCBMaSBGZW5nIHdyb3RlOg0KPiA+ID4gVGhlIGRlZmF1bHQgd29ya2VyIGFm
ZmluaXR5IHBvbGljeSBpcyB1c2luZyBhbGwgb25saW5lIGNwdXMsIGUuZy4gZnJvbSAwDQo+ID4g
PiB0byBOLTEuIEhvd2V2ZXIsIHNvbWUgY3B1cyBhcmUgYnVzeSBmb3Igb3RoZXIgam9icywgdGhl
biB0aGUgbnZtZS10Y3Agd2lsbA0KPiA+ID4gaGF2ZSBhIGJhZCBwZXJmb3JtYW5jZS4NCj4gPiA+
DQo+ID4gPiBUaGlzIHBhdGNoIGFkZHMgYSBtb2R1bGUgcGFyYW1ldGVyIHRvIHNldCB0aGUgY3B1
IGFmZmluaXR5IGZvciB0aGUgbnZtZS10Y3ANCj4gPiA+IHNvY2tldCB3b3JrZXIgdGhyZWFkcy4g
IFRoZSBwYXJhbWV0ZXIgaXMgYSBjb21tYSBzZXBhcmF0ZWQgbGlzdCBvZiBDUFUNCj4gPiA+IG51
bWJlcnMuICBUaGUgbGlzdCBpcyBwYXJzZWQgYW5kIHRoZSByZXN1bHRpbmcgY3B1bWFzayBpcyB1
c2VkIHRvIHNldCB0aGUNCj4gPiA+IGFmZmluaXR5IG9mIHRoZSBzb2NrZXQgd29ya2VyIHRocmVh
ZHMuICBJZiB0aGUgbGlzdCBpcyBlbXB0eSBvciB0aGUNCj4gPiA+IHBhcnNpbmcgZmFpbHMsIHRo
ZSBkZWZhdWx0IGFmZmluaXR5IGlzIHVzZWQuDQo+ID4gPg0KLi4uDQo+ID4gSSBhbSBub3QgaW4g
ZmF2b3VyIG9mIHRoaXMuDQo+ID4gTlZNZS1vdmVyLUZhYnJpY3MgaGFzIF92aXJ0dWFsXyBxdWV1
ZXMsIHdoaWNoIHJlYWxseSBoYXZlIG5vDQo+ID4gcmVsYXRpb25zaGlwIHRvIHRoZSB1bmRlcmx5
aW5nIGhhcmR3YXJlLg0KPiA+IFNvIHRyeWluZyB0byBiZSBjbGV2ZXIgaGVyZSBieSB0YWNraW5n
IHF1ZXVlcyB0byBDUFVzIHNvcnQgb2Ygd29ya3MgaWYNCj4gPiB5b3UgaGF2ZSBvbmUgc3Vic3lz
dGVtIHRvIHRhbGsgdG8sIGJ1dCBpZiB5b3UgaGF2ZSBzZXZlcmFsIHdoZXJlIGVhY2gNCj4gPiBl
eHBvc2VzIGEgX2RpZmZlcmVudF8gbnVtYmVyIG9mIHF1ZXVlcyB5b3UgZW5kIHVwIHdpdGggYSBx
dWl0ZQ0KPiA+IHN1Ym9wdGltYWwgc2V0dGluZyAoaWUgeW91IHJlbHkgb24gdGhlIHJlc3VsdGlu
ZyBjcHUgc2V0cyB0byBvdmVybGFwLA0KPiA+IGJ1dCB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhh
dCB0aGV5IGRvKS4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KPiBUaGUgY3VycmVu
dCBpby1xdWV1ZXMvY3B1IG1hcCBtZXRob2QgaXMgbm90IG9wdGltYWwuDQo+IEl0IGlzIHN0dXBp
ZCwgYW5kIGp1c3Qgc3RhcnRzIGZyb20gMCB0byB0aGUgbGFzdCBDUFUsIHdoaWNoIGlzIG5vdCBj
b25maWd1cmFibGUuDQoNCk1vZHVsZSBwYXJhbWV0ZXJzIHN1Y2ssIGFuZCBwYXNzaW5nIHRoZSBi
dWNrIHRvIHRoZSB1c2VyDQp3aGVuIHlvdSBjYW4ndCBkZWNpZGUgaG93IHRvIGRvIHNvbWV0aGlu
ZyBpc24ndCBhIGdvb2QgaWRlYSBlaXRoZXIuDQoNCklmIHRoZSBzeXN0ZW0gaXMgYnVzeSBwaW5u
aW5nIHRocmVhZHMgdG8gY3B1cyBpcyB2ZXJ5IGhhcmQgdG8NCmdldCByaWdodC4NCg0KSXQgY2Fu
IGJlIGJldHRlciB0byBzZXQgdGhlIHRocmVhZHMgdG8gcnVuIGF0IHRoZSBsb3dlc3QgUlQNCnBy
aW9yaXR5IC0gc28gdGhleSBoYXZlIHByaW9yaXR5IG92ZXIgYWxsICdub3JtYWwnIHRocmVhZHMN
CmFuZCBhbHNvIGhhdmUgYSB2ZXJ5IHN0aWNreSAoYnV0IG5vdCBmaXhlZCkgY3B1IGFmZmluaXR5
IHNvDQp0aGF0IGFsbCBzdWNoIHRocmVhZHMgdGVuZHMgdG8gZ2V0IHNwcmVhZCBvdXQgYnkgdGhl
IHNjaGVkdWxlci4NClRoaXMgYWxsIHdvcmtzIGJlc3QgaWYgdGhlIG51bWJlciBvZiBSVCB0aHJl
YWRzIGlzbid0IGdyZWF0ZXINCnRoYW4gdGhlIG51bWJlciBvZiBwaHlzaWNhbCBjcHUuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=


