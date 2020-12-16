Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30169C4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 08:01:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BE623343
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 08:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BE623343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:References:Message-Id:Date:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mMMZj7DKl4Q30pM22r46tuyyJoEmgp0M0ejo9X4v3fo=; b=Ok6mQwrG6FwiKXIJ8oiFDOg6m
	1gEwjDAVp+YwN3LwOOK+UHsO48iZcEfvjwOdG8eD9XCSuW9BrZuK08W/Z6V2m+C4Vygkva4jnupNy
	Go9kkK2JF9aWpbdsdK19+EGWOdcJ/z86rOyH4xaZRAiodXdJO8zQ1WhlYbJ2Ypj0US0o64Rp0CuU3
	9USpb009le7O0yfLTheHi+RtgMeubwaOiar4El1i7QsgWbpwG18xqFvv3lsP86MCVqxvFVvtK3zK2
	hj+mPR64/MjWE07HZidWzjmlTLgoDkdc9+sW8ypItAqUTPGGOHqFtmuGTNFVvtkH75Nhd9QzOnPtV
	prswWGp9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpRkI-0001zq-Ib; Wed, 16 Dec 2020 08:01:14 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpRkD-0001xw-47
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 08:01:12 +0000
Received: by mail-ed1-x533.google.com with SMTP id h16so23805478edt.7
 for <linux-nvme@lists.infradead.org>; Wed, 16 Dec 2020 00:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=TK2+rxKYqb9+AHBAgonGhFMhZ04YHGd5Yl1GOTZdM9o=;
 b=SYUUMPDPsVX0FpTrNk7+IQ5D0elUv6IeupWe1gij/Ndb8c/V9x/Kk1a/hMZ3DSrcya
 rTLueIbag23jVSh6DuCDci91vvwkbeVtdkzdyLBjX03sxAZSTUx326bT80TKiskoxwFf
 /nV2JVGwnoB0AMSw/wWg9+AdkZB2VummL91t4yvsfV57cAN7QnyG3hlfCGO0DAs6tKVr
 P2y/GLzf0n7xN3sNeLXhcm3tGn/VmVH0lwEZaP4FiDoUURwVOMaYSWBjCnX2fo2lK9PP
 fYk5wZx7a0lgwK7ek+FVbApRO8viQvM8ygAcl7QwDISMingTpiWejO3g9nEv3szuomgl
 dIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=TK2+rxKYqb9+AHBAgonGhFMhZ04YHGd5Yl1GOTZdM9o=;
 b=h9qMAwH+omXWwRSygskqK3fMulZx2OdUSFGbKI0M7aQM5/B1XQ2TGVKOLQKcUcy8rx
 FkhuvIyq2gWp/wfcN0qdXEppBmrspqLicX1MYgn6aKCfK2TEdFH0Qw4/G/Jf3xn8z052
 43tRw+f2foRTQnVUZH650G8gS2JBz4N1U6VFo8l2qrwQ6ZuiI1wg929t21MSxrmUtgAI
 1NFCmeFHcrXUxzDtouTu4AcsOgwm6ENWk4Rzad7kJfPg87ijLeROZdJX8F+bS6bFhsNW
 sNtMalmwk/Ag20R+rJk2BOdGKWuUUuPd6LjGq1y/7Ae+DcFiZunqBRf8/GF8TlIQycmg
 hB+Q==
X-Gm-Message-State: AOAM531Kcxreh31cQ+OPpcaSK3zSXRUk5gcJ5RTF9K2695iuBHpIt0Rc
 eje+q46xWTJVvmzOJyoP18zQ6g==
X-Google-Smtp-Source: ABdhPJxH6A/gyCc15lrO0/OaDJzFkcSc/9sFJ1LDfOKXOwmTW6gxp6PK/MEYoX3U6VXHzJvCAUzF7Q==
X-Received: by 2002:aa7:d2c9:: with SMTP id k9mr5614173edr.74.1608105666959;
 Wed, 16 Dec 2020 00:01:06 -0800 (PST)
Received: from [192.168.10.21] (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id mb22sm801178ejb.35.2020.12.16.00.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Dec 2020 00:01:06 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Date: Wed, 16 Dec 2020 09:01:05 +0100
Message-Id: <84685B9E-B4CB-4F30-AB58-DB88F117889D@javigon.com>
References: <20201215221254.GA3915989@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20201215221254.GA3915989@dhcp-10-100-145-180.wdc.com>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (18B92)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_030109_351901_D64CE7F7 
X-CRM114-Status: GOOD (  18.35  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gT24gMTUgRGVjIDIwMjAsIGF0IDIzLjEyLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5v
cmc+IHdyb3RlOgo+IAo+IO+7v09uIFR1ZSwgRGVjIDE1LCAyMDIwIGF0IDA4OjU1OjU3UE0gKzAx
MDAsIGphdmllckBqYXZpZ29uLmNvbSB3cm90ZToKPj4gRnJvbTogSmF2aWVyIEdvbnrDoWxleiA8
amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4+IAo+PiBDcmVhdGUgYSBjaGFyIGRldmljZSBwZXIg
TlZNZSBuYW1lc3BhY2UuIFRoaXMgY2hhciBkZXZpY2UgaXMgYWx3YXlzCj4+IGluaXRpYWxpemVk
LCBpbmRlcGVuZGVudGx5IG9mIHdoZXRoZXIgdGhlIGZlYXR1cmVzIGltcGxlbWVudGVkIGJ5IHRo
ZQo+PiBkZXZpY2UgYXJlIHN1cHBvcnRlZCBieSB0aGUga2VybmVsLiBVc2VyLXNwYWNlIGNhbiB0
aGVyZWZvcmUgYWx3YXlzCj4+IGlzc3VlIElPQ1RMcyB0byB0aGUgTlZNZSBkcml2ZXIgdXNpbmcg
dGhlIGNoYXIgZGV2aWNlLgo+PiAKPj4gVGhlIGNoYXIgZGV2aWNlIGlzIHByZXNlbnRlZCBhcyAv
ZGV2L2dlbmVyaWMtbnZtZVhjWW5aLiBUaGlzIG5hbWluZwo+PiBzY2hlbWUgZm9sbG93cyB0aGUg
Y29udmVudGlvbiBvZiB0aGUgaGlkZGVuIGRldmljZSAobnZtZVhjWW5aKS4gU3VwcG9ydAo+PiBm
b3IgbXVsdGlwYXRoIHdpbGwgZm9sbG93Lgo+PiAKPj4gQ2hyaXN0b3BoLCBLZWl0aDogSXMgdGhp
cyBnb2luZyBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uPwo+IAo+IEkgdGhpbmsgdGhpcyBpcyBsb29r
aW5nIG9rYXksIHRob3VnaCBJJ20gZ2V0dGluZyBzb21lIHdlaXJkIGVycm9ycyBhbmQKPiB3YXJu
aW5ncyBkdXJpbmcgYm9vdC4gVGhlIGZpcnN0IG9uZSBsb29rcyBsaWtlIHRoZSBmb2xsb3dpbmcg
KEkgd2lsbAo+IGxvb2sgaW50byBpdCB0b28sIGJ1dCBJIHdhbnRlZCB0byBnZXQgYSByZXBseSBv
dXQgc29vbmVyKS4KPiAKPiBbICAgIDQuNzM0MTQzXSBzeXNmczogY2Fubm90IGNyZWF0ZSBkdXBs
aWNhdGUgZmlsZW5hbWUgJy9kZXYvY2hhci8yNDI6MScKPiBbICAgIDQuNzM2MzU5XSBDUFU6IDQg
UElEOiA3IENvbW06IGt3b3JrZXIvdTE2OjAgTm90IHRhaW50ZWQgNS4xMC4wKyAjMTcyCj4gWyAg
ICA0Ljc0MDgzNl0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJ
WCwgMTk5NiksIEJJT1MgcmVsLTEuMTQuMC0wLWcxNTU4MjFhMTk5MGItcHJlYnVpbHQucWVtdS5v
cmcgMDQvMDEvMjAxNAo+IFsgICAgNC43NDQyMjhdIFdvcmtxdWV1ZTogbnZtZS13cSBudm1lX3Nj
YW5fd29yayBbbnZtZV9jb3JlXQo+IFsgICAgNC43NDU1NThdIENhbGwgVHJhY2U6Cj4gWyAgICA0
Ljc0NjEyMl0gIGR1bXBfc3RhY2srMHg2ZC8weDg4Cj4gWyAgICA0Ljc0NjgzNF0gIHN5c2ZzX3dh
cm5fZHVwLmNvbGQrMHgxNy8weDI0Cj4gWyAgICA0Ljc0NzY1Nl0gIHN5c2ZzX2RvX2NyZWF0ZV9s
aW5rX3NkLmlzcmEuMCsweGIwLzB4YzAKPiBbICAgIDQuNzQ3NjU5XSAgZGV2aWNlX2FkZCsweDYw
NC8weDdiMAo+IFsgICAgNC43NDkyOThdICBjZGV2X2RldmljZV9hZGQrMHg0Ni8weDcwCj4gWyAg
ICA0Ljc1MzI0MV0gID8gY2Rldl9pbml0KzB4NTEvMHg2MAo+IFsgICAgNC43NTMyNDZdICBudm1l
X2FsbG9jX25zKzB4NjcwLzB4OGEwIFtudm1lX2NvcmVdCj4gWyAgICA0Ljc1MzI0OV0gID8gX2Nv
bmRfcmVzY2hlZCsweDE1LzB4MzAKPiBbICAgIDQuNzUzMjUzXSAgbnZtZV92YWxpZGF0ZV9vcl9h
bGxvY19ucysweDk5LzB4MTkwIFtudm1lX2NvcmVdCj4gWyAgICA0Ljc1MzI1OF0gIG52bWVfc2Nh
bl93b3JrKzB4MTUyLzB4MjkwIFtudm1lX2NvcmVdCj4gWyAgICA0Ljc1MzI2MV0gIHByb2Nlc3Nf
b25lX3dvcmsrMHgxYWMvMHgzMzAKPiBbICAgIDQuNzUzMjYyXSAgd29ya2VyX3RocmVhZCsweDUw
LzB4M2EwCj4gWyAgICA0Ljc1MzI2NF0gID8gcHJvY2Vzc19vbmVfd29yaysweDMzMC8weDMzMAo+
IFsgICAgNC43NTMyNjVdICBrdGhyZWFkKzB4ZmIvMHgxMzAKPiBbICAgIDQuNzUzMjY2XSAgPyBr
dGhyZWFkX3BhcmsrMHg5MC8weDkwCj4gWyAgICA0Ljc1MzI2OV0gIHJldF9mcm9tX2ZvcmsrMHgx
Zi8weDMwCj4gWyAgICA0Ljc1MzI3Ml0gQ1BVOiA1IFBJRDogODggQ29tbToga3dvcmtlci91MTY6
MSBOb3QgdGFpbnRlZCA1LjEwLjArICMxNzIKCk1tbS4gSeKAmWxsIGxvb2sgaW50byBpdC4gSSBk
b27igJl0IHNlZSB0aGlzIGluIHRoZSBjb25maWcgSeKAmW0gdXNpbmcuIAoKPiAKPj4gS2VpdGg6
IFJlZ2FyZGluZyBudm1lLWNsaSBzdXBwb3J0LCB3aGF0IGRvIHlvdSB0aGluayBhYm91dCByZXBv
cnRpbmcgdGhlCj4+IGNoYXIgZGV2aWNlIGFzIGV4aXN0aW5nIGJsb2NrIGRldmljZXM/IElmIHRo
aXMgaXMgT0sgd2l0aCB5b3UsIEkgd2lsbAo+PiBzdWJtaXQgcGF0Y2hlcyBmb3IgdGhlIGZpbHRl
cnMuCj4gCj4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGFib3V0IHJl
cG9ydGluZyB0aGVzZSBhcwo+ICJleGlzdGluZyBibG9jayBkZXZpY2VzIi4gQXJlIHlvdSB0YWxr
aW5nIGFib3V0IHdoYXQncyBzaG93biBpbiB0aGUKPiAnbnZtZSBsaXN0JyBvdXRwdXQ/CgpFeGFj
dGx5LiBEbyB3ZSB3YW50IHRoZSBjaGFyIGRldmljZSB0byBiZSBsaXN0ZWQ/Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
