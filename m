Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7674BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2UloWusLxRsmcs11mM8V8zr1SU9TPq5sTgQNgw1kTjk=; b=ZzTlcLAGN+Bhgxb2sUP7rIGcMw
	yrmGmenA36Nyitqj0wgns6JCucyifG8bnOXTGw4WTe1TOIN3vh+UyVebycDcsEQtexMAyaCJM7k5C
	u2g4DiwzufC+bfbbkGs+iBvZ1I+fDUJZK/WQdHbYzbmi2DVs7naZtFMIMrXRZM7XiFVyIGio52Xl+
	bOVomsVmTA3fccbNLVdG1CJiTZAa9caHymiTbHB6z54oo5xv9GLKeynroCjL20ogaA68h84tG9Pnw
	eJGGouyAkK2GEn3Q7SZ0KMasvaNnl/yfgddiaH37zC7e6PtsYSQGt/B31E+5X3pXjVlL+w8prX4Zi
	JcbaMZKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWgGv-00BW2r-Sy; Tue, 22 Mar 2022 15:18:09 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWgGt-00BW2J-Kl
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 15:18:09 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 08:18:03 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::b962:3005:acea:aa09]) by
 SJSMAIL01.us.kioxia.com ([fe80::b962:3005:acea:aa09%5]) with mapi id
 15.01.2176.014; Tue, 22 Mar 2022 08:18:03 -0700
From: Clay Mayers <Clay.Mayers@kioxia.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "asml.silence@gmail.com" <asml.silence@gmail.com>
CC: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "sbates@raithlin.com" <sbates@raithlin.com>, "logang@deltatee.com"
 <logang@deltatee.com>, "pankydev8@gmail.com" <pankydev8@gmail.com>,
 "javier@javigon.com" <javier@javigon.com>, "mcgrof@kernel.org"
 <mcgrof@kernel.org>, "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, "anuj20.g@samsung.com"
 <anuj20.g@samsung.com>
Subject: RE: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Thread-Topic: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Thread-Index: AQHYMwaP8WKeHTnbdEm2AUHWA0dFWKzLlXmw
Date: Tue, 22 Mar 2022 15:18:03 +0000
Message-ID: <d66a6bb2d0974171b44777dd07889473@kioxia.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
In-Reply-To: <20220308152105.309618-6-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.90.53.183]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_081807_704646_C9CAF920 
X-CRM114-Status: GOOD (  10.98  )
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

PiBGcm9tOiBLYW5jaGFuIEpvc2hpDQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDgsIDIwMjIgNzoy
MSBBTQ0KPiBUbzogYXhib2VAa2VybmVsLmRrOyBoY2hAbHN0LmRlOyBrYnVzY2hAa2VybmVsLm9y
ZzsNCj4gYXNtbC5zaWxlbmNlQGdtYWlsLmNvbQ0KPiBDYzogaW8tdXJpbmdAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBibG9ja0B2Z2Vy
Lmtlcm5lbC5vcmc7IHNiYXRlc0ByYWl0aGxpbi5jb207IGxvZ2FuZ0BkZWx0YXRlZS5jb207DQo+
IHBhbmt5ZGV2OEBnbWFpbC5jb207IGphdmllckBqYXZpZ29uLmNvbTsgbWNncm9mQGtlcm5lbC5v
cmc7DQo+IGEubWFuemFuYXJlc0BzYW1zdW5nLmNvbTsgam9zaGlpaXRyQGdtYWlsLmNvbTsgYW51
ajIwLmdAc2Ftc3VuZy5jb20NCj4gU3ViamVjdDogW1BBVENIIDA1LzE3XSBudm1lOiB3aXJlLXVw
IHN1cHBvcnQgZm9yIGFzeW5jLXBhc3N0aHJ1IG9uIGNoYXItDQo+IGRldmljZS4NCj4gDQoNCg0K
PHNuaXA+DQo+ICtzdGF0aWMgdm9pZCBudm1lX3B0X3Rhc2tfY2Ioc3RydWN0IGlvX3VyaW5nX2Nt
ZCAqaW91Y21kKQ0KPiArew0KPiArCXN0cnVjdCBudm1lX3VyaW5nX2NtZF9wZHUgKnBkdSA9IG52
bWVfdXJpbmdfY21kX3BkdShpb3VjbWQpOw0KPiArCXN0cnVjdCByZXF1ZXN0ICpyZXEgPSBwZHUt
PnJlcTsNCj4gKwlpbnQgc3RhdHVzOw0KPiArCXN0cnVjdCBiaW8gKmJpbyA9IHJlcS0+YmlvOw0K
PiArDQo+ICsJaWYgKG52bWVfcmVxKHJlcSktPmZsYWdzICYgTlZNRV9SRVFfQ0FOQ0VMTEVEKQ0K
PiArCQlzdGF0dXMgPSAtRUlOVFI7DQo+ICsJZWxzZQ0KPiArCQlzdGF0dXMgPSBudm1lX3JlcShy
ZXEpLT5zdGF0dXM7DQo+ICsNCj4gKwkvKiB3ZSBjYW4gZnJlZSByZXF1ZXN0ICovDQo+ICsJYmxr
X21xX2ZyZWVfcmVxdWVzdChyZXEpOw0KPiArCWJsa19ycV91bm1hcF91c2VyKGJpbyk7DQo+ICsN
Cj4gKwlpZiAoIXN0YXR1cyAmJiBwZHUtPm1ldGFfYnVmZmVyKSB7DQo+ICsJCWlmIChjb3B5X3Rv
X3VzZXIocGR1LT5tZXRhX2J1ZmZlciwgcGR1LT5tZXRhLCBwZHUtDQo+ID5tZXRhX2xlbikpDQoN
ClRoaXMgY29weSBpcyBpbmNvcnJlY3RseSBjYWxsZWQgZm9yIHdyaXRlcy4NCg0KPiArCQkJc3Rh
dHVzID0gLUVGQVVMVDsNCj4gKwl9DQo+ICsJa2ZyZWUocGR1LT5tZXRhKTsNCj4gKw0KPiArCWlv
X3VyaW5nX2NtZF9kb25lKGlvdWNtZCwgc3RhdHVzKTsNCj4gK30NCjwvc25pcD4NCg==

