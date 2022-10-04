Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D332C43217
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EG/6IurmE+OPMDvTlXdom/akqpButAE+e0Ozv6o5wIo=; b=wA1kRY4ST7SQgihVJ9ReTWEYqi
	Ib3i26xlx5NuNp9nNP2ksy48niMagOzRC6WSce6FeoBik1YaGRrJ+VeY9Up6obUKVKQnZlMWPQ1nD
	yRsJP5Y7kOVi5rKI2Lkt1tQRqr6qP6URi0qA90MIvgqreWG2w8EMXVwcHLFUeosmhs17CkoFTUadU
	wviXCGxWyzoCMlQQakxLHkCQl5wM2u6/B09iS/0mEiLqoiFAhAaf0swHuBOBhsbmdd7ykKoumCBir
	Ghj6w/3cB6IHNpUQjODnH+lagVLDHePQTg+2aUH0Z8f3l04EeiXujMwD9n5+wwLEEyn3E14WrczEc
	WSIKw+Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1offpB-009SqG-DF; Tue, 04 Oct 2022 11:10:57 +0000
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223])
	by bombadil.infradead.org with smtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1offp6-009Sos-3t
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 11:10:55 +0000
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 4 Oct 2022 19:10:19
 +0800 (GMT+08:00)
X-Originating-IP: [106.117.99.137]
Date: Tue, 4 Oct 2022 19:10:19 +0800 (GMT+08:00)
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
In-Reply-To: <8aeea62b-c947-6414-bca1-3bd3f427cd56@gmail.com>
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
 <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
 <8aeea62b-c947-6414-bca1-3bd3f427cd56@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <118cdb2e.1067d5.183a2b07fa7.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgA3jw6bFDxjJqZ0Bw--.52252W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgcNAVZdtbwyZQAEsY
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_041052_463124_969CE112 
X-CRM114-Status: GOOD (  26.46  )
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

SGVsbG8sCgpPbiBNb24sIDMgT2N0IDIwMjIgMTA6NDg6MzEgLTA3MDAgSmFtZXMgU21hcnQgd3Jv
dGU6Cgo+IE9uIDEwLzIvMjAyMiA3OjU2IFBNLCBKYW1lcyBTbWFydCB3cm90ZToKPiA+IE9uIDEw
LzIvMjAyMiA2OjUwIFBNLCBkdW9taW5nQHpqdS5lZHUuY24gd3JvdGU6Cj4gPj4gSGVsbG8sCj4g
Pj4KPiA+PiBPbiBTdW4sIDIgT2N0IDIwMjIgMTA6MTI6MTUgLTA3MDAgSmFtZXMgU21hcnQgd3Jv
dGU6Cj4gPj4KPiA+Pj4gT24gMTAvMS8yMDIyIDU6MTkgUE0sIER1b21pbmcgWmhvdSB3cm90ZToK
PiA+Pj4+IFRoZSBmdW5jdGlvbiBscGZjX3BvbGxfdGltZW91dCgpIGlzIGEgdGltZXIgaGFuZGxl
ciB0aGF0IHJ1bnMgaW4gYW4KPiA+Pj4+IGF0b21pYyBjb250ZXh0LCBidXQgaXQgY2FsbHMgImt6
YWxsb2MoLi4sIEdGUF9LRVJORUwpIiB0aGF0IG1heSBzbGVlcC4KPiA+Pj4+IEFzIGEgcmVzdWx0
LCB0aGUgc2xlZXAtaW4tYXRvbWljLWNvbnRleHQgYnVnIHdpbGwgaGFwcGVuLiBUaGUgcHJvY2Vz
c2VzCj4gPj4+PiBpcyBzaG93biBiZWxvdzoKPiA+Pj4+Cj4gPj4+PiBscGZjX3BvbGxfdGltZW91
dCgpCj4gPj4+PiDCoMKgIGxwZmNfc2xpX2hhbmRsZV9mYXN0X3JpbmdfZXZlbnQoKQo+ID4+Pj4g
wqDCoMKgIGxwZmNfc2xpX3Byb2Nlc3NfdW5zb2xfaW9jYigpCj4gPj4+PiDCoMKgwqDCoCBscGZj
X2NvbXBsZXRlX3Vuc29sX2lvY2IoKQo+ID4+Pj4gwqDCoMKgwqDCoCBscGZjX252bWVfdW5zb2xf
bHNfaGFuZGxlcigpCj4gPj4+PiDCoMKgwqDCoMKgwqAgbHBmY19udm1lX2hhbmRsZV9sc3JlcSgp
Cj4gPj4+PiDCoMKgwqDCoMKgwqDCoCBudm1lX2ZjX3Jjdl9sc19yZXEoKQo+ID4+Pj4gwqDCoMKg
wqDCoMKgwqDCoCBremFsbG9jKHNpemVvZiguLiwgR0ZQX0tFUk5FTCkgLy9tYXkgc2xlZXAKPiA+
Pj4+Cj4gPj4+PiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIGdmcF90IHBhcmFtZXRlciBvZiBremFs
bG9jKCkgZnJvbSBHRlBfS0VSTkVMIHRvCj4gPj4+PiBHRlBfQVRPTUlDIGluIG9yZGVyIHRvIG1p
dGlnYXRlIHRoZSBidWcuCj4gPj4+Pgo+ID4+Pj4gRml4ZXM6IDE0ZmQxZTk4YWZhZiAoIm52bWUt
ZmM6IEFkZCBEaXNjb25uZWN0IEFzc29jaWF0aW9uIFJjdiBzdXBwb3J0IikKPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IER1b21pbmcgWmhvdSA8ZHVvbWluZ0B6anUuZWR1LmNuPgo+ID4+Pj4gLS0tCj4g
Pj4+PiDCoMKgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgfCAyICstCj4gPj4+PiDCoMKgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4+Pj4KPiA+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYy5jIGIvZHJpdmVycy9udm1lL2hvc3QvZmMu
Ywo+ID4+Pj4gaW5kZXggMTI3YWJhZjliYTUuLjM2Njk4ZGZjOGIzIDEwMDY0NAo+ID4+Pj4gLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvZmMuYwo+ID4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3Qv
ZmMuYwo+ID4+Pj4gQEAgLTE3NTQsNyArMTc1NCw3IEBAIG52bWVfZmNfcmN2X2xzX3JlcShzdHJ1
Y3QgbnZtZV9mY19yZW1vdGVfcG9ydCAKPiA+Pj4+ICpwb3J0cHRyLAo+ID4+Pj4gwqDCoMKgwqDC
oMKgIGxzb3AgPSBremFsbG9jKHNpemVvZigqbHNvcCkgKwo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzaXplb2YodW5pb24gbnZtZWZjX2xzX3JlcXVlc3RzKSArCj4gPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZih1bmlvbiBudm1lZmNfbHNfcmVzcG9u
c2VzKSwKPiA+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwpOwo+ID4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0FUT01JQyk7Cj4gPj4+PiDCoMKgwqDCoMKgwqAg
aWYgKCFsc29wKSB7Cj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mbyhscG9ydC0+
ZGV2LAo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUkNWICVzIExTIGZhaWxl
ZDogTm8gbWVtb3J5XG4iLAo+ID4+Pgo+ID4+PiBJIHdvdWxkIHByZWZlciB0aGlzIHdhcyBmaXhl
ZCB3aXRoaW4gbHBmYyByYXRoZXIgdGhhbiBpbnRyb2R1Y2luZyBhdG9taWMKPiA+Pj4gYWxsb2Nh
dGlvbnMgKDFzdCBpbiBlaXRoZXIgaG9zdCBvciB0YXJnZXQgdHJhbnNwb3J0KS7CoCBJdCB3YXMg
aW50cm9kdWNlZAo+ID4+PiBieSBscGZjIGNoYW5nZSBpbiBpcnEgaGFuZGxpbmcgc3R5bGUuCj4g
Pj4KPiA+PiBUaGFuayB5b3VyIGZvciB5b3VyIHJlcGx5IGFuZCBzdWdnZXN0aW9ucyEKPiA+Pgo+
ID4+IERvIHlvdSB0aGluayBjaGFuZ2UgdGhlIGxwZmNfcG9sbF90aW1lb3V0KCkgdG8gYSBkZWxh
eWVkX3dvcmsgaXMgYmV0dGVyPwo+ID4+Cj4gPj4gQmVzdCByZWdhcmRzLAo+ID4+IER1b21pbmcg
WmhvdQo+ID4gCj4gPiBhcyBhIG1pbmltdW06IHRoZSBscGZjX2NvbXBsZXRlX3Vuc29sX2lvY2Ig
aGFuZGxlciBzaG91bGQgYmUgcGFzc2luZyBvZmYgCj4gPiB0aGUgaW9jYiB0byBhIHdvcmsgcXVl
dWUgcm91dGluZSAtIHNvIHRoYXQgdGhlIGNvbnRleHQgY2hhbmdlcyBzbyB0aGF0IAo+ID4gZWl0
aGVyIG52bWUgaG9zdCBvciBudm1ldCBscyBjYWxsYmFjayByb3V0aW5lcyBjYW4gYmUgY2FsbGVk
LiBJZiAKPiA+IHBvc3NpYmxlLCBpdCBzaG91bGQgZG8gdGhlIGF4Y2hnIGFsbG9jIC0gdG8gYXZv
aWQgYSBHRlBfQVRPTUlDIHRoZXJlIGFzIAo+ID4gd2VsbC4uLgo+ID4gCj4gPiBJdCdzIHVzdWFs
bHkgYmVzdCBmb3IgdGhlc2UgbnZtZSBMUydzIGFuZCBFTFMncyB0byBiZSBkb25lIGluIGEgc2xv
dyAKPiA+IHBhdGggdGhyZWFkL3dvcmsgcXVldWUgZWxlbWVudC4gVGhhdCBtYXkgbWVhbiBzZWdt
ZW50aW5nIGEgbGl0dGxlIAo+ID4gZWFybGllciBpbiB0aGUgcGF0aC4KPiA+IAo+ID4gLS0gamFt
ZXMKPiA+IAo+IAo+IGxvb2tpbmcgZnVydGhlci4uLiAgIGxwZmNfcG9sbF90aW1lb3V0KCkgc2hv
dWxkIG9ubHkgYmUgdXNlZCBvbiBhbiBTTEktMyAKPiBhZGFwdGVyLiAgVGhlIGV4aXN0aW5nIFNM
SS0zIGFkYXB0ZXJzIGRvbid0IHN1cHBvcnQgTlZNZS4gU28gSSdtIGEgCj4gbGl0dGxlIGNvbmZ1
c2VkIGJ5IHRoaXMgc3RhY2sgdHJhY2UuCgpJIGZvdW5kIHRoaXMgcHJvYmxlbSB0aHJvdWdoIGEg
c3RhdGljIGFuYWx5c2lzIHRvb2wgd3JvdGVuIGJ5IG15c2VsZi4KSSB0aGluayB0aGUgaGFja2Vy
IG1heSBzaW11bGF0ZSB0aGUgaGFyZHdhcmUgdG8gdHJpZ2dlciB0aGlzIHN0YWNrIHRyYWNlLgpT
bywgSSBzZW5kIHRoZSBwYXRjaCB0byBjb3JyZWN0IHRoZSBwcm9ibGVtLgoKPiBDYW4geW91IGRl
c2NyaWJlIHdoYXQgdGhlIHN5c3RlbSBjb25maWcvc29mdHdhcmUgc2V0dXAgaXMgYW5kIAo+IHNw
ZWNpZmljYWxseSB3aGF0IGxwZmMgYWRhcHRlciBpcyBiZWluZyB1c2VkIChkbWVzZyBhdHRhY2ht
ZW50IGxvZ3MgYXJlIAo+IHN1ZmZpY2llbnQsIG9yIGxzcGNpIG91dHB1dCkuCgpCZXN0IHJlZ2Fy
ZHMsCkR1b21pbmcgWmhvdQoK

