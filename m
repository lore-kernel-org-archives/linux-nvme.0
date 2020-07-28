Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC80DC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:06:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C9F207CD
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RLSlPWZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C9F207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LzI1v12dU5XUISrkGHoehAtAeSI1DrY+b/O95m7LHQY=; b=RLSlPWZvguzykH0LQseryuyvK
	xjQbjRel0S2c3y0sdOGNg25LnVdK+310+dr5ujVnlGteavS34Jay2MyDKo9Ulf5uSy1aubK7Wgw+G
	z+9IBEx8Jl8uUV0q/7TUVF27WdtSwrZyo9jB5Bct9cYkHZqhlfJ7RVTwXMdXzvu11BfI0KmUHAJJM
	zZ/eRv6rrSs8GUMswb1bdrqt7PoPDiZR4JJHwG3MyQuGQRxpCrcQZD0Lyvtc2Y74Vik1zExY5m9R6
	+beiMBZM1/fnTBskiONbHmWeNoN7fYKftn8j0QLT6G9aG7yxeKaxxQnAKbndq7YKYWbSicVcF0vkL
	usYMXD9Ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Fwm-0008LK-3m; Tue, 28 Jul 2020 03:06:32 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Fwd-0008Eu-LO
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:06:27 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EA30A5D7E872AC34A143;
 Tue, 28 Jul 2020 11:06:15 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 28 Jul 2020 11:06:15 +0800
Subject: Re: [PATCH] nvme-rdma: fix deadlock when delete ctrl due to reconnect
 fail
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200727080926.30776-1-lengchao@huawei.com>
 <e477f1b3-f351-1aa3-6132-d7e729db11b9@grimberg.me>
 <c129a034-ca6f-7323-91d4-8a899ede7777@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c229ca6e-646a-372a-2526-ad90e2da1abf@huawei.com>
Date: Tue, 28 Jul 2020 11:06:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c129a034-ca6f-7323-91d4-8a899ede7777@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_230625_012371_49F6B341 
X-CRM114-Status: GOOD (  19.19  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzcvMjggNzozMSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMK
Pj4+IGluZGV4IGY4Zjg1NmRjMGM2Ny4uYjM4MWUyY2RlNTBhIDEwMDY0NAo+Pj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvcmRtYS5jCj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMK
Pj4+IEBAIC05ODksOCArOTg5LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3duX2lv
X3F1ZXVlcyhzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfY2FuY2VsX3JlcXVlc3QsICZjdHJsLT5jdHJsKTsKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19tcV90YWdzZXRfd2FpdF9jb21wbGV0ZWRf
cmVxdWVzdChjdHJsLT5jdHJsLnRhZ3NldCk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4g
LcKgwqDCoMKgwqDCoMKgIGlmIChyZW1vdmUpCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
dm1lX3N0YXJ0X3F1ZXVlcygmY3RybC0+Y3RybCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgbnZtZV9z
dGFydF9xdWV1ZXMoJmN0cmwtPmN0cmwpOwo+Pgo+PiBUaGlzIHdpbGwgZmFpbCBJL08gZHVyaW5n
IGNvbnRyb2xsZXIgcmVzZXQsIHNvIG5hayBvbiB0aGlzLgpUaGUgaW8gd2lsbCBkbyBub3QgZmFp
bC4gSWYgd29yayB3aXRoIG5hdGl2ZSBtdWx0aXBhdGggb3IgZG0tbXVsdGlwYXRoLApudm1lX3Jk
bWFfcXVldWVfcnEgd2lsbCByZXR1cm4gaW8gZXJyb3IsIGFuZCB0aGVuIG11bHRpcGF0aCB3aWxs
CmZhaWwgb3ZlciB0byBvdGhlciBwYXRoIGFuZCByZXRyeSBpbywgdGhpcyBpcyB3ZSBleHBlY3Rl
ZC4gSWYgd29yawp3aXRob3V0IG11bHRpcGF0aCwgbnZtZV9yZG1hX3F1ZXVlX3JxIHdpbGwgcmV0
dXJuIEJMS19TVFNfUkVTT1VSQ0UsCmFuZCB0aGVuIHRoZSB1cHBlciBsYXllciB3aWxsIHJlcXVl
dWUgYW5kIHJldHJ5LiBTdXJlbHkgdGhlcmUgaXMgYQp3ZWFrbmVzczp0aGUgaW8gd2lsbCByZXRy
eSByZXBlYXRlZCBldmVyeSBCTEtfTVFfUkVTT1VSQ0VfREVMQVkoM21zKQp3aGlsZSByZWNvbm5l
Y3RpbmcuIEJlY2F1c2UgY29udHJvbGxlciByZXNldCBtYXkgbmVlZCBsb25nIHRpbWUsCmFuZCBu
dm1lIG92ZXIgcm9jZSBpcyBtYWlubHkgdXNlZCB3aXRoIG11bHRpcGF0aCBzb2Z0d2FyZSwgc28g
d2hlbgpjb250cm9sbGVyIHJlc2V0IHdlIGV4cGVjdCBmYWlsIG92ZXIgdG8gb3RoZXIgcGF0aCBh
bmQgcmV0cnkgaW8sLCBqdXN0Cmxpa2UgZXJyb3IgcmVjb3ZlcnkuIElmIHdvcmsgd2l0aG91dCBt
dWx0aXBhdGgsIHdlIHRvbGVyYXRlIHJlcGVhdGVkCkkvTyByZXRyaWVzIGR1cmluZyBlcnJvciBy
ZWNvdmVyeSBvciBjb250cm9sbGVyIHJlc2V0LgoKPiAKPiBDYW4geW91IHRyeSB0aGlzOgo+IC0t
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9yZG1hLmMKPiBpbmRleCBkNTgyMzE2MzZkMTEuLjk2YzBkNjY0ZmU5YiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9y
ZG1hLmMKPiBAQCAtMTE0OSw2ICsxMTQ5LDExIEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9yZWNv
bm5lY3RfY3RybF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuOwo+IAo+ICDCoHJlcXVldWU6Cj4gK8KgwqDCoMKgwqDCoCAvKgo+ICvCoMKgwqDC
oMKgwqDCoCAqIG1ha2Ugc3VyZSBxdWV1ZXMgYXJlIG5vdCBxdWllc2NlZCBkdWUgdG8gYSByZWNv
bm5lY3QKPiArwqDCoMKgwqDCoMKgwqAgKiBzZXF1ZW5jZSB0aGF0IGZhaWxlZCBhZnRlciBjcmVh
dGluZyBzb21lIEkvTyBxdWV1ZXMKPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKg
IG52bWVfc3RhcnRfcXVldWVzKGN0cmwpOwo+ICDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mbyhjdHJs
LT5jdHJsLmRldmljZSwgIkZhaWxlZCByZWNvbm5lY3QgYXR0ZW1wdCAlZFxuIiwKPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5jdHJsLm5yX3Jl
Y29ubmVjdHMpOwo+ICDCoMKgwqDCoMKgwqDCoCBudm1lX3JkbWFfcmVjb25uZWN0X29yX3JlbW92
ZShjdHJsKTsKPiAtLSAKPiAuU3VyZWx5IHRoaXMgY2FuIHNvbHZlIHRoZSBwcm9ibGVtLCBidXQg
d2hlbiBjb250cm9sbGVyIHJlc2V0IGluCm11bHRpcGF0aCBlbnZpcm9ubWVudCB3ZSBleHBlY3Qg
ZmFpbCBvdmVyIHRvIG90aGVyIHBhdGggYW5kIHJldHJ5IGlvLApqdXN0IGxpa2UgZXJyb3IgcmVj
b3ZlcnkuIEJvdGggZm9yIGNvbnRyb2xsZXIgcmVzZXQgYW5kIGVycm9yIHJlY292ZXJ5LAp3ZSBu
ZWVkIHVucXVpZXNjZSB0aGUgcXVldWUuIFNvIG52bWVfcmRtYV90ZWFyZG93bl9pb19xdWV1ZXMg
c2hvdWxkCmRpcmVjdGx5IHVucXVpZXNjZSBxdWV1ZXMgYWZ0ZXIgY2FuY2VsIHJlcXVlc3QsIGRv
IG5vdCBuZWVkIGNhcmUKdGhlIHBhcmFtZXRlcjpyZW1vdmUuCkZvciB0aGlzIHNvbHV0aW9uLCBp
ZiBudm1lX3JkbWFfc2V0dXBfY3RybCBmYWlsZWQgaW4gbnZtZV9yZG1hX3Jlc2V0X2N0cmxfd29y
aywKd2lsbCBzdGFydCBudm1lX3JkbWFfcmVjb25uZWN0X2N0cmxfd29yaywgdGh1cyBubyBkaWZm
ZXJlbmNlLgpJZiB3ZSBkbyBub3QgdG9sZXJhdGUgcmVwZWF0ZWQgSS9PIHJldHJpZXMgZHVyaW5n
IGNvbnRyb2xsZXIgcmVzZXQsCndlIGNhbiBkbyBsaWtlIHRoaXM6Ci0tLQogIGRyaXZlcnMvbnZt
ZS9ob3N0L3JkbWEuYyB8IDEgKwogIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3Jk
bWEuYwppbmRleCBiMzgxZTJjZGU1MGEuLmFjNzljNGQyOTRjMiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvcmRtYS5jCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwpAQCAtMTkz
Niw2ICsxOTM2LDcgQEAgbnZtZV9yZG1hX3RpbWVvdXQoc3RydWN0IHJlcXVlc3QgKnJxLCBib29s
IHJlc2VydmVkKQogIAkJICovCiAgCQlmbHVzaF93b3JrKCZjdHJsLT5lcnJfd29yayk7CiAgCQlu
dm1lX3JkbWFfdGVhcmRvd25faW9fcXVldWVzKGN0cmwsIGZhbHNlKTsKKwkJbnZtZV9zdGFydF9x
dWV1ZXMoJmN0cmwtPmN0cmwpOwogIAkJbnZtZV9yZG1hX3RlYXJkb3duX2FkbWluX3F1ZXVlKGN0
cmwsIGZhbHNlKTsKICAJCXJldHVybiBCTEtfRUhfRE9ORTsKICAJfQotLSAKMi4xNi40CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
