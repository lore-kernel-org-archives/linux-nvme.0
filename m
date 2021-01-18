Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1FCC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 03:22:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE02224B0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 03:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE02224B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TMQtudokBTs0d3W9MsI+GNff55mEmDo2phh+vey/0EE=; b=WxBhVBYf+LKf/n1sxGLqVdSHg
	B3mvGn8lAnH2qgWj5lxMqg8KfTiDhosjCo7zQ8NNyA0rLtf2mdTTNgy9b04XkJUFJYCrfytufsMLR
	BVowHZMSbxTD+mowXCJseVJg4siHVz+65g9CEKi36YWcFhaO6Mut4G083dwXJcUWzU5lDfZ6Wx+yd
	XlpozYg8jpskNFOP1F0K8SY9sp2JPoah9DHEBLoQve2bLVpdndGUdTh1hN/G8RyOzfziruvPh5rIe
	to8kGB3kXCs6szhK3rRkYjD79Ny/xyaOxnYIEnY/z0sspNcU6cQD8ilRa0LrcarqwQo9xMabeK9SC
	Voc4MuCog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1L7e-0003Yt-Ne; Mon, 18 Jan 2021 03:22:30 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1L7b-0003UQ-QJ
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 03:22:29 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DJxqz6M5fzW0QS;
 Mon, 18 Jan 2021 11:20:31 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 18 Jan 2021 11:22:17 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 18
 Jan 2021 11:22:17 +0800
Subject: Re: [PATCH v2 4/6] nvme-rdma: avoid IO error and repeated request
 completion
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210107033149.15701-1-lengchao@huawei.com>
 <20210107033149.15701-5-lengchao@huawei.com>
 <07e41b4f-914a-11e8-5638-e2d6408feb3f@grimberg.me>
 <7b12be41-0fcd-5a22-0e01-8cd4ac9cde5b@huawei.com>
 <a3404c7d-ccc8-0d55-d4a8-fc15107c90e6@grimberg.me>
 <695b6839-5333-c342-2189-d7aaeba797a7@huawei.com>
 <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <0b5c8e31-8dc2-994a-1710-1b1be07549c9@huawei.com>
Date: Mon, 18 Jan 2021 11:22:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4ff22d33-12fa-1f70-3606-54821f314c45@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210117_222228_382711_0B2A71E1 
X-CRM114-Status: GOOD (  29.04  )
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

CgpPbiAyMDIxLzEvMTYgOToxOCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+Pj4+IFdoZW4g
YSByZXF1ZXN0IGlzIHF1ZXVlZCBmYWlsZWQsIGJsa19zdGF0dXNfdCBpcyBkaXJlY3RseSByZXR1
cm5lZAo+Pj4+Pj4gdG8gdGhlIGJsay1tcS4gSWYgYmxrX3N0YXR1c190IGlzIG5vdCBCTEtfU1RT
X1JFU09VUkNFLAo+Pj4+Pj4gQkxLX1NUU19ERVZfUkVTT1VSQ0UsIEJMS19TVFNfWk9ORV9SRVNP
VVJDRSwgYmxrLW1xIGNhbGwKPj4+Pj4+IGJsa19tcV9lbmRfcmVxdWVzdCB0byBjb21wbGV0ZSB0
aGUgcmVxdWVzdCB3aXRoIEJMS19TVFNfSU9FUlIuCj4+Pj4+PiBJbiB0d28gc2NlbmFyaW9zLCB0
aGUgcmVxdWVzdCBzaG91bGQgYmUgcmV0cmllZCBhbmQgbWF5IHN1Y2NlZWQuCj4+Pj4+PiBGaXJz
dCwgaWYgd29yayB3aXRoIG52bWUgbXVsdGlwYXRoLCB0aGUgcmVxdWVzdCBtYXkgYmUgcmV0cmll
ZAo+Pj4+Pj4gc3VjY2Vzc2Z1bGx5IGluIGFub3RoZXIgcGF0aCwgYmVjYXVzZSB0aGUgZXJyb3Ig
aXMgcHJvYmFibHkgcmVsYXRlZCB0bwo+Pj4+Pj4gdGhlIHBhdGguIFNlY29uZCwgaWYgd29yayB3
aXRob3V0IG11bHRpcGF0aCBzb2Z0d2FyZSwgdGhlIHJlcXVlc3QgbWF5Cj4+Pj4+PiBiZSByZXRy
aWVkIHN1Y2Nlc3NmdWxseSBhZnRlciBlcnJvciByZWNvdmVyeS4KPj4+Pj4+IElmIHRoZSByZXF1
ZXN0IGlzIGNvbXBsZXRlIHdpdGggQkxLX1NUU19JT0VSUiBpbiBibGtfbXFfZGlzcGF0Y2hfcnFf
bGlzdC4KPj4+Pj4+IFRoZSBzdGF0ZSBvZiByZXF1ZXN0IG1heSBiZSBjaGFuZ2VkIHRvIE1RX1JR
X0lOX0ZMSUdIVC4gSWYgZnJlZSB0aGUKPj4+Pj4+IHJlcXVlc3QgYXN5bmNocm9ub3VzbHkgc3Vj
aCBhcyBpbiBudm1lX3N1Ym1pdF91c2VyX2NtZCwgaW4gZXh0cmVtZQo+Pj4+Pj4gc2NlbmFyaW8g
dGhlIHJlcXVlc3Qgd2lsbCBiZSByZXBlYXRlZCBmcmVlZCBpbiB0ZWFyIGRvd24uCj4+Pj4+PiBJ
ZiBhIG5vbi1yZXNvdXJjZSBlcnJvciBvY2N1cnMgaW4gcXVldWVfcnEsIHNob3VsZCBkaXJlY3Rs
eSBjYWxsCj4+Pj4+PiBudm1lX2NvbXBsZXRlX3JxIHRvIGNvbXBsZXRlIHJlcXVlc3QgYW5kIHNl
dCB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0bwo+Pj4+Pj4gTVFfUlFfQ09NUExFVEUuIG52bWVfY29t
cGxldGVfcnEgd2lsbCBkZWNpZGUgdG8gcmV0cnksIGZhaWwgb3ZlciBvciBlbmQKPj4+Pj4+IHRo
ZSByZXF1ZXN0Lgo+Pj4+Pj4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2No
YW9AaHVhd2VpLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gwqAgZHJpdmVycy9udm1lL2hvc3QvcmRt
YS5jIHwgMiArLQo+Pj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4+Pj4+Pgo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3Jk
bWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+Pj4gaW5kZXggZGY5ZjZmNDU0OWYx
Li40YTg5YmY0NGVjZGMgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1h
LmMKPj4+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+Pj4gQEAgLTIwOTMs
NyArMjA5Myw3IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9yZG1hX3F1ZXVlX3JxKHN0cnVj
dCBibGtfbXFfaHdfY3R4ICpoY3R4LAo+Pj4+Pj4gwqAgdW5tYXBfcWU6Cj4+Pj4+PiDCoMKgwqDC
oMKgIGliX2RtYV91bm1hcF9zaW5nbGUoZGV2LCByZXEtPnNxZS5kbWEsIHNpemVvZihzdHJ1Y3Qg
bnZtZV9jb21tYW5kKSwKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
RE1BX1RPX0RFVklDRSk7Cj4+Pj4+PiAtwqDCoMKgIHJldHVybiByZXQ7Cj4+Pj4+PiArwqDCoMKg
IHJldHVybiBudm1lX3RyeV9jb21wbGV0ZV9mYWlsZWRfcmVxKHJxLCByZXQpOwo+Pj4+Pgo+Pj4+
PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcy4gVGhlcmUgYXJlIGVycm9ycyB0aGF0IG1heSBub3Qg
YmUgcmVsYXRlZCB0bwo+Pj4+PiBhbnl0aGluZyB0aGF0IGlzIHBhdGhpbmcgcmVsYXRlZCAoc3cg
YnVnLCBtZW1vcnkgbGVhaywgbWFwcGluZyBlcnJvciwKPj4+Pj4gZXRjLCBldGMpIHdoeSBzaG91
bGQgd2UgcmV0dXJuIHRoaXMgb25lLXNob3QgZXJyb3I/Cj4+Pj4gQWx0aG91Z2ggZmFpbCBvdmVy
IHJldHJ5IGlzIG5vdCByZXF1aXJlZCwgaWYgd2UgcmV0dXJuIHRoZSBlcnJvciB0bwo+Pj4+IGJs
ay1tcSwgYSBsb3cgcHJvYmFiaWxpdHkgY3Jhc2ggbWF5IGhhcHBlbi4gYmVjYXVzZSBibGstbXEg
ZG8gbm90IHNldAo+Pj4+IHRoZSBzdGF0ZSBvZiByZXF1ZXN0IHRvIE1RX1JRX0NPTVBMRVRFIGJl
Zm9yZSBjb21wbGV0ZSB0aGUgcmVxdWVzdCwKPj4+PiB0aGUgcmVxdWVzdCBtYXkgYmUgZnJlZWQg
YXN5bmNocm9ub3VzbHkgc3VjaCBhcyBpbiBudm1lX3N1Ym1pdF91c2VyX2NtZC4KPj4+PiBJZiBy
YWNlIHdpdGggZXJyb3IgcmVjb3ZlcnksIHJlcXVlc3QgZG91YmxlIGNvbXBsZXRpb24gbWF5IGhh
cHBlbnMuCj4+Pgo+Pj4gVGhlbiBmaXggdGhhdCwgZG9uJ3Qgd29yayBhcm91bmQgaXQuCj4+IEkn
bSBub3QgdHJ5aW5nIHRvIHdvcmsgYXJvdW5kIGl0LiBUaGUgcHVycG9zZSBvZiB0aGlzIGlzIHRv
IHNvbHZlCj4+IHRoZSBwcm9ibGVtIG9mIG52bWUgbmF0aXZlIG11bHRpcGF0aGluZyBhdCB0aGUg
c2FtZSB0aW1lLgo+IAo+IFBsZWFzZSBleHBsYWluIGhvdyB0aGlzIGlzIGFuIG52bWUtbXVsdGlw
YXRoIGlzc3VlPwo+IAo+Pj4KPj4+Pgo+Pj4+IFNvIHdlIGNhbiBub3QgcmV0dXJuIHRoZSBlcnJv
ciB0byBibGstbXEgaWYgdGhlIGJsa19zdGF0dXNfdCBpcyBub3QKPj4+PiBCTEtfU1RTX1JFU09V
UkNFLCBCTEtfU1RTX0RFVl9SRVNPVVJDRSwgQkxLX1NUU19aT05FX1JFU09VUkNFLgo+Pj4KPj4+
IFRoaXMgaXMgbm90IHNvbWV0aGluZyB3ZSBzaG91bGQgYmUgaGFuZGxpbmcgaW4gbnZtZS4gYmxv
Y2sgZHJpdmVycwo+Pj4gc2hvdWxkIGJlIGFibGUgdG8gZmFpbCBxdWV1ZV9ycSwgYW5kIHRoaXMg
YWxsIHNob3VsZCBsaXZlIGluIHRoZQo+Pj4gYmxvY2sgbGF5ZXIuCj4+IE9mIGNvdXJzZSwgaXQg
aXMgYWxzbyBhbiBpZGVhIHRvIHJlcGFpciB0aGUgYmxvY2sgZHJpdmVycyBkaXJlY3RseS4KPj4g
SG93ZXZlciwgYmxvY2sgbGF5ZXIgaXMgdW5hd2FyZSBvZiBudm1lIG5hdGl2ZSBtdWx0aXBhdGhp
bmcsCj4gCj4gTm9yIGl0IHNob3VsZCBiZQo+IAo+PiB3aWxsIGNhdXNlIHRoZSByZXF1ZXN0IHJl
dHVybiBlcnJvciB3aGljaCBzaG91bGQgYmUgYXZvaWRlZC4KPiAKPiBOb3Qgc3VyZSBJIHVuZGVy
c3RhbmQuLgo+IHJlcXVlc3RzIHNob3VsZCBmYWlsb3ZlciBmb3IgcGF0aCByZWxhdGVkIGVycm9y
cywKPiB3aGF0IHF1ZXVlX3JxIGVycm9ycyBhcmUgZXhwZWN0ZWQgdG8gYmUgZmFpbGVkIG92ZXIg
ZnJvbSB5b3VyCj4gcGVyc3BlY3RpdmU/CkFsdGhvdWdoIGZhaWwgb3ZlciBmb3Igb25seSBwYXRo
IHJlbGF0ZWQgZXJyb3JzIGlzIHRoZSBiZXN0IGNob2ljZSwgaXQncwphbG1vc3QgaW1wb3NzaWJs
ZSB0byBhY2hpZXZlLgpUaGUgcHJvYmFiaWxpdHkgb2Ygbm9uLXBhdGgtcmVsYXRlZCBlcnJvcnMg
aXMgdmVyeSBsb3cuIEFsdGhvdWdoIHRoZXNlCmVycm9ycyBkbyBub3QgcmVxdWlyZSBmYWlsIG92
ZXIgcmV0cnksIHRoZSBjb3N0IG9mIGZhaWwgb3ZlciByZXRyeQppcyBjb21wbGV0ZSB0aGUgcmVx
dWVzdCB3aXRoIGVycm9yIGRlbGF5IGEgYml0IGxvbmcgdGltZShyZXRyeSBzZXZlcmFsCnRpbWVz
KS4gSXQncyBub3QgdGhlIGJlc3QgY2hvaWNlLCBidXQgSSB0aGluayBpdCdzIGFjY2VwdGFibGUs
IGJlY2F1c2UKSEJBIGRyaXZlciBkb2VzIG5vdCBoYXZlIHBhdGgtcmVsYXRlZCBlcnJvciBjb2Rl
cyBidXQgb25seSBnZW5lcmFsIGVycm9yCmNvZGVzLiBJdCBpcyBkaWZmaWN1bHQgdG8gaWRlbnRp
Znkgd2hldGhlciB0aGUgZ2VuZXJhbCBlcnJvciBjb2RlcyBhcmUKcGF0aC1yZWxhdGVkLgo+IAo+
PiBUaGUgc2NlbmFyaW86IHVzZSB0d28gSEJBcyBmb3IgbnZtZSBuYXRpdmUgbXVsdGlwYXRoLCBh
bmQgdGhlbiBvbmUgSEJBCj4+IGZhdWx0LAo+IAo+IFdoYXQgaXMgdGhlIHNwZWNpZmljIGVycm9y
IHRoZSBkcml2ZXIgc2Vlcz8KVGhlIHBhdGggcmVsYXRlZCBlcnJvciBjb2RlIGlzIGNsb3NlbHkg
cmVsYXRlZCB0byBIQkEgZHJpdmVyCmltcGxlbWVudGF0aW9uLiBJbiBnZW5lcmFsIGl0IGlzIEVJ
Ty4gSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvCmFzc3VtZSB3aGF0IGdlbmVyYWwg
ZXJyb3IgY29kZSB0aGUgZHJpdmVyIHJldHVybnMgaW4gdGhlIGV2ZW50IG9mIGEgcGF0aAplcnJv
ci4KPiAKPj4gdGhlIGJsa19zdGF0dXNfdCBvZiBxdWV1ZV9ycSBpcyBCTEtfU1RTX0lPRVJSLCBi
bGstbXEgd2lsbCBjYWxsCj4+IGJsa19tcV9lbmRfcmVxdWVzdCB0byBjb21wbGV0ZSB0aGUgcmVx
dWVzdCB3aGljaCBieXBhc3MgbmFtZSBuYXRpdmUKPj4gbXVsdGlwYXRoLiBXZSBleHBlY3QgdGhl
IHJlcXVlc3QgZmFpbCBvdmVyIHRvIG5vcm1hbCBIQkEsIGJ1dCB0aGUgcmVxdWVzdAo+PiBpcyBk
aXJlY3RseSBjb21wbGV0ZWQgd2l0aCBCTEtfU1RTX0lPRVJSLgo+PiBUaGUgdHdvIHNjZW5hcmlv
cyBjYW4gYmUgZml4ZWQgYnkgZGlyZWN0bHkgY29tcGxldGluZyB0aGUgcmVxdWVzdCBpbiBxdWV1
ZV9ycS4KPiBXZWxsLCBjZXJ0YWlubHkgdGhpcyBvbmUtc2hvdCBhbHdheXMgcmV0dXJuIDAgYW5k
IGNvbXBsZXRlIHRoZSBjb21tYW5kCj4gd2l0aCBIT1NUX1BBVEggZXJyb3IgaXMgbm90IGEgZ29v
ZCBhcHByb2FjaCBJTU8KU28gd2hhdCdzIHRoZSBiZXR0ZXIgb3B0aW9uPyBKdXN0IGNvbXBsZXRl
IHRoZSByZXF1ZXN0IHdpdGggaG9zdCBwYXRoCmVycm9yIGZvciBub24tRU5PTUVNIGFuZCBFQUdB
SU4gcmV0dXJuZWQgYnkgdGhlIEhCQSBkcml2ZXI/CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
