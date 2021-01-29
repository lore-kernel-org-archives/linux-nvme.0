Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD92AC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:24:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237A260234
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 03:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237A260234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=klhtM/gj5zrhHXi9Tm0teqetRlPMub+hk2155IR+kgE=; b=LEFdm2uWBhI8i26Em5jQTQXz6
	H6/bvQkbcebcNKvBiKSe7wZcfm8DXyWsvMmoQclz8eSLdwZi29Wfd8vlaj55pqPDaj2sOYxUhsni+
	Ds+75FS2gGJDop4sGNPywfD4i4zE6qWtkjWQQ0kJ0mZuhbxXabOIzMTddCHdxYkzsdRIvTfGz7QaQ
	xfBaZWpTbMGBRG0Uvl1BRdM03LUB5Nc/kPKjipf5bPrf+JQ/SVIGRkqFzVcsOL/IQOVgvhMMDMpM9
	2Rf3+pQPt5N6jxkAq7qrrlzAjr5tIzxcniVueko1ujgwaNcphd2RrR2TBqA1hBOZfzTidfT7FdQDK
	HNBTlBr5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5KOU-0000y9-6y; Fri, 29 Jan 2021 03:24:22 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5KOS-0000xl-8O
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 03:24:21 +0000
Received: by mail-wr1-f46.google.com with SMTP id q7so7396030wre.13
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 19:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5GG8/DHZriqjxDmM2Ga/OsXfYmbiNsvsK+fvLtzb83I=;
 b=BZq73KryyjGxxh4gPWp1zgqw29oQtn712ts7lewCgev9isiRJDQdcjnnMC3XaM6q0f
 NhwXZZvzaiJMicdCu7CoHggHhGMXgKxS4yD/9dyhmLdauQRTeJIPBjK7aCNCbW+EGQOh
 LtWZS2+YocQ5AUMzVWKXac0VScq2wazhT8pgPWzTb419yA4MfA+vGOIk5Vo0IsQVzm4w
 qXltPNZ4X7GgQNdOJ2UlzzPJEvPAb+ZKlDrPJQO/oBsQhsWTU4nQBp6W6OYN5SGmh5lw
 rEugEI0b9sugPaIedhU875m1ugqd964MBa7ZJlVBPgbRPnDQOL2mRZqQD8N/IJU/xRzT
 o4AQ==
X-Gm-Message-State: AOAM531893bDzdSxwmI8tJK1fPnqpifPok0wff1ueWOh3hiMCksN9nt9
 AlDn1A70KkvG9JCIX9AXwNfhCPG8TJs=
X-Google-Smtp-Source: ABdhPJzRi2JjEDG0HDYiPXvDBSUHQbkXPJaoF4QHN4wOgx9Xzw+WAGzmwgArCjMQsVl4OWS7SxaFNg==
X-Received: by 2002:adf:9261:: with SMTP id 88mr2073565wrj.227.1611890659229; 
 Thu, 28 Jan 2021 19:24:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id h15sm9650294wrt.10.2021.01.28.19.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 19:24:18 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
Date: Thu, 28 Jan 2021 19:24:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_222420_319242_922282C9 
X-CRM114-Status: GOOD (  20.07  )
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

Cj4+Pj4gV2h5IG5vdCBqdXN0IGNhbGwgc2V0IHRoZSBzdGF0dXMgYW5kIGNhbGwgbnZtZV9yZG1h
X2NvbXBsZXRlX3JxIGFuZAo+Pj4+IHJldHVybiBoZXJlPwo+Pj4gSWYgdGhlIGVyciBpcyBFTk9N
RU0gb3IgRUFHQUlOLCBJIGFtIG5vdCBzdXJlIHRoZSBlcnIgbXVzdCBiZSBhCj4+PiBwYXRoLXJl
bGF0ZWQgZXJyb3IgZm9yIGFsbCBIQkEgZHJpdmVycy4gU28gcmV1c2VkIHRoZSBlcnJvciBjaGVj
ayBjb2RlLgo+Pj4gSSB0aGluayBpdCB3b3VsZCBiZSBtb3JlIHJlYXNvbmFibGUgdG8gYXNzdW1l
IGFueSBlcnJvcnMgcmV0dXJuZWQgYnkgSEJBCj4+PiBkcml2ZXIgYXMgcGF0aC1yZWxhdGVkIGVy
cm9ycy4KPj4+IElmIHlvdSB0aGluayBzbywgSSB3aWxsIG1vZGlmeSBpdCBpbiBuZXh0IHBhdGNo
IHZlcnNpb24uCj4+Cj4+IE1lYW50IHRvIGRvIHRoYXQgb25seSBmb3IgLUVJTy4gV2Ugc2hvdWxk
IGFic29sdXRlbHkgbm90IGRvIGFueSBvZiB0aGlzCj4+IGZvciBzdHVmZiBsaWtlIEVJTlZBTCwg
RU9QTk9UU1VQUCwgRVBFUk0gb3IgYW55IHN0cmFuZ2UgZXJyb3IgdGhhdCBtYXkKPj4gcmV0dXJu
IGR1ZSB0byBhIGJ1ZyBvciBhbnl0aGluZyBsaWtlIHRoYXQuCj4gb2ssIHBsZWFzZSByZXZpZXcg
YWdhaW4sIHRoYW5rIHlvdS4KPiAtLS0KPiAgwqBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA5
ICsrKysrKystLQo+ICDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L3JkbWEuYwo+IGluZGV4IGI3Y2U0ZjIyMWQ5OS4uNjZiNjk3NDYxYmQ5IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3JkbWEuYwo+IEBAIC0yMDg0LDggKzIwODQsMTMgQEAgc3RhdGljIGJsa19zdGF0dXNf
dCBudm1lX3JkbWFfcXVldWVfcnEoc3RydWN0IAo+IGJsa19tcV9od19jdHggKmhjdHgsCj4gCj4g
IMKgwqDCoMKgwqDCoMKgIGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVx
LT5zZ2UsIHJlcS0+bnVtX3NnZSwKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXEtPm1yID8gJnJlcS0+cmVnX3dyLndyIDogTlVMTCk7Cj4gLcKgwqDC
oMKgwqDCoCBpZiAodW5saWtlbHkoZXJyKSkKPiArwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShl
cnIpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVyciA9PSAtRUlPKSB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfY29t
cGxldGVfZmFpbGVkX3JxKHJxLCAKPiBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUik7CgpJIHdhcyB0
aGlua2luZyBhYm91dDoKLS0KICAgICAgICAgZXJyID0gbnZtZV9yZG1hX3Bvc3Rfc2VuZChxdWV1
ZSwgc3FlLCByZXEtPnNnZSwgcmVxLT5udW1fc2dlLAogICAgICAgICAgICAgICAgICAgICAgICAg
cmVxLT5tciA/ICZyZXEtPnJlZ193ci53ciA6IE5VTEwpOwogICAgICAgICBpZiAodW5saWtlbHko
ZXJyKSkgewogICAgICAgICAgICAgICAgIGlmIChlcnIgPT0gLUVJTykgewogICAgICAgICAgICAg
ICAgICAgICAgICAgLyoKICAgICAgICAgICAgICAgICAgICAgICAgICAqIEZhaWwgdGhlIHJldXFl
c3Qgc28gdXBwZXIgbGF5ZXIgY2FuIGZhaWxvdmVyIEkvTwogICAgICAgICAgICAgICAgICAgICAg
ICAgICogaWYgYW5vdGhlciBwYXRoIGlzIGF2YWlsYWJsZQogICAgICAgICAgICAgICAgICAgICAg
ICAgICovCiAgICAgICAgICAgICAgICAgICAgICAgICByZXEtPnN0YXR1cyA9IE5WTUVfU0NfSE9T
VF9QQVRIX0VSUk9SOwogICAgICAgICAgICAgICAgICAgICAgICAgbnZtZV9yZG1hX2NvbXBsZXRl
X3JxKHJxKTsKICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBCTEtfU1RTX09LOwoKICAg
ICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICAgZ290byBlcnJfdW5tYXA7CiAgICAgICAg
IH0KLS0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
