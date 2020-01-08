Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC0AC282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 21:50:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963920692
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 21:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b5FuqN3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963920692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yt4VWjL7dBDTjqg5B/AlS/8jDuLk8jHLhRF8XYw2lDg=; b=b5FuqN3OuOdxqR
	ZhW8hU+lb8h2Xrv9awHW7sPqnmjKAdDTROvGlpzfsO0BHipZHIWsc28/WuUPuiTqTXtLCrVTVv9H5
	7M4F125nF06+RHg5lK4Ht8KwZrJfU+pdy5R0GT+t3OSBDqfoTSTouGj1GWl/Avhqq5gnSgcoKaVlx
	ItWoHLrcsZdw1WSoKHtcLdhszxnV4GXLDG6AhDE6MirBOEQmwfCBVxwjElprM/lVlWKksQ3Vm6MZ0
	iBa4chHMdQwxBUUYl2C8PoXXsLP3KMH67Rs1JhThzWjFtIQLi4H2NGCqji8Lhy/6wkkjUMeFqBZtB
	rqH+SX3VJxyr779ygbGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipJDn-0007FC-JI; Wed, 08 Jan 2020 21:50:35 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipJDj-0007Dv-Jb
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 21:50:34 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1ipJDT-00014M-FT; Wed, 08 Jan 2020 14:50:16 -0700
To: Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200108174030.3430-1-logang@deltatee.com>
 <20200108174030.3430-7-logang@deltatee.com>
 <707b39a3-b58a-44b7-7ffa-0c2bd3f28e21@mellanox.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2d8a1cc2-be58-176e-b12b-8dbc5dab8739@deltatee.com>
Date: Wed, 8 Jan 2020 14:50:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <707b39a3-b58a-44b7-7ffa-0c2bd3f28e21@mellanox.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 sbates@raithlin.com, chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v10 6/9] nvme: Export existing nvme core functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_135031_639559_4C97FC2A 
X-CRM114-Status: GOOD (  14.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLTAxLTA4IDI6NDggcC5tLiwgTWF4IEd1cnRvdm95IHdyb3RlOgo+IAo+IE9uIDEv
OC8yMDIwIDc6NDAgUE0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4gRXhwb3J0IG52bWVfcHV0
X25zKCksIG52bWVfY29tbWFuZF9lZmZlY3RzKCksIG52bWVfZXhlY3V0ZV9wYXNzdGhydV9ycSgp
Cj4+IGFuZCBudm1lX2ZpbmRfZ2V0X25zKCkgZm9yIHVzZSBpbiB0aGUgbnZtZXQgcGFzc3RocnUg
Y29kZS4KPj4KPj4gVGhlIGV4cG9ydHMgYXJlIGNvbmRpdGlvbmFsIG9uIENPTkZJR19OVk1FX1RB
UkdFVF9QQVNTVEhSVS4KPj4KPj4gQmFzZWQtb24tYS1wYXRjaC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogTG9nYW4g
R3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jIHwgMTQgKysrKysrKysrLS0tLS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3Qv
bnZtZS5oIHzCoCA1ICsrKysrCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCBkNzkxMmU3YTk5MTEuLjAz
NzQxNTg4MmQ0NiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+ICsr
KyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtNDYzLDcgKzQ2Myw3IEBAIHN0YXRp
YyB2b2lkIG52bWVfZnJlZV9ucyhzdHJ1Y3Qga3JlZiAqa3JlZikKPj4gwqDCoMKgwqDCoCBrZnJl
ZShucyk7Cj4+IMKgIH0KPj4gwqAgLXN0YXRpYyB2b2lkIG52bWVfcHV0X25zKHN0cnVjdCBudm1l
X25zICpucykKPj4gK3ZvaWQgbnZtZV9wdXRfbnMoc3RydWN0IG52bWVfbnMgKm5zKQo+PiDCoCB7
Cj4+IMKgwqDCoMKgwqAga3JlZl9wdXQoJm5zLT5rcmVmLCBudm1lX2ZyZWVfbnMpOwo+PiDCoCB9
Cj4+IEBAIC04OTYsOCArODk2LDggQEAgc3RhdGljIHZvaWQgKm52bWVfYWRkX3VzZXJfbWV0YWRh
dGEoc3RydWN0IGJpbwo+PiAqYmlvLCB2b2lkIF9fdXNlciAqdWJ1ZiwKPj4gwqDCoMKgwqDCoCBy
ZXR1cm4gRVJSX1BUUihyZXQpOwo+PiDCoCB9Cj4+IMKgIC1zdGF0aWMgdTMyIG52bWVfY29tbWFu
ZF9lZmZlY3RzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdAo+PiBudm1lX25zICpucywK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OCBvcGNvZGUpCj4+ICt1MzIgbnZt
ZV9jb21tYW5kX2VmZmVjdHMoc3RydWN0IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfbnMg
Km5zLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU4IG9wY29kZSkKPj4gwqAgewo+PiDC
oMKgwqDCoMKgIHUzMiBlZmZlY3RzID0gMDsKPj4gwqAgQEAgLTk4Miw3ICs5ODIsNyBAQCBzdGF0
aWMgdm9pZCBudm1lX3Bhc3N0aHJ1X2VuZChzdHJ1Y3QgbnZtZV9jdHJsCj4+ICpjdHJsLCB1MzIg
ZWZmZWN0cykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcXVldWVfc2NhbihjdHJsKTsKPj4g
wqAgfQo+PiDCoCAtc3RhdGljIHZvaWQgbnZtZV9leGVjdXRlX3Bhc3N0aHJ1X3JxKHN0cnVjdCBy
ZXF1ZXN0ICpycSkKPj4gK3ZvaWQgbnZtZV9leGVjdXRlX3Bhc3N0aHJ1X3JxKHN0cnVjdCByZXF1
ZXN0ICpycSkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2NvbW1hbmQgKmNtZCA9
IG52bWVfcmVxKHJxKS0+Y21kOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2N0cmwgKmN0cmwg
PSBudm1lX3JlcShycSktPmN0cmw7Cj4+IEBAIC0zNDQxLDcgKzM0NDEsNyBAQCBzdGF0aWMgaW50
IG5zX2NtcCh2b2lkICpwcml2LCBzdHJ1Y3QgbGlzdF9oZWFkCj4+ICphLCBzdHJ1Y3QgbGlzdF9o
ZWFkICpiKQo+PiDCoMKgwqDCoMKgIHJldHVybiBuc2EtPmhlYWQtPm5zX2lkIC0gbnNiLT5oZWFk
LT5uc19pZDsKPj4gwqAgfQo+PiDCoCAtc3RhdGljIHN0cnVjdCBudm1lX25zICpudm1lX2ZpbmRf
Z2V0X25zKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4+IHVuc2lnbmVkIG5zaWQpCj4+ICtzdHJ1
Y3QgbnZtZV9ucyAqbnZtZV9maW5kX2dldF9ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNp
Z25lZCBuc2lkKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMgKm5zLCAqcmV0
ID0gTlVMTDsKPj4gwqAgQEAgLTQyMjUsNiArNDIyNSwxMCBAQCBFWFBPUlRfU1lNQk9MX0dQTChu
dm1lX3N5bmNfcXVldWVzKTsKPj4gwqDCoCAqIHVzZSBieSB0aGUgbnZtZXQtcGFzc3RocnUgYW5k
IHNob3VsZCBub3QgYmUgdXNlZCBmb3IKPj4gwqDCoCAqIG90aGVyIHRoaW5ncy4KPj4gwqDCoCAq
Lwo+PiArRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9wdXRfbnMpOwo+PiArRVhQT1JUX1NZTUJPTF9H
UEwobnZtZV9jb21tYW5kX2VmZmVjdHMpOwo+PiArRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9leGVj
dXRlX3Bhc3N0aHJ1X3JxKTsKPj4gK0VYUE9SVF9TWU1CT0xfR1BMKG52bWVfZmluZF9nZXRfbnMp
Owo+IAo+IFNpbmNlIHRoaXMgaXMgdGhlIGNvbnZlbnRpb24gaW4gdGhlIGRyaXZlciwgY2FuIHlv
dSBleHBvcnQgdGhlIHN5bWJvbHMKPiBhdCB0aGUgZW5kIG9mIGVhY2ggZnVuY3Rpb24gPwoKQ2hy
aXN0b3BoIHNwZWNpZmljYWxseSBhc2tlZCBmb3IgdGhlc2UgdG8gYmUgZXhwb3J0ZWQgYXQgdGhl
IGVuZCBvZiB0aGUKZmlsZSB3aXRoaW4gYW4gI2lmZGVmIENPTkZJR19OVk1FX1RBUkdFVF9QQVNT
VEhSVS4KCkxvZ2FuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
