Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097FCC61DFD
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 07:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3h5MAMMmUk0EY1Z9CD8jEa83DLvliV5XaTunLPPiVfQ=; b=qB6ZbWD6+ocdNByHO/NSWU3y8U
	aB76gmivSB8AKILCcPFMfInIKHzmZsRO8DwdFqT1tU2B9wHKDGE94SKc0qTbFFA5qBv+f/16uxlsI
	vSr9ooJpTf7ZMSTvbbAWV/A+yf00pd6z4attlRyD7Afc7P3v0ypMY5NepN/Rwpk+43ktuebIqM93O
	ng3ZCD0dekb47CjNfGItkD7kZX3a09prFpdeIipZE8u70IjUxxk8CgZMu3ocHlc/VWw/DQE32U+Ko
	5kbLnQKlMD1QlHNVxRyGpGnHKmgaN56FMDVlG4l9tb94YjGp4Cicya8aNhKINn69JPkBGzk8GUVq5
	Hc/vJPag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ff6-0000000DyfP-2TSP;
	Wed, 02 Sep 2026 07:45:36 +0000
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ff2-0000000Dyec-2sIK
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 07:45:34 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3h5MAMMmUk0EY1Z9CD8jEa83DLvliV5XaTunLPPiVfQ=;
	b=Blc8LzTzW/qn9hsp1vAhqSIfMmgZhTfm+vH/oK2ZUfmcOCL7zehbEdqbDPH5qH+u9foU6pzew
	lLm78avDPrBQzzvm0ItUJv1bL5dIJK9gtUe/Wet6Z6ZAns+2PrVX9eHkMn3It2fzklwN6oTgFNG
	rVtnjS4nuDfUkvH3+kaXfuM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hZZHM0sc3z1K96b;
	Wed,  2 Sep 2026 15:34:23 +0800 (CST)
Received: from kwepemk300009.china.huawei.com (unknown [7.202.195.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B7C44058A;
	Wed,  2 Sep 2026 15:45:13 +0800 (CST)
Received: from kwepemk200005.china.huawei.com (7.202.194.71) by
 kwepemk300009.china.huawei.com (7.202.195.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 2 Sep 2026 15:45:12 +0800
Received: from kwepemk200005.china.huawei.com ([7.202.194.71]) by
 kwepemk200005.china.huawei.com ([7.202.194.71]) with mapi id 15.02.2562.045;
 Wed, 2 Sep 2026 15:45:12 +0800
From: Kangfenglong <kangfenglong@huawei.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, liuyonglong
	<liuyonglong@huawei.com>, "Wangyu (Eric)" <seven.wangyu@huawei.com>
Subject: [PATCH v3] nvme-pci: fix CMB mapping when CMBSZ Size field is zero
Thread-Topic: [PATCH v3] nvme-pci: fix CMB mapping when CMBSZ Size field is
 zero
Thread-Index: AQHdAfCi0dQZ95AJYEyV6RZtGnUzlLa60/nA
Date: Wed, 2 Sep 2026 07:45:12 +0000
Message-ID: <a313aae6ec654180b050f2cab12e8400@huawei.com>
References: <20260622024129.40800-1-kangfenglong@huawei.com>
In-Reply-To: <20260622024129.40800-1-kangfenglong@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.121.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_004533_062766_DA37C1A0 
X-CRM114-Status: GOOD (  18.87  )
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

RnJpZW5kbHkgcGluZy4NCkl0IGhhcyBiZWVuIG92ZXIgdHdvIG1vbnRocyBzaW5jZSB0aGlzIHBh
dGNoIHdhcyBzdWJtaXR0ZWQuIEkgd291bGQgaGlnaGx5DQogYXBwcmVjaWF0ZSBpdCBpZiBzb21l
b25lIGNvdWxkIHRha2UgYSBxdWljayBsb29rIG9yIHByb3ZpZGUgc29tZSBmZWVkYmFjay4NClBs
ZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgbW9kaWZpY2F0aW9ucyBhcmUgbmVlZGVkLg0KVGhhbmtz
IQ0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IEthbmdmZW5nbG9uZyA8a2FuZ2Zlbmdsb25n
QGh1YXdlaS5jb20+IA0Kt6LLzcqxvOQ6IDIwMjbE6jbUwjIyyNUgMTA6NDENCsrVvP7Iyzoga2J1
c2NoQGtlcm5lbC5vcmcNCrOty806IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGl1eW9uZ2xvbmcgPGxpdXlvbmdsb25nQGh1YXdlaS5j
b20+OyBXYW5neXUgKEVyaWMpIDxzZXZlbi53YW5neXVAaHVhd2VpLmNvbT47IEthbmdmZW5nbG9u
ZyA8a2FuZ2Zlbmdsb25nQGh1YXdlaS5jb20+DQrW98ziOiBbUEFUQ0ggdjNdIG52bWUtcGNpOiBm
aXggQ01CIG1hcHBpbmcgd2hlbiBDTUJTWiBTaXplIGZpZWxkIGlzIHplcm8NCg0KVGhlIGNvbnRy
b2xsZXIgbWVtb3J5IGJ1ZmZlciBzaXplIGlzIGRlZmluZWQgYnkgdGhlIFNaIGZpZWxkIGluIHRo
ZSBDTUJTWiByZWdpc3RlciAoYml0cyAzMToxMikuIEFjY29yZGluZyB0byB0aGUgTlZNZSBzcGVj
aWZpY2F0aW9uLCBhIHZhbHVlIG9mIHplcm8gaW4gdGhlIFNaIGZpZWxkIGluZGljYXRlcyB0aGF0
IG5vIENNQiBpcyBwcmVzZW50Lg0KDQpDb21taXQgZjY1ZWZkNmRmZTRlICgibnZtZS1wY2k6IGNs
ZWFuIHVwIENNQiBpbml0aWFsaXphdGlvbiIpIHJlcGxhY2VkIHRoZSBjaGVjayBmb3IgYSB6ZXJv
IFNaIGZpZWxkIHdpdGggYSBjaGVjayBmb3IgYSB6ZXJvIENNQlNaIHJlZ2lzdGVyIHZhbHVlLCB1
bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IGEgemVybyByZWdpc3RlciBpbXBsaWVzIG5vIENNQi4N
Ckhvd2V2ZXIsIGEgQ01CU1ogcmVnaXN0ZXIgY2FuIGJlIG5vbi16ZXJvIHdoaWxlIHRoZSBTWiBm
aWVsZCBpcyB6ZXJvLCBmb3IgZXhhbXBsZSB3aGVuIFNpemUgVW5pdHMgKFNaVSkgaXMgc2V0IHRv
IGEgbm9uLXplcm8gdmFsdWUgYnV0IHRoZSBhY3R1YWwgc2l6ZSBpcyB6ZXJvIChlLmcuIENNQlNa
ID0gMHgxMDA6IFNaVSA9IDEsIFNaID0gMCkuDQoNCldoZW4gdGhpcyBoYXBwZW5zLCBudm1lX21h
cF9jbWIoKSBwcm9jZWVkcyB0byBjb21wdXRlIGEgc2l6ZSBvZiB6ZXJvLCBwYXNzZXMgdGhlIGFs
aWdubWVudCBjaGVja3MgKHplcm8gaXMgYWx3YXlzIGFsaWduZWQpLCBhbmQgY2FsbHMNCnBjaV9w
MnBkbWFfYWRkX3Jlc291cmNlKCkgd2l0aCBzaXplPTAuIFRoZSBQMlBETUEgc3Vic3lzdGVtIHRo
ZW4gZGVmYXVsdHMgc2l6ZSB0byB0aGUgZW50aXJlIHJlbWFpbmluZyBCQVIsIHdoaWNoIG1heSBu
b3QgYmUgcHJvcGVybHkgYWxpZ25lZCBmb3IgbWVtb3J5IGhvdHBsdWcsIHRyaWdnZXJpbmc6DQoN
CiAgV0FSTklORzogQ1BVOiAwIFBJRDogMTAgYXQgbW0vbWVtb3J5X2hvdHBsdWcuYzozOTYgX19h
ZGRfcGFnZXMNCiAgTWlzYWxpZ25lZCBfX2FkZF9wYWdlcyBzdGFydDogMHg0OTRhMDAwMCBlbmQ6
IDB4NDk0YTAwMGYNCg0KRml4IHRoaXMgYnk6DQoxLiBSZXN0b3JpbmcgdGhlIGNoZWNrIGZvciBh
IHplcm8gU1ogZmllbGQsIHdoaWNoIGV4cGxpY2l0bHkgdmVyaWZpZXMNCiAgIHRoYXQgdGhlIGNv
bnRyb2xsZXIgYWN0dWFsbHkgaGFzIGEgQ01CIGJlZm9yZSBwcm9jZWVkaW5nLg0KMi4gQWRkaW5n
IGEgYm91bmRhcnkgY2hlY2sgaW4gbnZtZV9jbWJfc2l6ZV91bml0KCkgdG8gcmVqZWN0IFNaVSB2
YWx1ZXMNCiAgIGdyZWF0ZXIgdGhhbiA2LiBUaGUgU1pVIGZpZWxkIGlzIDQgYml0cywgYnV0IHZh
bHVlcyA3LTE1IGFyZSByZXNlcnZlZA0KICAgYnkgdGhlIE5WTWUgc3BlY2lmaWNhdGlvbiBhbmQg
cHJvZHVjZSBhIHNoaWZ0IGNvdW50ID49IDQwIGluIHRoZQ0KICAgbGVmdC1zaGlmdCBvcGVyYXRp
b24gKDFVTEwgPDwgKDEyICsgNCAqIHN6dSkgd2hlbiBzenUgPj0gNyksIHdoaWNoDQogICBleGNl
ZWRzIHRoZSBtYXhpbXVtIDY0IEdCIHVuaXQgc2l6ZSBkZWZpbmVkIGJ5IHRoZSBzcGVjLg0KMy4g
Q2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBudm1lX2NtYl9zaXplX3VuaXQoKSBmb3IgemVy
byBiZWZvcmUNCiAgIHByb2NlZWRpbmcsIGFuZCB1c2luZyBjaGVja19tdWxfb3ZlcmZsb3coKSBm
b3IgdGhlIHNpemUgY2FsY3VsYXRpb24NCiAgIHRvIGRldGVjdCBpbnRlZ2VyIG92ZXJmbG93IHRo
YXQgY291bGQgd3JhcCB0byBhIG5vbi16ZXJvIHZhbHVlIGFuZA0KICAgYnlwYXNzIHRoZSBTWiBj
aGVjay4NCg0KRml4ZXM6IGY2NWVmZDZkZmU0ZSAoIm52bWUtcGNpOiBjbGVhbiB1cCBDTUIgaW5p
dGlhbGl6YXRpb24iKQ0KU2lnbmVkLW9mZi1ieToga2FuZ2Zlbmdsb25nIDxrYW5nZmVuZ2xvbmdA
aHVhd2VpLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMTMgKysrKysrKysr
KystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9wY2kuYyBpbmRleCA4NDM4YzkwNGVjNDkuLmVlMmQ3ODJmNDk1NyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KQEAg
LTI0NDgsNiArMjQ0OCw5IEBAIHN0YXRpYyB1NjQgbnZtZV9jbWJfc2l6ZV91bml0KHN0cnVjdCBu
dm1lX2RldiAqZGV2KSAgew0KIAl1OCBzenUgPSAoZGV2LT5jbWJzeiA+PiBOVk1FX0NNQlNaX1Na
VV9TSElGVCkgJiBOVk1FX0NNQlNaX1NaVV9NQVNLOw0KIA0KKwlpZiAoc3p1ID4gNikNCisJCXJl
dHVybiAwOw0KKw0KIAlyZXR1cm4gMVVMTCA8PCAoMTIgKyA0ICogc3p1KTsNCiB9DQogDQpAQCAt
MjQ1OCw3ICsyNDYxLDcgQEAgc3RhdGljIHUzMiBudm1lX2NtYl9zaXplKHN0cnVjdCBudm1lX2Rl
diAqZGV2KQ0KIA0KIHN0YXRpYyB2b2lkIG52bWVfbWFwX2NtYihzdHJ1Y3QgbnZtZV9kZXYgKmRl
dikgIHsNCi0JdTY0IHNpemUsIG9mZnNldDsNCisJdTY0IHNpemUsIHVuaXRfc2l6ZSwgb2Zmc2V0
Ow0KIAlyZXNvdXJjZV9zaXplX3QgYmFyX3NpemU7DQogCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0g
dG9fcGNpX2RldihkZXYtPmRldik7DQogCWludCBiYXI7DQpAQCAtMjQ3Miw5ICsyNDc1LDE1IEBA
IHN0YXRpYyB2b2lkIG52bWVfbWFwX2NtYihzdHJ1Y3QgbnZtZV9kZXYgKmRldikNCiAJZGV2LT5j
bWJzeiA9IHJlYWRsKGRldi0+YmFyICsgTlZNRV9SRUdfQ01CU1opOw0KIAlpZiAoIWRldi0+Y21i
c3opDQogCQlyZXR1cm47DQorCWlmICghbnZtZV9jbWJfc2l6ZShkZXYpKQ0KKwkJcmV0dXJuOw0K
IAlkZXYtPmNtYmxvYyA9IHJlYWRsKGRldi0+YmFyICsgTlZNRV9SRUdfQ01CTE9DKTsNCiANCi0J
c2l6ZSA9IG52bWVfY21iX3NpemVfdW5pdChkZXYpICogbnZtZV9jbWJfc2l6ZShkZXYpOw0KKwl1
bml0X3NpemUgPSBudm1lX2NtYl9zaXplX3VuaXQoZGV2KTsNCisJaWYgKCF1bml0X3NpemUpDQor
CQlyZXR1cm47DQorCWlmIChjaGVja19tdWxfb3ZlcmZsb3codW5pdF9zaXplLCBudm1lX2NtYl9z
aXplKGRldiksICZzaXplKSkNCisJCXJldHVybjsNCiAJb2Zmc2V0ID0gbnZtZV9jbWJfc2l6ZV91
bml0KGRldikgKiBOVk1FX0NNQl9PRlNUKGRldi0+Y21ibG9jKTsNCiAJYmFyID0gTlZNRV9DTUJf
QklSKGRldi0+Y21ibG9jKTsNCiAJYmFyX3NpemUgPSBwY2lfcmVzb3VyY2VfbGVuKHBkZXYsIGJh
cik7DQotLQ0KMi4xMi4wLndpbmRvd3MuMQ0KDQo=

