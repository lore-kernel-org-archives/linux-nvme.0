Return-Path: <SRS0=uUcO=BE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A1C433E3
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2020 09:01:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3777206D8
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2020 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ComtaSs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3777206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CYS1J5ndGgVRyKc0A3CD4LI+Zc4a1MAFnv7XDvXy6TA=; b=ComtaSs8mHUeEaEmcaWaB+olj
	oXaycTRb3/1+hA6TzFx43+Us6wBSv0ge4rnCw1q+5sRvp8yxv3RvnV/TWx9q9srIVid0zNbJYhB3I
	pZ3goWnhZofM5cQJe4rh+BxhTscUFDH6xSlAGnWynTE4+WgGUuCdtmuyJzv8AYukNpnQl+JhKhmJB
	Jn8HwJePu39nyrQvYPpjFz1BihT1heqZavk4dvzaIPV2b1E7x0I5ElcC4w5heY5M1pxLD8L4CoIj/
	8u0Hcu/CvBy44nwL/Pc+8AjK95OGa7NDU7+PFHzYnZY34DU/C6k9+OxALCSvgaZ3YPvXR5pRzEL+x
	UfII/MYsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzG36-0003XP-8a; Sat, 25 Jul 2020 09:00:56 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzG32-0003Wh-SQ
 for linux-nvme@lists.infradead.org; Sat, 25 Jul 2020 09:00:53 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1028A45AD9BF891FE3F3;
 Sat, 25 Jul 2020 17:00:48 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0;
 Sat, 25 Jul 2020 17:00:44 +0800
Subject: Re: [PATCH] nvme-core: optimize process for error status
 NVME_SC_CMD_INTERRUPTED
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200724081407.19346-1-lengchao@huawei.com>
 <29618961-2596-7d75-40de-13af435d2d83@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <b672ba3f-9d1f-74f8-e927-0b6081b266d4@huawei.com>
Date: Sat, 25 Jul 2020 17:00:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <29618961-2596-7d75-40de-13af435d2d83@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200725_050053_178993_93B2967C 
X-CRM114-Status: GOOD (  10.58  )
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

Ck9uIDIwMjAvNy8yNSA2OjAxLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IEBAIC0yNDMsNyAr
MjQyLDcgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX2Vycm9yX3N0YXR1cyh1MTYgc3RhdHVz
KQo+PiDCoCDCoCBzdGF0aWMgaW5saW5lIGJvb2wgbnZtZV9yZXFfbmVlZHNfcmV0cnkoc3RydWN0
IHJlcXVlc3QgKnJlcSkKPj4gwqAgewo+PiAtwqDCoMKgIGlmIChibGtfbm9yZXRyeV9yZXF1ZXN0
KHJlcSkpCj4+ICvCoMKgwqAgaWYgKCFudm1lX3JlcV9sb2NhbF9yZXRyeShyZXEpICYmIGJsa19u
b3JldHJ5X3JlcXVlc3QocmVxKSkKPgo+IFdoeSBpcyB0aGlzIG5lZWRlZD8KCkJlY2F1c2UgaWYg
d29yayB3aXRoIGRtLW11bHRpcGF0aCBvciBvdGhlciBtdWx0aXBhdGggc29mdHdhcmUsCnRoZSBt
dWx0aXBhdGggc29mdHdhcmUgd2lsbCBzZXQgY21kX2ZsYWdzIGFzIFJFUV9GQUlMRkFTVF9UUkFO
U1BPUlQuCklmIGlvIHJldHVybiB3aXRoIGFueSBlcnJvciwgbnZtZSB3aWxsIHJldHVybiBpbyBl
cnJvciB0byBibG9jayBsYXllciwKdGhlIG11bHRpcGF0aCB3aWxsIHNldCB0aGUgcGF0aCBmYXVs
dCBhbmQgcmV0cnkgaW4gb3RoZXIgcGF0aCwKYnV0IHJlYWx5IG5lZWQgcmV0cnkgaW4gdGhlIGN1
cnJlbnQgcGF0aCBpbiBzb21lIHNjZW5hcmlvcy4KU28gd2UgbmVlZCBpbnRyb2R1Y2UgbnZtZV9y
ZXFfbG9jYWxfcmV0cnkgdG8gY2hlY2sgaWYgbmVlZCByZXRyeQppbiB0aGUgY3VycmVudCBwYXRo
LCBpZiBuZWVkZWQsIGRvIG5vdCBuZWVkIGNoZWNraW5nIHRoZSBjbWRfZmxhZ3MKdGhyb3VnaCBi
bGtfbm9yZXRyeV9yZXF1ZXN0LiBBY2NvcmRpbmcgdGhlIHByb3RvY29sIGRlZmluZSwKdGhlIGVy
cm9yIGNvZGUgTlZNRV9TQ19DTURfSU5URVJSVVBURUQgaXMgYSBnb29kIGNob2ljZS4KClRoZSBz
Y2VuYXJpbyB3aGljaCBuZWVkIHJldHJ5IGluIHRoZSBjdXJyZW50IHBhdGg6ClNjZW5hcmlvIDE6
IHVzZXIgY29uZmlndXJlcyBhIFFvUyBwb2xpY3kgb24gdGhlIHN0b3JhZ2Ugc3lzdGVtLgpTdG9y
YWdlIHN5c3RlbSBuZWVkIHRvIHRlbGwgaG9zdCB0byByZXRyeSBpbyBhZnRlciBhIGRlZmluZWQg
dGltZQp3aGVuIG5lZWQgY29udHJvbCBRb1MuIEhvc3Qgc2hvdWxkIHJldHJ5IHRoZSBpbyBpbiB0
aGUgY3VycmVudCBwYXRoCmluc3RlYWQgb2YgcmV0dXJuIGlvIHRvIGJsb2NrIGxheWVyLgoKU2Nl
bmFyaW8gMzptYW55IGhvc3RzKG1vcmUgdGhhbiAxMDApIGFjY2VzcyB0aGUgc2FtZSBzdG9yYWdl
IGRldmljZS4KSS9PcyBhcmUgbm90IGRlbGl2ZXJlZCBhdCB0aGUgc2FtZSB0aW1lIGluIG1vc3Qg
Y2FzZXMsaG93ZXZlciBhIGxhcmdlCm51bWJlciBvZiBJL09zIG1heSBiZSBidXJzdCBkZWxpdmVy
ZWQgYXQgdGhlIHNhbWUgdGltZSBzb21ldGltZXMuCkluIHRoaXMgY2FzZSwgdGhlIHN0b3JhZ2Ug
ZGV2aWNlIGNhbiBub3QgdHJlYXQgYWxsIEkvT3MsIG5lZWRzIGhvc3QKcmV0cnkgaW4gdGhlIGN1
cnJlbnQgcGF0aCBhZnRlciBhIGRlZmluZWQgdGltZS4KClNjZW5hcmlvIDM6IHN0b3JhZ2Ugc29m
dHdhcmUgdXBncmFkZSBpbmxpbmUuIFRoZSBzdG9yYWdlIHN5c3RlbSBtYXkgbmVlZApob3N0IHJl
dHJ5IGluIHRoZSBjdXJyZW50IHBhdGggYWZ0ZXIgc29mdHdhcmUgdXBncmFkZSBjb21wbGV0ZWQu
CgoKPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiDCoMKgwqDCoMKgIGlm
IChudm1lX3JlcShyZXEpLT5zdGF0dXMgJiBOVk1FX1NDX0ROUikKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBmYWxzZTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUu
aCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+PiBpbmRleCAxZGUzZjliODI3YWEuLjMyMTNh
YWU4OTg1YyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oCj4+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+PiBAQCAtNzI1LDQgKzcyNSwxMCBAQCB2b2lkIG52
bWVfaHdtb25faW5pdChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsKPj4gwqAgc3RhdGljIGlubGlu
ZSB2b2lkIG52bWVfaHdtb25faW5pdChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKSB7IH0KPj4gwqAg
I2VuZGlmCj4+IMKgICtzdGF0aWMgaW5saW5lIGJvb2wgbnZtZV9yZXFfbG9jYWxfcmV0cnkoc3Ry
dWN0IHJlcXVlc3QgKnJlcSkKPj4gK3sKPj4gK8KgwqDCoCBpZiAobnZtZV9yZXEocmVxKS0+c3Rh
dHVzID09IE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHRydWU7Cj4+ICvCoMKgwqAgcmV0dXJuIGZhbHNlOwo+PiArfQo+PiDCoCAjZW5kaWYgLyogX05W
TUVfSCAqLwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
