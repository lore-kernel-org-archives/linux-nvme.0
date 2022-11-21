Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE7C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pp0hg+x2IYGXYlxwmZ7YXpo4Bg7tukii4RVTwJAAId8=; b=GJflL6ZV98WWOrJKyMBQi0kks8
	moREsGFaEb9uBalDOFXE3eN1KIuMnyVDJFQyvoj+soEUiVWSlujWiAEZMrj6lukbAR7rHhY2W8iEx
	PQUqevWXZFERt5B94FPlX+PiPx2hPeqi/5jglrrSzORSVyYbJzLtmJcrOzsjr31tbLYE2CaXaCmVj
	drZgU1hL1LycnM6J/ivPDdyMUeF0Srgoqi5Ab/oV08KXTlyKgo/e4fOLzKZGrSlKJpDshWfp4AzmB
	nfkO7QaqzqhCPaKiCUTIX0qsvaHIkEi/APvJsOX5abSUfo27Gb3LNshNDtC8o4kK4LM+RZVtRIuxI
	3nqQjr2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox8f8-00F9Km-Hy; Mon, 21 Nov 2022 15:24:46 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox8Qw-00F1FY-Dp
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 15:10:09 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NG9ls0HRSzmVpr;
	Mon, 21 Nov 2022 23:09:29 +0800 (CST)
Received: from kwepemm000014.china.huawei.com (7.193.23.6) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 23:09:58 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm000014.china.huawei.com (7.193.23.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 23:09:57 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Mon, 21 Nov 2022 23:09:57 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBudm1lOiBmaXggbWVt?=
 =?utf-8?B?bGVhayBpbiBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZSgp?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gbnZtZTogZml4IG1lbWxlYWsgaW4g?=
 =?utf-8?B?bnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoKQ==?=
Thread-Index: AQHY/Y7V6+qG/4VcjkiWJOn1jmhu+a5JPohA//98NoCAAIacgP//pxqAgACSzaA=
Date: Mon, 21 Nov 2022 15:09:57 +0000
Message-ID: <60ca79176d924b40b646fd1c9d2c3227@huawei.com>
References: <20221121062113.84721-1-zhangqilong3@huawei.com>
	<b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
	<dacd7300dfe54845b6a5ef2ee8f940d7@huawei.com>
	<9a9512de-1bbc-fafb-74d1-3bd0a156ab81@grimberg.me>
	<3e04d64de5bc4891b67b97f8fc8f9023@huawei.com>
 <e86daef2-dcfc-5918-b718-a6f1d3c6cf9b@grimberg.me>
In-Reply-To: <e86daef2-dcfc-5918-b718-a6f1d3c6cf9b@grimberg.me>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.246]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_071006_842315_721340E8 
X-CRM114-Status: GOOD (  16.19  )
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

PiBPbiAxMS8yMS8yMiAxMzo1NCwgemhhbmdxaWxvbmcgd3JvdGU6DQo+ID4+Pj4+ICAgICBkcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA3ICsrKysrLS0NCj4gPj4+Pj4gICAgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMNCj4gPj4+Pj4gaW5kZXggZGE1NWNlNDVhYzcwLi5lMDZkMWIzOTYxZmUgMTAwNjQ0DQo+
ID4+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+Pj4+PiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4+Pj4gQEAgLTM3NDgsMTMgKzM3NDgsMTYgQEAgc3Rh
dGljIHNzaXplX3QNCj4gPj4+PiBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ID4+Pj4+ICAgICAJCWludCByZXQ7DQo+ID4+Pj4+DQo+ID4+Pj4+ICAg
ICAJCXJldCA9IG52bWVfYXV0aF9nZW5lcmF0ZV9rZXkoZGhjaGFwX3NlY3JldCwNCj4gJmN0cmwt
DQo+ID4+IGhvc3Rfa2V5KTsNCj4gPj4+Pj4gLQkJaWYgKHJldCkNCj4gPj4+Pj4gKwkJaWYgKHJl
dCkgew0KPiA+Pj4+PiArCQkJa2ZyZWUoZGhjaGFwX3NlY3JldCk7DQo+ID4+Pj4+ICAgICAJCQly
ZXR1cm4gcmV0Ow0KPiA+Pj4+PiArCQl9DQo+ID4+Pj4+ICAgICAJCWtmcmVlKG9wdHMtPmRoY2hh
cF9zZWNyZXQpOw0KPiA+Pj4+PiAgICAgCQlvcHRzLT5kaGNoYXBfc2VjcmV0ID0gZGhjaGFwX3Nl
Y3JldDsNCj4gPj4+Pj4gICAgIAkJLyogS2V5IGhhcyBjaGFuZ2VkOyByZS1hdXRoZW50aWNhdGlv
biB3aXRoIG5ldyBrZXkNCj4gKi8NCj4gPj4+Pj4gICAgIAkJbnZtZV9hdXRoX3Jlc2V0KGN0cmwp
Ow0KPiA+Pj4+PiAtCX0NCj4gPj4+Pj4gKwl9IGVsc2UNCj4gPj4+Pj4gKwkJa2ZyZWUoZGhjaGFw
X3NlY3JldCk7DQo+ID4+DQo+ID4+IFBlcmhhcHMgbGV0cyBjaGFuZ2UgdGhlIGNoZWNrIGFib3Zl
IHRvIHN0cm5jbXAgZGlyZWN0bHkgYWdhaW5zdCBidWYNCj4gPj4gYW5kIGFsbG9jYXRlIGluc2lk
ZSB0aGUgY2xhdXNlLg0KPiA+Pg0KPiA+DQo+ID4gR29vZCBzdWdnZXN0aW9uIGFuZCBJIGhhdmUg
dXBkYXRlZCBmaXhlcyBsaWtlOg0KPiA+DQo+ID4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ID4gQEAgLTM3MzAsNyAr
MzczMCw2IEBAIHN0YXRpYyBzc2l6ZV90DQo+IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0X3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiAgIHsNCj4gPiAgICAgICAgICBzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gICAgICAgICAgc3RydWN0IG52
bWZfY3RybF9vcHRpb25zICpvcHRzID0gY3RybC0+b3B0czsNCj4gPiAtICAgICAgIGNoYXIgKmRo
Y2hhcF9zZWNyZXQ7DQo+ID4NCj4gPiAgICAgICAgICBpZiAoIWN0cmwtPm9wdHMtPmRoY2hhcF9z
ZWNyZXQpDQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiBAQCAtMzcz
OSwxNyArMzczOCwyMCBAQCBzdGF0aWMgc3NpemVfdA0KPiBudm1lX2N0cmxfZGhjaGFwX3NlY3Jl
dF9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gICAgICAgICAgaWYgKG1lbWNtcChidWYs
ICJESEhDLTE6IiwgNykpDQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
Pg0KPiA+IC0gICAgICAgZGhjaGFwX3NlY3JldCA9IGt6YWxsb2MoY291bnQgKyAxLCBHRlBfS0VS
TkVMKTsNCj4gPiAtICAgICAgIGlmICghZGhjaGFwX3NlY3JldCkNCj4gPiAtICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gLSAgICAgICBtZW1jcHkoZGhjaGFwX3NlY3JldCwgYnVm
LCBjb3VudCk7DQo+ID4gICAgICAgICAgbnZtZV9hdXRoX3N0b3AoY3RybCk7DQo+ID4gLSAgICAg
ICBpZiAoc3RyY21wKGRoY2hhcF9zZWNyZXQsIG9wdHMtPmRoY2hhcF9zZWNyZXQpKSB7DQo+ID4g
KyAgICAgICBpZiAoc3RybmNtcChidWYsIG9wdHMtPmRoY2hhcF9zZWNyZXQsIGNvdW50KSkgew0K
PiA+ICAgICAgICAgICAgICAgICAgaW50IHJldDsNCj4gPiArICAgICAgICAgICAgICAgY2hhciAq
ZGhjaGFwX3NlY3JldDsNCj4gPg0KPiA+ICsgICAgICAgICAgICAgICBkaGNoYXBfc2VjcmV0ID0g
a3phbGxvYyhjb3VudCArIDEsIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAo
IWRoY2hhcF9zZWNyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07DQo+ID4gKyAgICAgICAgICAgICAgIG1lbWNweShkaGNoYXBfc2VjcmV0LCBidWYsIGNvdW50
KTsNCj4gDQo+IE1heWJlIGttZW1kdXAgaW5zdGVhZD8NCg0KT0ssIEl0IGxvb2tzIGdvb2QuIEkg
d2lsbCB1cGRhdGUgaW4gdmVyc2lvbiB2Mi4NCg0KVGhhbmtzLg0KPiANCj4gPiAgICAgICAgICAg
ICAgICAgIHJldCA9IG52bWVfYXV0aF9nZW5lcmF0ZV9rZXkoZGhjaGFwX3NlY3JldCwgJmN0cmwt
Pmhvc3Rfa2V5KTsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKGRoY2hh
cF9zZWNyZXQpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+
ICsgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgICBrZnJlZShvcHRzLT5kaGNo
YXBfc2VjcmV0KTsNCj4gPg0KPiA+IERvIHlvdSB0aGluayBpcyBpdCB0aGF0IG9rPw0KPiA+DQoN
Cg==

