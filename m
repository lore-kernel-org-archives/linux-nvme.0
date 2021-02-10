Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F249AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 12:10:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03E164DC3
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 12:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03E164DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ABJAyGw4mvqryWG9Y1ppfMIMmMSZM04C/S4rKbE5DKY=; b=X8gz4647mi/+NooKVGHSCP0X8
	BEafqAWcfLoeuc5lcdCoJiuIZ/uwBYX80p7ZqyJh9/sSpP3/Ele4OmifQk/MbsJ6ZXdRs0vq6WrpI
	Zf7kGFxXQf0IrqwpPjqmcE45sZeEUk3llMZjcyXZRANW5UoKTzUumdwEWjQhPDs+Gi2nIZiA91FMc
	ws8yFVG3WntIzelmRmBKxzfIYhdHGR8+rJWAVzhfn8JggrmaUAVSeS6/iWZ/91Ch5IvAYbopI4wfC
	3r/DaNgSD5EiI95C0cXwic9aUDgyw0YzxRjarrx2wtAKsb4Y7Emn2GuSuREcdS+WtsFpS64rXYud2
	DShd59kww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9oJz-0004LL-SU; Wed, 10 Feb 2021 12:10:15 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9oJw-0004KX-Ow
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 12:10:13 +0000
Received: by mail-pf1-x42e.google.com with SMTP id c11so1125045pfp.10
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=eQCLhAK71RZ0tdusIefYuuxCCWk3IGyZngenB86NCVk=;
 b=cBs0QFVTkmyvZTR6P+deH3b4c2LrxYrKu9COJ+fhKH/UyEFfFszktNQXFh85ntByG9
 fMkp1GmaPSVW6OzRfA95bpADtKLdE5gwCcUhYd/ZfHbQDbMAaRjNTk+lNzJ4bLvPGSzm
 JZgDgIBIHjcDWs5Ycbp0q6EcJHA+9BfT8bbXphKuyErhOg7TnvVyCCswe+NoEJrhR+T5
 FSw+vMRe4kG0MFK+bGi9d3b0yGcwlTdQrRYx0taBlSFWIYeSKvvZ7FnlCFSpj5A+0xuN
 b9kJuaEs02iqxGLJhXQtpuUOXzfkyL1T22i1hYMLqGYAqCi80r0Rnn3sz755GJa1V/Fw
 Jr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=eQCLhAK71RZ0tdusIefYuuxCCWk3IGyZngenB86NCVk=;
 b=KdV3lWQEJMpxJ6UDw0TOIvxLssKouExsS+hJ5fSz1XAxVnSjbywJWNUrh+0ob6Al52
 cqb1AvT/FzzHFdsijYmbvMFTyzMullJHr5J6ReZ6BWotEWYka/GcG32XN8qXqGEBDOyP
 6EDGsjwh2nTUsUVN4ArrNtNWUP75vW07r2X3X6l/K2bSo9mL1aRaIexZ9H3zK+ZF6Zbs
 UD1ulPg2f8bWmcPiTjYIEzAzc2g4AbvLTfpx9CNKXBRlFjPpmL3C2X3XKJU7Ad1WOBlH
 26P08gdVZR8yDAssiwq6/ePk8r1j4n0i2uELY9eC29aqgZohzxlX5kbYRclrRJJKwWnb
 UdMQ==
X-Gm-Message-State: AOAM533J5+MmBSSrBl2LpaVoWFT0r6+owmitBgSt8i+QI0mU5o0XQ0Ou
 VRVvnF3BgCauIfAYXh8PibI=
X-Google-Smtp-Source: ABdhPJymVZ516ZRfsx79Yg6pvPvU2kqt8CvO2RPKEOeXenS9YAYgy/vR2uVpZxufiq4wCs7V2ZGWfg==
X-Received: by 2002:a05:6a00:844:b029:1cb:3531:e712 with SMTP id
 q4-20020a056a000844b02901cb3531e712mr2914745pfk.78.1612959008873; 
 Wed, 10 Feb 2021 04:10:08 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id j9sm2138868pfh.52.2021.02.10.04.10.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Feb 2021 04:10:08 -0800 (PST)
Date: Wed, 10 Feb 2021 21:10:06 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
Message-ID: <20210210121006.GA2325@localhost.localdomain>
References: <20210119064318.124415-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119064318.124415-1-hare@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_071012_854801_22933BB4 
X-CRM114-Status: GOOD (  26.12  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjEtMDEtMTkgMDc6NDM6MTgsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBUaGUgb3JpZ2lu
YWwgZGVzaWduIHRvIHVzZSBkZXZpY2UtbWFuYWdlZCByZXNvdXJjZSBhbGxvY2F0aW9uCj4gZG9l
c24ndCByZWFsbHkgd29yayBhcyB0aGUgTlZNZSBjb250cm9sbGVyIGhhcyBhIHZhc3RseSBkaWZm
ZXJlbnQKPiBsaWZldGltZSB0aGFuIHRoZSBod21vbiBzeXNmcyBhdHRyaWJ1dGVzLCBjYXVzaW5n
IHdhcm5pbmcgYWJvdXQKPiBkdXBsaWNhdGUgc3lzZnMgZW50cmllcyB1cG9uIHJlY29ubmVjdGlv
bi4KPiBUaGlzIHBhdGNoIHJld29ya3MgdGhlIGh3bW9uIGFsbG9jYXRpb24gdG8gYXZvaWQgZGV2
aWNlLW1hbmFnZWQKPiByZXNvdXJjZSBhbGxvY2F0aW9uLCBhbmQgdXNlcyB0aGUgTlZNZSBjb250
cm9sbGVyIGFzIHBhcmVudCBmb3IKPiB0aGUgc3lzZnMgYXR0cmlidXRlcy4KPiAKPiBDYzogR3Vl
bnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pgo+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBS
ZWluZWNrZSA8aGFyZUBzdXNlLmRlPgo+IFRlc3RlZC1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25l
ckBzdXNlLmRlPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgIHwgIDEgKwo+ICBk
cml2ZXJzL252bWUvaG9zdC9od21vbi5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggIHwgIDYgKysrKysrCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+
IGluZGV4IGZmZjQ5ZTU0NGZkZi4uM2M2Yzc3ZTQ0YmY3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC00
NDE5LDYgKzQ0MTksNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChudm1lX3N0YXJ0X2N0cmwpOwo+ICAK
PiAgdm9pZCBudm1lX3VuaW5pdF9jdHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCj4gIHsKPiAr
CW52bWVfaHdtb25fZXhpdChjdHJsKTsKPiAgCW52bWVfZmF1bHRfaW5qZWN0X2ZpbmkoJmN0cmwt
PmZhdWx0X2luamVjdCk7Cj4gIAlkZXZfcG1fcW9zX2hpZGVfbGF0ZW5jeV90b2xlcmFuY2UoY3Ry
bC0+ZGV2aWNlKTsKPiAgCWNkZXZfZGV2aWNlX2RlbCgmY3RybC0+Y2RldiwgY3RybC0+ZGV2aWNl
KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvaHdtb24uYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L2h3bW9uLmMKPiBpbmRleCA1NTJkYmMwNDU2N2IuLjhmOWU5Njk4Njc4MCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9od21vbi5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvaHdtb24uYwo+IEBAIC0yMjMsMTIgKzIyMywxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGh3
bW9uX2NoaXBfaW5mbyBudm1lX2h3bW9uX2NoaXBfaW5mbyA9IHsKPiAgCj4gIGludCBudm1lX2h3
bW9uX2luaXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAgewo+IC0Jc3RydWN0IGRldmljZSAq
ZGV2ID0gY3RybC0+ZGV2Owo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gY3RybC0+ZGV2aWNlOwo+
ICAJc3RydWN0IG52bWVfaHdtb25fZGF0YSAqZGF0YTsKPiAgCXN0cnVjdCBkZXZpY2UgKmh3bW9u
Owo+ICAJaW50IGVycjsKPiAgCj4gLQlkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpk
YXRhKSwgR0ZQX0tFUk5FTCk7Cj4gKwlkYXRhID0ga3phbGxvYyhzaXplb2YoKmRhdGEpLCBHRlBf
S0VSTkVMKTsKPiAgCWlmICghZGF0YSkKPiAgCQlyZXR1cm4gMDsKPiAgCj4gQEAgLTIzNywxOSAr
MjM3LDMwIEBAIGludCBudm1lX2h3bW9uX2luaXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAg
Cj4gIAllcnIgPSBudm1lX2h3bW9uX2dldF9zbWFydF9sb2coZGF0YSk7Cj4gIAlpZiAoZXJyKSB7
Cj4gLQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLAo+IC0JCQkiRmFpbGVkIHRvIHJlYWQgc21hcnQg
bG9nIChlcnJvciAlZClcbiIsIGVycik7Cj4gLQkJZGV2bV9rZnJlZShkZXYsIGRhdGEpOwo+ICsJ
CWRldl93YXJuKGRldiwgIkZhaWxlZCB0byByZWFkIHNtYXJ0IGxvZyAoZXJyb3IgJWQpXG4iLCBl
cnIpOwo+ICsJCWtmcmVlKGRhdGEpOwo+ICAJCXJldHVybiBlcnI7Cj4gIAl9Cj4gIAo+IC0JaHdt
b24gPSBkZXZtX2h3bW9uX2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8oZGV2LCAibnZtZSIsIGRh
dGEsCj4gLQkJCQkJCSAgICAgJm52bWVfaHdtb25fY2hpcF9pbmZvLAo+IC0JCQkJCQkgICAgIE5V
TEwpOwo+ICsJaHdtb24gPSBod21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9pbmZvKGRldiwgIm52
bWUiLAo+ICsJCQkJCQlkYXRhLCAmbnZtZV9od21vbl9jaGlwX2luZm8sCj4gKwkJCQkJCU5VTEwp
Owo+ICAJaWYgKElTX0VSUihod21vbikpIHsKPiAgCQlkZXZfd2FybihkZXYsICJGYWlsZWQgdG8g
aW5zdGFudGlhdGUgaHdtb24gZGV2aWNlXG4iKTsKPiAtCQlkZXZtX2tmcmVlKGRldiwgZGF0YSk7
Cj4gKwkJa2ZyZWUoZGF0YSk7Cj4gIAl9Cj4gLQo+ICsJY3RybC0+aHdtb25fZGV2aWNlID0gaHdt
b247Cj4gIAlyZXR1cm4gMDsKPiAgfQo+ICsKPiArdm9pZCBudm1lX2h3bW9uX2V4aXQoc3RydWN0
IG52bWVfY3RybCAqY3RybCkKPiArewo+ICsJaWYgKGN0cmwtPmh3bW9uX2RldmljZSkgewo+ICsJ
CXN0cnVjdCBudm1lX2h3bW9uX2RhdGEgKmRhdGEgPQo+ICsJCQlkZXZfZ2V0X2RydmRhdGEoY3Ry
bC0+aHdtb25fZGV2aWNlKTsKPiArCj4gKwkJaHdtb25fZGV2aWNlX3VucmVnaXN0ZXIoY3RybC0+
aHdtb25fZGV2aWNlKTsKPiArCQljdHJsLT5od21vbl9kZXZpY2UgPSBOVUxMOwo+ICsJCWtmcmVl
KGRhdGEpOwo+ICsJfQo+ICt9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUu
aCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+IGluZGV4IDg4YTZiOTcyNDdmNS4uZjUxYjk0
MmJiNGY1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L252bWUuaAo+IEBAIC0yNDYsNiArMjQ2LDkgQEAgc3RydWN0IG52bWVf
Y3RybCB7Cj4gIAlzdHJ1Y3Qgcndfc2VtYXBob3JlIG5hbWVzcGFjZXNfcndzZW07Cj4gIAlzdHJ1
Y3QgZGV2aWNlIGN0cmxfZGV2aWNlOwo+ICAJc3RydWN0IGRldmljZSAqZGV2aWNlOwkvKiBjaGFy
IGRldmljZSAqLwo+ICsjaWZkZWYgQ09ORklHX05WTUVfSFdNT04KPiArCXN0cnVjdCBkZXZpY2Ug
Kmh3bW9uX2RldmljZTsKPiArI2VuZGlmCj4gIAlzdHJ1Y3QgY2RldiBjZGV2Owo+ICAJc3RydWN0
IHdvcmtfc3RydWN0IHJlc2V0X3dvcms7Cj4gIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QgZGVsZXRlX3dv
cms7Cj4gQEAgLTgwOSwxMSArODEyLDE0IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IG52bWVfbnMg
Km52bWVfZ2V0X25zX2Zyb21fZGV2KHN0cnVjdCBkZXZpY2UgKmRldikKPiAgCj4gICNpZmRlZiBD
T05GSUdfTlZNRV9IV01PTgo+ICBpbnQgbnZtZV9od21vbl9pbml0KHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwpOwo+ICt2b2lkIG52bWVfaHdtb25fZXhpdChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKTsK
PiAgI2Vsc2UKPiAgc3RhdGljIGlubGluZSBpbnQgbnZtZV9od21vbl9pbml0KHN0cnVjdCBudm1l
X2N0cmwgKmN0cmwpCj4gIHsKPiAgCXJldHVybiAwOwo+ICB9Cj4gKwo+ICtzdGF0aWMgaW5saW5l
IGludCBudm1lX2h3bW9uX2V4aXQoc3RydWN0IG52bWVfY3RybCAqY3RybCkge30KCkN1cnJlbnRs
eSwgbnZtZS01LjEyIGhhcyBidWlsZCBlcnJvcnM6CgpyaXZlcnMvbnZtZS90YXJnZXQvLi4vaG9z
dC9udm1lLmg6IEluIGZ1bmN0aW9uIOKAmG52bWVfaHdtb25fZXhpdOKAmToKZHJpdmVycy9udm1l
L3RhcmdldC8uLi9ob3N0L252bWUuaDo4MjU6NDI6IGVycm9yOiBubyByZXR1cm4gc3RhdGVtZW50
IGluIGZ1bmN0aW9uIHJldHVybmluZyBub24tdm9pZCBbLVdlcnJvcj1yZXR1cm4tdHlwZV0KIHN0
YXRpYyBpbmxpbmUgaW50IG52bWVfaHdtb25fZXhpdChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKSB7
fQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
