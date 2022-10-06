Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BDBC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 20:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8J+BNIctYlKjtM6FcF99mWd9DAcQj8sntxn2P7GoAmQ=; b=2ULcx9NGXtzciA4LKVrm7E6ILw
	JxOuyGJ9fXhYoFPMGD2XOzLD1npfAafo1RBIONljYxsGTH5pPBuwRb+jiRswJiN5ZPYSQxjW+JxEN
	jumCkoKT8MlnswNXSDizzrR1x2DK9WMuxs2I4wSHOosEj6O1rcvenifgLOOjPMMIY6HZhipbcBImb
	EtxEYQx3LbF/d7MzP9RmwKwH35JUeHtrf3bTrB8qIcoEzf4fsNyWsgXKezsKIBrX9WkH0uOZFQjDK
	vcQ2PqBGX3oeuINHFbZZaGyDZSEz8WB+o7L1ESziSPpJ1yt+8FwicRyjk8QqZPrIubek6WPk7573L
	0sS8XGKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogXHv-004z4Q-2N; Thu, 06 Oct 2022 20:16:11 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogXHr-004z24-6x
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 20:16:09 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 13:16:02 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::4518:affe:df36:adc9%3]) with mapi id 15.01.2375.031; Thu, 6 Oct 2022
 13:16:02 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>
Subject: RE: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Topic: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone
 Changed AEN
Thread-Index: AQHY1FTkfGYaIXwsQECopyvrDRJ6WK4Bu5+A///ThYA=
Date: Thu, 6 Oct 2022 20:16:02 +0000
Message-ID: <391578965a624d76af5ef2ab21346443@kioxia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
 <a3aaa8ae-d259-359d-8a08-084d53fca830@grimberg.me>
In-Reply-To: <a3aaa8ae-d259-359d-8a08-084d53fca830@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_131607_269028_3297872B 
X-CRM114-Status: GOOD (  27.08  )
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
eSwgT2N0b2JlciA2LCAyMDIyIDQ6MzQgQU0NCj4gVG86IENsYXkgTWF5ZXJzIDxDbGF5Lk1heWVy
c0BraW94aWEuY29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBLZWl0
aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+OyBKZW5zIEF4Ym9lIDxheGJvZUBmYi5jb20+OyBD
aHJpc3RvcGgNCj4gSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MiAwLzJdIG52bWU6IFN1cHBvcnQgdXNlciBtb2RlIHByb2Nlc3Npbmcgb2YgWk5TIFpvbmUNCj4g
Q2hhbmdlZCBBRU4NCj4gDQo+IA0KPiA+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgWk5TIFpv
bmUtRGVzY3JpcHRvci1DaGFuZ2VzIEFFTiwgd2hpY2ggaXMgb2YNCj4gPiB0eXBlIG5vdGlmeSBh
bmQgdXNlcyBDUUUuRFcxIHRvIGNvbnZleSB0aGUgTlNJRCBvZiB0aGUgbG9nIHBhZ2UgdG8gcmVh
ZC4NCj4gPg0KPiA+IFBhdGNoIDEgYWRkcyBub24temVybyBOVk1FX0FFTl9EQVRBIHdpdGggdGhl
IHZhbHVlIG9mIENRRS5EVzEgdG8gYWxsDQo+ID4gTlZNRV9BRU4gdWV2ZW50cy4NCj4gPg0KPiA+
IFBhdGNoIDIgZ2VuZXJhdGVzIGEgdWV2ZW50IGZvciBhbGwgdW5oYW5kbGVkIEFFTiBub3RpZnkg
cmVzdWx0cyBpbnN0ZWFkDQo+ID4gb2YgaXNzdWluZyBhIGRldiB3YXJuaW5nLg0KPiA+DQo+ID4g
VGhpcyBzdXBwb3J0IGlzIHBsYW5uZWQgdG8gYmUgdXNlZCBieSBib3RoIHpvbmUgYmFzZWQgYXBw
bGljYXRpb25zIGFuZA0KPiA+IGFub3RoZXIgdW5yZWxlYXNlZCBkZXZpY2Ugd2l0aCBhbiBhbHRl
cm5hdGUgY29tbWFuZCBzZXQuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxDQo+ID4gLSBCcmVh
ayB1cCBpbnRvIHR3byBwYXRjaGVzDQo+ID4gLSBPbmx5IGlubHVjZGUgQUVOX0RBVEEgaWYgQ1FF
LkRXMSBpcyBub24temVybw0KPiANCj4gV2hhdCBhYm91dCB0aGUgb3RoZXIgY29tbWVudHMgdGhh
dCB3ZXJlIGdpdmVuIG9uIHYxPw0KDQpNeSBtaXN0YWtlDQoNCj4gDQo+IC0tDQo+ICA+ICAgI2Vu
ZGlmDQo+ICA+IC0gICAgY2FzZSBOVk1FX0FFUl9OT1RJQ0VfRElTQ19DSEFOR0VEOg0KPiAgPiAr
ICAgIGRlZmF1bHQ6DQo+ICA+ICAgICAgICAgICBjdHJsLT5hZW5fcmVzdWx0ID0gcmVzdWx0Ow0K
PiAgPiAgICAgICAgICAgYnJlYWs7DQo+ICA+IC0gICAgZGVmYXVsdDoNCj4gID4gLSAgICAgICAg
ZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAiYXN5bmMgZXZlbnQgcmVzdWx0ICUwOHhcbiIsIHJlc3Vs
dCk7DQo+IA0KPiBJJ2Qga2VlcCB0aGUgbG9nLi4uIGFuZCBhbHNvIGRvbid0IGtub3cgaWYgd2Ug
d2FudCB0byBwYXNzIGFueSB1bmtub3duDQo+IHBvc3NpYmxlIHNwYW0gdG8gdXNlcnNwYWNlLi4u
IG5vdCBzdXJlIHRoYXQgYmVpbmcgYmxpbmRseSBmb3J3YXJkDQo+IGNvbXBhdGlibGUgaXMgdGhl
IHJpZ2h0IGNob2ljZSBoZXJlLg0KDQpJJ2xsIHB1dCBpdCBiYWNrIGluLiAgSSB3ZW50IGJhY2sg
YW5kIGZvcnRoIG9uIHRoaXMuICBNeSByZWFzb25pbmcgZm9yDQpyZW1vdmluZyBpcyB0aGF0IHRo
ZSBvdGhlciB0eXBlcyBvZiBBRU4gZG9uJ3Qgd2FybiBhbmQgYWx3YXlzIGdlbmVyYXRlDQphIHVl
dmVudC4gIE9ubHkgdGhlIE5PVElDRSB0eXBlIGNvbmRpdGlvbmFsbHkgc2V0cyBjdHJsLT5hZW5f
cmVzdWx0DQpiZWZvcmUgcXVldWVpbmcgYXN5bmNfZXZlbnRfd29yay4NCg0KVGhlIHJlYWwgY29u
dHJvbCBvdmVyIEFFTnMgaXMgdGhlIEFFTiBjb25maWcgZmVhdHVyZS4gIFdoZW4gYW4gQUVOIGlz
DQpnZW5lcmF0ZWQgYW5kIHVuaGFuZGxlZCwgYWxsIHRoZSBBRU5zIG9mIHRoYXQgdHlwZSB3aWxs
IG5vIGxvbmdlciBiZQ0Kc2VudC4gIFRoZXkgY2FuJ3QgYmUgb24gYnkgZGVmYXVsdCB3aXRob3V0
IGJyZWFraW5nIHRoZSBzeXN0ZW0gc28NCnRoZXJlIHdvbid0IGJlIGEgZmxvb2Qgb2YgbWVhbmlu
Z2xlc3MgTlZNRV9BRU4gdWV2ZW50cy4NCg0KVGhlIG9uZXMgdG8gc3VwcHJlc3MgYXJlIHRob3Nl
IHRoYXQgZG9uJ3QgZ28gdGhyb3VnaCBkZWZhdWx0IGFuZA0KYXJlIGhhbmRsZWQgaW4gdGhlIGtl
cm5lbC4gIFRoYXQncyB1bmNoYW5nZWQuDQoNCj4gDQo+ICA+ICAgICAgIH0NCj4gID4gICAgICAg
cmV0dXJuIHJlcXVldWU7DQo+ICA+ICAgfQ0KPiAgPiBAQCAtNDc5OSw4ICs0ODAwLDEwIEBAIHZv
aWQgbnZtZV9jb21wbGV0ZV9hc3luY19ldmVudChzdHJ1Y3QNCj4gbnZtZV9jdHJsICpjdHJsLCBf
X2xlMTYgc3RhdHVzLA0KPiAgPiAgICAgICAgICAgYnJlYWs7DQo+ICA+ICAgICAgIH0NCj4gID4g
ICAtICAgIGlmIChyZXF1ZXVlKQ0KPiAgPiArICAgIGlmIChyZXF1ZXVlKSB7DQo+ICA+ICsgICAg
ICAgIGN0cmwtPmFlbl9kYXRhID0gbGU2NF90b19jcHUocmVzLT51NjQpID4+IDMyOw0KPiANCj4g
UGxlYXNlIHVzZSBhIGhlbHBlciBmb3IgdGhhdC4NCj4gYWVuX2RhdGEgaXMgbm90IGEgZ3JlYXQg
bmFtZS4uLiBtYXliZSB1c2UgYSB1bmlvbiBmb3IgdGhhdCBmb3IgdGhlDQo+IHNwZWNpZmljIGFl
biBzdWJ0eXBlPw0KPiANCj4gTWF5YmUgaXQnZCBiZSBiZXR0ZXIgdGhhdCB6b25lZCBuYW1lc3Bh
Y2UgYWVuIGlzIGhhbmRsZWQgZXhwbGljaXRseQ0KPiBhbmQgcGFzc2VzIGEgQUVOX05TSUQgZW52
IHZlcmlhYmxlIHRvIHRoZSB1ZXZlbnQuDQoNCkknbGwgcmVzcGluIHdpdGggWk5TIHNwZWNpZmlj
IGhhbmRsaW5nIGFuZCBuYW1pbmcgd2l0aCBhIHVuaW9uLiBJDQp0aGluayBpdCdzIHZhbHVhYmxl
IHRvIGtlZXAgZ2VuZXJhdGluZyB1ZXZlbnRzIHdpdGggQUVOX0RBVEEgd2hlbg0Kbm90IFpOUyBv
ciBOT1RJQ0UuICBTb21lIHJlY2VudCB3b3JrIGhhcyBhbGxvd2VkIGFsbCBhbHRlcm5hdGUNCmNv
bW1hbmQgc2V0cyB0byBiZSB1c2VkIHRocm91Z2ggYW4gbmcgZGV2aWNlIHdpdGhvdXQgY2hhbmdl
cyB0bw0KdGhlIGNvcmUuICBUaGlzIGZpbGxzIHRoZSBnYXAgb2YgQUVOIHByb2Nlc3NpbmcuICBU
aGUgZG93biBzaWRlIGlzIGl0J3MNCmRpZmZpY3VsdCB0byB0ZXN0IHRoZSBub24tWk5TIHBhdGgg
d2hlbiBaTlMgaXMgc3BlY2lhbCBjYXNlZC4NCg0K

