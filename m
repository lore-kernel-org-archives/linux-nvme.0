Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CAC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 15:38:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABE42087E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nspL/BN8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk33wkxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABE42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sYc6SFbQ8SS+jvVWnj3x2EOkpReNU6q/OowwTBk13zY=; b=nspL/BN8k+yvLP
	/CaAwEdsKhEyEpLW3zcUo/iRZvPdYVW3lNqdJhCW6SbZlFD/Onh950Lu2NPyQQiGnUV4xxQk16qGq
	YwHjgi7fxYljHZbS5BYbJrtBd4j9OBtsIT3Nf9MkOuAoTgWmx2TsNS6bBxrbFX/kdYp0jdX+4/rR2
	TGXj6q0sc98O2naBz2nOrU38B357G3w5xREpSBU0UIvbCYtunymC6C9ZqZmoI9w+RXq8I/xtliOJ1
	VkxOSpj6m42riioulXRTlPefXmQtZtrlgGK8YswRjPkifpD0qEJv5VAOCrXHwYcaQT6K4R2VKlo31
	oBXXNrE6usFsw3PKkGcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS0v1-0008Hl-95; Tue, 05 Nov 2019 15:38:55 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS0uz-0008Gw-A5
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 15:38:54 +0000
Received: by mail-lj1-x244.google.com with SMTP id n5so11355495ljc.9
 for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2019 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EIBHT5s6k+333mQe6iMA24qOIrnpa2LpfWWRGm3y8Uk=;
 b=Gk33wkxLvAqPOKdHBeJ6/Wa+w97SPkh9B3EAkkX7ibmcliP2i+jxA/tLdWb7LJQcao
 22DiooKESnaW5Fr1zKJC2eDwcXyX9eDXs8BkHVl1mglyDeJsj3Tc8MDf4Kgrt0LEzcCD
 6re7DGPQuAlrVVB+LWbQM9X1Z7SLuzsS1dhaSWU8BLN201a2TVuFP28M2anLI1/JmtsO
 gl/6KVoA1f5ZldRpmIbIXKELKfQvbRGgKsG5C0/HUkNHrEDNx7BLUGEMCvE2uNW5eH5E
 oVdhEc1kPI3nfsLIM9tAFvhe3CN426XtFhX3D7Kiq0WIrJXFgVIYt2KzzkOoGIT+fD74
 uxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EIBHT5s6k+333mQe6iMA24qOIrnpa2LpfWWRGm3y8Uk=;
 b=fMdRVdaZn54dGLPdN1Mt3gXnwyxVK6gvTn7uF4EYV3NesLtQPQB58STFtkVOQwkeFH
 LS4p69AowjWGR+oKoeTysCwuKC+zpSqf4ibGTIJL6tmjizxnNh1QZy6aurWkJY8g1vRN
 Rq2vVu1ExCBIBs48GfJJXVlvatZj6wsSR9htf82DRmUTIPQdjTvOHZlZXRcQy8Ta2+KZ
 AHWoeeLXvVrTqf6ATduqf/ly+x7/qEkVNRkqqJe9jo3XS3HsqWZ2PANbm119tT3/HoNU
 5XLgFB4JRQWn6oHtDaEC50Keo3XTNirpi2ILUmeiaQfYgJz78ApkNxEVl9cV7CU5EVmZ
 KeKg==
X-Gm-Message-State: APjAAAX8sK/Fo0tZaY97F/pBRWStvHh87oBXQzIcACEkmSvz0H26ORE2
 Xg3y1VwtKgOajgWH/nxFIcDcMpeo7nMxkh+jPfI=
X-Google-Smtp-Source: APXvYqyiGPWvrCoBqJQH7r/HG/3sG6Ju3FA5kbjzd30hxCt/lsfpv0gfRpsiNbY1AP1GIFX/pQGmwzTzcF1+WHkGSGU=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr6634886ljj.93.1572968331102;
 Tue, 05 Nov 2019 07:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20191102145530.16104-1-linux@roeck-us.net>
In-Reply-To: <20191102145530.16104-1-linux@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 6 Nov 2019 00:38:39 +0900
Message-ID: <CAC5umyi9PuMTERNvNShfzu725bhBtkOZsD3NWtcxhKq5XGU2CQ@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
To: Guenter Roeck <linux@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_073853_355509_5CD83694 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMuaXpSjlnJ8pIDIzOjU1IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD46Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUtaHdtb24uYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L252bWUtaHdtb24uYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi4yOGI0YjdmNDNiYjAKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvZHJp
dmVycy9udm1lL2hvc3QvbnZtZS1od21vbi5jCj4gQEAgLTAsMCArMSwxODEgQEAKPiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPiArLyoKPiArICogTlZNIEV4cHJlc3MgaGFy
ZHdhcmUgbW9uaXRvcmluZyBzdXBwb3J0Cj4gKyAqIENvcHlyaWdodCAoYykgMjAxOSwgR3VlbnRl
ciBSb2Vjawo+ICsgKi8KPiArCj4gKyNpbmNsdWRlIDxsaW51eC9od21vbi5oPgo+ICsjaW5jbHVk
ZSA8YXNtL3VuYWxpZ25lZC5oPgo+ICsKPiArI2luY2x1ZGUgIm52bWUuaCIKPiArCj4gK3N0cnVj
dCBudm1lX2h3bW9uX2RhdGEgewo+ICsgICAgICAgc3RydWN0IG52bWVfY3RybCAqY3RybDsKPiAr
ICAgICAgIHN0cnVjdCBudm1lX3NtYXJ0X2xvZyBsb2c7Cj4gKyAgICAgICBzdHJ1Y3QgbXV0ZXgg
cmVhZF9sb2NrOwo+ICt9Owo+ICsKPiArc3RhdGljIGludCBudm1lX2h3bW9uX2dldF9zbWFydF9s
b2coc3RydWN0IG52bWVfaHdtb25fZGF0YSAqZGF0YSkKPiArewo+ICsgICAgICAgaW50IHJldDsK
PiArCj4gKyAgICAgICByZXQgPSBudm1lX2dldF9sb2coZGF0YS0+Y3RybCwgTlZNRV9OU0lEX0FM
TCwgTlZNRV9MT0dfU01BUlQsIDAsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgJmRhdGEt
PmxvZywgc2l6ZW9mKGRhdGEtPmxvZyksIDApOwo+ICsKPiArICAgICAgIHJldHVybiByZXQgPD0g
MCA/IHJldCA6IC1FSU87Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgbnZtZV9od21vbl9yZWFkKHN0
cnVjdCBkZXZpY2UgKmRldiwgZW51bSBod21vbl9zZW5zb3JfdHlwZXMgdHlwZSwKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICB1MzIgYXR0ciwgaW50IGNoYW5uZWwsIGxvbmcgKnZhbCkKPiAr
ewo+ICsgICAgICAgc3RydWN0IG52bWVfaHdtb25fZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOwo+ICsgICAgICAgc3RydWN0IG52bWVfc21hcnRfbG9nICpsb2cgPSAmZGF0YS0+bG9n
Owo+ICsgICAgICAgaW50IHRlbXA7Cj4gKyAgICAgICBpbnQgZXJyOwo+ICsKPiArICAgICAgIC8q
Cj4gKyAgICAgICAgKiBGaXJzdCBoYW5kbGUgYXR0cmlidXRlcyB3aGljaCBkb24ndCByZXF1aXJl
IHVzIHRvIHJlYWQKPiArICAgICAgICAqIHRoZSBzbWFydCBsb2cuCj4gKyAgICAgICAgKi8KPiAr
ICAgICAgIHN3aXRjaCAoYXR0cikgewo+ICsgICAgICAgY2FzZSBod21vbl90ZW1wX21heDoKPiAr
ICAgICAgICAgICAgICAgKnZhbCA9IChkYXRhLT5jdHJsLT53Y3RlbXAgLSAyNzMpICogMTAwMDsK
PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKyAgICAgICBjYXNlIGh3bW9uX3RlbXBfY3Jp
dDoKPiArICAgICAgICAgICAgICAgKnZhbCA9IChkYXRhLT5jdHJsLT5jY3RlbXAgLSAyNzMpICog
MTAwMDsKClRoaXMgYXR0cmlidXRlIHNob3VsZCBiZSAnaHdtb25fdGVtcF9tYXhfYWxhcm0nIHJh
dGhlciB0aGFuCidod21vbl90ZW1wX2NyaXRfYWxhcm0nPwoKVGhlICdod21vbl90ZW1wX2NyaXRf
YWxhcm0nIGluZGljYXRlcyB0aGF0IHRoZSB0ZW1wZXJhdHVyZSBpcyBncmVhdGVyCnRoYW4gQ0NU
RU1QLgoKQnV0IGFjY29yZGluZyB0byB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIENyaXRpY2FsIFdh
cm5pbmcgZmllbGQgaW4gdGhlIE5WTWUKc3BlYywgdGhlIGJpdCAxIGlzIHNldCB0byAnMScgd2hl
biB0aGUgdGVtcGVyYXR1cmUgaXMgZ3JlYXRlciB0aGFuIG9yCmVxdWFsIHRvIGFuIG92ZXIgdGVt
cGVyYXR1cmUgdGhyZXNob2xkLiAgVGhlIGRlZmF1bHQgdmFsdWUgb2YgdGhlIG92ZXIKdGVtcGVy
YXR1cmUgdGhyZXNob2xkIGZvciBDb21wb3NpdGUgVGVtcGVyYXR1cmUgaXMgV0NURU1QLgoKVGhh
dCdzIHdoeSBJIHRoaW5rIHRoaXMgYXR0cmlidXRlIHNob3VsZCBiZSAnaHdtb25fdGVtcF9tYXhf
YWxhcm0nIHdoaWNoCmluZGljYXRlcyB0aGF0IHRoZSB0ZW1wZXJhdHVyZSBpcyBncmVhdGVyIHRo
YW4gV0NURU1QLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
