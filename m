Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9CBC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 12:37:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA52964EF5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 12:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA52964EF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b5vTkMkz1Cf7ncYxqtXBh2OPIxn9vcFMNtlYBdH9IWc=; b=Pjk12T5BpGy2JuvyQetzJqk56
	0yYXUI0wAO75tCR0i75lXRcXD6W70lg1TscZZUiM6mE2a8Sm9XzhucvLVLYJ0Fc1GGYb3xJ0rnBcR
	w5ZwSVg1tLnKA7itj72wMzB14JTmXaQvNd7HHs0Nob9zUluPjqTfQayUmzMMLwYNj8+0ntS8Du4PX
	l1v2RXXlb8zeiEx4JXFDXgeZBf64FavUuEhvRqxxGqvB5lcXGvuECcYdGV+dBBmMFkidknAJDVaLx
	8u0LxxFBKKBhXYrqb6XsRfJcBAqAqaHodhyH0UD6aneVYLA8VHZ3vThqEq0eaLMmWEBFkcfUnnh7P
	4PqiF9APg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEASm-0006Bk-1G; Mon, 22 Feb 2021 12:37:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEASi-0006BC-V9
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 12:37:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 92DAEB048;
 Mon, 22 Feb 2021 12:37:15 +0000 (UTC)
Subject: Re: [PATCHv2] nvme: add 'fail_if_no_path' sysfs attribute
To: Minwoo Im <minwoo.im.dev@gmail.com>
References: <20210222064155.105742-1-hare@suse.de>
 <20210222101519.GA2856@localhost.localdomain>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6bf38292-c852-32a3-2ed8-4445321aefd7@suse.de>
Date: Mon, 22 Feb 2021 13:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222101519.GA2856@localhost.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_073717_149996_464FE0E0 
X-CRM114-Status: GOOD (  25.69  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yMi8yMSAxMToxNSBBTSwgTWlud29vIEltIHdyb3RlOgo+IE9uIDIxLTAyLTIyIDA3OjQx
OjU1LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IEluIHNvbWUgc2V0dXBzIGxpa2UgUkFJRCB3
ZSBuZWVkIHRvIHJldHVybiBhbiBJL08gZXJyb3IKPj4gb25jZSBhbGwgcGF0aHMgYXJlIHVuYXZh
aWxhYmxlIHRvIGFsbG93IHRoZSB1cHBlciBsYXllcnMKPj4gdG8gc3RhcnQgdGhlaXIgb3duIGVy
cm9yIHJlY292ZXJ5IChsaWtlIHJlZGlyZWN0aW5nIEkvTwo+PiB0byBvdGhlciBtaXJyb3JzKS4K
Pj4gVGhpcyBwYXRjaCBhZGRzIGEgc3lzZnMgYXR0cmlidXRlICdmYWlsX2lmX25vX3BhdGgnIHRv
Cj4+IGFsbG93IHRoZSBhZG1pbiB0byBlbmFibGUgdGhhdCBiZWhhdmlvdXIgaW5zdGVhZCBvZiB0
aGUKPj4gY3VycmVudCAncXVldWUgdW50aWwgYSBwYXRoIGJlY29tZXMgYXZhaWxhYmxlJyBwb2xp
Y3kuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+
PiAtLS0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICB8ICA1ICsrKysrCj4+ICAg
ZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLQo+PiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgICAgIHwgIDIgKysK
Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKPj4gaW5kZXggNWMxZWMzYmZiOWQzLi5lZjIwMDI5YTQ2YjIgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9jb3JlLmMKPj4gQEAgLTM0NjYsNiArMzQ2Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICpudm1lX25zX2lkX2F0dHJzW10gPSB7Cj4+ICAgI2lmZGVmIENPTkZJR19OVk1FX01VTFRJUEFU
SAo+PiAgIAkmZGV2X2F0dHJfYW5hX2dycGlkLmF0dHIsCj4+ICAgCSZkZXZfYXR0cl9hbmFfc3Rh
dGUuYXR0ciwKPj4gKwkmZGV2X2F0dHJfZmFpbF9pZl9ub19wYXRoLmF0dHIsCj4+ICAgI2VuZGlm
Cj4+ICAgCU5VTEwsCj4+ICAgfTsKPj4gQEAgLTM0OTYsNiArMzQ5NywxMCBAQCBzdGF0aWMgdW1v
ZGVfdCBudm1lX25zX2lkX2F0dHJzX2FyZV92aXNpYmxlKHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+
PiAgIAkJaWYgKCFudm1lX2N0cmxfdXNlX2FuYShudm1lX2dldF9uc19mcm9tX2RldihkZXYpLT5j
dHJsKSkKPj4gICAJCQlyZXR1cm4gMDsKPj4gICAJfQo+PiArCWlmIChhID09ICZkZXZfYXR0cl9m
YWlsX2lmX25vX3BhdGguYXR0cikgewo+PiArCQlpZiAoZGV2X3RvX2Rpc2soZGV2KS0+Zm9wcyA9
PSAmbnZtZV9iZGV2X29wcykKPj4gKwkJCXJldHVybiAwOwo+PiArCX0KPj4gICAjZW5kaWYKPj4g
ICAJcmV0dXJuIGEtPm1vZGU7Cj4+ICAgfQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+PiBpbmRleCAw
Njk2MzE5YWRhZjYuLjM1ZWQyZjZkNDMxYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4g
QEAgLTI4MywxMCArMjgzLDEzIEBAIHN0YXRpYyBib29sIG52bWVfYXZhaWxhYmxlX3BhdGgoc3Ry
dWN0IG52bWVfbnNfaGVhZCAqaGVhZCkKPj4gICAJCQljb250aW51ZTsKPj4gICAJCXN3aXRjaCAo
bnMtPmN0cmwtPnN0YXRlKSB7Cj4+ICAgCQljYXNlIE5WTUVfQ1RSTF9MSVZFOgo+PiArCQkJcmV0
dXJuIHRydWU7Cj4gCj4gSGVsbG8gSGFubmVzLAo+IAo+IE1heSBJIGFzayB0aGVyZSdzIGFueSBy
ZWFzb24gd2h5IExJVkUgc3RhdGUgaXMgbm90IGNvdmVyZWQgYnkgdGhlIHN5c2ZzCj4gYXR0cmli
dXRlIHRoYXQgdGhpcyBwYXRjaCBpbnRyb2R1Y2VkID8gIFdvdWxkbid0IGl0IGJlIHBvc3NpYmxl
IHRvIGhhdmUKPiBubyBhdmFpbGFibGUgcGF0aHMgKGluYWNjZXNzaWJsZSkgaW4gTElWRSBzdGF0
ZSA/Cj4gCj4gVGhhbmtzISA6KQo+IApBaCwgeW91IG1lYW4gQU5BIGluYWNjZXNzaWJsZT8KSG1t
LiBUZWNobmljYWxseSwgeWVzLCB0aGlzIG1pZ2h0IGJlIHRoZSBjYXNlLgpJJ2xsIGJlIHVwZGF0
aW5nIHRoZSBwYXRjaC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAg
ICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
