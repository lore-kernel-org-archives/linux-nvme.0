Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB28C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 23:27:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9725C20768
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 23:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LeHQs+S2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LU25oWZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u2KUTkTj5Wfy0uUYbusiSIlRTeIn4ekZWl4iUbQIV6A=; b=LeHQs+S21dqd4/YuSREfbVPqn
	/2oSk1NPnqJdHq17IAiZn5c8o3y505hl9g3A/Rj2IqA73mR593GCtdchVgXQcCvt1OLLMzwZvgBYD
	/J0tZlvTCB69GFktw9SzbX/bHbqw53s09JYsCMVY7KyXFbjNs0HTdGEmVN5GrEH16ee3BJVbuJ14r
	HFVVK0IHV1MUk3N6CG9KciWEfT/kPYa5c2aoJJ5CBeydqK9eXa4ifvYyou+x+JqYxRG6NqDiYqU4b
	s/lO8L/AivW7ORXjynbXmeV6XMnih3xm6tDrlBjsibUu5xArqoVIhSPm6O6rDByb1gChKwdScTL6y
	zawY8FaiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6j74-0006kd-Cu; Fri, 14 Aug 2020 23:27:54 +0000
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6j70-0006jX-TZ
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 23:27:52 +0000
Received: by mail-qv1-xf43.google.com with SMTP id j10so5056788qvo.13
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=pFusNAks5pLiGFyRyhMcxb8CheqZWbEPtXyEPlWmqV8=;
 b=LU25oWZDjQrMvaBtwxcBY/9jxVmF8APeUKJ8uvIuXhHG9F4JyetD3QXNuBIJ4xLr17
 oG1jYF0sQo5bX6MXx/SYPGcb7j53gDRqBVc+9ODCGJKo3feOMt6CQinFzMcDs2nEVWCe
 QavqQmPIDPRew1Q/LmbMgd9h3en2nP8bpNPs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pFusNAks5pLiGFyRyhMcxb8CheqZWbEPtXyEPlWmqV8=;
 b=AdpMItVpNPQ7WmmHApI8eXEaQbt4pSOOi+3pFaJcOezpwFONUsSaQkFz5CBPxiIJpP
 whWk9hMLKokcFE06Yji+F2z5UTCMgS/X/A8VldvJAgXTS6fZ/t9fsQdsWTiuH7oVMkTx
 dvMe1qkRnEux5ztN0zvLdYVR1ilIgQyqWhjODXXhmkPqU0i3EVlqd2YofIdk1qCX6cRd
 WVYG2V/r21gq6TL6sOqMbj46dy8LhSZssq4oFjaSutzvbaDiBOLnStKSDFYOWwB7PUrw
 i7me5gtf9G8D9PaXwYOhONo4sGPRdZHGOYjkI9Lik/e7/ntsUdLp4ZU9cGVTIDEuts0K
 jAUg==
X-Gm-Message-State: AOAM533D9qzvGpWd4Fk4jKHU2NJfGtRZITg3Y/t89kkwDb01uH2wmnoU
 2CPudO6uf0GOoBSDnu9XnDMZ1OCW3VKa6Q==
X-Google-Smtp-Source: ABdhPJy/DXqccIFjrIX0zGtIWrJup0BgPZYukoDadY+hoDyioPRiuV0FfnQhrDNcEZD2aT01YD0lkw==
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr4705757qvw.153.1597447668902; 
 Fri, 14 Aug 2020 16:27:48 -0700 (PDT)
Received: from [10.230.26.209] ([192.19.224.250])
 by smtp.gmail.com with ESMTPSA id x28sm9982808qki.55.2020.08.14.16.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 16:27:48 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <37c1a34b-9956-b9b6-8e06-f44c99470a73@broadcom.com>
Date: Fri, 14 Aug 2020 16:27:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200806191127.592062-8-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_192750_989787_ADDC4C24 
X-CRM114-Status: GOOD (  33.14  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzYvMjAyMCAxMjoxMSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBDdXJyZW50bHkg
d2UgY2hlY2sgaWYgdGhlIGNvbnRyb2xsZXIgc3RhdGUgIT0gTElWRSwgYW5kCj4gd2UgZGlyZWN0
bHkgZmFpbCB0aGUgY29tbWFuZCB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoaXMKPiBpcyB0
aGUgY29ubmVjdCBjb21tYW5kIG9yIGFuIGFkbWluIGNvbW1hbmQgd2l0aGluIHRoZQo+IGNvbnRy
b2xsZXIgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UuCj4KPiBUaGlzIGlzIHdyb25nLCB3ZSBuZWVk
IHRvIGNoZWNrIGlmIHRoZSByZXF1ZXN0IHJpc2tpbmcKPiBjb250cm9sbGVyIHNldHVwL3RlYXJk
b3duIGJsb2NraW5nIGlmIG5vdCBjb21wbGV0ZWQgYW5kCj4gb25seSB0aGVuIGZhaWwuCj4KPiBU
aGUgbG9naWMgc2hvdWxkIGJlOgo+IC0gUkVTRVRUSU5HLCBvbmx5IGZhaWwgZmFicmljcy9hZG1p
biBjb21tYW5kcyBvdGhlcndpc2UKPiAgICBjb250cm9sbGVyIHRlYXJkb3duIHdpbGwgYmxvY2su
IG90aGVyd2lzZSByZXNldCB0aGUgdGltZXIKPiAgICBhbmQgY29tZSBiYWNrIGFnYWluLgo+IC0g
Q09OTkVDVElORywgaWYgdGhpcyBpcyBhIGNvbm5lY3QgKG9yIGFuIGFkbWluIGNvbW1hbmQpLCB3
ZSBmYWlsCj4gICAgcmlnaHQgYXdheSAodW5ibG9jayBjb250cm9sbGVyIGluaXRpYWxpemF0aW9u
KSwgb3RoZXJ3aXNlIHdlCj4gICAgdHJlYXQgaXQgbGlrZSBhbnl0aGluZyBlbHNlLgo+IC0gb3Ro
ZXJ3aXNlIHRyaWdnZXIgZXJyb3IgcmVjb3ZlcnkgYW5kIHJlc2V0IHRoZSB0aW1lciAodGhlCj4g
ICAgZXJyb3IgaGFuZGxlciB3aWxsIHRha2UgY2FyZSBvZiBjb21wbGV0aW5nL2RlbGF5aW5nIGl0
KS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4g
LS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA2OCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygr
KSwgMTggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRt
YS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4gaW5kZXggYWJjMzE4NzM3ZjM1Li4zMGI0
MDFmY2MwNmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4gKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4gQEAgLTExODUsNiArMTE4NSw3IEBAIHN0YXRpYyB2
b2lkIG52bWVfcmRtYV9lcnJvcl9yZWNvdmVyeShzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwp
Cj4gICAJaWYgKCFudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJsLCBOVk1FX0NUUkxf
UkVTRVRUSU5HKSkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gKwlkZXZfd2FybihjdHJsLT5jdHJsLmRl
dmljZSwgInN0YXJ0aW5nIGVycm9yIHJlY292ZXJ5XG4iKTsKPiAgIAlxdWV1ZV93b3JrKG52bWVf
cmVzZXRfd3EsICZjdHJsLT5lcnJfd29yayk7Cj4gICB9Cj4gICAKPiBAQCAtMTk1MSw2ICsxOTUy
LDIzIEBAIHN0YXRpYyBpbnQgbnZtZV9yZG1hX2NtX2hhbmRsZXIoc3RydWN0IHJkbWFfY21faWQg
KmNtX2lkLAo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIG52bWVfcmRt
YV9jb21wbGV0ZV90aW1lZF9vdXQoc3RydWN0IHJlcXVlc3QgKnJxKQo+ICt7Cj4gKwlzdHJ1Y3Qg
bnZtZV9yZG1hX3JlcXVlc3QgKnJlcSA9IGJsa19tcV9ycV90b19wZHUocnEpOwo+ICsJc3RydWN0
IG52bWVfcmRtYV9xdWV1ZSAqcXVldWUgPSByZXEtPnF1ZXVlOwo+ICsJc3RydWN0IG52bWVfcmRt
YV9jdHJsICpjdHJsID0gcXVldWUtPmN0cmw7Cj4gKwo+ICsJLyogZmVuY2Ugb3RoZXIgY29udGV4
dHMgdGhhdCBtYXkgY29tcGxldGUgdGhlIGNvbW1hbmQgKi8KPiArCW11dGV4X2xvY2soJmN0cmwt
PnRlYXJkb3duX2xvY2spOwo+ICsJbnZtZV9yZG1hX3N0b3BfcXVldWUocXVldWUpOwo+ICsJaWYg
KGJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpCj4gKwkJZ290byBvdXQ7Cj4gKwludm1lX3Jl
cShycSktPnN0YXR1cyA9IE5WTUVfU0NfSE9TVF9BQk9SVEVEX0NNRDsKPiArCWJsa19tcV9jb21w
bGV0ZV9yZXF1ZXN0KHJxKTsKPiArb3V0Ogo+ICsJbXV0ZXhfdW5sb2NrKCZjdHJsLT50ZWFyZG93
bl9sb2NrKTsKPiArfQo+ICsKCkkgYmVsaWV2ZSB0aGVyZSBzaG91bGQgYmUgc29tZSBjb21tZW50
IGV4cGxhaW5pbmcgd2h5IGl0J3Mgb2sgdG8gbGVhdmUgCnRoZSByZG1hIHF1ZXVlIHN0b3BwZWQu
CkkgdGhpbmsgaXQncyBvayBhczoKcmVzZXR0aW5nOiB0aGUgY29udHJvbGxlciB3aWxsIGJlIHJl
c2V0LCBzbyB0aGUgcXVldWUgd2lsbCBiZSBkZWxldGVkCmNvbm5lY3Rpbmc6IGluaXQgaW8gZmFp
bHVyZXMgd2lsbCB0ZWFyZG93biBwYXJ0aWFsbHkgaW5pdGlhbGl6ZWQgCmNvbnRyb2xsZXIsIHNv
IHRoZSBxdWV1ZSB3aWxsIGJlIGRlbGV0ZWQKCj4gICBzdGF0aWMgZW51bSBibGtfZWhfdGltZXJf
cmV0dXJuCj4gICBudm1lX3JkbWFfdGltZW91dChzdHJ1Y3QgcmVxdWVzdCAqcnEsIGJvb2wgcmVz
ZXJ2ZWQpCj4gICB7Cj4gQEAgLTE5NjEsMjkgKzE5NzksNDMgQEAgbnZtZV9yZG1hX3RpbWVvdXQo
c3RydWN0IHJlcXVlc3QgKnJxLCBib29sIHJlc2VydmVkKQo+ICAgCWRldl93YXJuKGN0cmwtPmN0
cmwuZGV2aWNlLCAiSS9PICVkIFFJRCAlZCB0aW1lb3V0XG4iLAo+ICAgCQkgcnEtPnRhZywgbnZt
ZV9yZG1hX3F1ZXVlX2lkeChxdWV1ZSkpOwo+ICAgCj4gLQkvKgo+IC0JICogUmVzdGFydCB0aGUg
dGltZXIgaWYgYSBjb250cm9sbGVyIHJlc2V0IGlzIGFscmVhZHkgc2NoZWR1bGVkLiBBbnkKPiAt
CSAqIHRpbWVkIG91dCBjb21tYW5kcyB3b3VsZCBiZSBoYW5kbGVkIGJlZm9yZSBlbnRlcmluZyB0
aGUgY29ubmVjdGluZwo+IC0JICogc3RhdGUuCj4gLQkgKi8KPiAtCWlmIChjdHJsLT5jdHJsLnN0
YXRlID09IE5WTUVfQ1RSTF9SRVNFVFRJTkcpCj4gKwlzd2l0Y2ggKGN0cmwtPmN0cmwuc3RhdGUp
IHsKPiArCWNhc2UgTlZNRV9DVFJMX1JFU0VUVElORzoKPiArCQlpZiAoIW52bWVfcmRtYV9xdWV1
ZV9pZHgocXVldWUpKSB7Cj4gKwkJCS8qCj4gKwkJCSAqIGlmIHdlIGFyZSBpbiB0ZWFyZG93biB3
ZSBtdXN0IGNvbXBsZXRlIGltbWVkaWF0ZWx5Cj4gKwkJCSAqIGJlY2F1c2Ugd2UgbWF5IGJsb2Nr
IHRoZSB0ZWFyZG93biBzZXF1ZW5jZSAoZS5nLgo+ICsJCQkgKiBudm1lX2Rpc2FibGVfY3RybCB0
aW1lZCBvdXQpLgo+ICsJCQkgKi8KPiArCQkJbnZtZV9yZG1hX2NvbXBsZXRlX3RpbWVkX291dChy
cSk7Cj4gKwkJCXJldHVybiBCTEtfRUhfRE9ORTsKPiArCQl9Cj4gKwkJLyoKPiArCQkgKiBSZXN0
YXJ0IHRoZSB0aW1lciBpZiBhIGNvbnRyb2xsZXIgcmVzZXQgaXMgYWxyZWFkeSBzY2hlZHVsZWQu
Cj4gKwkJICogQW55IHRpbWVkIG91dCBjb21tYW5kcyB3b3VsZCBiZSBoYW5kbGVkIGJlZm9yZSBl
bnRlcmluZyB0aGUKPiArCQkgKiBjb25uZWN0aW5nIHN0YXRlLgo+ICsJCSAqLwo+ICAgCQlyZXR1
cm4gQkxLX0VIX1JFU0VUX1RJTUVSOwoKSWYgeW91J3JlIGluIFJFU0VUVElORywgd2h5IGRvIHlv
dSBuZWVkIHRvIHF1YWxpZnkgaW9zIG9ubHkgb24gdGhlIGFkbWluIApxdWV1ZS4gQ2FuJ3QgYWxs
IGlvcywgcmVnYXJkbGVzcyBvZiBxdWV1ZSwganVzdCBiZSBjb21wbGV0ZV90aW1lZF9vdXQoKSAK
P8KgIElzbid0IHRoaXMganVzdCBhIHJhY2UgYmV0d2VlbiB0aGUgaW8gdGltZW91dCBhbmQgdGhl
IHJlc2V0dGluZyAKcm91dGluZSByZWFjaGluZyB0aGUgaW8gPwoKCj4gLQo+IC0JaWYgKGN0cmwt
PmN0cmwuc3RhdGUgIT0gTlZNRV9DVFJMX0xJVkUpIHsKPiArCWNhc2UgTlZNRV9DVFJMX0NPTk5F
Q1RJTkc6Cj4gKwkJaWYgKHJlc2VydmVkIHx8ICFudm1lX3JkbWFfcXVldWVfaWR4KHF1ZXVlKSkg
ewo+ICsJCQkvKgo+ICsJCQkgKiBpZiB3ZSBhcmUgY29ubmVjdGluZyB3ZSBtdXN0IGNvbXBsZXRl
IGltbWVkaWF0ZWx5Cj4gKwkJCSAqIGNvbm5lY3QgKHJlc2VydmVkKSBvciBhZG1pbiByZXF1ZXN0
cyBiZWNhdXNlIHdlIG1heQo+ICsJCQkgKiBibG9jayBjb250cm9sbGVyIHNldHVwIHNlcXVlbmNl
Lgo+ICsJCQkgKi8KPiArCQkJbnZtZV9yZG1hX2NvbXBsZXRlX3RpbWVkX291dChycSk7Cj4gKwkJ
CXJldHVybiBCTEtfRUhfRE9ORTsKPiArCQl9CgpUaGlzIGlzIHJlYXNvbmFibGUuwqAgQnV0IEkn
bSB3b25kZXJpbmcgd2h5IHRoaXMgdG9vIGlzbid0IGp1c3QgCmNvbXBsZXRpbmcgYW55IGlvIHRo
YXQgdGltZWQgb3V0LsKgIEZvciB0aGUgbm9uLWNvbnRyb2xsZXIgY3JlYXRlL2luaXQgCmlvcyAt
IHRoZXknbGwgZWl0aGVyIGJvdW5jZSBiYWNrIHRvIHRoZSBtdWx0aXBhdGhlciBvciB3aWxsIHJl
cXVldWUuIApXaXRoIHRoZSByZXF1ZXVlLCB0aGVyZSdzIGFuIG9wcG9ydHVuaXR5IGZvciBWaWt0
b3IgR2xhZGtvJ3ZzICJyZWplY3QgCkkvTyB0byBvZmZsaW5lIGRldmljZSIgdG8gYm91bmNlIGl0
IGlmIGl0J3MgYmVlbiB3YWl0aW5nIGEgd2hpbGUuCgo+ICsJCS8qIGZhbGx0aHJ1ICovCj4gKwlk
ZWZhdWx0Ogo+ICAgCQkvKgo+IC0JCSAqIFRlYXJkb3duIGltbWVkaWF0ZWx5IGlmIGNvbnRyb2xs
ZXIgdGltZXMgb3V0IHdoaWxlIHN0YXJ0aW5nCj4gLQkJICogb3Igd2UgYXJlIGFscmVhZHkgc3Rh
cnRlZCBlcnJvciByZWNvdmVyeS4gYWxsIG91dHN0YW5kaW5nCj4gLQkJICogcmVxdWVzdHMgYXJl
IGNvbXBsZXRlZCBvbiBzaHV0ZG93biwgc28gd2UgcmV0dXJuIEJMS19FSF9ET05FLgo+ICsJCSAq
IGV2ZXJ5IG90aGVyIHN0YXRlIHNob3VsZCB0cmlnZ2VyIHRoZSBlcnJvciByZWNvdmVyeQo+ICsJ
CSAqIHdoaWNoIHdpbGwgYmUgaGFuZGxlZCBieSB0aGUgZmxvdyBhbmQgY29udHJvbGxlciBzdGF0
ZQo+ICsJCSAqIG1hY2hpbmUKPiAgIAkJICovCj4gLQkJZmx1c2hfd29yaygmY3RybC0+ZXJyX3dv
cmspOwo+IC0JCW52bWVfcmRtYV90ZWFyZG93bl9pb19xdWV1ZXMoY3RybCwgZmFsc2UpOwo+IC0J
CW52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZShjdHJsLCBmYWxzZSk7Cj4gLQkJcmV0dXJu
IEJMS19FSF9ET05FOwo+ICsJCW52bWVfcmRtYV9lcnJvcl9yZWNvdmVyeShjdHJsKTsKPiAgIAl9
Cj4gICAKPiAtCWRldl93YXJuKGN0cmwtPmN0cmwuZGV2aWNlLCAic3RhcnRpbmcgZXJyb3IgcmVj
b3ZlcnlcbiIpOwo+IC0JbnZtZV9yZG1hX2Vycm9yX3JlY292ZXJ5KGN0cmwpOwo+IC0KPiAgIAly
ZXR1cm4gQkxLX0VIX1JFU0VUX1RJTUVSOwo+ICAgfQo+ICAgCgotLSBqYW1lcwoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
