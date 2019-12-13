Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43AC00454
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 22:27:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB68214D8
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 22:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GfKn6NVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB68214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pfSWfJnYt3wQxV6torY5zAuAcjab+hsloWVBjrfygUw=; b=GfKn6NVNaCXHNpobG/L3dBzd8
	pi4Vnf7QUMTf3bkm7uZ3vlSQkxx1zXk88UldSbCMhtXCQac2YUICahLYK2hGyYLzyTslKBBe0MV7x
	ZbNCLcdoO4ZrFv1ObYEDDtVRhd2xqRE62d/J5Kzp8PcX1VGEa28JLEZ+FOIb7BI49C4au4TuF87Fc
	RHzPOyhtbChq04Xv6mSFJWLqp9Fb456WN4Le3p5gH5ciitH0Z2vTFxE9gNc5zyVjWG4/dYD86oXh5
	9mey5Q7ejRGWgM4C5ahnVRZWnGV1OaBFSp8IRPX7b51rgKdcdjRSvy1aT6Zh/Z1l9Yl+3TK+kCW9D
	LG6+hoqMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifs5M-0004kU-S1; Fri, 13 Dec 2019 21:02:52 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifs5K-0004j2-KN
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 21:02:52 +0000
Received: by mail-oi1-f193.google.com with SMTP id k196so1906914oib.2
 for <linux-nvme@lists.infradead.org>; Fri, 13 Dec 2019 13:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QZOZ0S6rrNiBxzcWILzSCKNOEpc5Wfbp7yyXk5488hU=;
 b=rBug/WiavV4+lo+XWE0hrIplUnGGetMO9GQ/XNEN7VcxjI86VAlwrGBmzBgx9hF34s
 7awxyNMIh7OndMmNG19QiBO0DR+5boegkJaCky3PxMq1zqFEAkWc7JdG2rs2N61pWE+e
 ZUmzrflKE6fOGPU/aD95GWQ3JJcMsLVbpg5G+KFMitqSu6izf+DqYu3DCP2kq4KTZ5Z8
 JyyaSNx7SvdIj4uhzdRuHaCNAqBbvG/i1TI3QmVPzTKXLLQvm3maLVbl8J+0xGQbsGT6
 yqmM8//BlIFyRhNmitFmdzGfGnOjYa3QRu1h/ZdLsl5hAfIEje1TH6smfVL5AnBAuynt
 2eLg==
X-Gm-Message-State: APjAAAXcHoPjtOjctGFPNSrWfrtWrBxcJUL+E7hrf+idBFn7rN/PeUIh
 XkHBeqLjxYnsq7I9Yn3muGo=
X-Google-Smtp-Source: APXvYqzvMCemXbwq+Fa/r6USRGkAOmuQ3fzE4Epg4XJfiisGmYz0bGfTohO7aGzcDSZvfPZXx3AZJQ==
X-Received: by 2002:a54:4485:: with SMTP id v5mr7429253oiv.144.1576270969698; 
 Fri, 13 Dec 2019 13:02:49 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id f3sm3718070oto.57.2019.12.13.13.02.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Dec 2019 13:02:49 -0800 (PST)
Subject: Re: [PATCH] nvme: Translate more status codes to blk_status_t
To: "Meneghini, John" <John.Meneghini@netapp.com>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20191205195730.5774-1-kbusch@kernel.org>
 <93B95176-A634-4A62-A8BF-2C599E597979@netapp.com>
 <C041F01A-6577-4DC4-A992-6F040EC6C0C9@netapp.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18f741dd-2445-141e-ea2b-4185476da8d2@grimberg.me>
Date: Fri, 13 Dec 2019 13:02:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <C041F01A-6577-4DC4-A992-6F040EC6C0C9@netapp.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191213_130250_722379_C2D90ABD 
X-CRM114-Status: GOOD (  20.11  )
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
Cc: Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gICAgICBMZXQgbWUgdGVzdCB0aGlzIG91dCBhbmQgSeKAmWxsIHNlZSB3aGF0IGhhcHBlbnMu
Cj4gICAgICAKPiBLZWl0aCwgSSd2ZSB0ZXN0ZWQgdGhpcyBvdXQsIHVzaW5nIENSRCB3aXRoIGJv
dGggTlZNRV9TQ19DTURfSU5URVJSVVBURUQgYW5kIE5WTUVfU0NfTlNfTk9UX1JFQURZLgo+IAo+
IEl0IHdvcmtzIHdlbGwgZW5vdWdoLCBidXQgSSB0aGluayB0aGUgcHJvYmxlbSBnb2VzIGEgbGl0
dGxlIGRlZXBlciB0aGFuIHRoaXMuCj4gCj4+IFRoZXNlIGFyZSBub3QgZ2VuZXJpYyBJTyBlcnJv
cnMgYW5kIHNob3VsZCB1c2UgYSBub24tcGF0aAo+PiAgIHNwZWNpZmljIGVycm9yIHNvIHRoYXQg
aXQgY2FuIHVzZSB0aGUgbm9uLWZhaWxvdmVyIHJldHJ5IHBhdGguCj4gCj4gWWVzLCBhZ3JlZWQu
ICBCdXQgd2UgaGF2ZSB0aGlzIHByb2JsZW0gd2l0aCBldmVyeS9hbnkgb3RoZXIgTlZNZSBzdGF0
dXMgdGhhdCBnZXRzIHJldHVybmVkIGFzIHdlbGwuCj4gSXQgZG9lc24ndCBtYWtlIHNlbnNlIHRv
IGp1c3Qga2VlcCBvdmVybG9hZGluZyB0aGUgaGFsZiBhIGRvemVuIGVycm9ycyB5b3UgaGF2ZSBp
biBibGtfcGF0aF9lcnJvcigpOwo+IAo+IEkgdGhpbmsgdGhlIHJlYWwgcHJvYmxlbSBpcyBoZXJl
Ogo+IAo+ICAgMjc2ICAgICAgICAgaWYgKHVubGlrZWx5KHN0YXR1cyAhPSBCTEtfU1RTX09LICYm
IG52bWVfcmVxX25lZWRzX3JldHJ5KHJlcSkpKSB7Cj4gICAyNzcgICAgICAgICAgICAgICAgIGlm
ICgocmVxLT5jbWRfZmxhZ3MgJiBSRVFfTlZNRV9NUEFUSCkgJiYKPiAgIDI3OCAgICAgICAgICAg
ICAgICAgICAgIGJsa19wYXRoX2Vycm9yKHN0YXR1cykpIHsKPiAgIDI3OSAgICAgICAgICAgICAg
ICAgICAgICAgICBudm1lX2ZhaWxvdmVyX3JlcShyZXEpOwo+ICAgMjgwICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybjsKPiAgIDI4MSAgICAgICAgICAgICAgICAgfQo+ICJudm1lL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyIgbGluZSAyODEgb2YgNDI2NyAtLTYlLS0gY29sIDMtMTcKPiAK
PiBJZiB3ZSBhcmUgcmVhbGx5IG5vdCBhbGxvd2VkIHRvIGNoYW5nZSB0aGUgYmxrX3BhdGhfZXJy
b3IoKSByb3V0aW5lIGJlY2F1c2UgaXQncyBhIHBhcnQgb2YKPiB0aGUgYmxvY2sgbGF5ZXIsIHRo
ZW4gd2h5IGRvIHdlIGhhdmUgaXQgc3R1Y2sgaW4gdGhlIG1pZGRsZSBvZiBvdXIgbXVsdGlwYXRo
aW5nIHBvbGljeQo+IGxvZ2ljPwo+IAo+IE1heWJlIHdlIHNob3VsZCBjcmVhdGUgYW4gbnZtZV9w
YXRoX2Vycm9yKCkgZnVuY3Rpb24gdG8gcmVwbGFjZSB0aGUgYmxrX3BhdGhfZXJyb3IoKQo+IGZ1
bmN0aW9uIGhlcmUuCj4gCj4gVGhlIG90aGVyIHByb2JsZW0gaXM6IHNldHRpbmcgUkVRX05WTUVf
TVBBVEggY29tcGxldGVseSBjaGFuZ2VzIHRoZSBlcnJvcgo+IGVycm9yIGhhbmRsaW5nIGxvZ2lj
LiAgSWYgbXkgY29udHJvbGxlciBoYXMgYSBzaW5nbGUgcGF0aCBpdCBoYXBwaWx5IHJldHVybnMg
YWxsIGtpbmRzCj4gb2YgTlZNZSBlcnJvcnMgbm90IGhhbmRsZWQgYnkgdGhlIG52bWVfZXJyb3Jf
c3RhdHVzKCkgd2hpdGUgbGlzdC4gIFRob3NlCj4gZXJyb3JzIGFsbCBmYWxsIHRocm91Z2ggeW91
ciByZXRyeSBsb2dpYyBhbmQgZW5kIHVwIHJldHVybmluZyAgQkxLX1NUU19JT0VSUi4KPiAKPiBI
b3dldmVyLCBhcyBzb29uIGFzIHdlIGFkZCBhbm90aGVyIHBhdGggdG8gdGhhdCBzYW1lIGNvbnRy
b2xsZXIsIGFuZCB0dXJuIG9uCj4gUkVRX05WTUVfTVBBVEgsIGFsbCBvZiBhIHN1ZGRlbiB0aGUg
Y29udHJvbGxlciBnZXRzIGEgcmVzZXQgZm9yIHJldHVybmluZwo+IHRoZSB2ZXJ5IHNhbWUgZXJy
b3JzIHRoYXQgaXQgcmV0dW5lZCBiZWZvcmUuCgpJIGFncmVlIHdlIHNob3VsZCBsb3NlIHRoaXMg
Y29udHJvbGxlciByZXNldCBhbmQgb25seSBkbyB0aGlzIGZvcgpzcGVjaWZpYyBlcnJvciBjYXNl
cyB3aGVyZSBpdHMgbmVlZGVkIChub3QgdGhpbmtpbmcgb2YgYW55IGZyb20gdGhlCnRvcCBvZiBt
eSBoZWFkKS4KCj4gQW5kIHRoYXQgaGFwcGVucyBiZWZvcmUgZXZlbiBhIHNpbmdsZSByZXRyeSBp
cyBhdHRlbXB0ZWQgLSB1bmxlc3MgaXQncyBhbiBOVk1lIHBhdGhpbmcgZXJyb3IuCj4gCj4gMTA1
ICAgICAgICAgZGVmYXVsdDoKPiAxMDYgICAgICAgICAgICAgICAgIC8qCj4gMTA3ICAgICAgICAg
ICAgICAgICAgKiBSZXNldCB0aGUgY29udHJvbGxlciBmb3IgYW55IG5vbi1BTkEgZXJyb3IgYXMg
d2UgZG9uJ3Qga25vdwo+IDEwOCAgICAgICAgICAgICAgICAgICogd2hhdCBjYXVzZWQgdGhlIGVy
cm9yLgo+IDEwOSAgICAgICAgICAgICAgICAgICovCj4gMTEwICAgICAgICAgICAgICAgICBudm1l
X3Jlc2V0X2N0cmwobnMtPmN0cmwpOwo+IDExMSAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gMTEy
ICAgICAgICAgfQo+ICJudm1lL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIiBsaW5lIDEx
MiBvZiA3MzkgLS0xNSUtLSBjb2wgMS04Cj4gCj4gVGhpcyBtYWtlcyBubyBzZW5zZS4KClNvIGxl
dHMgcmVtb3ZlIHRoaXMgcmVzZXQuIEhhdmUgdGhlIHRyYW5zcG9ydCB0YWtlIGNhcmUgb2YgdGhp
cywgb3IgZG8KaXQgb25seSB3aGVuIGl0IGlzIGNsZWFybHkgbmVlZGVkLgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
