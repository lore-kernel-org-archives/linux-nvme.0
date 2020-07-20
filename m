Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C42C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:56:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B1722B4E
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g1HYOoi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B1722B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Edg4x9tTCyfZHHdG4YL2DWq1smW9X5fCuo0Vps7nO58=; b=g1HYOoi0v0OjEbFWbARQV8Ej3
	mSlgu6EW1JzWxH9RQQSgLQmRxhtqu7tin0A4JcuxEyRN2t88lX5R/dWl91ZXZuiqcDkn5FYsEVE9M
	GiC0F2ehpbm+TZ5jnbsvNVkyaEvfQPPhbCy8SK+5sAwDLARdha8pzUIhF7URaiRmbhQiSsO3Q0nTB
	gzT4sSc22SEEQq8n89qFoydjsVZIcozomNT5iRDJqjMmRREKa3b6TOHZ/+GaT8TogZRMbLvfWYHEl
	fDcbVBvKbw0LH9zaps12VVYmCOlz2W/atNiff4Uw/i4YAjCnVJ3kWVd6Whv17pIS5OYBQXzm4aATE
	AQ14X/HaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxbu4-0002bX-Jl; Mon, 20 Jul 2020 19:56:48 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxbu2-0002az-8e
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 19:56:46 +0000
Received: by mail-pj1-f68.google.com with SMTP id b92so432916pjc.4
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 12:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=00Bv5AVItBaYBf9yub/7cZ9olLTw4fU30BrUbYKkLfY=;
 b=UyENyyYtdTSDx+pGES6sfgZfndP4fu2SuO0UTuBm2uGc1pKqpXZ9TQmK+1oZ//YfKT
 MA98492C1tmW8TPZnVnLGezdYEiLP0KtrK3M4ShOQ4J5GVICZhkYJ2X7y+GJiqOxySQz
 pNrDgod9imJ6eXCb4a5nOwueDcF8fQj9YNto7NddY2bjIDyDlfI3ie8jo1UI6GwO3BAm
 2v4XRcSdu5VdvhnIwR8sHkmEyfNZJTvCHJ154Dcy0NHeai97rlnMZWF9rxWw5RrN3c4Z
 q3nFRrOQ/8AdenASzDNz1YD+Oh7D3Ogx9fXzI5UB8X4/VSby4Mgymj517L6fnVMtLYG+
 QqAQ==
X-Gm-Message-State: AOAM533fFuVLBIxyy3XHehg5Bp0KyBRI8hwbGL8kIU75pnXl2LUfdPMz
 WNdUFrRI8OlyCH9aLYNVBurLb8pg
X-Google-Smtp-Source: ABdhPJyX3zlLSL9zYOJD1enSYhVF1yPpzjOHvM9kphNnAcKmVAut3lmQM76htOlFjXNj3byIT3+Ohw==
X-Received: by 2002:a17:90a:f981:: with SMTP id
 cq1mr1026099pjb.173.1595275004766; 
 Mon, 20 Jul 2020 12:56:44 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id x23sm17419018pfn.4.2020.07.20.12.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 12:56:43 -0700 (PDT)
Subject: Re: [PATCH] nvme-fc: set max_segments to lldd max value
To: Max Gurtovoy <maxg@mellanox.com>, James Smart <jsmart2021@gmail.com>,
 linux-nvme@lists.infradead.org
References: <20200714190336.119013-1-jsmart2021@gmail.com>
 <75927cec-e607-0293-47d3-f8b6141425f0@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ed9ba851-9e0e-f5ba-8dbd-1be3d46ac3d5@grimberg.me>
Date: Mon, 20 Jul 2020 12:56:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <75927cec-e607-0293-47d3-f8b6141425f0@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_155646_324152_970AF481 
X-CRM114-Status: GOOD (  17.57  )
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
Cc: "Ewan D . Milne" <emilne@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IEN1cnJlbnRseSB0aGUgRkMgdHJhbnNwb3J0IGlzIHNldCBtYXhfaHdfc2VjdG9ycyBiYXNl
ZCBvbiB0aGUgbGxkZHMKPj4gbWF4IHNnbCBzZWdtZW50IGNvdW50LiBIb3dldmVyLCB0aGUgYmxv
Y2sgcXVldWUgbWF4IHNlZ21lbnRzIGlzCj4+IHNldCBiYXNlZCBvbiB0aGUgY29udHJvbGxlcidz
IG1heF9zZWdtZW50cyBjb3VudCwgd2hpY2ggdGhlIHRyYW5zcG9ydAo+PiBkb2VzIG5vdCBzZXQu
wqAgQXMgc3VjaCwgdGhlIGxsZGQgaXMgcmVjZWl2aW5nIHNnbCBsaXN0cyB0aGF0IGFyZQo+PiBl
eGNlZWRpbmcgaXRzIG1heCBzZWdtZW50IGNvdW50Lgo+Pgo+PiBTZXQgdGhlIGNvbnRyb2xsZXIg
bWF4IHNlZ21lbnQgY291bnQgYW5kIGRlcml2ZSBtYXhfaHdfc2VjdG9ycyBmcm9tCj4+IHRoZSBt
YXggc2VnbWVudCBjb3VudC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFy
dDIwMjFAZ21haWwuY29tPgo+PiBSZXZpZXdlZC1ieTogRXdhbiBELiBNaWxuZSA8ZW1pbG5lQHJl
ZGhhdC5jb20+Cj4+IENDOiBNYXggR3VydG92b3kgPG1heGdAbWVsbGFub3guY29tPgo+Pgo+PiAt
LS0KPj4gTG9va3MgbGlrZSB0aGUgc2V0dGluZyBvZiBtYXhfc2VnbWVudHMgaGFzIGJlZW4gbWlz
c2luZyBmcm9tIGFsbAo+PiBmYWJyaWMgdHJhbnNwb3J0cyBmb3IgYSB3aGlsZS4gUmRtYSBoYWQg
YSBmaXh1cCAoZmYxM2MxYjg3Yzk3KSBmcm9tCj4+IE1heCBsYXN0IGZhbGwgdGhhdCBjb3JyZWN0
ZWQgdGhpcy4gQnV0IHRjcCBhbmQgZmMgd2VyZSBzdGlsbCBsYWNraW5nLgo+PiBDb3B5aW5nIE1h
eCB0byBsb29rIGF0IHRjcC4KPiAKPiBUaGUgVENQIHN0YWNrIGlzIG5vdCBsaW1pdGluZyB0aGUg
SU8gc2l6ZSwgSSBndWVzcyBiZWNhdXNlIG9mIHRoZSBmYWN0IAo+IGl0J3MgYSBzdHJlYW1pbmcg
cHJvdG9jb2wuCj4gCj4gU28gSSBkb24ndCBzZWUgYSBidWcgaW4gdGhlIHRjcCBkcml2ZXIgYnV0
IHdlIGNhbiBjb25zaWRlciBsaW1pdGluZyB0aGUgCj4gSU8gc2l6ZSBpZiBpdCB3aWxsIGltcHJv
dmUgcGVyZm9ybWFuY2UgaW4gc29tZSBjYXNlcy4KPiAKPiBCVFcsIEFGQUlLIHRoZSBpc2NzaSBU
Q1AgYWN0cyB0aGUgc2FtZS4KPiAKPiBTYWdpLAo+IAo+IGRvIHlvdSBzZWUgc29tZSBiZW5lZml0
cyB3ZSBjYW4gZ2V0IGJ5IGxpbWl0aW5nIHRoZSBtZHRzIGZvciB0Y3AgPwoKTm90IHJlYWxseS4u
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
