Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E79DC4332B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 07:17:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246722076A
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 07:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k+8E0EpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246722076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ohvqUC6AC7ivBg2b53wjI3sRCNkba4/jpaYos3xfDXw=; b=k+8E0EpIUaCv+59NIYb1VKsO1
	8mLmIGmMd3Ky6C6GcBxe0PxVuS6GLvgr3d8hK1gewTEn/BlcOgN3F0PmZ6u1iQK1uA5If/Fqx//kp
	8qxrMzq/AIDu5ZU67k6LMxwoPy+enU3yAekiXLU5YR60iFWiz/ruBRoR7QmFR3N7z3VOPhZq13V0K
	r+ph2TMTPISRyN2qlTpdyUdVlOtTWWdicHJSZi/q9z7dE0InE8Pd9LwS5IYX3W+1TacMpCkSFN09M
	H71g8CVVSOOaovNcCXG+SYehLz26rnoMJuDDqFvxwSGVRsxuPEvb9plpG+KK7h2jlSYDn5odDEsgN
	3uqC61pLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGdoD-0006WT-Nd; Tue, 24 Mar 2020 07:17:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGdoA-0006Vl-8I
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 07:17:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5258CACA1;
 Tue, 24 Mar 2020 07:17:02 +0000 (UTC)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-block@vger.kernel.org
References: <20200323182324.3243-1-ikegami.t@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2293733b-77d7-6fbb-a81a-b68c10656757@suse.de>
Date: Tue, 24 Mar 2020 08:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323182324.3243-1-ikegami.t@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_001706_583849_EFF922D9 
X-CRM114-Status: GOOD (  21.70  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8yMy8yMCA3OjIzIFBNLCBUb2t1bm9yaSBJa2VnYW1pIHdyb3RlOgo+IEN1cnJlbnRseSBk
YXRhIGxlbmd0aCBjYW4gYmUgc3BlY2lmaWVkIGFzIFVJTlRfTUFYIGJ1dCBmYWlsZWQuCj4gVGhp
cyBpcyBjYXVzZWQgYnkgdGhlIG1heCBzZWdtZW50cyBwYXJhbWV0ZXIgbGltaXQgc2V0IGFzIFVT
SFJUX01BWC4KPiBUbyByZXNvbHZlIHRoaXMgaXNzdWUgY2hhbmdlIHRvIGluY3JlYXNlIHRoZSB2
YWx1ZSBsaW1pdCByYW5nZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBUb2t1bm9yaSBJa2VnYW1pIDxp
a2VnYW1pLnRAZ21haWwuY29tPgo+IENjOiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcKPiBD
YzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gLS0tCj4gICBibG9jay9ibGstc2V0
dGluZ3MuYyAgICAgfCAyICstCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAyICstCj4g
ICBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oICAgfCA3ICsrKystLS0KPiAgIDMgZmlsZXMgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ibG9j
ay9ibGstc2V0dGluZ3MuYyBiL2Jsb2NrL2Jsay1zZXR0aW5ncy5jCj4gaW5kZXggYzhlZGEyZTdi
OTFlLi5lZDQwYmRhNTczYzIgMTAwNjQ0Cj4gLS0tIGEvYmxvY2svYmxrLXNldHRpbmdzLmMKPiAr
KysgYi9ibG9jay9ibGstc2V0dGluZ3MuYwo+IEBAIC0yNjYsNyArMjY2LDcgQEAgRVhQT1JUX1NZ
TUJPTChibGtfcXVldWVfbWF4X3dyaXRlX3plcm9lc19zZWN0b3JzKTsKPiAgICAqICAgIEVuYWJs
ZXMgYSBsb3cgbGV2ZWwgZHJpdmVyIHRvIHNldCBhbiB1cHBlciBsaW1pdCBvbiB0aGUgbnVtYmVy
IG9mCj4gICAgKiAgICBodyBkYXRhIHNlZ21lbnRzIGluIGEgcmVxdWVzdC4KPiAgICAqKi8KPiAt
dm9pZCBibGtfcXVldWVfbWF4X3NlZ21lbnRzKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCB1bnNp
Z25lZCBzaG9ydCBtYXhfc2VnbWVudHMpCj4gK3ZvaWQgYmxrX3F1ZXVlX21heF9zZWdtZW50cyhz
dHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSwgdW5zaWduZWQgaW50IG1heF9zZWdtZW50cykKPiAgIHsK
PiAgIAlpZiAoIW1heF9zZWdtZW50cykgewo+ICAgCQltYXhfc2VnbWVudHMgPSAxOwo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPiBpbmRleCBhNGQ4YzkwZWU3Y2MuLjJiNDhhYWIwOTY5ZSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBA
QCAtMjE5Myw3ICsyMTkzLDcgQEAgc3RhdGljIHZvaWQgbnZtZV9zZXRfcXVldWVfbGltaXRzKHN0
cnVjdCBudm1lX2N0cmwgKmN0cmwsCj4gICAKPiAgIAkJbWF4X3NlZ21lbnRzID0gbWluX25vdF96
ZXJvKG1heF9zZWdtZW50cywgY3RybC0+bWF4X3NlZ21lbnRzKTsKPiAgIAkJYmxrX3F1ZXVlX21h
eF9od19zZWN0b3JzKHEsIGN0cmwtPm1heF9od19zZWN0b3JzKTsKPiAtCQlibGtfcXVldWVfbWF4
X3NlZ21lbnRzKHEsIG1pbl90KHUzMiwgbWF4X3NlZ21lbnRzLCBVU0hSVF9NQVgpKTsKPiArCQli
bGtfcXVldWVfbWF4X3NlZ21lbnRzKHEsIG1pbl90KHUzMiwgbWF4X3NlZ21lbnRzLCBVSU5UX01B
WCkpOwo+ICAgCX0KPiAgIAlpZiAoKGN0cmwtPnF1aXJrcyAmIE5WTUVfUVVJUktfU1RSSVBFX1NJ
WkUpICYmCj4gICAJICAgIGlzX3Bvd2VyX29mXzIoY3RybC0+bWF4X2h3X3NlY3RvcnMpKQo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51eC9ibGtkZXYu
aAo+IGluZGV4IGY2MjlkNDBjNjQ1Yy4uNGY0MjI0ZTIwYzI4IDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvbGludXgvYmxrZGV2LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCj4gQEAgLTMz
OCw4ICszMzgsOCBAQCBzdHJ1Y3QgcXVldWVfbGltaXRzIHsKPiAgIAl1bnNpZ25lZCBpbnQJCW1h
eF93cml0ZV96ZXJvZXNfc2VjdG9yczsKPiAgIAl1bnNpZ25lZCBpbnQJCWRpc2NhcmRfZ3JhbnVs
YXJpdHk7Cj4gICAJdW5zaWduZWQgaW50CQlkaXNjYXJkX2FsaWdubWVudDsKPiArCXVuc2lnbmVk
IGludAkJbWF4X3NlZ21lbnRzOwo+ICAgCj4gLQl1bnNpZ25lZCBzaG9ydAkJbWF4X3NlZ21lbnRz
Owo+ICAgCXVuc2lnbmVkIHNob3J0CQltYXhfaW50ZWdyaXR5X3NlZ21lbnRzOwo+ICAgCXVuc2ln
bmVkIHNob3J0CQltYXhfZGlzY2FyZF9zZWdtZW50czsKPiAgIAo+IEBAIC0xMDY3LDcgKzEwNjcs
OCBAQCBleHRlcm4gdm9pZCBibGtfcXVldWVfbWFrZV9yZXF1ZXN0KHN0cnVjdCByZXF1ZXN0X3F1
ZXVlICosIG1ha2VfcmVxdWVzdF9mbiAqKTsKPiAgIGV4dGVybiB2b2lkIGJsa19xdWV1ZV9ib3Vu
Y2VfbGltaXQoc3RydWN0IHJlcXVlc3RfcXVldWUgKiwgdTY0KTsKPiAgIGV4dGVybiB2b2lkIGJs
a19xdWV1ZV9tYXhfaHdfc2VjdG9ycyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqLCB1bnNpZ25lZCBp
bnQpOwo+ICAgZXh0ZXJuIHZvaWQgYmxrX3F1ZXVlX2NodW5rX3NlY3RvcnMoc3RydWN0IHJlcXVl
c3RfcXVldWUgKiwgdW5zaWduZWQgaW50KTsKPiAtZXh0ZXJuIHZvaWQgYmxrX3F1ZXVlX21heF9z
ZWdtZW50cyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqLCB1bnNpZ25lZCBzaG9ydCk7Cj4gK2V4dGVy
biB2b2lkIGJsa19xdWV1ZV9tYXhfc2VnbWVudHMoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCj4g
KwkJCQkgICB1bnNpZ25lZCBpbnQgbWF4X3NlZ21lbnRzKTsKPiAgIGV4dGVybiB2b2lkIGJsa19x
dWV1ZV9tYXhfZGlzY2FyZF9zZWdtZW50cyhzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqLAo+ICAgCQl1
bnNpZ25lZCBzaG9ydCk7Cj4gICBleHRlcm4gdm9pZCBibGtfcXVldWVfbWF4X3NlZ21lbnRfc2l6
ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqLCB1bnNpZ25lZCBpbnQpOwo+IEBAIC0xMjc2LDcgKzEy
NzcsNyBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBxdWV1ZV9tYXhfaHdfc2VjdG9ycyhj
b25zdCBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKPiAgIAlyZXR1cm4gcS0+bGltaXRzLm1heF9o
d19zZWN0b3JzOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgc2hvcnQgcXVl
dWVfbWF4X3NlZ21lbnRzKGNvbnN0IHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQo+ICtzdGF0aWMg
aW5saW5lIHVuc2lnbmVkIGludCBxdWV1ZV9tYXhfc2VnbWVudHMoY29uc3Qgc3RydWN0IHJlcXVl
c3RfcXVldWUgKnEpCj4gICB7Cj4gICAJcmV0dXJuIHEtPmxpbWl0cy5tYXhfc2VnbWVudHM7Cj4g
ICB9Cj4gCk9uZSB3b3VsZCBhc3N1bWUgdGhhdCB0aGUgc2FtZSByZWFzb25pbmcgZ29lcyBmb3Ig
bWF4X2ludGVncml0eV9zZWdtZW50LCBubz8KCk90aGVyd2lzZSBsb29rcyBnb29kLgoKUmV2aWV3
ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgVGVhbWxlYWQgU3RvcmFnZSAmIE5ldHdv
cmtpbmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkw
NDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVy
OiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
