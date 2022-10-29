Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717B4FA3743
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Oct 2022 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQcGMC1ElOWzRuWg7TKs+r0GJJZSt6khVI7vjsheMkc=; b=ivE2e4vH7tKVcjlQy+hP5n/MNB
	FYUuyuBvQgSfqVBSwgaTPdUIzoZHcq21RaEW3aY6jxx5LraucZ8ObtAzjMSha3jVpG09mKIuDRvV8
	18qHc1Fprmk7rvgL8Exb0MM5aushlYncbX13kZUKhd9kYsvEuwoaUJlwaOwp5/6RghyDDy2wM5IgD
	i0lKQG9xcHr87WNQiNb1MQNxsHg0k3WJQez6PjIfyUUpiD8dhPZVQBS3q3wlmh2HDKD/RtR5FK0Dq
	B6WGv1dA9o6aOqhFPUnUUV6GaSjU8OOSfG8epjevUnDFJUB1CEbUCLnu+NfRP9UDX2ePblvqoBoT8
	vJbhJiqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooa0z-003UAC-Oo; Sat, 29 Oct 2022 00:47:57 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooa0w-003U8f-Lc
	for linux-nvme@lists.infradead.org; Sat, 29 Oct 2022 00:47:56 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Oct 2022 17:47:45 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::213a:a308:b836:4a06%3]) with mapi id 15.01.2375.032; Fri, 28 Oct 2022
 17:47:45 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Keith
 Busch" <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>
Subject: RE: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Thread-Topic: [PATCH V2 1/2] nvme: Include AEN CQE.DW1 in NVME_AEN uevents
Thread-Index: AQHY1FTl/5xNbvKKu0OeZNJHTFrqZ64TJB2A//+rNrCADQ0ZAIAABeoA///LslA=
Date: Sat, 29 Oct 2022 00:47:44 +0000
Message-ID: <a02c1a5f6fb348e99928ee8538d9f936@kioxia.com>
References: <20220929223955.3275715-1-clay.mayers@kioxia.com>
 <20220929223955.3275715-2-clay.mayers@kioxia.com>
 <20221017132359.GA23141@lst.de> <96244e61f9b94ed3aff59f3f14ecdca4@kioxia.com>
 <20221025153846.GA24661@lst.de>
 <3d95023d-58c1-3d8b-768a-6a986db00e62@grimberg.me>
In-Reply-To: <3d95023d-58c1-3d8b-768a-6a986db00e62@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.77.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_174754_728941_AA862C55 
X-CRM114-Status: GOOD (  23.79  )
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

PiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDI1LCAyMDIyIDk6MDAgQU0NCj4gPj4gV2hhdCBoYXBwZW5zIHRvZGF5IGlzIGEg
d2FybmluZyBpcyBsb2dnZWQgYW5kIHRoZSBsb2cgcGFnZSBpcyBsZWZ0DQo+ID4+IHVucmVhZC4g
IFRoZSBwYXRjaCBjbG9zZXMgdGhhdCBnYXAgYWxsb3dpbmcgWkRDIEFFTnMgdG8gYmUgZW5hYmxl
DQo+ID4+IGFuZCBoYW5kbGVkIGluIHVzZXIgc3BhY2UgZm9yIHRoaW5ncyBsaWtlIFJvY2tzREIn
cyBaZW5GUy4gIEtlcm5lbA0KPiA+PiBjbGllbnRzIHdpbGwgYWxzbyBuZWVkIGEgd2F5IHRvIGhh
bmRsZSB0aGVtLCBidXQgY2FuJ3QgdGhhdCBiZSBhDQo+ID4+IGRpZmZlcmVudCBwYXRjaCBzZXJp
ZXM/DQo+ID4NCj4gPiBUaGUgcHJvYmxlbSBpcyBob3cgdGhlIE5WTWUgQUVOcyB3b3JrIC0gdGhl
IGFyZSByYWlzZWQgYW5kIHRoZW4gdGhlDQo+ID4gQUVOIGNvbW1hbmQgY29tcGxldGlvbiBpcyBk
ZWxpdmVyZWQgYW5kIHRoZXkgYXJlIGNsZWFyZWQgYnkgcmVhZGluZw0KPiA+IHRoZSBsb2cgcGFn
ZS4gIEJ1dCBpZiB3ZSBkZWxpdmVyIHRoZW0gdG8gdXNlcnNwYWNlLCB3ZSBsb3NlIHRoZSBwZW5k
aW5nDQo+ID4gc3RhdGUgb2YgdGhlIEFFTiBmb3IgdGhlIGtlcm5lbC4gIFJpZ2h0IG5vdyB0aGF0
IGlzIG5vdCBhbiBpc3N1ZSwNCj4gPiBidXQgd2UgbG9zZSBhbGwgY2hhbmNlIG9mIGV2ZXIgbWFr
aW5nIHVzZSBvZiB0aGF0IGluZm9ybWF0aW9uIGluDQo+ID4gdGhlIGtlcm5lbC4gIFNvIG1heWJl
IHRoZSBhbnN3ZXIgaXMgdG8gaGFuZGxlIHRoZSBBRU4gaW4gdGhlIGtlcm5lbCwNCj4gPiByZWFk
IHRoZSBjaGFuZ2VkIHpvbmVzIGxvZyBpbiB0aGUga2VybmVsLCBhbmQgdGhlbiBzZW5kIGFuIHVl
dmVudA0KPiA+IGZvciBhbGwgY2hhbmdlcyB6b25lcyB0byB1c2Vyc3BhY2UuDQo+IA0KPiBUaGF0
IGlzIHdoYXQgSSB3YXMgdGhpbmtpbmcuLi4gSSBmZWVsIHdlIGhhZCB0aGlzIGRpc2N1c3Npb24g
YmVmb3JlDQo+IG9uIGEgZGlmZmVyZW50IEFFTiAobWF5YmUgaXQgd2FzIHNvbWV0aGluZyB0aGF0
IHdhbnRlZCB0byBnZXQgQU5BDQo+IGluZm8gdG8gdXNlcnNwYWNlKS4uLg0KDQpJZiB5b3UncmUg
dGhpbmtpbmcgb2YgdGhpczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS9CTDBQ
UjEzTUI0MjkxMzcxQjRGRDQ0QjkzRDE4N0IyMzE5QzQxOUBCTDBQUjEzTUI0MjkxLm5hbXByZDEz
LnByb2Qub3V0bG9vay5jb20vDQpJIHNoYXJlIHRoZSBjb25jZXJuIG9mIGJvdGggdXNlciBhbmQg
a2VybmVsIHJlYWRpbmcgdGhlIEFFTiByZWZlcmVuY2VkDQpsb2cgcGFnZS4gICBUaGUgc29sdXRp
b24gc2hvdWxkIGxvb2sgbW9yZSBsaWtlIHdoYXQgQ2hyaXN0b3BoIG91dGxpbmVkDQphYm92ZSB3
aXRoIHRoZSBrZXJuZWwgcmVhZGluZyB0aGUgbG9nIHBhZ2UgYW5kIHJvdXRpbmcgcmVzdWx0cy4N
Cg0KSG93ZXZlciwgdGhlIFpEQyBBRU4gaXMgbm90IGF0IHRoZSBjb250cm9sbGVyIGxldmVsLiAg
SXQgc3VwcGxpZXMgdGhlDQpOU0lEIHNvIG9ubHkgdGhlIGNvZGUgd3JpdGluZyB0byB0aGUgbmFt
ZXNwYWNlIGNhbiBiZSBub3RpZmllZCBhbmQNCm9ubHkgaXQgd2lsbCByZWFkIHRoZSBsb2cgcGFn
ZS4gIEhvc3QtYXdhcmUgem9uZWQgZGV2aWNlcyBjYW4ndCBiZQ0KcGFydGl0aW9uZWQgc28gcmVz
cG9uc2liaWxpdHkgd291bGRuJ3QgYmUgc3BsaXQgYWNyb3NzIHVzZXIgbW9kZSwNCmtlcm5lbCBv
ciBtdWx0aXBsZSBhcHBsaWNhdGlvbnMuDQoNClllcywgdGhlIGtlcm5lbCBkb2Vzbid0IGdldCB0
byBsb29rIGF0IG15IG5hbWVzcGFjZSdzIFpEQyBlbnRyaWVzIGFuZA0KSXQgaGFzIG5vIHJlYXNv
biB0by4gIEluIHRoZSBmdXR1cmUgd2hlbiB0aGUga2VybmVsIGlzIHByb2Nlc3NpbmcgWkRDDQpl
bnRyaWVzIGZvciBhIG5hbWVzcGFjZSwgSSBzaG91bGRu4oCZdCBleHBlY3QgYSB1ZXZlbnQgb3Ig
dG8gc2VlIGl0cyBaREMNCmVudHJpZXMganVzdCBsaWtlIHR3byBhcHBzIHVzaW5nIGRpZmZlcmVu
dCBuYW1lc3BhY2VzLg0KDQoNCg==

