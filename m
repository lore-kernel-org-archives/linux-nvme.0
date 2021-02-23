Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:41:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664D964E4B
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 12:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664D964E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4DZDLwraPXdN+rtOQ75B6pagXW4bABdGu5gSDfDPRx0=; b=N9QkQsN2SPJkYetVEOds5vmRF
	7cobVDl0f1kVAjOkJbiS5XK9hziIIROqZThbodHFdFxgYiTBkRimtYOIIHNDPe0KzAB5nmE0Xoand
	iIRyY+rYmF5DjFgkDAZywicQHLV3Ya76nHKeAzFgX4d9b1+PM9S+WlUsh8dyyb8v30YYp7E3wlw/r
	LLy2ZqoXAzBgE4ZZ3Rdyir4f62gl1vIJvKClXwAPyY5z7c9GlPPRGw6+IH64CdiHeku06UsT9QUSl
	Qo5CQtYtmI1HdHKLtFHXvnOJWnPY/Ts6QBFx4osZIxF5Hg8cG0rkkDhLlTUhwV56ceJOHXdY7GvoA
	rsO41LQ0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEX0A-000340-5M; Tue, 23 Feb 2021 12:41:18 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEX07-00033c-Tc
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 12:41:16 +0000
Received: by mail-pg1-x534.google.com with SMTP id p21so12253551pgl.12
 for <linux-nvme@lists.infradead.org>; Tue, 23 Feb 2021 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=FKwUWKupv7rREcgme7x6mR39GOnj4MPWucJJkmSwTl4=;
 b=RlZ0CPCr4j8WWfzqi5rjQJ0kNFPcFrM+LRQZoO0VV6M7bzLKnq/S3xaVsHd3Xuk9JI
 5YlxQQOvwcmQEIHiH4sFUdgWBtwvsqTD0oRhxzQhrBfL5cxLKt6cc4BQ0h+U9bqJ6mjG
 PUlX/IYw0P8NFknTRfsm6RiKLXfBuLALn925IforpO1yQchcnRf+9nPQPyOTX7mQeWvB
 WyCHH2tl1qNlA3lJVOUm4wCawvWKSJLF57nifwXZ9ANtcT89evOEiP3kovPiQfL9F4i2
 PNPHR4fw07WVPQl1pcvYp6XcTZewCHoC9ivOhYFipsQmofsgn6Pb+jt1RXi8/5mdsDAx
 +tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=FKwUWKupv7rREcgme7x6mR39GOnj4MPWucJJkmSwTl4=;
 b=eHLOqOgUEA9+vggtW/tPm8pG9PvXP6fagK1L63Z5KLtW5PqKxdeZP51VUm2CQ4f7Tu
 ZS/wkDWFVO1Vv4wmDZ1up+wGqcqYh7TcEHgjB8gXXndNb2tqbw14iwX20m+rZ/IktGAq
 UqKixRXSj0kGhJzZ8kS5bvR1CpXmnpaBPs7fCspqRQMyOQiPBmeUq+skhSdDPQK1r7Jn
 cPY+r359P3fMdqUHh/qwLxeq3nW5YQljbLK3mDxxA2MOujFYNQW1oS7M3vTpqLs6w4YU
 2qh7EnEV+gzkSiYnSqY1eRuG0yWftGmGRx0q0xHU7LmKI+mw6sJnCxFsDidv8/HN5yg4
 5x8g==
X-Gm-Message-State: AOAM531vC3ej0R3diHw72T/Ti2SvhE9KAY90kFElZsuTzLEIX1DuLYmo
 M8d+gJyCbzBiRDoTJoAmFb0=
X-Google-Smtp-Source: ABdhPJxV7WUXsCWlGc4iBy+0kfbAUJfXUdV4P08WMbeRwACK6UTN1NCBqhhVv9JYXE23x84QbOposQ==
X-Received: by 2002:a05:6a00:78e:b029:1ed:d3df:a480 with SMTP id
 g14-20020a056a00078eb02901edd3dfa480mr1754498pfu.72.1614084071945; 
 Tue, 23 Feb 2021 04:41:11 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id lx1sm3020868pjb.8.2021.02.23.04.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:41:11 -0800 (PST)
Date: Tue, 23 Feb 2021 21:41:09 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] nvme: add 'fail_if_no_path' sysfs attribute
Message-ID: <20210223124109.GB2119@localhost.localdomain>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210223115922.104369-2-hare@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_074116_016051_A621264E 
X-CRM114-Status: GOOD (  21.76  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjEtMDItMjMgMTI6NTk6MjEsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBJbiBzb21lIHNl
dHVwcyBsaWtlIFJBSUQgb3IgY2x1c3RlciB3ZSBuZWVkIHRvIHJldHVybiBhbiBJL08gZXJyb3IK
PiBvbmNlIGFsbCBwYXRocyBhcmUgdW5hdmFpbGFibGUgdG8gYWxsb3cgdGhlIHVwcGVyIGxheWVy
cyB0byBzdGFydAo+IHRoZWlyIG93biBlcnJvciByZWNvdmVyeSAobGlrZSByZWRpcmVjdGluZyBJ
L08gdG8gb3RoZXIgbWlycm9ycykuCj4gVGhpcyBwYXRjaCBhZGRzIGEgc3lzZnMgYXR0cmlidXRl
ICdmYWlsX2lmX25vX3BhdGgnIHRvIGFsbG93IHRoZQo+IGFkbWluIHRvIGVuYWJsZSB0aGF0IGJl
aGF2aW91ciBpbnN0ZWFkIG9mIHRoZSBjdXJyZW50ICdxdWV1ZSB1bnRpbAo+IGEgcGF0aCBiZWNv
bWVzIGF2YWlsYWJsZScgcG9saWN5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICB8
ICA1ICsrKysKPiAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgfCA0MyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLQo+ICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggICAg
ICB8ICAyICsrCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCj4gaW5kZXggNGRlNmEzYTEzNTc1Li4yZmIzZWNjMGM1M2IgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4gQEAgLTM0NjQsNiArMzQ2NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmli
dXRlICpudm1lX25zX2lkX2F0dHJzW10gPSB7Cj4gICNpZmRlZiBDT05GSUdfTlZNRV9NVUxUSVBB
VEgKPiAgCSZkZXZfYXR0cl9hbmFfZ3JwaWQuYXR0ciwKPiAgCSZkZXZfYXR0cl9hbmFfc3RhdGUu
YXR0ciwKPiArCSZkZXZfYXR0cl9mYWlsX2lmX25vX3BhdGguYXR0ciwKPiAgI2VuZGlmCj4gIAlO
VUxMLAo+ICB9Owo+IEBAIC0zNDk0LDYgKzM0OTUsMTAgQEAgc3RhdGljIHVtb2RlX3QgbnZtZV9u
c19pZF9hdHRyc19hcmVfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwKPiAgCQlpZiAoIW52
bWVfY3RybF91c2VfYW5hKG52bWVfZ2V0X25zX2Zyb21fZGV2KGRldiktPmN0cmwpKQo+ICAJCQly
ZXR1cm4gMDsKPiAgCX0KPiArCWlmIChhID09ICZkZXZfYXR0cl9mYWlsX2lmX25vX3BhdGguYXR0
cikgewo+ICsJCWlmIChkZXZfdG9fZGlzayhkZXYpLT5mb3BzID09ICZudm1lX2JkZXZfb3BzKQo+
ICsJCQlyZXR1cm4gMDsKPiArCX0KPiAgI2VuZGlmCj4gIAlyZXR1cm4gYS0+bW9kZTsKPiAgfQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4gaW5kZXggMDY5NjMxOWFkYWY2Li5kNTc3M2VhMTA1YjEgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9tdWx0aXBhdGguYwo+IEBAIC0yODMsMTAgKzI4MywxOCBAQCBzdGF0aWMgYm9v
bCBudm1lX2F2YWlsYWJsZV9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQpCj4gIAkJCWNv
bnRpbnVlOwo+ICAJCXN3aXRjaCAobnMtPmN0cmwtPnN0YXRlKSB7Cj4gIAkJY2FzZSBOVk1FX0NU
UkxfTElWRToKPiArCQkJaWYgKCF0ZXN0X2JpdChOVk1FX05TSEVBRF9GQUlMX0lGX05PX1BBVEgs
Cj4gKwkJCQkgICAgICAmaGVhZC0+ZmxhZ3MpKQo+ICsJCQkJcmV0dXJuIHRydWU7Cj4gKwkJCWlm
IChucy0+YW5hX3N0YXRlICE9IE5WTUVfQU5BX0lOQUNDRVNTSUJMRSAmJgo+ICsJCQkgICAgbnMt
PmFuYV9zdGF0ZSAhPSBOVk1FX0FOQV9QRVJTSVNURU5UX0xPU1MpCj4gKwkJCQlyZXR1cm4gdHJ1
ZTsKCkl0IGxvb2tzIGxpa2UgaXQgbmVlZHMgdG8gcHJldmVudCBmYWxsdGhydSBoZXJlIHdpdGgg
cmV0dXJuIGZhbHNlLiAgSXQKY2F1c2VzIGZvbGxvd2luZyB3YXJuaW5nOgoKICBkcml2ZXJzL252
bWUvaG9zdC9tdWx0aXBhdGguYzogSW4gZnVuY3Rpb24g4oCYbnZtZV9hdmFpbGFibGVfcGF0aOKA
mToKICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYzoyODk6Nzogd2FybmluZzogdGhpcyBz
dGF0ZW1lbnQgbWF5IGZhbGwgdGhyb3VnaCBbLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD1dCiAgICAy
ODkgfCAgICBpZiAobnMtPmFuYV9zdGF0ZSAhPSBOVk1FX0FOQV9JTkFDQ0VTU0lCTEUgJiYKICAg
ICAgICB8ICAgICAgIF4KICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYzoyOTI6Mzogbm90
ZTogaGVyZQogICAgMjkyIHwgICBjYXNlIE5WTUVfQ1RSTF9SRVNFVFRJTkc6CiAgICAgICAgfCAg
IF5+fn4KCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwppbmRleCBmOTk1YjgyMzQ2MjIuLmQ2OTJlYWIzZDQ4
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKKysrIGIvZHJpdmVy
cy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKQEAgLTI4OSw2ICsyODksNyBAQCBzdGF0aWMgYm9vbCBu
dm1lX2F2YWlsYWJsZV9wYXRoKHN0cnVjdCBudm1lX25zX2hlYWQgKmhlYWQpCiAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChucy0+YW5hX3N0YXRlICE9IE5WTUVfQU5BX0lOQUNDRVNTSUJMRSAm
JgogICAgICAgICAgICAgICAgICAgICAgICAgICAgbnMtPmFuYV9zdGF0ZSAhPSBOVk1FX0FOQV9Q
RVJTSVNURU5UX0xPU1MpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHRy
dWU7CisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKICAgICAgICAgICAgICAg
IGNhc2UgTlZNRV9DVFJMX1JFU0VUVElORzoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
