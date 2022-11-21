Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C9EC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HIA5kztu7mCpBb4pXEcbJGRIDdzecXJE3USJ0/Apjgs=; b=X42oxohfdpq6bfFVagkWweAC5b
	v859weUfIgo4+32W4j5i8TkuAzw0AAqUSxmtLLueRBz4twBydd5HUHO0/3c3YCOZqEOUI1ZXnD5VU
	pFvT9o+PBVDHh+T8XFprr0Mx1Yhlu85RaqDZFULqM0/661y7E+YeUWYt394xRcaIJ5bhG8pFwe+Ip
	ckZqbtUggqlxWBXjqW0rG3p9F2sIrHw2P4b9q5NWZKfEfyBNchaG4eo5ip5PV+fzc6mfXghP3VLMo
	m/nvrhSKmnyrOBpYLY0S0wd7clDMUhlZXgJXKyutQHR0fb4KVyYOooF24WFgWeBs+6x5R8eUmKeSI
	5I5+Wivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox53L-00CxSX-LO; Mon, 21 Nov 2022 11:33:31 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox53I-00CxQ4-Fv
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 11:33:30 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NG4tn3K6JzFqT4;
	Mon, 21 Nov 2022 19:30:09 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (7.193.23.81) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:33:23 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 19:33:23 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2375.031;
 Mon, 21 Nov 2022 19:33:23 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG52bWU6IGZpeCBtZW1sZWFrIGluIG52bWVfY3Ry?=
 =?utf-8?B?bF9kaGNoYXBfc2VjcmV0X3N0b3JlKCk=?=
Thread-Topic: [PATCH] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Thread-Index: AQHY/Y7V6+qG/4VcjkiWJOn1jmhu+a5JPohA
Date: Mon, 21 Nov 2022 11:33:22 +0000
Message-ID: <dacd7300dfe54845b6a5ef2ee8f940d7@huawei.com>
References: <20221121062113.84721-1-zhangqilong3@huawei.com>
 <b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
In-Reply-To: <b86df48d-2fd2-fe90-a1c2-721cb51d826e@grimberg.me>
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
X-CRM114-CacheID: sfid-20221121_033328_716270_7A6835F4 
X-CRM114-Status: GOOD (  17.53  )
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

PiANCj4gPiBJZiBkaGNoYXBfc2VjcmV0IGlzIG5vdCBjb25zaXN0ZW50IHdpdGggb3B0aW9ucyBv
cg0KPiA+IG52bWVfYXV0aF9nZW5lcmF0ZV9rZXkoKSBmYWlscywgd2Ugc2hvdWxkIGZyZWUgdGhl
IG1lbW9yeSBvZg0KPiA+IGRoY2hhcF9zZWNyZXQgdG8gYXZvaWQgbWVtbGVhay4NCj4gPg0KPiA+
IEZpeGVzOiBmNTBmZmY3M2Q2MjAgKCJudm1lOiBpbXBsZW1lbnQgSW4tQmFuZCBhdXRoZW50aWNh
dGlvbiIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUWlsb25nIDx6aGFuZ3FpbG9uZzNAaHVh
d2VpLmNvbT4NCj4gDQo+IFBsZWFzZSBoYXZlIGEgbG9vayBhdCBudm1lLTYuMiwgaWYgdGhlcmUg
aXMgc3RpbGwgYSBsZWFrLCBwbGVhc2Ugc2VuZCBhIHBhdGNoDQo+IGFnYWluc3QgaXQuDQo+IA0K
DQpIaQ0KICAgICBJIGhhdmUgY2hlY2tlZCBpdCwgIHRoZXJlIGlzIHN0aWxsIGEgbGVhayBhdCBu
dm1lLTYuMi4NCg0KVGhhbmtzLg0KDQo+IFRoYW5rcy4NCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA3ICsrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGluZGV4DQo+
ID4gZGE1NWNlNDVhYzcwLi5lMDZkMWIzOTYxZmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ID4g
QEAgLTM3NDgsMTMgKzM3NDgsMTYgQEAgc3RhdGljIHNzaXplX3QNCj4gbnZtZV9jdHJsX2RoY2hh
cF9zZWNyZXRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAgCQlpbnQgcmV0Ow0KPiA+
DQo+ID4gICAJCXJldCA9IG52bWVfYXV0aF9nZW5lcmF0ZV9rZXkoZGhjaGFwX3NlY3JldCwgJmN0
cmwtDQo+ID5ob3N0X2tleSk7DQo+ID4gLQkJaWYgKHJldCkNCj4gPiArCQlpZiAocmV0KSB7DQo+
ID4gKwkJCWtmcmVlKGRoY2hhcF9zZWNyZXQpOw0KPiA+ICAgCQkJcmV0dXJuIHJldDsNCj4gPiAr
CQl9DQo+ID4gICAJCWtmcmVlKG9wdHMtPmRoY2hhcF9zZWNyZXQpOw0KPiA+ICAgCQlvcHRzLT5k
aGNoYXBfc2VjcmV0ID0gZGhjaGFwX3NlY3JldDsNCj4gPiAgIAkJLyogS2V5IGhhcyBjaGFuZ2Vk
OyByZS1hdXRoZW50aWNhdGlvbiB3aXRoIG5ldyBrZXkgKi8NCj4gPiAgIAkJbnZtZV9hdXRoX3Jl
c2V0KGN0cmwpOw0KPiA+IC0JfQ0KPiA+ICsJfSBlbHNlDQo+ID4gKwkJa2ZyZWUoZGhjaGFwX3Nl
Y3JldCk7DQo+ID4gICAJLyogU3RhcnQgcmUtYXV0aGVudGljYXRpb24gKi8NCj4gPiAgIAlkZXZf
aW5mbyhjdHJsLT5kZXZpY2UsICJyZS1hdXRoZW50aWNhdGluZyBjb250cm9sbGVyXG4iKTsNCj4g
PiAgIAlxdWV1ZV93b3JrKG52bWVfd3EsICZjdHJsLT5kaGNoYXBfYXV0aF93b3JrKTsNCg0K

