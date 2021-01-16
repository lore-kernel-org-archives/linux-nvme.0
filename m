Return-Path: <SRS0=ocGt=GT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3552C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jan 2021 01:19:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1D9239E4
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Jan 2021 01:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1D9239E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9rgZEX7pyJDQ8SdWGMK3MQVcr7Gkm4QGFhqKA3Jah3U=; b=pxQm/QObQ/nNX/4yahMWpq9uN
	/2YwqZKbt+Znk3qgqTYyjW4njfIzlPG4FwVSEDqIIvNqxVggYcI5ktZhip/zcemyKxaHgvA3Glxnx
	PXRoPWFEOqHidZF5oc2QycUUOH8RCWn4wlGEgpDRCYtn1xxW1XIDtF8D8CrJZ6iE4D29khRshNyyw
	jIWW5B1rBEKAC5297ftKv9ej9YzaS11jw9x1FpYuQjDTu7KmvcN8C5rrStLRZ4Qu9vq9DN2ttddpo
	FF47imAK7v3zO2V5wSpIJjIRqWhKSNOrnX7wyZvVDwarQeHWNs1hI0oViQNMDNTkDsBgB8pHtyFXg
	kepuI7Rag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0aEq-0002aA-O0; Sat, 16 Jan 2021 01:18:48 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0aEm-0002Zg-GC
 for linux-nvme@lists.infradead.org; Sat, 16 Jan 2021 01:18:46 +0000
Received: by mail-pg1-f172.google.com with SMTP id n10so7096408pgl.10
 for <linux-nvme@lists.infradead.org>; Fri, 15 Jan 2021 17:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Bk1g4DDQRejcA8N92RC1Q91YUpSSEep8rJPoxm/h/vY=;
 b=Ixx4n/YNZYgWIG428ohWnv7NWzLEM96VSkiej5C6IDcffIJ8h8k69mIQpiFGCvve50
 RmsC/XidXOeiGgk5Vl2+QfuLPt4cTBDsAyv8X+KDKGUfqC+AR1dIm3ClIXI8GDXQlQrC
 /HmzQbde9Ylg7NkJxliA2Ic3xPain4Qph77KLdvQqOQMFGoRcTFnAiZDwcuJXmNgOwMM
 psg/50Iu3dELofo6jaO5fdXRZzkVKDL8vwFiRL05GTPe2Ex9q3mpPjPaMJnEFICoAvUs
 LLJPDgfWUpzWn5zKvLqbeiPa8H5NShtWgpPMsDu2pjEDtlWz5ia6qH4DXVMiCu970j7n
 jczg==
X-Gm-Message-State: AOAM533+WDvshbC7vfyFu7mUtTtxrLv88BYjBuZNZgnAXZkdf5L/umfM
 WbFWgYEbyim554vWmDrj+2w=
X-Google-Smtp-Source: ABdhPJzMUulJ5IqzhoPjxrSkH/xb78AxnsprNqcD2AC6+RH9EhU5NLjatBndzXTsFhD3j6ONl2sB9A==
X-Received: by 2002:a62:ea17:0:b029:1ad:4788:7815 with SMTP id
 t23-20020a62ea170000b02901ad47887815mr15523329pfh.1.1610759920292; 
 Fri, 15 Jan 2021 17:18:40 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e2f:377f:716f:f0b9?
 ([2601:647:4802:9070:5e2f:377f:716f:f0b9])
 by smtp.gmail.com with ESMTPSA id 22sm9073073pfn.190.2021.01.15.17.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jan 2021 17:18:39 -0800 (PST)
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
Date: Fri, 15 Jan 2021 17:18:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_201844_579527_3B15336F 
X-CRM114-Status: GOOD (  27.73  )
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

Cj4+Pj4+IFdoZW4gYSByZXF1ZXN0IGlzIHF1ZXVlZCBmYWlsZWQsIGJsa19zdGF0dXNfdCBpcyBk
aXJlY3RseSByZXR1cm5lZAo+Pj4+PiB0byB0aGUgYmxrLW1xLiBJZiBibGtfc3RhdHVzX3QgaXMg
bm90IEJMS19TVFNfUkVTT1VSQ0UsCj4+Pj4+IEJMS19TVFNfREVWX1JFU09VUkNFLCBCTEtfU1RT
X1pPTkVfUkVTT1VSQ0UsIGJsay1tcSBjYWxsCj4+Pj4+IGJsa19tcV9lbmRfcmVxdWVzdCB0byBj
b21wbGV0ZSB0aGUgcmVxdWVzdCB3aXRoIEJMS19TVFNfSU9FUlIuCj4+Pj4+IEluIHR3byBzY2Vu
YXJpb3MsIHRoZSByZXF1ZXN0IHNob3VsZCBiZSByZXRyaWVkIGFuZCBtYXkgc3VjY2VlZC4KPj4+
Pj4gRmlyc3QsIGlmIHdvcmsgd2l0aCBudm1lIG11bHRpcGF0aCwgdGhlIHJlcXVlc3QgbWF5IGJl
IHJldHJpZWQKPj4+Pj4gc3VjY2Vzc2Z1bGx5IGluIGFub3RoZXIgcGF0aCwgYmVjYXVzZSB0aGUg
ZXJyb3IgaXMgcHJvYmFibHkgcmVsYXRlZCB0bwo+Pj4+PiB0aGUgcGF0aC4gU2Vjb25kLCBpZiB3
b3JrIHdpdGhvdXQgbXVsdGlwYXRoIHNvZnR3YXJlLCB0aGUgcmVxdWVzdCBtYXkKPj4+Pj4gYmUg
cmV0cmllZCBzdWNjZXNzZnVsbHkgYWZ0ZXIgZXJyb3IgcmVjb3ZlcnkuCj4+Pj4+IElmIHRoZSBy
ZXF1ZXN0IGlzIGNvbXBsZXRlIHdpdGggQkxLX1NUU19JT0VSUiBpbiAKPj4+Pj4gYmxrX21xX2Rp
c3BhdGNoX3JxX2xpc3QuCj4+Pj4+IFRoZSBzdGF0ZSBvZiByZXF1ZXN0IG1heSBiZSBjaGFuZ2Vk
IHRvIE1RX1JRX0lOX0ZMSUdIVC4gSWYgZnJlZSB0aGUKPj4+Pj4gcmVxdWVzdCBhc3luY2hyb25v
dXNseSBzdWNoIGFzIGluIG52bWVfc3VibWl0X3VzZXJfY21kLCBpbiBleHRyZW1lCj4+Pj4+IHNj
ZW5hcmlvIHRoZSByZXF1ZXN0IHdpbGwgYmUgcmVwZWF0ZWQgZnJlZWQgaW4gdGVhciBkb3duLgo+
Pj4+PiBJZiBhIG5vbi1yZXNvdXJjZSBlcnJvciBvY2N1cnMgaW4gcXVldWVfcnEsIHNob3VsZCBk
aXJlY3RseSBjYWxsCj4+Pj4+IG52bWVfY29tcGxldGVfcnEgdG8gY29tcGxldGUgcmVxdWVzdCBh
bmQgc2V0IHRoZSBzdGF0ZSBvZiByZXF1ZXN0IHRvCj4+Pj4+IE1RX1JRX0NPTVBMRVRFLiBudm1l
X2NvbXBsZXRlX3JxIHdpbGwgZGVjaWRlIHRvIHJldHJ5LCBmYWlsIG92ZXIgb3IgCj4+Pj4+IGVu
ZAo+Pj4+PiB0aGUgcmVxdWVzdC4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBMZW5n
IDxsZW5nY2hhb0BodWF3ZWkuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy9udm1lL2hv
c3QvcmRtYS5jIHwgMiArLQo+Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0
L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+PiBpbmRleCBkZjlmNmY0NTQ5
ZjEuLjRhODliZjQ0ZWNkYyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRt
YS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+PiBAQCAtMjA5Myw3
ICsyMDkzLDcgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3JkbWFfcXVldWVfcnEoc3RydWN0
IAo+Pj4+PiBibGtfbXFfaHdfY3R4ICpoY3R4LAo+Pj4+PiDCoCB1bm1hcF9xZToKPj4+Pj4gwqDC
oMKgwqDCoCBpYl9kbWFfdW5tYXBfc2luZ2xlKGRldiwgcmVxLT5zcWUuZG1hLCBzaXplb2Yoc3Ry
dWN0IAo+Pj4+PiBudm1lX2NvbW1hbmQpLAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIERNQV9UT19ERVZJQ0UpOwo+Pj4+PiAtwqDCoMKgIHJldHVybiByZXQ7Cj4+Pj4+
ICvCoMKgwqAgcmV0dXJuIG52bWVfdHJ5X2NvbXBsZXRlX2ZhaWxlZF9yZXEocnEsIHJldCk7Cj4+
Pj4KPj4+PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcy4gVGhlcmUgYXJlIGVycm9ycyB0aGF0IG1h
eSBub3QgYmUgcmVsYXRlZCB0bwo+Pj4+IGFueXRoaW5nIHRoYXQgaXMgcGF0aGluZyByZWxhdGVk
IChzdyBidWcsIG1lbW9yeSBsZWFrLCBtYXBwaW5nIGVycm9yLAo+Pj4+IGV0YywgZXRjKSB3aHkg
c2hvdWxkIHdlIHJldHVybiB0aGlzIG9uZS1zaG90IGVycm9yPwo+Pj4gQWx0aG91Z2ggZmFpbCBv
dmVyIHJldHJ5IGlzIG5vdCByZXF1aXJlZCwgaWYgd2UgcmV0dXJuIHRoZSBlcnJvciB0bwo+Pj4g
YmxrLW1xLCBhIGxvdyBwcm9iYWJpbGl0eSBjcmFzaCBtYXkgaGFwcGVuLiBiZWNhdXNlIGJsay1t
cSBkbyBub3Qgc2V0Cj4+PiB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0byBNUV9SUV9DT01QTEVURSBi
ZWZvcmUgY29tcGxldGUgdGhlIHJlcXVlc3QsCj4+PiB0aGUgcmVxdWVzdCBtYXkgYmUgZnJlZWQg
YXN5bmNocm9ub3VzbHkgc3VjaCBhcyBpbiBudm1lX3N1Ym1pdF91c2VyX2NtZC4KPj4+IElmIHJh
Y2Ugd2l0aCBlcnJvciByZWNvdmVyeSwgcmVxdWVzdCBkb3VibGUgY29tcGxldGlvbiBtYXkgaGFw
cGVucy4KPj4KPj4gVGhlbiBmaXggdGhhdCwgZG9uJ3Qgd29yayBhcm91bmQgaXQuCj4gSSdtIG5v
dCB0cnlpbmcgdG8gd29yayBhcm91bmQgaXQuIFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8gc29s
dmUKPiB0aGUgcHJvYmxlbSBvZiBudm1lIG5hdGl2ZSBtdWx0aXBhdGhpbmcgYXQgdGhlIHNhbWUg
dGltZS4KClBsZWFzZSBleHBsYWluIGhvdyB0aGlzIGlzIGFuIG52bWUtbXVsdGlwYXRoIGlzc3Vl
PwoKPj4KPj4+Cj4+PiBTbyB3ZSBjYW4gbm90IHJldHVybiB0aGUgZXJyb3IgdG8gYmxrLW1xIGlm
IHRoZSBibGtfc3RhdHVzX3QgaXMgbm90Cj4+PiBCTEtfU1RTX1JFU09VUkNFLCBCTEtfU1RTX0RF
Vl9SRVNPVVJDRSwgQkxLX1NUU19aT05FX1JFU09VUkNFLgo+Pgo+PiBUaGlzIGlzIG5vdCBzb21l
dGhpbmcgd2Ugc2hvdWxkIGJlIGhhbmRsaW5nIGluIG52bWUuIGJsb2NrIGRyaXZlcnMKPj4gc2hv
dWxkIGJlIGFibGUgdG8gZmFpbCBxdWV1ZV9ycSwgYW5kIHRoaXMgYWxsIHNob3VsZCBsaXZlIGlu
IHRoZQo+PiBibG9jayBsYXllci4KPiBPZiBjb3Vyc2UsIGl0IGlzIGFsc28gYW4gaWRlYSB0byBy
ZXBhaXIgdGhlIGJsb2NrIGRyaXZlcnMgZGlyZWN0bHkuCj4gSG93ZXZlciwgYmxvY2sgbGF5ZXIg
aXMgdW5hd2FyZSBvZiBudm1lIG5hdGl2ZSBtdWx0aXBhdGhpbmcsCgpOb3IgaXQgc2hvdWxkIGJl
Cgo+IHdpbGwgY2F1c2UgdGhlIHJlcXVlc3QgcmV0dXJuIGVycm9yIHdoaWNoIHNob3VsZCBiZSBh
dm9pZGVkLgoKTm90IHN1cmUgSSB1bmRlcnN0YW5kLi4KcmVxdWVzdHMgc2hvdWxkIGZhaWxvdmVy
IGZvciBwYXRoIHJlbGF0ZWQgZXJyb3JzLAp3aGF0IHF1ZXVlX3JxIGVycm9ycyBhcmUgZXhwZWN0
ZWQgdG8gYmUgZmFpbGVkIG92ZXIgZnJvbSB5b3VyCnBlcnNwZWN0aXZlPwoKPiBUaGUgc2NlbmFy
aW86IHVzZSB0d28gSEJBcyBmb3IgbnZtZSBuYXRpdmUgbXVsdGlwYXRoLCBhbmQgdGhlbiBvbmUg
SEJBCj4gZmF1bHQsCgpXaGF0IGlzIHRoZSBzcGVjaWZpYyBlcnJvciB0aGUgZHJpdmVyIHNlZXM/
Cgo+IHRoZSBibGtfc3RhdHVzX3Qgb2YgcXVldWVfcnEgaXMgQkxLX1NUU19JT0VSUiwgYmxrLW1x
IHdpbGwgY2FsbAo+IGJsa19tcV9lbmRfcmVxdWVzdCB0byBjb21wbGV0ZSB0aGUgcmVxdWVzdCB3
aGljaCBieXBhc3MgbmFtZSBuYXRpdmUKPiBtdWx0aXBhdGguIFdlIGV4cGVjdCB0aGUgcmVxdWVz
dCBmYWlsIG92ZXIgdG8gbm9ybWFsIEhCQSwgYnV0IHRoZSByZXF1ZXN0Cj4gaXMgZGlyZWN0bHkg
Y29tcGxldGVkIHdpdGggQkxLX1NUU19JT0VSUi4KPiBUaGUgdHdvIHNjZW5hcmlvcyBjYW4gYmUg
Zml4ZWQgYnkgZGlyZWN0bHkgY29tcGxldGluZyB0aGUgcmVxdWVzdCBpbiAKPiBxdWV1ZV9ycS4K
V2VsbCwgY2VydGFpbmx5IHRoaXMgb25lLXNob3QgYWx3YXlzIHJldHVybiAwIGFuZCBjb21wbGV0
ZSB0aGUgY29tbWFuZAp3aXRoIEhPU1RfUEFUSCBlcnJvciBpcyBub3QgYSBnb29kIGFwcHJvYWNo
IElNTwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
