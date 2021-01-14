Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:55:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927472395C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927472395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PetbW1uew4VjK+IQpN1bv/x3tasPCwGhdA2IvepiFMc=; b=uaqdyJyzxu8oKiUnkVispVYm4
	MtB9qUBrN4CSMuMGlCQFc5iYf9FjqL4HP+d8D1t9Vcdq3FSLyLGMyxyyxBGuUsDJlWd0MHBTfJKSl
	egyM0oiIXNxO1oiflg7LxA4yX6bi+JxjGenVFpuIqMUi76mmGCvWK87jfjAyUYivecSB1nYLdF4zM
	O7Ksj7cTnl92OW3mtNh3dTamW69He8FayspCZC2IRHt5Zk3kNcAS3bvtAM5DRX4HajifnMLcMYbBh
	Yh91ZHgxuLhwgVhSeyMLz8IdQ9WiG5qCviFI36isszRPLV8FzGqY8bpmnwFxivIQH4sVyKKx+kjQE
	HGY63Xp5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzwXa-0000AD-Kh; Thu, 14 Jan 2021 06:55:30 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzwXY-00009L-6d
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 06:55:30 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DGZmX45pzz5Fm4;
 Thu, 14 Jan 2021 14:54:20 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:55:22 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:55:21 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
Date: Thu, 14 Jan 2021 14:55:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_015529_365366_8CA26956 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMTQgODoxOSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gV2hlbiBhIHJl
cXVlc3QgaXMgcXVldWVkIGZhaWxlZCwgYmxrX3N0YXR1c190IGlzIGRpcmVjdGx5IHJldHVybmVk
Cj4+IHRvIHRoZSBibGstbXEuIElmIGJsa19zdGF0dXNfdCBpcyBub3QgQkxLX1NUU19SRVNPVVJD
RSwKPj4gQkxLX1NUU19ERVZfUkVTT1VSQ0UsIEJMS19TVFNfWk9ORV9SRVNPVVJDRSwgYmxrLW1x
IGNhbGwKPj4gYmxrX21xX2VuZF9yZXF1ZXN0IHRvIGNvbXBsZXRlIHRoZSByZXF1ZXN0IHdpdGgg
QkxLX1NUU19JT0VSUi4KPj4gSW4gdHdvIHNjZW5hcmlvcywgdGhlIHJlcXVlc3Qgc2hvdWxkIGJl
IHJldHJpZWQgYW5kIG1heSBzdWNjZWVkLgo+PiBGaXJzdCwgaWYgd29yayB3aXRoIG52bWUgbXVs
dGlwYXRoLCB0aGUgcmVxdWVzdCBtYXkgYmUgcmV0cmllZAo+PiBzdWNjZXNzZnVsbHkgaW4gYW5v
dGhlciBwYXRoLCBiZWNhdXNlIHRoZSBlcnJvciBpcyBwcm9iYWJseSByZWxhdGVkIHRvCj4+IHRo
ZSBwYXRoLiBTZWNvbmQsIGlmIHdvcmsgd2l0aG91dCBtdWx0aXBhdGggc29mdHdhcmUsIHRoZSBy
ZXF1ZXN0IG1heQo+PiBiZSByZXRyaWVkIHN1Y2Nlc3NmdWxseSBhZnRlciBlcnJvciByZWNvdmVy
eS4KPj4gSWYgdGhlIHJlcXVlc3QgaXMgY29tcGxldGUgd2l0aCBCTEtfU1RTX0lPRVJSIGluIGJs
a19tcV9kaXNwYXRjaF9ycV9saXN0Lgo+PiBUaGUgc3RhdGUgb2YgcmVxdWVzdCBtYXkgYmUgY2hh
bmdlZCB0byBNUV9SUV9JTl9GTElHSFQuIElmIGZyZWUgdGhlCj4+IHJlcXVlc3QgYXN5bmNocm9u
b3VzbHkgc3VjaCBhcyBpbiBudm1lX3N1Ym1pdF91c2VyX2NtZCwgaW4gZXh0cmVtZQo+PiBzY2Vu
YXJpbyB0aGUgcmVxdWVzdCB3aWxsIGJlIHJlcGVhdGVkIGZyZWVkIGluIHRlYXIgZG93bi4KPj4g
SWYgYSBub24tcmVzb3VyY2UgZXJyb3Igb2NjdXJzIGluIHF1ZXVlX3JxLCBzaG91bGQgZGlyZWN0
bHkgY2FsbAo+PiBudm1lX2NvbXBsZXRlX3JxIHRvIGNvbXBsZXRlIHJlcXVlc3QgYW5kIHNldCB0
aGUgc3RhdGUgb2YgcmVxdWVzdCB0bwo+PiBNUV9SUV9DT01QTEVURS4gbnZtZV9jb21wbGV0ZV9y
cSB3aWxsIGRlY2lkZSB0byByZXRyeSwgZmFpbCBvdmVyIG9yIGVuZAo+PiB0aGUgcmVxdWVzdC4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBMZW5nIDxsZW5nY2hhb0BodWF3ZWkuY29tPgo+PiAt
LS0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIHwgMiArLQo+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBpbmRl
eCBkZjlmNmY0NTQ5ZjEuLjRhODliZjQ0ZWNkYyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvcmRtYS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiBAQCAtMjA5
Myw3ICsyMDkzLDcgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3JkbWFfcXVldWVfcnEoc3Ry
dWN0IGJsa19tcV9od19jdHggKmhjdHgsCj4+IMKgIHVubWFwX3FlOgo+PiDCoMKgwqDCoMKgIGli
X2RtYV91bm1hcF9zaW5nbGUoZGV2LCByZXEtPnNxZS5kbWEsIHNpemVvZihzdHJ1Y3QgbnZtZV9j
b21tYW5kKSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBETUFfVE9fREVW
SUNFKTsKPj4gLcKgwqDCoCByZXR1cm4gcmV0Owo+PiArwqDCoMKgIHJldHVybiBudm1lX3RyeV9j
b21wbGV0ZV9mYWlsZWRfcmVxKHJxLCByZXQpOwo+IAo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlz
LiBUaGVyZSBhcmUgZXJyb3JzIHRoYXQgbWF5IG5vdCBiZSByZWxhdGVkIHRvCj4gYW55dGhpbmcg
dGhhdCBpcyBwYXRoaW5nIHJlbGF0ZWQgKHN3IGJ1ZywgbWVtb3J5IGxlYWssIG1hcHBpbmcgZXJy
b3IsCj4gZXRjLCBldGMpIHdoeSBzaG91bGQgd2UgcmV0dXJuIHRoaXMgb25lLXNob3QgZXJyb3I/
CkFsdGhvdWdoIGZhaWwgb3ZlciByZXRyeSBpcyBub3QgcmVxdWlyZWQsIGlmIHdlIHJldHVybiB0
aGUgZXJyb3IgdG8KYmxrLW1xLCBhIGxvdyBwcm9iYWJpbGl0eSBjcmFzaCBtYXkgaGFwcGVuLiBi
ZWNhdXNlIGJsay1tcSBkbyBub3Qgc2V0CnRoZSBzdGF0ZSBvZiByZXF1ZXN0IHRvIE1RX1JRX0NP
TVBMRVRFIGJlZm9yZSBjb21wbGV0ZSB0aGUgcmVxdWVzdCwKdGhlIHJlcXVlc3QgbWF5IGJlIGZy
ZWVkIGFzeW5jaHJvbm91c2x5IHN1Y2ggYXMgaW4gbnZtZV9zdWJtaXRfdXNlcl9jbWQuCklmIHJh
Y2Ugd2l0aCBlcnJvciByZWNvdmVyeSwgcmVxdWVzdCBkb3VibGUgY29tcGxldGlvbiBtYXkgaGFw
cGVucy4KClNvIHdlIGNhbiBub3QgcmV0dXJuIHRoZSBlcnJvciB0byBibGstbXEgaWYgdGhlIGJs
a19zdGF0dXNfdCBpcyBub3QKQkxLX1NUU19SRVNPVVJDRSwgQkxLX1NUU19ERVZfUkVTT1VSQ0Us
IEJMS19TVFNfWk9ORV9SRVNPVVJDRS4KPiAuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
