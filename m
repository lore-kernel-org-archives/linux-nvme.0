Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD2AC3F2C2
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 23:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E51A246A3
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 23:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="phgv+5Td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E51A246A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5GrApJ2y6NwfxIdvo/LYi7AFwzJ24XkuzE9pspPhwJc=; b=phgv+5TdLC0DwkmNaJuQU6VOX
	tvEydYrq6ugXEL27R8wgoOCx6Nqdi76MPP22fGuy5vX8W/pvujumHlPJQG694Yebz0S8oCgg3X99y
	wV/ASZM7vN4rN6VND2OCGMGgM+jbWvSr18+BqrxoQM7O75T60TEUx8ARgulaFucVq0KKr6gCm+cT5
	XdIarNMoV2WVzrwLNqgAwMC64Ii5VBJxKaU4mo2ZG+0OH+YQ4O0E3wuRrIlNVpnrhXVZ/gA29ZMZU
	vKJPxSZpnSr2oyoZtmqbI12wa25NLGW8jb6hoXLDwFhHeIPLJbn6KSg9ATCqEVyoH7k6Az2NQEzFX
	RPPTRl8kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7SLD-00030l-Vh; Thu, 27 Feb 2020 23:13:15 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7SLB-00030L-Le
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 23:13:14 +0000
Received: by mail-oi1-f193.google.com with SMTP id q81so1058591oig.0
 for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2020 15:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vuP2i555x9rQeLyB1v3KlAfJsd5dT+gQKeEPZLvbG7U=;
 b=IBGBvNgwvbt2w4TcB0GWuTQkCbExE1MxKyGfaHHUgtzl8ln2MQLTXoXfKmQ62HUWhA
 SFUlMM0zc6AFXZT0bPh+1SdQvLhjjyuE0eJD0L8swN2oR8l3Lras3+R/FBQxOxcIgkn5
 I2efX8v/UdBmAU1aqLOrzY0sq64ERO9czC97ujfWUW2OrD3uFMWs1IKstw4IDeds1tkB
 wjZxyPQu1K+bcL+1WsgHotmuqnv/S0ft9Ldew6txXpshqwY6TLiBMaH8lqpEVTpY8O8x
 YW0/mJAK1XPjkunhVXdHURKkgYR3htFYhe2l/oiWKTnJNQOSE8uiTEilBJOl/X9ZKzuE
 //hw==
X-Gm-Message-State: APjAAAUgNtjVEnqlMHMGgptbg2ySa9sv8xsrk4/HMJN3N2hghsyaSjoH
 Ap7KYepSN8IfO37UfUA7vm2TUIIL
X-Google-Smtp-Source: APXvYqzigNcduadD51SnQ3RWu/qpj0QrIQNpNPc0NMbtWNTDLeraVQfc5Y6jSTpgNetyyTPyGtkGng==
X-Received: by 2002:aca:c646:: with SMTP id w67mr1011516oif.171.1582845192170; 
 Thu, 27 Feb 2020 15:13:12 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id t23sm2479235oic.28.2020.02.27.15.13.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Feb 2020 15:13:11 -0800 (PST)
Subject: Re: [PATCH v11 8/9] nvmet-passthru: Add enable/disable helpers
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-9-logang@deltatee.com>
 <96234649-fbc1-fb56-54d8-2f73dc455ffd@grimberg.me>
 <9c6355d8-cf4e-9932-1cef-0a7140f0fa7e@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <283c563a-06a9-9c12-bd4e-d15e790fad57@grimberg.me>
Date: Thu, 27 Feb 2020 15:13:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9c6355d8-cf4e-9932-1cef-0a7140f0fa7e@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200227_151313_710847_D2527B63 
X-CRM114-Status: GOOD (  15.04  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiArwqDCoMKgIGlmIChzdWJzeXMtPnZlciA8IE5WTUVfVlMoMSwgMiwgMSkpIHsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBwcl93YXJuKCJudm1lIGNvbnRyb2xsZXIgdmVyc2lvbiBpcyB0b28gb2xk
OiAlZC4lZC4lZCwKPj4+IGFkdmVydGlzaW5nIDEuMi4xXG4iLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKGludClOVk1FX01BSk9SKHN1YnN5cy0+dmVyKSwKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIChpbnQpTlZNRV9NSU5PUihzdWJzeXMtPnZlciksCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAoaW50KU5WTUVfVEVSVElBUlkoc3Vic3lzLT52ZXIpKTsKPj4+ICvCoMKgwqDC
oMKgwqDCoCBzdWJzeXMtPnZlciA9IE5WTUVfVlMoMSwgMiwgMSk7Cj4+Cj4+IFVtbS4uIGlzIHRo
aXMgT0s/IGRvIHdlIGltcGxlbWVudCB0aGUgbWFuZGF0b3J5IDEuMi4xIGZlYXR1cmVzIG9uIGJl
aGFsZgo+PiBvZiB0aGUgcGFzc3RocnUgZGV2aWNlPwo+IAo+IFRoaXMgd2FzIHRoZSBhcHByb2Fj
aCB0aGF0IENocmlzdG9waCBzdWdnZXN0ZWQuIEl0IHNlZW1lZCBzZW5zaWJsZSB0bwo+IG1lLiBI
b3dldmVyLCBpdCB3b3VsZCBhbHNvICpwcm9iYWJseSogYmUgb2sgdG8ganVzdCByZWplY3QgdGhl
c2UKPiBkZXZpY2VzLiBVbmxlc3MgeW91IGZlZWwgc3Ryb25nbHkgYWJvdXQgdGhpcywgSSdsbCBw
cm9iYWJseSBsZWF2ZSBpdCB0aGUKPiB3YXkgaXQgaXMuCgpTb3VuZHMgb2sgdG8gbWUuCgo+Pj4g
K8KgwqDCoCB9Cj4+PiArCj4+PiArwqDCoMKgIG11dGV4X3VubG9jaygmc3Vic3lzLT5sb2NrKTsK
Pj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+PiArCj4+PiArb3V0X3B1dF9jdHJsOgo+Pj4gK8KgwqDC
oCBudm1lX3B1dF9jdHJsKGN0cmwpOwo+Pj4gK291dF91bmxvY2s6Cj4+PiArwqDCoMKgIG11dGV4
X3VubG9jaygmc3Vic3lzLT5sb2NrKTsKPj4+ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4+ICt9Cj4+
PiArCj4+PiArc3RhdGljIHZvaWQgX19udm1ldF9wYXNzdGhydV9jdHJsX2Rpc2FibGUoc3RydWN0
IG52bWV0X3N1YnN5cyAqc3Vic3lzKQo+Pj4gK3sKPj4+ICvCoMKgwqAgaWYgKHN1YnN5cy0+cGFz
c3RocnVfY3RybCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHhhX2VyYXNlKCZwYXNzdGhydV9zdWJz
eXN0ZW1zLCBzdWJzeXMtPnBhc3N0aHJ1X2N0cmwtPmNudGxpZCk7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgbnZtZV9wdXRfY3RybChzdWJzeXMtPnBhc3N0aHJ1X2N0cmwpOwo+Pj4gK8KgwqDCoCB9Cj4+
PiArwqDCoMKgIHN1YnN5cy0+cGFzc3RocnVfY3RybCA9IE5VTEw7Cj4+PiArwqDCoMKgIHN1YnN5
cy0+dmVyID0gTlZNRVRfREVGQVVMVF9WUzsKPj4+ICt9Cj4+Cj4+IElzbid0IGl0IHN0cmFuZ2Ug
dGhhdCBhIHN1YnN5c3RlbSBjaGFuZ2VzIGl0cyB2ZXJzaW9uIGluIGl0cyBsaWZldGltZT8KPiAK
PiBJdCBkb2VzIHNlZW0gc3RyYW5nZS4gSG93ZXZlciwgaXQncyBub3QgYXQgYWxsIHVucHJlY2Vk
ZW50ZWQuIFNlZQo+IG52bWV0X3N1YnN5c19hdHRyX3ZlcnNpb25fc3RvcmUoKSB3aGljaCBnaXZl
cyB0aGUgdXNlciBkaXJlY3QgY29udHJvbCBvZgo+IHRoZSB2ZXJzaW9uIHRocm91Z2ggY29uZmln
ZnMuCgpZb3UncmUgcmlnaHQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
