Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CFDC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 06:06:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D85A610E7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 06:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D85A610E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qDO2IxbgxJxve4XTU9/ybIWsTb45YF5kF6TlDuqqAy4=; b=Lh4A/5kGPHxMY61FJwoLQlCwU
	Gp5OhnyTmW/F3+l16MeojJnrNeRf89qBeCVlN7YCXcH9sK7Wrf2VoYRQYr7WgBqdPdFK7FHalZt6b
	P8gX2mojYOS7hEqXcfLpfX5cL794mX13KTBsiaa4NYqXqECpcf+pjsY3gdBHAUy1ZJCAxPuBZ8x42
	6Zux0uXT1jtu18MudzarRJC7ZWU+Pvzmu9SSxdUEYIFqeI7Ict8jbB/AAhPyUfPH2Nb5GOPT4b3Yt
	GBxBrENhV3coCaUHzJ2Vqacvj5GFRZSyLKZJXOQXAzgyce4TZbjuR34joum+uytQE9MbjSKsdgJnc
	cXIca759w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXHcJ-000x9d-Sf; Fri, 16 Apr 2021 06:06:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXHUm-000vvI-88
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 05:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=MUjw5mCnvtsftvs6tFiJOLxzJ7dsvdKAxTPW2x/KZw0=; b=i6ymW38GOZZIhHSxBV5v9Eq6l2
 dU4skJMuiXsXo1QbMJ7s9wgHGcOz6mx9wLjSm9kyobyl/zCtaZu8u7S36ovQ/GODlA7OgeDCjYGJz
 wkL+W6kYngtPXazk/I/ID8/a3W/oSxQFrKTsfiwAP8PXWuMkWU22dVWK2nvdZOMobpTccrWDMSb+S
 YdUx95oMaT5oGksNtJcFBo1FG+yak4NGn3BgWZt0REYTHzVnPtE0M8Di7ez/y9zpEJ2i+0fkcepwO
 kW1pkYsGrOHksdTQzvsCVVM4gE0tsX8BJDEXnyUN8f7EnYyhfiLTNAmc/YY/OtyI0HJMj9QHDhLRN
 m++58+pw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXHUj-0096JF-DE
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 05:58:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 23572AFEA;
 Fri, 16 Apr 2021 05:58:16 +0000 (UTC)
Subject: Re: nvme: Return BLK_STS_TARGET if the DNR bit is set
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210415231126.8746-1-snitzer@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <c715a982-4a75-d30f-e6f6-15ad125e7b89@suse.de>
Date: Fri, 16 Apr 2021 07:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231126.8746-1-snitzer@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_225821_613032_7806882E 
X-CRM114-Status: GOOD (  20.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8xNi8yMSAxOjExIEFNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6Cj4gQlo6IDE5NDg2OTAKPiBV
cHN0cmVhbSBTdGF0dXM6IFJIRUwtb25seQo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgU25pdHpl
ciA8c25pdHplckByZWRoYXQuY29tPgo+IAo+IHJoZWwtOC5naXQgY29tbWl0IGVmNGFiOTBjMTJk
YjVlMGU1MDgwMGVjMzIzNzM2Yjk1YmU3YTZmZjUKPiBBdXRob3I6IE1pa2UgU25pdHplciA8c25p
dHplckByZWRoYXQuY29tPgo+IERhdGU6ICAgVHVlIEF1ZyAyNSAyMTo1Mjo0NSAyMDIwIC0wNDAw
Cj4gCj4gICAgIFtudm1lXSBudm1lOiBSZXR1cm4gQkxLX1NUU19UQVJHRVQgaWYgdGhlIEROUiBi
aXQgaXMgc2V0Cj4gICAgIAo+ICAgICBNZXNzYWdlLWlkOiA8MjAyMDA4MjUyMTUyNDguMjI5MS04
LXNuaXR6ZXJAcmVkaGF0LmNvbT4KPiAgICAgUGF0Y2h3b3JrLWlkOiAzMjUxNzgKPiAgICAgUGF0
Y2h3b3JrLWluc3RhbmNlOiBwYXRjaHdvcmsKPiAgICAgTy1TdWJqZWN0OiBbUkhFTDguMyBQQVRD
SCAwNy8xMF0gbnZtZTogUmV0dXJuIEJMS19TVFNfVEFSR0VUIGlmIHRoZSBETlIgYml0IGlzIHNl
dAo+ICAgICBCdWd6aWxsYTogMTg0MzUxNQo+ICAgICBSSC1BY2tlZC1ieTogRGF2aWQgTWlsYnVy
biA8ZG1pbGJ1cm5AcmVkaGF0LmNvbT4KPiAgICAgUkgtQWNrZWQtYnk6IEdvcGFsIFRpd2FyaSA8
Z3Rpd2FyaUByZWRoYXQuY29tPgo+ICAgICBSSC1BY2tlZC1ieTogRXdhbiBNaWxuZSA8ZW1pbG5l
QHJlZGhhdC5jb20+Cj4gICAgIAo+ICAgICBCWjogMTg0MzUxNQo+ICAgICBVcHN0cmVhbSBTdGF0
dXM6IFJIRUwtb25seQo+ICAgICAKPiAgICAgSWYgdGhlIEROUiBiaXQgaXMgc2V0IHdlIHNob3Vs
ZCBub3QgcmV0cnkgdGhlIGNvbW1hbmQsIGV2ZW4gaWYKPiAgICAgdGhlIHN0YW5kYXJkIHN0YXR1
cyBldmFsdWF0aW9uIGluZGljYXRlcyBzby4KPiAgICAgCj4gICAgIFNVU0UgaXMgY2Fycnlpbmcg
dGhpcyBwYXRjaCBpbiB0aGVpciBrZXJuZWw6Cj4gICAgIGh0dHBzOi8vbHduLm5ldC9BcnRpY2xl
cy84MDAzNzAvCj4gICAgIAo+ICAgICBCYXNlZCBvbiBwYXRjaCBwb3N0ZWQgZm9yIHVwc3RyZWFt
IGluY2x1c2lvbiBidXQgcmVqZWN0ZWQ6Cj4gICAgIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1udm1lLzIwMTkwODA2MTExMDM2LjExMzIzMy0xLWhhcmVAc3VzZS5kZS8KPiAgICAg
djI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAxOTA4MDcwNzEyMDguMTAx
ODgyLTEtaGFyZUBzdXNlLmRlLwo+ICAgICB2Mi1rZWl0aDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtbnZtZS8yMDE5MDgwNzE0NDcyNS5HQjI1NjIxQGxvY2FsaG9zdC5sb2NhbGRvbWFp
bi8KPiAgICAgdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAxOTA4MTIw
NzUxNDcuNzk1OTgtMS1oYXJlQHN1c2UuZGUvCj4gICAgIHYzLWtlaXRoOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1udm1lLzIwMTkwODEzMTQxNTEwLkdCMzI2ODZAbG9jYWxob3N0Lmxv
Y2FsZG9tYWluLwo+ICAgICAKPiAgICAgVGhpcyBjb21taXQncyBjaGFuZ2UgaXMgYmFzaWNhbGx5
ICJ2My1rZWl0aCIuCj4gICAgIAo+ICAgICBTaWduZWQtb2ZmLWJ5OiBNaWtlIFNuaXR6ZXIgPHNu
aXR6ZXJAcmVkaGF0LmNvbT4KPiAgICAgU2lnbmVkLW9mZi1ieTogRnJhbnRpc2VrIEhyYmF0YSA8
ZmhyYmF0YUByZWRoYXQuY29tPgo+IAo+IC0tLQo+ICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
fCAgICAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gCj4gSW5kZXg6
IGxpbnV4LXJoZWw5L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiAtLS0g
bGludXgtcmhlbDkub3JpZy9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgbGludXgtcmhl
bDkvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gQEAgLTIzNyw2ICsyMzcsOSBAQCBzdGF0aWMg
dm9pZCBudm1lX2RlbGV0ZV9jdHJsX3N5bmMoc3RydWN0Cj4gIAo+ICBzdGF0aWMgYmxrX3N0YXR1
c190IG52bWVfZXJyb3Jfc3RhdHVzKHUxNiBzdGF0dXMpCj4gIHsKPiArCWlmICh1bmxpa2VseShz
dGF0dXMgJiBOVk1FX1NDX0ROUikpCj4gKwkJcmV0dXJuIEJMS19TVFNfVEFSR0VUOwo+ICsKPiAg
CXN3aXRjaCAoc3RhdHVzICYgMHg3ZmYpIHsKPiAgCWNhc2UgTlZNRV9TQ19TVUNDRVNTOgo+ICAJ
CXJldHVybiBCTEtfU1RTX09LOwo+IApObzsgdGhpcyBpcyBtb3N0IGxpa2VseSB3cm9uZyBmb3Ig
cXVpdGUgc29tZSBtYWNoaW5lcy4KQXQgdGhpcyB0aW1lIHdlIGRvbid0IGhhdmUgYSBmaXhlZCBt
YXBwaW5nIGZvciB0aGUgRE5SIGJpdDsKc29tZSBCTEtfU1RTX1hYIGNvZGVzIGNhbiBiZSByZXRy
aWVkLCBzb21lIG1pZ2h0LCBvdGhlcnMgc2hvdWxkIG5vdDsgd2UKbmV2ZXIgd2VudCBzbyBmYXIg
YXMgdG8gZm9ybWFsbHkgY29kZSB0aGF0LgoKQnV0IG1hcHBpbmcgaXQgdG8gQkxLX1NUU19UQVJH
RVQgaXMgbm90IHRoZSBjb3JyZWN0IHdheSBoZXJlLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlCQkgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1
c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIExJTlVYIEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBKLiBT
bWl0aGFyZCwgSi4gR3VpbGQsIEQuIFVwbWFueXUsIEcuIE5vcnRvbgpIUkIgMjEyODQgKEFHIE7D
vHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
