Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A28C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:54:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397C4207B0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397C4207B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U8qnKVzl/q31+GrOT5m15aDBrjk0ME7rIcRR6Rkmkbk=; b=kJ8IMiMYF/Gd9pvXVURPbUgR6
	RsTkZFPPbIb2i2aAckjKChKZmQ66VPVfLIZz4YTd04Cp/8OqHXQhQgKgRh1w4Q3j3MQFint1Y9HGY
	3EnVe1Ui8QuTemMlXDLfHQWXUGlw501/ZJa5h9mgaBdbjZlvRDidN/7YMROLMeVr0HH8Vw6TyAen9
	7f5vuFtkR/XdbqHCBTkY/NzK33EASxwAggYlEHKGGKmIPlKn5lvB36vV9dI+2RJiAHxxHOCZCRK+l
	nDLtmAyVoQydBVUUPltGg/JSPxGB4W3fF3gecPHbjjsO1tPRbHAucb8iuBykyRHdfZijxxeyfUCik
	BSA2asUaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0FFe-000270-DI; Fri, 15 Jan 2021 02:54:14 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0FFa-00024x-KX
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 02:54:12 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DH5MK67hJzXyqt;
 Fri, 15 Jan 2021 10:52:45 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 15 Jan 2021 10:53:41 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 15
 Jan 2021 10:53:41 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
Date: Fri, 15 Jan 2021 10:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_215412_102862_9A441D5A 
X-CRM114-Status: GOOD (  21.91  )
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

CgpPbiAyMDIxLzEvMTUgNToyNSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBXaGVuIGEg
cmVxdWVzdCBpcyBxdWV1ZWQgZmFpbGVkLCBibGtfc3RhdHVzX3QgaXMgZGlyZWN0bHkgcmV0dXJu
ZWQKPj4+PiB0byB0aGUgYmxrLW1xLiBJZiBibGtfc3RhdHVzX3QgaXMgbm90IEJMS19TVFNfUkVT
T1VSQ0UsCj4+Pj4gQkxLX1NUU19ERVZfUkVTT1VSQ0UsIEJMS19TVFNfWk9ORV9SRVNPVVJDRSwg
YmxrLW1xIGNhbGwKPj4+PiBibGtfbXFfZW5kX3JlcXVlc3QgdG8gY29tcGxldGUgdGhlIHJlcXVl
c3Qgd2l0aCBCTEtfU1RTX0lPRVJSLgo+Pj4+IEluIHR3byBzY2VuYXJpb3MsIHRoZSByZXF1ZXN0
IHNob3VsZCBiZSByZXRyaWVkIGFuZCBtYXkgc3VjY2VlZC4KPj4+PiBGaXJzdCwgaWYgd29yayB3
aXRoIG52bWUgbXVsdGlwYXRoLCB0aGUgcmVxdWVzdCBtYXkgYmUgcmV0cmllZAo+Pj4+IHN1Y2Nl
c3NmdWxseSBpbiBhbm90aGVyIHBhdGgsIGJlY2F1c2UgdGhlIGVycm9yIGlzIHByb2JhYmx5IHJl
bGF0ZWQgdG8KPj4+PiB0aGUgcGF0aC4gU2Vjb25kLCBpZiB3b3JrIHdpdGhvdXQgbXVsdGlwYXRo
IHNvZnR3YXJlLCB0aGUgcmVxdWVzdCBtYXkKPj4+PiBiZSByZXRyaWVkIHN1Y2Nlc3NmdWxseSBh
ZnRlciBlcnJvciByZWNvdmVyeS4KPj4+PiBJZiB0aGUgcmVxdWVzdCBpcyBjb21wbGV0ZSB3aXRo
IEJMS19TVFNfSU9FUlIgaW4gYmxrX21xX2Rpc3BhdGNoX3JxX2xpc3QuCj4+Pj4gVGhlIHN0YXRl
IG9mIHJlcXVlc3QgbWF5IGJlIGNoYW5nZWQgdG8gTVFfUlFfSU5fRkxJR0hULiBJZiBmcmVlIHRo
ZQo+Pj4+IHJlcXVlc3QgYXN5bmNocm9ub3VzbHkgc3VjaCBhcyBpbiBudm1lX3N1Ym1pdF91c2Vy
X2NtZCwgaW4gZXh0cmVtZQo+Pj4+IHNjZW5hcmlvIHRoZSByZXF1ZXN0IHdpbGwgYmUgcmVwZWF0
ZWQgZnJlZWQgaW4gdGVhciBkb3duLgo+Pj4+IElmIGEgbm9uLXJlc291cmNlIGVycm9yIG9jY3Vy
cyBpbiBxdWV1ZV9ycSwgc2hvdWxkIGRpcmVjdGx5IGNhbGwKPj4+PiBudm1lX2NvbXBsZXRlX3Jx
IHRvIGNvbXBsZXRlIHJlcXVlc3QgYW5kIHNldCB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0bwo+Pj4+
IE1RX1JRX0NPTVBMRVRFLiBudm1lX2NvbXBsZXRlX3JxIHdpbGwgZGVjaWRlIHRvIHJldHJ5LCBm
YWlsIG92ZXIgb3IgZW5kCj4+Pj4gdGhlIHJlcXVlc3QuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVy
cy9udm1lL2hvc3QvcmRtYS5jIHwgMiArLQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+IGluZGV4IGRmOWY2
ZjQ1NDlmMS4uNGE4OWJmNDRlY2RjIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L3JkbWEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+IEBAIC0yMDkz
LDcgKzIwOTMsNyBAQCBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVfcmRtYV9xdWV1ZV9ycShzdHJ1
Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwKPj4+PiDCoCB1bm1hcF9xZToKPj4+PiDCoMKgwqDCoMKg
IGliX2RtYV91bm1hcF9zaW5nbGUoZGV2LCByZXEtPnNxZS5kbWEsIHNpemVvZihzdHJ1Y3QgbnZt
ZV9jb21tYW5kKSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERNQV9U
T19ERVZJQ0UpOwo+Pj4+IC3CoMKgwqAgcmV0dXJuIHJldDsKPj4+PiArwqDCoMKgIHJldHVybiBu
dm1lX3RyeV9jb21wbGV0ZV9mYWlsZWRfcmVxKHJxLCByZXQpOwo+Pj4KPj4+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCB0aGlzLiBUaGVyZSBhcmUgZXJyb3JzIHRoYXQgbWF5IG5vdCBiZSByZWxhdGVkIHRv
Cj4+PiBhbnl0aGluZyB0aGF0IGlzIHBhdGhpbmcgcmVsYXRlZCAoc3cgYnVnLCBtZW1vcnkgbGVh
aywgbWFwcGluZyBlcnJvciwKPj4+IGV0YywgZXRjKSB3aHkgc2hvdWxkIHdlIHJldHVybiB0aGlz
IG9uZS1zaG90IGVycm9yPwo+PiBBbHRob3VnaCBmYWlsIG92ZXIgcmV0cnkgaXMgbm90IHJlcXVp
cmVkLCBpZiB3ZSByZXR1cm4gdGhlIGVycm9yIHRvCj4+IGJsay1tcSwgYSBsb3cgcHJvYmFiaWxp
dHkgY3Jhc2ggbWF5IGhhcHBlbi4gYmVjYXVzZSBibGstbXEgZG8gbm90IHNldAo+PiB0aGUgc3Rh
dGUgb2YgcmVxdWVzdCB0byBNUV9SUV9DT01QTEVURSBiZWZvcmUgY29tcGxldGUgdGhlIHJlcXVl
c3QsCj4+IHRoZSByZXF1ZXN0IG1heSBiZSBmcmVlZCBhc3luY2hyb25vdXNseSBzdWNoIGFzIGlu
IG52bWVfc3VibWl0X3VzZXJfY21kLgo+PiBJZiByYWNlIHdpdGggZXJyb3IgcmVjb3ZlcnksIHJl
cXVlc3QgZG91YmxlIGNvbXBsZXRpb24gbWF5IGhhcHBlbnMuCj4gCj4gVGhlbiBmaXggdGhhdCwg
ZG9uJ3Qgd29yayBhcm91bmQgaXQuCkknbSBub3QgdHJ5aW5nIHRvIHdvcmsgYXJvdW5kIGl0LiBU
aGUgcHVycG9zZSBvZiB0aGlzIGlzIHRvIHNvbHZlCnRoZSBwcm9ibGVtIG9mIG52bWUgbmF0aXZl
IG11bHRpcGF0aGluZyBhdCB0aGUgc2FtZSB0aW1lLgo+IAo+Pgo+PiBTbyB3ZSBjYW4gbm90IHJl
dHVybiB0aGUgZXJyb3IgdG8gYmxrLW1xIGlmIHRoZSBibGtfc3RhdHVzX3QgaXMgbm90Cj4+IEJM
S19TVFNfUkVTT1VSQ0UsIEJMS19TVFNfREVWX1JFU09VUkNFLCBCTEtfU1RTX1pPTkVfUkVTT1VS
Q0UuCj4gCj4gVGhpcyBpcyBub3Qgc29tZXRoaW5nIHdlIHNob3VsZCBiZSBoYW5kbGluZyBpbiBu
dm1lLiBibG9jayBkcml2ZXJzCj4gc2hvdWxkIGJlIGFibGUgdG8gZmFpbCBxdWV1ZV9ycSwgYW5k
IHRoaXMgYWxsIHNob3VsZCBsaXZlIGluIHRoZQo+IGJsb2NrIGxheWVyLgpPZiBjb3Vyc2UsIGl0
IGlzIGFsc28gYW4gaWRlYSB0byByZXBhaXIgdGhlIGJsb2NrIGRyaXZlcnMgZGlyZWN0bHkuCkhv
d2V2ZXIsIGJsb2NrIGxheWVyIGlzIHVuYXdhcmUgb2YgbnZtZSBuYXRpdmUgbXVsdGlwYXRoaW5n
LCB3aWxsIGNhdXNlCnRoZSByZXF1ZXN0IHJldHVybiBlcnJvciB3aGljaCBzaG91bGQgYmUgYXZv
aWRlZC4KVGhlIHNjZW5hcmlvOiB1c2UgdHdvIEhCQXMgZm9yIG52bWUgbmF0aXZlIG11bHRpcGF0
aCwgYW5kIHRoZW4gb25lIEhCQQpmYXVsdCwgdGhlIGJsa19zdGF0dXNfdCBvZiBxdWV1ZV9ycSBp
cyBCTEtfU1RTX0lPRVJSLCBibGstbXEgd2lsbCBjYWxsCmJsa19tcV9lbmRfcmVxdWVzdCB0byBj
b21wbGV0ZSB0aGUgcmVxdWVzdCB3aGljaCBieXBhc3MgbmFtZSBuYXRpdmUKbXVsdGlwYXRoLiBX
ZSBleHBlY3QgdGhlIHJlcXVlc3QgZmFpbCBvdmVyIHRvIG5vcm1hbCBIQkEsIGJ1dCB0aGUgcmVx
dWVzdAppcyBkaXJlY3RseSBjb21wbGV0ZWQgd2l0aCBCTEtfU1RTX0lPRVJSLgpUaGUgdHdvIHNj
ZW5hcmlvcyBjYW4gYmUgZml4ZWQgYnkgZGlyZWN0bHkgY29tcGxldGluZyB0aGUgcmVxdWVzdCBp
biBxdWV1ZV9ycS4KCj4gLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
