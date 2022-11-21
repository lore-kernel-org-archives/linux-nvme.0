Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865CEC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nfVhAYiSrMrFOLyXEkvuYsZWDQVZCgM3mxAGCqdv/L4=; b=feHEjXS+wjDEU0rYtKZteD/osF
	ayVpsYLemndVytiB4kLlpEzwuSELa1IqCa+VeIc3aceFl6qzoYJ32ePpHULxR2ZNphQkB5+Fvr0K3
	sCDjNjxRPkeFb9RIz/jud+DzvXJ1h8DPfle3mslgCTljXKPJtUv8BnMJreAZiSE6b4ukgBPK9+SeT
	7yD0SBEmLfFriha3rz2NIOv+hg/0O3UL47MBVjLc3DHTAUDqXPTA6+W6mreb1frce6+/o+6SEuuLm
	/dLbzjl+SdxynGY+QbAOuYCoLe/sGaaXIaJx9D7SP2zcYOkCjzJb7I2U3n9ZC166+ANH6w9UgGLSU
	mIcaBetA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox5Nf-00D6jq-Pm; Mon, 21 Nov 2022 11:54:31 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox5Nb-00D6gO-SU
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 11:54:30 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NG5QB2kx6z15MmC;
	Mon, 21 Nov 2022 19:53:54 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:54:22 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:54:22 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Mon, 21 Nov 2022 19:54:22 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gbnZtZTogZml4IG1lbWxlYWsgaW4g?=
 =?utf-8?B?bnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoKQ==?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG52bWU6IGZpeCBtZW1sZWFrIGluIG52bWVfY3Ry?=
 =?utf-8?B?bF9kaGNoYXBfc2VjcmV0X3N0b3JlKCk=?=
Thread-Index: AQHY/Y7V6+qG/4VcjkiWJOn1jmhu+a5JPohA//98NoCAAIacgA==
Date: Mon, 21 Nov 2022 11:54:21 +0000
Message-ID: <3e04d64de5bc4891b67b97f8fc8f9023@huawei.com>
References: <20221121062113.84721-1-zhangqilong3@huawei.com>
	<b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
	<dacd7300dfe54845b6a5ef2ee8f940d7@huawei.com>
 <9a9512de-1bbc-fafb-74d1-3bd0a156ab81@grimberg.me>
In-Reply-To: <9a9512de-1bbc-fafb-74d1-3bd0a156ab81@grimberg.me>
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
X-CRM114-CacheID: sfid-20221121_035428_281560_917B58A6 
X-CRM114-Status: GOOD (  13.32  )
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

PiA+Pj4gICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgNyArKysrKy0tDQo+ID4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMNCj4gPj4+IGluZGV4IGRhNTVjZTQ1YWM3MC4uZTA2ZDFiMzk2MWZlIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ID4+PiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gPj4+IEBAIC0zNzQ4LDEzICszNzQ4LDE2IEBAIHN0YXRp
YyBzc2l6ZV90DQo+ID4+IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0X3N0b3JlKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gPj4+ICAgIAkJaW50IHJldDsNCj4gPj4+DQo+ID4+PiAgICAJCXJldCA9IG52
bWVfYXV0aF9nZW5lcmF0ZV9rZXkoZGhjaGFwX3NlY3JldCwgJmN0cmwtDQo+IGhvc3Rfa2V5KTsN
Cj4gPj4+IC0JCWlmIChyZXQpDQo+ID4+PiArCQlpZiAocmV0KSB7DQo+ID4+PiArCQkJa2ZyZWUo
ZGhjaGFwX3NlY3JldCk7DQo+ID4+PiAgICAJCQlyZXR1cm4gcmV0Ow0KPiA+Pj4gKwkJfQ0KPiA+
Pj4gICAgCQlrZnJlZShvcHRzLT5kaGNoYXBfc2VjcmV0KTsNCj4gPj4+ICAgIAkJb3B0cy0+ZGhj
aGFwX3NlY3JldCA9IGRoY2hhcF9zZWNyZXQ7DQo+ID4+PiAgICAJCS8qIEtleSBoYXMgY2hhbmdl
ZDsgcmUtYXV0aGVudGljYXRpb24gd2l0aCBuZXcga2V5ICovDQo+ID4+PiAgICAJCW52bWVfYXV0
aF9yZXNldChjdHJsKTsNCj4gPj4+IC0JfQ0KPiA+Pj4gKwl9IGVsc2UNCj4gPj4+ICsJCWtmcmVl
KGRoY2hhcF9zZWNyZXQpOw0KPiANCj4gUGVyaGFwcyBsZXRzIGNoYW5nZSB0aGUgY2hlY2sgYWJv
dmUgdG8gc3RybmNtcCBkaXJlY3RseSBhZ2FpbnN0IGJ1ZiBhbmQNCj4gYWxsb2NhdGUgaW5zaWRl
IHRoZSBjbGF1c2UuDQo+IA0KDQpHb29kIHN1Z2dlc3Rpb24gYW5kIEkgaGF2ZSB1cGRhdGVkIGZp
eGVzIGxpa2U6DQoNCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jDQpAQCAtMzczMCw3ICszNzMwLDYgQEAgc3RhdGljIHNzaXplX3Qg
bnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KIHsNCiAg
ICAgICAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KICAg
ICAgICBzdHJ1Y3QgbnZtZl9jdHJsX29wdGlvbnMgKm9wdHMgPSBjdHJsLT5vcHRzOw0KLSAgICAg
ICBjaGFyICpkaGNoYXBfc2VjcmV0Ow0KDQogICAgICAgIGlmICghY3RybC0+b3B0cy0+ZGhjaGFw
X3NlY3JldCkNCiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCkBAIC0zNzM5LDE3ICsz
NzM4LDIwIEBAIHN0YXRpYyBzc2l6ZV90IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0X3N0b3JlKHN0
cnVjdCBkZXZpY2UgKmRldiwNCiAgICAgICAgaWYgKG1lbWNtcChidWYsICJESEhDLTE6IiwgNykp
DQogICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQoNCi0gICAgICAgZGhjaGFwX3NlY3Jl
dCA9IGt6YWxsb2MoY291bnQgKyAxLCBHRlBfS0VSTkVMKTsNCi0gICAgICAgaWYgKCFkaGNoYXBf
c2VjcmV0KQ0KLSAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KLSAgICAgICBtZW1jcHko
ZGhjaGFwX3NlY3JldCwgYnVmLCBjb3VudCk7DQogICAgICAgIG52bWVfYXV0aF9zdG9wKGN0cmwp
Ow0KLSAgICAgICBpZiAoc3RyY21wKGRoY2hhcF9zZWNyZXQsIG9wdHMtPmRoY2hhcF9zZWNyZXQp
KSB7DQorICAgICAgIGlmIChzdHJuY21wKGJ1Ziwgb3B0cy0+ZGhjaGFwX3NlY3JldCwgY291bnQp
KSB7DQogICAgICAgICAgICAgICAgaW50IHJldDsNCisgICAgICAgICAgICAgICBjaGFyICpkaGNo
YXBfc2VjcmV0Ow0KDQorICAgICAgICAgICAgICAgZGhjaGFwX3NlY3JldCA9IGt6YWxsb2MoY291
bnQgKyAxLCBHRlBfS0VSTkVMKTsNCisgICAgICAgICAgICAgICBpZiAoIWRoY2hhcF9zZWNyZXQp
DQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCisgICAgICAgICAgICAg
ICBtZW1jcHkoZGhjaGFwX3NlY3JldCwgYnVmLCBjb3VudCk7DQogICAgICAgICAgICAgICAgcmV0
ID0gbnZtZV9hdXRoX2dlbmVyYXRlX2tleShkaGNoYXBfc2VjcmV0LCAmY3RybC0+aG9zdF9rZXkp
Ow0KLSAgICAgICAgICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAgaWYgKHJldCkgew0K
KyAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUoZGhjaGFwX3NlY3JldCk7DQogICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAg
ICAgICBrZnJlZShvcHRzLT5kaGNoYXBfc2VjcmV0KTsNCg0KRG8geW91IHRoaW5rIGlzIGl0IHRo
YXQgb2s/DQoNCg==

