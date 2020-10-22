Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F2C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:58:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CF722206
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 01:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hVdMAnGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CF722206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xzizUSY6kTzRueNf4454F4pLzlxzJ0CpciwWrTyfL2Q=; b=hVdMAnGGAFT3Cf5fZyA+j3nKw
	JPrXrwolUg6w5RnWM2k+fY0QlZU5ncBSkLqajnUDSkw50lDF2N+T4xcy1+aiJdORJXuM72s8hlLdQ
	JvANuI1LU8Zzqj/9UL+mTux0ptQdRDPpdccFVgWe0Eh6cZcdfUPHP2TOgv7Wt2v7Elu/Crym6HA7R
	JbSElS+B4Ii7gOCMv2RXe4p0jV+UJfv/LMQDWVz5Fy3Nv3MCTWX+xGDypSrs90IFgteafzjJVnqw8
	aK2Lni+wADxpEM6eo4SeLHaSxT2g5VX93AkbkJXKsS9Y/7eQ3YTWygh92fbdQbZtdrs2kgSBIw0wi
	pMQtRh10w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVPsD-0000w9-Uz; Thu, 22 Oct 2020 01:58:38 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVPsA-0000uX-JO
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 01:58:35 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 19EA0A2ACA040EE82462;
 Thu, 22 Oct 2020 09:58:27 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 22 Oct 2020 09:58:26 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 22
 Oct 2020 09:58:26 +0800
Subject: Re: [PATCH 0/3] avoid race between time out and tear down
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20201020090808.27702-1-lengchao@huawei.com>
 <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
 <3d5b96dd-4e0f-758a-4175-e69fef0b8c34@huawei.com>
 <b60f34ea-86f1-ef86-8e1f-b156b7681699@grimberg.me>
 <5a48d20f-e9c9-5d37-776a-1fe3b1eb79a8@huawei.com>
 <db872ac4-662c-1e47-291a-7c64ae0cfa57@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <1903f0fa-7dd3-6e87-0e4e-502628822e89@huawei.com>
Date: Thu, 22 Oct 2020 09:58:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <db872ac4-662c-1e47-291a-7c64ae0cfa57@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_215834_879113_5FCA0567 
X-CRM114-Status: GOOD (  13.83  )
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

CgpPbiAyMDIwLzEwLzIxIDE2OjUzLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+Pj4gQXZv
aWQgcmFjZSBiZXR3ZWVuIHRpbWUgb3V0IGFuZCB0ZWFyIGRvd24gZm9yIHJkbWEgYW5kIHRjcC4K
Pj4+Pj4KPj4+Pj4gVGhpcyBwYXRjaHNldCBvdmVyYWxsIGxvb2tzIGdvb2QsIGJ1dCB3ZSBzdGls
bCBuZWVkIHRoZSBwYXRjaCB0aGF0Cj4+Pj4+IGF2b2lkcyBkb3VibGUgY29tcGxldGlvbjoKPj4+
Pj4KPj4+Pj4gLS0gCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+Pj4+IGluZGV4IDYyOWIwMjU2ODVkMS4uNDY0Mjhm
ZjBiMGZjIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+Pj4+PiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+Pj4+PiBAQCAtMjE3NSw3ICsyMTc1LDcgQEAg
c3RhdGljIHZvaWQgbnZtZV90Y3BfY29tcGxldGVfdGltZWRfb3V0KHN0cnVjdCByZXF1ZXN0ICpy
cSkKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBmZW5jZSBvdGhlciBjb250ZXh0cyB0aGF0IG1h
eSBjb21wbGV0ZSB0aGUgY29tbWFuZCAqLwo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X2xv
Y2soJnRvX3RjcF9jdHJsKGN0cmwpLT50ZWFyZG93bl9sb2NrKTsKPj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoCBudm1lX3RjcF9zdG9wX3F1ZXVlKGN0cmwsIG52bWVfdGNwX3F1ZXVlX2lkKHJlcS0+cXVl
dWUpKTsKPj4+Pj4gLcKgwqDCoMKgwqDCoCBpZiAoIWJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChy
cSkpIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoYmxrX21xX3JlcXVlc3Rfc3RhcnRlZChycSkg
JiYgIWJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpIHsKPj4+PiBZZXMsIHRoaXMgcGF0Y2gg
aXMgbmVlZC4gYW5kIHNhbWVseSBmb3IgbnZtZV9jYW5jZWxfcmVxdWVzdC4KPj4+PiBUaGlzIHdp
bGwgZml4IHRoZSByYWNlIHdpdGggYXN5bmNocm9ub3VzIGNvbXBsZXRpb24uCj4+Pj4KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCj4+Pj4gaW5kZXggZTg1ZjYzMDRlZmQ3Li4xZTgzOGQ5NTIwOTYgMTAwNjQ0Cj4+Pj4g
LS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jCj4+Pj4gQEAgLTMzOCw3ICszMzgsNyBAQCBib29sIG52bWVfY2FuY2VsX3JlcXVl
c3Qoc3RydWN0IHJlcXVlc3QgKnJlcSwgdm9pZCAqZGF0YSwgYm9vbCByZXNlcnZlZCkKPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJDYW5jZWxsaW5nIEkvTyAlZCIsIHJlcS0+dGFnKTsKPj4+Pgo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqAgLyogZG9uJ3QgYWJvcnQgb25lIGNvbXBsZXRlZCByZXF1ZXN0ICovCj4+Pj4gLcKg
wqDCoMKgwqDCoCBpZiAoYmxrX21xX3JlcXVlc3RfY29tcGxldGVkKHJlcSkpCj4+Pj4gK8KgwqDC
oMKgwqDCoCBpZiAoYmxrX21xX3JlcXVlc3RfY29tcGxldGVkKHJlcSkgfHwgIWJsa19tcV9yZXF1
ZXN0X3N0YXJ0ZWQocnEpKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiB0cnVlOwo+Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBudm1lX3JlcShyZXEpLT5zdGF0
dXMgPSBOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQ7Cj4+Pgo+Pj4gVGhpcyBvbmUgaXMgdW5uZWVk
ZWQgYmVjYXVzZSBibGtfbXFfdGFnc2V0X2J1c3lfaXRlciBjaGVja3MgdGhhdCB0aGUKPj4+IHJl
cXVlc3QgaGFzIHN0YXJ0ZWQuLi4KPj4gWWVzLCBpdCBpcyBhbHJlYWR5IGNoZWNrZWQuCj4gCj4g
Q2FuIHlvdSBhZGQgdGhlIGF0dGFjaGVkIHBhdGNoZXMgYW5kIHJlc2VuZD8KPiAKPiBZb3UgY2Fu
IGFsc28gYWRkIG15Ogo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPgpvaywgSSB3aWxsIGRvIGl0IGxhdGVyLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
