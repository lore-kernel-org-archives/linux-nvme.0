Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF791C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:25:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B848820792
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bu/SVJiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B848820792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eg4BGvciSa272AYo41bv5LdNWTP2dbgoOBwoMnB/hoc=; b=bu/SVJiNV+fmcmV7M8xALKnwh
	sIfI45AQfXmSwXHYXaBo5agBPHWWvcTsqGLnqc8X2hMtvxsr8ieceTFwxdgbYBL/t0gYseFdjFNk3
	j3Q2LWl4icju8kh8ARi+MLjvo6V1GdysROMt2kh0fgvyt5OfMoCUxyUS/xrRVHLUpLSa6yPIRY2+5
	Z+9EVuV0JZjJbeGgf5dFQmY/yHJSsQzsLLmet0V4+eqLZc1WaYp7ot40ngFeVap+IsJ7PGXkcnWB/
	4r2375LRrXehuW6e5JIl4tdVkPZpNwpT61D8DmbHgfPaO+V+kjMtTxPFWKhWJoBK9yknd/Oiq+yga
	0WryVuCng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0J3F-0007bx-1V; Tue, 28 Jul 2020 06:25:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0J3B-0007ba-EL
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 06:25:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 99AF1B123;
 Tue, 28 Jul 2020 06:25:30 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-3-hare@suse.de>
 <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <25b94bcf-1730-da16-6a1f-b68ffa4b8970@suse.de>
Date: Tue, 28 Jul 2020 08:25:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_022521_629624_89EDEA1F 
X-CRM114-Status: GOOD (  21.56  )
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
Cc: linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8yNy8yMCA5OjQ2IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+IAo+IE9uIDcvMjcv
MjAgOTowOCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBXaGVuIG52bWVfcm91bmRfcm9i
aW5fcGF0aCgpIGZpbmRzIGEgdmFsaWQgbmFtZXNwYWNlIHdlIHNob3VsZCBiZSAKPj4gdXNpbmcg
aXQ7Cj4+IGZhbGxpbmcgYmFjayB0byBfX252bWVfZmluZF9wYXRoKCkgZm9yIG5vbi1vcHRpbWl6
ZWQgcGF0aHMgd2lsbCBjYXVzZSB0aGUKPj4gcmVzdWx0IGZyb20gbnZtZV9yb3VuZF9yb2Jpbl9w
YXRoKCkgdG8gYmUgaWdub3JlZCBmb3Igbm9uLW9wdGltaXplZCAKPj4gcGF0aHMuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IE1hcnRpbiBXaWxjayA8bXdpbGNrQHN1c2UuY29tPgo+PiBTaWduZWQtb2Zm
LWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMv
bnZtZS9ob3N0L211bHRpcGF0aC5jIHwgNSArKysrLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9tdWx0aXBhdGguYyAKPj4gYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+
PiBpbmRleCBmZThmN2YxMjNmYWMuLjk3ZDNjMTliNTY4NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlw
YXRoLmMKPj4gQEAgLTI3Miw4ICsyNzIsMTEgQEAgaW5saW5lIHN0cnVjdCBudm1lX25zICpudm1l
X2ZpbmRfcGF0aChzdHJ1Y3QgCj4+IG52bWVfbnNfaGVhZCAqaGVhZCkKPj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgbnZtZV9ucyAqbnM7Cj4+IMKgwqDCoMKgwqAgbnMgPSBzcmN1X2RlcmVmZXJlbmNlKGhl
YWQtPmN1cnJlbnRfcGF0aFtub2RlXSwgJmhlYWQtPnNyY3UpOwo+PiAtwqDCoMKgIGlmIChSRUFE
X09OQ0UoaGVhZC0+c3Vic3lzLT5pb3BvbGljeSkgPT0gTlZNRV9JT1BPTElDWV9SUiAmJiBucykK
Pj4gK8KgwqDCoCBpZiAoUkVBRF9PTkNFKGhlYWQtPnN1YnN5cy0+aW9wb2xpY3kpID09IE5WTUVf
SU9QT0xJQ1lfUlIgJiYgbnMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG5zID0gbnZtZV9yb3Vu
ZF9yb2Jpbl9wYXRoKGhlYWQsIG5vZGUsIG5zKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChucykK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5zOwo+PiArwqDCoMKgIH0KPj4gwqDC
oMKgwqDCoCBpZiAodW5saWtlbHkoIW5zIHx8ICFudm1lX3BhdGhfaXNfb3B0aW1pemVkKG5zKSkp
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBucyA9IF9fbnZtZV9maW5kX3BhdGgoaGVhZCwgbm9kZSk7
Cj4gCj4gTWF5YmUgaW5zdGVhZCBvZiB0aGUgZWFybHkgcmV0dXJuIHB1dCB0aGUgZm9sbG93aW5n
IGNvbmRpdGlvbiBvbiBlbHNlPwoKVGhhdCBkZXBlbmRzIG9uIHdoZXRoZXIgd2Ugd2FudCB0byBo
YXZlIGEgZmFsbGJhY2sgdG8gX19udm1lX2ZpbmRfcGF0aCgpIApvciBub3QuIFdpdGggeW91ciBz
dWdnZXN0aW9uIHdlIHdvdWxkIGxvc2UgdGhhdDsgSSdkIHJhdGhlciBrZWVwIGl0LgoKQ2hlZXJz
LAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgVGVhbWxlYWQgU3Rv
cmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2No
w6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
