Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FC8C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 01:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJoziP6+b7T9r0ImJh9xgRDH5VfB/Xpihb4duRgmUPk=; b=JZtI9h4neRNaRhQxdcAJW87peG
	eNFidUPEvHD0fmGoRCRatHmVnRgU08fTDyfMftoV3PNRB9xwAXiwy9YVauwTBYKpTuN7Z/53R/kgf
	OmCHFCgIEe4626JP3mCzbHULxucXjNQqn3XvRP4vhRtnku0KHGz9ihTClN/6+5biCJC2QwElyB5Ee
	F+VUMG0rAB2UstECGOVjsNoad1GygcIESgXdmAmHacPuNOMUauRGkeg7Gntl0tMcMbI4EScj0tsuA
	ZSlyGz0JfXpT/YYutpPQWRF8efN0ZfCgAJpuh/Hamr/1ybdvyVplo5XumXLFMFL1kDNXEJIfzEcdi
	iWfsumbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofAc5-003Pf2-Rz; Mon, 03 Oct 2022 01:51:21 +0000
Received: from zg8tmtm4lje5ny4xodqumjaa.icoremail.net ([138.197.184.20])
	by bombadil.infradead.org with smtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofAbx-003PcR-SL
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 01:51:17 +0000
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 3 Oct 2022 09:50:43
 +0800 (GMT+08:00)
X-Originating-IP: [106.117.99.137]
Date: Mon, 3 Oct 2022 09:50:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "James Smart" <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, 
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXnP3zPzpjF6_UBg--.23647W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg4MAVZdtbwGGwAAse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221002_185114_256002_E1690B18 
X-CRM114-Status: GOOD (  15.47  )
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

SGVsbG8sCgpPbiBTdW4sIDIgT2N0IDIwMjIgMTA6MTI6MTUgLTA3MDAgSmFtZXMgU21hcnQgd3Jv
dGU6Cgo+IE9uIDEwLzEvMjAyMiA1OjE5IFBNLCBEdW9taW5nIFpob3Ugd3JvdGU6Cj4gPiBUaGUg
ZnVuY3Rpb24gbHBmY19wb2xsX3RpbWVvdXQoKSBpcyBhIHRpbWVyIGhhbmRsZXIgdGhhdCBydW5z
IGluIGFuCj4gPiBhdG9taWMgY29udGV4dCwgYnV0IGl0IGNhbGxzICJremFsbG9jKC4uLCBHRlBf
S0VSTkVMKSIgdGhhdCBtYXkgc2xlZXAuCj4gPiBBcyBhIHJlc3VsdCwgdGhlIHNsZWVwLWluLWF0
b21pYy1jb250ZXh0IGJ1ZyB3aWxsIGhhcHBlbi4gVGhlIHByb2Nlc3Nlcwo+ID4gaXMgc2hvd24g
YmVsb3c6Cj4gPiAKPiA+IGxwZmNfcG9sbF90aW1lb3V0KCkKPiA+ICAgbHBmY19zbGlfaGFuZGxl
X2Zhc3RfcmluZ19ldmVudCgpCj4gPiAgICBscGZjX3NsaV9wcm9jZXNzX3Vuc29sX2lvY2IoKQo+
ID4gICAgIGxwZmNfY29tcGxldGVfdW5zb2xfaW9jYigpCj4gPiAgICAgIGxwZmNfbnZtZV91bnNv
bF9sc19oYW5kbGVyKCkKPiA+ICAgICAgIGxwZmNfbnZtZV9oYW5kbGVfbHNyZXEoKQo+ID4gICAg
ICAgIG52bWVfZmNfcmN2X2xzX3JlcSgpCj4gPiAgICAgICAgIGt6YWxsb2Moc2l6ZW9mKC4uLCBH
RlBfS0VSTkVMKSAvL21heSBzbGVlcAo+ID4gCj4gPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIGdm
cF90IHBhcmFtZXRlciBvZiBremFsbG9jKCkgZnJvbSBHRlBfS0VSTkVMIHRvCj4gPiBHRlBfQVRP
TUlDIGluIG9yZGVyIHRvIG1pdGlnYXRlIHRoZSBidWcuCj4gPiAKPiA+IEZpeGVzOiAxNGZkMWU5
OGFmYWYgKCJudm1lLWZjOiBBZGQgRGlzY29ubmVjdCBBc3NvY2lhdGlvbiBSY3Ygc3VwcG9ydCIp
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVkdS5jbj4KPiA+
IC0tLQo+ID4gICBkcml2ZXJzL252bWUvaG9zdC9mYy5jIHwgMiArLQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gPiBpbmRl
eCAxMjdhYmFmOWJhNS4uMzY2OThkZmM4YjMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9mYy5jCj4gPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gPiBAQCAtMTc1NCw3
ICsxNzU0LDcgQEAgbnZtZV9mY19yY3ZfbHNfcmVxKHN0cnVjdCBudm1lX2ZjX3JlbW90ZV9wb3J0
ICpwb3J0cHRyLAo+ID4gICAJbHNvcCA9IGt6YWxsb2Moc2l6ZW9mKCpsc29wKSArCj4gPiAgIAkJ
CXNpemVvZih1bmlvbiBudm1lZmNfbHNfcmVxdWVzdHMpICsKPiA+ICAgCQkJc2l6ZW9mKHVuaW9u
IG52bWVmY19sc19yZXNwb25zZXMpLAo+ID4gLQkJCUdGUF9LRVJORUwpOwo+ID4gKwkJCUdGUF9B
VE9NSUMpOwo+ID4gICAJaWYgKCFsc29wKSB7Cj4gPiAgIAkJZGV2X2luZm8obHBvcnQtPmRldiwK
PiA+ICAgCQkJIlJDViAlcyBMUyBmYWlsZWQ6IE5vIG1lbW9yeVxuIiwKPiAKPiBJIHdvdWxkIHBy
ZWZlciB0aGlzIHdhcyBmaXhlZCB3aXRoaW4gbHBmYyByYXRoZXIgdGhhbiBpbnRyb2R1Y2luZyBh
dG9taWMgCj4gYWxsb2NhdGlvbnMgKDFzdCBpbiBlaXRoZXIgaG9zdCBvciB0YXJnZXQgdHJhbnNw
b3J0KS4gIEl0IHdhcyBpbnRyb2R1Y2VkIAo+IGJ5IGxwZmMgY2hhbmdlIGluIGlycSBoYW5kbGlu
ZyBzdHlsZS4KClRoYW5rIHlvdXIgZm9yIHlvdXIgcmVwbHkgYW5kIHN1Z2dlc3Rpb25zIQoKRG8g
eW91IHRoaW5rIGNoYW5nZSB0aGUgbHBmY19wb2xsX3RpbWVvdXQoKSB0byBhIGRlbGF5ZWRfd29y
ayBpcyBiZXR0ZXI/CgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQ==

