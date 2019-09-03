Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A3C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 06:40:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72582173E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 06:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pXBIHQMr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TV5VYm6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72582173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pbb62IQxxGVvs7qzHC2HO6gDMAJgQQz5Cnyxb+6bYrI=; b=pXBIHQMrUiRFHQ
	KhCmTimicQzKa3WrdhXj0xsM/VLR6b40xEtDKrXuTpPmQ+osgf/V09SNWYzdmXxKvvnbZAVbqQ0c4
	kJ5tUFLmZ+N6P2NBxnMTO3dvoVkqH7qUOdYDLOqHLpvVrbSfdAp/meqfQh1h7oyEd+riYJZF2nh/n
	85nnCR2G+sRu7GiVgX/PJBrhBorzkfgB3dCgHwDRMTuuHoSWuOtprq+dGuIuq8qK/5EGPElqjh9+o
	CFK7dQDzOd7CU02Sb7qn6GrhT8TgLpblnmkvinEYhQ4Al5m4U46Qqrgl5YEKGdG8Vhx9r9qsViQ1z
	MveNxihYLtUaJkwAOCkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i52Ub-0001vV-K9; Tue, 03 Sep 2019 06:40:41 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i52UZ-0001us-04
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 06:40:40 +0000
Received: by mail-wm1-x343.google.com with SMTP id n2so15338559wmk.4
 for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2019 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VhuVDySfmcvstN8741b2Ik1NxceAwBCvdqIveUGyu50=;
 b=TV5VYm6JImCihhWcqRQnUWVX/pPDjVvbZVJrR2k8FwxM+wiABP++D9zgw68wlvsfu3
 jccirv4jaV4WI3Cs6KdoY5XIzW6llFF6lIuIzlK1lODCaq3JMsI2fsOJ5/ZUIn6YoG2d
 6/ZoWU1ur+0dvYOiBAjeFHb7u9osQ5pNVAzf0A7W+0f8QY2x9PNKZ7MT1WzZgf7iAaGi
 m/X0kd8nQfes5XnVTjtjLfLNdg0Jg36u9uZMFSQH2qMLaCoVgowIilc+Cf0bvy0jSksc
 clbPysLr7xo78AOXV2rcWwZG4bSQXFxZ3CtBYo/jg83b0rQVyhhHI2gYS80OjDC2xbDJ
 6p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VhuVDySfmcvstN8741b2Ik1NxceAwBCvdqIveUGyu50=;
 b=Fil3XRXmLmY7lekgmaegSBE/fvG5Y0iYNIwBnXXpKMXelzRm9lddY3P8op6eI+7x3V
 k9uR87lrIuubLxKOqQQAbiqa/2sejyT/2EW+8ks0Te6ZxFiCd+uhmeLYFY8mkn38tTQY
 InNVMoJzjnoLU99hK+OKxYA8P/L3zS6KoV2FQJyqADmXGFOCQ+eSkpeiXnY/gJdaD+NK
 VteyqTiFnzblLipi0aZf1oq1pUJfVwqlHlQCgCp35Pap1fEu27h9eL0BVxKO1YULSRZn
 x8bo9KIiJUXAAzDxqtBTk5OBTVGUwhz0V/AOdAJqYFhrxiYdPllxX0c9YzoECzPLx/t+
 eJmA==
X-Gm-Message-State: APjAAAWep8vDYyyYzgQLRH2xOmnA9z8E3hIHBCuvWnIY2DcZG3h4qyeT
 UAXVmzajIVXFLZu+R1mkCGWFzg==
X-Google-Smtp-Source: APXvYqwxZyLYOA4K4IIxmCZX+e8qo7Lu+nn1WkLudP4Hvji2QWEV0FpxrluywJ0JK2DP6HhDfYw/PQ==
X-Received: by 2002:a05:600c:12:: with SMTP id
 g18mr27841464wmc.95.1567492837383; 
 Mon, 02 Sep 2019 23:40:37 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ca2:9689:fa5d:1fea?
 ([2a01:e34:ed2f:f020:ca2:9689:fa5d:1fea])
 by smtp.googlemail.com with ESMTPSA id v8sm34320256wra.79.2019.09.02.23.40.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Sep 2019 23:40:36 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Ming Lei <ming.lei@redhat.com>
References: <20190827085344.30799-2-ming.lei@redhat.com>
 <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de>
 <20190827225827.GA5263@ming.t460p>
 <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de>
 <20190828110633.GC15524@ming.t460p>
 <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
 <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
Date: Tue, 3 Sep 2019 08:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903063125.GA21022@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190902_234039_045139_2BCC7C8B 
X-CRM114-Status: GOOD (  20.66  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDMvMDkvMjAxOSAwODozMSwgTWluZyBMZWkgd3JvdGU6Cj4gSGkgRGFuaWVsLAo+IAo+IE9u
IFR1ZSwgU2VwIDAzLCAyMDE5IGF0IDA3OjU5OjM5QU0gKzAyMDAsIERhbmllbCBMZXpjYW5vIHdy
b3RlOgo+Pgo+PiBIaSBNaW5nIExlaSwKPj4KPj4gT24gMDMvMDkvMjAxOSAwNTozMCwgTWluZyBM
ZWkgd3JvdGU6Cj4+Cj4+IFsgLi4uIF0KPj4KPj4KPj4+Pj4gMikgaXJxL3RpbWluZyBkb2Vzbid0
IGNvdmVyIHNvZnRpcnEKPj4+Pgo+Pj4+IFRoYXQncyBzb2x2YWJsZSwgcmlnaHQ/Cj4+Pgo+Pj4g
WWVhaCwgd2UgY2FuIGV4dGVuZCBpcnEvdGltaW5nLCBidXQgdWdseSBmb3IgaXJxL3RpbWluZywg
c2luY2UgaXJxL3RpbWluZwo+Pj4gZm9jdXNlcyBvbiBoYXJkaXJxIHByZWRpY2F0aW9uLCBhbmQg
c29mdGlycSBpc24ndCBpbnZvbHZlZCBpbiB0aGF0Cj4+PiBwdXJwb3NlLgo+Pj4KPj4+PiAgCj4+
Pj4+IERhbmllbCwgY291bGQgeW91IHRha2UgYSBsb29rIGFuZCBzZWUgaWYgaXJxIGZsb29kIGRl
dGVjdGlvbiBjYW4gYmUKPj4+Pj4gaW1wbGVtZW50ZWQgZWFzaWx5IGJ5IGlycS90aW1pbmcuYz8K
Pj4+Pgo+Pj4+IEkgYXNzdW1lIHlvdSBjYW4gdGFrZSBhIGxvb2sgYXMgd2VsbCwgcmlnaHQ/Cj4+
Pgo+Pj4gWWVhaCwgSSBoYXZlIGxvb2tlZCBhdCB0aGUgY29kZSBmb3IgYSB3aGlsZSwgYnV0IEkg
dGhpbmsgdGhhdCBpcnEvdGltaW5nCj4+PiBjb3VsZCBiZWNvbWUgY29tcGxpY2F0ZWQgdW5uZWNl
c3NhcmlseSBmb3IgY292ZXJpbmcgaXJxIGZsb29kIGRldGVjdGlvbiwKPj4+IG1lYW50aW1lIGl0
IGlzIG11Y2ggbGVzcyBlZmZpY2llbnQgZm9yIGRldGVjdGluZyBJUlEgZmxvb2QuCj4+Cj4+IElu
IHRoZSBzZXJpZXMsIHRoZXJlIGlzIG5vdGhpbmcgZGVzY3JpYmluZyByaWdvcm91c2x5IHRoZSBw
cm9ibGVtIChJIGNhbgo+PiBvbmx5IGd1ZXNzKSBhbmQgd2h5IHRoZSBwcm9wb3NlZCBzb2x1dGlv
biBzb2x2ZXMgaXQuCj4+Cj4+IFdoYXQgaXMgeW91ciBkZWZpbml0aW9uIG9mIGFuICdpcnEgZmxv
b2QnPyBBIGhpZ2ggaXJxIGxvYWQ/IEFuIGlycQo+PiBhcnJpdmluZyB3aGlsZSB3ZSBhcmUgcHJv
Y2Vzc2luZyB0aGUgcHJldmlvdXMgb25lIGluIHRoZSBib3R0b20gaGFsdmVzPwo+IAo+IFNvIGZh
ciwgaXQgbWVhbnMgdGhhdCBoYW5kbGluZyBpbnRlcnJ1cHQgJiBzb2Z0aXJxIHRha2VzIGFsbCB1
dGlsaXphdGlvbgo+IG9mIG9uZSBDUFUsIHRoZW4gcHJvY2Vzc2VzIGNhbid0IGJlIHJ1biBvbiB0
aGlzIENQVSBiYXNpY2FsbHksIHVzdWFsbHkKPiBzb3J0IG9mIENQVSBsb2NrdXAgd2FybmluZyB3
aWxsIGJlIHRyaWdnZXJlZC4KCkl0IGlzIGEgc2NoZWR1bGVyIHByb2JsZW0gdGhlbiA/Cgo+PiBU
aGUgcGF0Y2ggMi80IGRlc2NyaXB0aW9uIHNheXMgImhvd2V2ZXIgSU8gY29tcGxldGlvbiBpcyBv
bmx5IGRvbmUgb24KPj4gb25lIG9mIHRoZXNlIHN1Ym1pc3Npb24gQ1BVIGNvcmVzIi4gVGhhdCBk
ZXNjcmliZXMgdGhlIGJvdHRsZW5lY2sgYW5kCj4+IHRoZW4gdGhlIHBhdGNoIHNheXMgIkFkZCBJ
UlFGX1JFU0NVRV9USFJFQUQgdG8gY3JlYXRlIG9uZSBpbnRlcnJ1cHQKPj4gdGhyZWFkIGhhbmRs
ZXIiLCB3aGF0IGlzIHRoZSByYXRpb25hbCBiZXR3ZWVuIHRoZSBib3R0bGVuZWNrIChwcm9ibGVt
KQo+PiBhbmQgdGhlIGlycWZfcmVzY3VlX3RocmVhZCAoc29sdXRpb24pPwo+IAo+IFRoZSBzb2x1
dGlvbiBpcyB0byBzd2l0Y2ggdG8gaGFuZGxlIHRoaXMgaW50ZXJydXB0IG9uIHRoZSBjcmVhdGVk
IHJlc2N1ZQo+IGlycSB0aHJlYWQgY29udGV4dCB3aGVuIGlycSBmbG9vZCBpcyBkZXRlY3RlZCwg
YW5kICd0aGlzIGludGVycnVwdCcgbWVhbnMKPiB0aGUgaW50ZXJydXB0IHJlcXVlc3RlZCB3aXRo
IElSUUZfUkVTQ1VFX1RIUkVBRC4KPiAKPj4KPj4gSXMgaXQgcmVhbGx5IHRoZSBzb2x1dGlvbiB0
byB0cmFjayB0aGUgaXJxIHRpbWluZ3MgdG8gZGV0ZWN0IGEgZmxvb2Q/Cj4gCj4gVGhlIHNvbHV0
aW9uIHRyYWNrcyB0aGUgdGltZSB0YWtlbiBvbiBydW5uaW5nIGRvX0lSUSgpIGZvciBlYWNoIENQ
VS4KCgoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3
LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNv
bS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1i
bG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
