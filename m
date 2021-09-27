Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04BBC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:52:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9162F60F6D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9162F60F6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPk6aNRyWUELIia/u2ZTMaOEyof89AxT26cejg9GTFg=; b=ebjUJ2YjUN9aFIvERQzq+Ex7Bj
	RVatrPm7XOO5BpkR9AIEN3xklaN1JgWpYfEsdrKC21ZsunF7hIQmUn06ayw3O7mYFIHEVEaPwH+cJ
	6zTqeV6QkYJTDUMAo/ysn/JDA9LG5CFg/l/2Jn1ctjKPwtPS8vGz5GK/GlGEfwNtgaiJ1Z/8ra879
	cpg4r/MWDrwvxgea7bMIQ4z6PMWCumS3R8Hz+I2jwYL2fapjIw83Kx++dlsfgfxp2EADLsDJw5m5N
	xggCvepgjHHjvIcVmWQAfGU/5Ci/nuBW5tzi92DqxfbDtkFxVG4VwFu0FxLssQzg21zQEe7PgOPQE
	9HldQPUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUlQv-001sQn-I0; Mon, 27 Sep 2021 07:52:17 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUlQs-001sQ9-98
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 07:52:15 +0000
Received: by mail-ed1-f48.google.com with SMTP id x7so50857515edd.6
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 00:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4OFhBs1l3mVS6Ir+myuYdrxMtCwqxgyKyqQ1V6PpYeU=;
 b=pFxc9764LIfBo/Tde4LCSdLNuP5BPpG+kB8tNAJOe3VpW0tqnhUPj6WKsLVEqqYQQq
 Qq+ksZSOXJ/oM02DfuBh4wsNDCVoveWZ4mAPphEVGITVEsLlN6Lef2M4pWy+90IUn1/E
 uzCxKdsunl4AMvyFDPjThdbxZK7hBP0UtTlgrAJ7xIW/kVrkCGhK4kWiVa5ooFZPTZX7
 9YSRPHq1AyNIwUpL9Smo6B7xreR6mt7yp8a9T5AxIo2j92otTU8rPNFsDuwYa/X89lcz
 Bgs6OpmjKSdgQXzq0//wCiLQN2EQEj3eBW5tKLtf+reUoOT3lcjVfxkdkZoNh9NpczFz
 ysVA==
X-Gm-Message-State: AOAM531lMMsFKXMeKYE8yTZGa/o6Phy2LBR/B2Sa8/Skdsu+2Ff2FzsW
 H2CFxBj1uO79I+ibN48v54I=
X-Google-Smtp-Source: ABdhPJyOfrmtxrcm19J/J1EYOAuyM6nZN7pRgijyXWvEKiZKK9k0wcqJUmkoYTDily41uv6ry7f/Qg==
X-Received: by 2002:a50:a2a5:: with SMTP id 34mr11426941edm.150.1632729132768; 
 Mon, 27 Sep 2021 00:52:12 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id h26sm3776020edz.1.2021.09.27.00.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 00:52:12 -0700 (PDT)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
 <745c58b2-e508-25c0-f094-8d24af0631ed@grimberg.me>
 <0a7e7f2a-3f62-96c3-3b04-549afb8343ff@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <70d2b1af-fcf0-43e4-1083-1d8ba56e91be@grimberg.me>
Date: Mon, 27 Sep 2021 10:52:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0a7e7f2a-3f62-96c3-3b04-549afb8343ff@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_005214_347601_FBF17FEB 
X-CRM114-Status: GOOD (  15.24  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA5LzI3LzIxIDg6NDggQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA5LzI3LzIx
IDEyOjUzIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pgo+Pj4gKy8qIEFzc3VtZXMgdGhhdCB0
aGUgY29udHJvbGxlciBpcyBpbiBzdGF0ZSBSRVNFVFRJTkcgKi8KPj4+ICtzdGF0aWMgdm9pZCBu
dm1lX2RoY2hhcF9hdXRoX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+Pj4gK3sKPj4+
ICvCoMKgwqAgc3RydWN0IG52bWVfY3RybCAqY3RybCA9Cj4+PiArwqDCoMKgwqDCoMKgwqAgY29u
dGFpbmVyX29mKHdvcmssIHN0cnVjdCBudm1lX2N0cmwsIGRoY2hhcF9hdXRoX3dvcmspOwo+Pj4g
K8KgwqDCoCBpbnQgcmV0LCBxOwo+Pj4gKwo+Pgo+PiBIZXJlIEkgd291bGQgcHJpbnQgYSBzaW5n
bGU6Cj4+IMKgwqDCoMKgwqBkZXZfaW5mbyhjdHJsLT5kZXZpY2UsICJyZS1hdXRoZW50aWNhdGlu
ZyBjb250cm9sbGVyIik7Cj4+Cj4+IFRoaXMgaXMgaW5zdGVhZCBvZiBhbGwgdGhlIHF1ZXVlIHJl
LWF1dGhlbnRpY2F0aW9uIHByaW50cyB0aGF0Cj4+IHNob3VsZCBiZSBkZXZfZGJnLgo+Pgo+PiBM
ZXQncyBhdm9pZCBkb2luZyB0aGUgcGVyLXF1ZXVlIHByaW50Li4uCj4gCj4gSG1tLiBBY3R1YWxs
eSB0aGUgc3BlYyBhbGxvd3MgdG8gdXNlIGRpZmZlcmVudCBrZXlzIHBlciBxdWV1ZSwgZXZlbiAK
PiB0aG91Z2ggb3VyIGltcGxlbWVudGF0aW9uIGRvZXNuJ3QuIEFuZCBmbWRzIGhhcyBzdHJ1Z2ds
ZWQgdG8gY29tZSB1cCAKPiB3aXRoIGEgc2FuZSB1c2VjYXNlIGZvciB0aGF0LgoKV2UgZG9uJ3Qg
bmVlZCB0byBzdXBwb3J0IGl0LCBidXQgcmVnYXJkbGVzcyB3ZSBzaG91bGQgbm90CmluZm8gcHJp
bnQgcGVyLXF1ZXVlLgoKPiBCdXQgeWVzLCBva2F5LCB3aWxsIGJlIHVwZGF0aW5nIGl0LgoKR3Jl
YXQuLi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
