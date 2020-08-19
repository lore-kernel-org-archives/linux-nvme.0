Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B481C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:38:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CAD207FB
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4mdQHjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CAD207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vXGGdr/15z+Vpge298Kx4UFStIDasyjQTJu7GmhzbMU=; b=a4mdQHjReyzmxRk9QY/kQ0q34
	sjpJ3fo6UmREuSFmGTMbM4OAwUngFo5dEg2jXnFUnxFmWEhx11ZIhP4pixnnMFR6/aITV4jI0yWeh
	EO9aE6dT/PMZYHr9SDXtd2cNoFKdniofydq4CjvpZqvI3I8RENo8R1UuSvRbRdeY1iTV2+GpZzUiO
	7hjtW1SZbIgcXJh1xHsrf/aIj/CjlQx889oxHGs6IvovEnBa7S0Y5cUxc6JrZceuV3KvpjLaQC9Ks
	CKnwgKevtZ/ttG71e2cVEuwdWkNFsX0rSzqxxjpMLyhuBWwpKQuN/Y7CvqOUm37DNOQ2gtD7RihAQ
	+1huoDtNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8C7i-0005pc-Cn; Wed, 19 Aug 2020 00:38:38 +0000
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8C7g-0005oo-4d
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 00:38:36 +0000
Received: by mail-pf1-f177.google.com with SMTP id x25so10803363pff.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 17:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sJUjb0LKcmacfew301SkRicvRv1z1jpAFqY9ST4l+ks=;
 b=AFLwNjsFAMjQoqo/rc3jzHQ+ZD96zUCfweFQ6YFRg7FCw+A1tX4fY6eTmMdXf399om
 /r26zmElADuMNCdj18fEO2d07wzXpgBEqrah6z7ehLXFCNzNVKCzp8xZD/PwczlBB/Gf
 L5ZcCMX8nCzy04BXkREtvsZ7M2tL8gCOTu1tyiKAbaTarTT4hX1uMupKSNTUBR/NCASe
 87Z8HZ2YNcfNEvudc6KvAlG5HnmTPqS9DhBCRPvKHJ0aSe/6x2aoLZM7dOOBFK7qd+u9
 mdLbM0blu+7Qojxp5QX5ycFvbv71KdkcToAbG6CDpjE4Jyd5ps9zpmptjA6A7Bu3oa8E
 6xuQ==
X-Gm-Message-State: AOAM532NvCjHTpDCSSm59z8WMiLQ+cCr6CTpRfgpyaCffOEF+bHxuQ8G
 PPIlVxwqh82jX6FY3wae+js=
X-Google-Smtp-Source: ABdhPJwnNh2m/pRxQIrHwU7ScyFRPFkjfRogFobu93ujH1WdE2y9ReduBys0AA58KGLq+F4rdYtFhw==
X-Received: by 2002:a63:1b0b:: with SMTP id b11mr15611482pgb.447.1597797514264; 
 Tue, 18 Aug 2020 17:38:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bcd0:fda9:d34d:a3ab?
 ([2601:647:4802:9070:bcd0:fda9:d34d:a3ab])
 by smtp.gmail.com with ESMTPSA id hi13sm966953pjb.26.2020.08.18.17.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 17:38:33 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me>
 <37c1a34b-9956-b9b6-8e06-f44c99470a73@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <49496213-73da-d642-d146-c8e8f5bf6916@grimberg.me>
Date: Tue, 18 Aug 2020 17:38:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <37c1a34b-9956-b9b6-8e06-f44c99470a73@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_203836_225421_7E7C2961 
X-CRM114-Status: GOOD (  28.06  )
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

Cj4+ICtzdGF0aWMgdm9pZCBudm1lX3JkbWFfY29tcGxldGVfdGltZWRfb3V0KHN0cnVjdCByZXF1
ZXN0ICpycSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX3JlcXVlc3QgKnJlcSA9
IGJsa19tcV9ycV90b19wZHUocnEpOwo+PiArwqDCoMKgIHN0cnVjdCBudm1lX3JkbWFfcXVldWUg
KnF1ZXVlID0gcmVxLT5xdWV1ZTsKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0
cmwgPSBxdWV1ZS0+Y3RybDsKPj4gKwo+PiArwqDCoMKgIC8qIGZlbmNlIG90aGVyIGNvbnRleHRz
IHRoYXQgbWF5IGNvbXBsZXRlIHRoZSBjb21tYW5kICovCj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygm
Y3RybC0+dGVhcmRvd25fbG9jayk7Cj4+ICvCoMKgwqAgbnZtZV9yZG1hX3N0b3BfcXVldWUocXVl
dWUpOwo+PiArwqDCoMKgIGlmIChibGtfbXFfcmVxdWVzdF9jb21wbGV0ZWQocnEpKQo+PiArwqDC
oMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+ICvCoMKgwqAgbnZtZV9yZXEocnEpLT5zdGF0dXMgPSBO
Vk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQ7Cj4+ICvCoMKgwqAgYmxrX21xX2NvbXBsZXRlX3JlcXVl
c3QocnEpOwo+PiArb3V0Ogo+PiArwqDCoMKgIG11dGV4X3VubG9jaygmY3RybC0+dGVhcmRvd25f
bG9jayk7Cj4+ICt9Cj4+ICsKPiAKPiBJIGJlbGlldmUgdGhlcmUgc2hvdWxkIGJlIHNvbWUgY29t
bWVudCBleHBsYWluaW5nIHdoeSBpdCdzIG9rIHRvIGxlYXZlIAo+IHRoZSByZG1hIHF1ZXVlIHN0
b3BwZWQuCj4gSSB0aGluayBpdCdzIG9rIGFzOgo+IHJlc2V0dGluZzogdGhlIGNvbnRyb2xsZXIg
d2lsbCBiZSByZXNldCwgc28gdGhlIHF1ZXVlIHdpbGwgYmUgZGVsZXRlZAo+IGNvbm5lY3Rpbmc6
IGluaXQgaW8gZmFpbHVyZXMgd2lsbCB0ZWFyZG93biBwYXJ0aWFsbHkgaW5pdGlhbGl6ZWQgCj4g
Y29udHJvbGxlciwgc28gdGhlIHF1ZXVlIHdpbGwgYmUgZGVsZXRlZAoKSSBjYW4gYWRkIHRoaXMg
Y29tbWVudC4KCj4gCj4+IMKgIHN0YXRpYyBlbnVtIGJsa19laF90aW1lcl9yZXR1cm4KPj4gwqAg
bnZtZV9yZG1hX3RpbWVvdXQoc3RydWN0IHJlcXVlc3QgKnJxLCBib29sIHJlc2VydmVkKQo+PiDC
oCB7Cj4+IEBAIC0xOTYxLDI5ICsxOTc5LDQzIEBAIG52bWVfcmRtYV90aW1lb3V0KHN0cnVjdCBy
ZXF1ZXN0ICpycSwgYm9vbCAKPj4gcmVzZXJ2ZWQpCj4+IMKgwqDCoMKgwqAgZGV2X3dhcm4oY3Ry
bC0+Y3RybC5kZXZpY2UsICJJL08gJWQgUUlEICVkIHRpbWVvdXRcbiIsCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJxLT50YWcsIG52bWVfcmRtYV9xdWV1ZV9pZHgocXVldWUpKTsKPj4gLcKgwqDC
oCAvKgo+PiAtwqDCoMKgwqAgKiBSZXN0YXJ0IHRoZSB0aW1lciBpZiBhIGNvbnRyb2xsZXIgcmVz
ZXQgaXMgYWxyZWFkeSBzY2hlZHVsZWQuIEFueQo+PiAtwqDCoMKgwqAgKiB0aW1lZCBvdXQgY29t
bWFuZHMgd291bGQgYmUgaGFuZGxlZCBiZWZvcmUgZW50ZXJpbmcgdGhlIAo+PiBjb25uZWN0aW5n
Cj4+IC3CoMKgwqDCoCAqIHN0YXRlLgo+PiAtwqDCoMKgwqAgKi8KPj4gLcKgwqDCoCBpZiAoY3Ry
bC0+Y3RybC5zdGF0ZSA9PSBOVk1FX0NUUkxfUkVTRVRUSU5HKQo+PiArwqDCoMKgIHN3aXRjaCAo
Y3RybC0+Y3RybC5zdGF0ZSkgewo+PiArwqDCoMKgIGNhc2UgTlZNRV9DVFJMX1JFU0VUVElORzoK
Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghbnZtZV9yZG1hX3F1ZXVlX2lkeChxdWV1ZSkpIHsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
IGlmIHdlIGFyZSBpbiB0ZWFyZG93biB3ZSBtdXN0IGNvbXBsZXRlIGltbWVkaWF0ZWx5Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBiZWNhdXNlIHdlIG1heSBibG9jayB0aGUgdGVhcmRv
d24gc2VxdWVuY2UgKGUuZy4KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIG52bWVfZGlz
YWJsZV9jdHJsIHRpbWVkIG91dCkuCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZG1hX2NvbXBsZXRlX3RpbWVkX291dChycSk7
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBCTEtfRUhfRE9ORTsKPj4gK8KgwqDC
oMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
UmVzdGFydCB0aGUgdGltZXIgaWYgYSBjb250cm9sbGVyIHJlc2V0IGlzIGFscmVhZHkgc2NoZWR1
bGVkLgo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIEFueSB0aW1lZCBvdXQgY29tbWFuZHMgd291bGQg
YmUgaGFuZGxlZCBiZWZvcmUgZW50ZXJpbmcgdGhlCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogY29u
bmVjdGluZyBzdGF0ZS4KPj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBCTEtfRUhfUkVTRVRfVElNRVI7Cj4gCj4gSWYgeW91J3JlIGluIFJFU0VUVElO
Rywgd2h5IGRvIHlvdSBuZWVkIHRvIHF1YWxpZnkgaW9zIG9ubHkgb24gdGhlIGFkbWluIAo+IHF1
ZXVlLiBDYW4ndCBhbGwgaW9zLCByZWdhcmRsZXNzIG9mIHF1ZXVlLCBqdXN0IGJlIGNvbXBsZXRl
X3RpbWVkX291dCgpIAo+ID/CoCBJc24ndCB0aGlzIGp1c3QgYSByYWNlIGJldHdlZW4gdGhlIGlv
IHRpbWVvdXQgYW5kIHRoZSByZXNldHRpbmcgCj4gcm91dGluZSByZWFjaGluZyB0aGUgaW8gPwoK
WW91IGFyZSBjb3JyZWN0LCBnaXZlbiB0aGF0IHdlIGFyZSBzZXJpYWxpemVkIGFnYWluc3QgdGhl
IHJlc2V0L2Vycm9yIApyZWNvdmVyeSB3ZSBjYW4ganVzdCBkbyB0aGUgc2FtZSBmb3IgYm90aC4g
VGhlIHJlcXVlc3QgaXMgZ29pbmcgdG8KYmUgY2FuY2VsbGVkIGFueXdheXMuCgo+IAo+IAo+PiAt
Cj4+IC3CoMKgwqAgaWYgKGN0cmwtPmN0cmwuc3RhdGUgIT0gTlZNRV9DVFJMX0xJVkUpIHsKPj4g
K8KgwqDCoCBjYXNlIE5WTUVfQ1RSTF9DT05ORUNUSU5HOgo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KHJlc2VydmVkIHx8ICFudm1lX3JkbWFfcXVldWVfaWR4KHF1ZXVlKSkgewo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaWYgd2UgYXJl
IGNvbm5lY3Rpbmcgd2UgbXVzdCBjb21wbGV0ZSBpbW1lZGlhdGVseQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogY29ubmVjdCAocmVzZXJ2ZWQpIG9yIGFkbWluIHJlcXVlc3RzIGJlY2F1
c2Ugd2UgbWF5Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBibG9jayBjb250cm9sbGVy
IHNldHVwIHNlcXVlbmNlLgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQocnEpOwo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX0VIX0RPTkU7Cj4+ICvCoMKgwqDCoMKg
wqDCoCB9Cj4gCj4gVGhpcyBpcyByZWFzb25hYmxlLsKgIEJ1dCBJJ20gd29uZGVyaW5nIHdoeSB0
aGlzIHRvbyBpc24ndCBqdXN0IAo+IGNvbXBsZXRpbmcgYW55IGlvIHRoYXQgdGltZWQgb3V0LsKg
IEZvciB0aGUgbm9uLWNvbnRyb2xsZXIgY3JlYXRlL2luaXQgCj4gaW9zIC0gdGhleSdsbCBlaXRo
ZXIgYm91bmNlIGJhY2sgdG8gdGhlIG11bHRpcGF0aGVyIG9yIHdpbGwgcmVxdWV1ZS4gCj4gV2l0
aCB0aGUgcmVxdWV1ZSwgdGhlcmUncyBhbiBvcHBvcnR1bml0eSBmb3IgVmlrdG9yIEdsYWRrbyd2
cyAicmVqZWN0IAo+IEkvTyB0byBvZmZsaW5lIGRldmljZSIgdG8gYm91bmNlIGl0IGlmIGl0J3Mg
YmVlbiB3YWl0aW5nIGEgd2hpbGUuCgpZb3UgYXJlIHJpZ2h0LCBJIGNhbiBkbyB0aGF0IHRvIGFu
eSBzdGF0ZSB0aGF0IGlzIG5vdCBMSVZFLgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3IQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
