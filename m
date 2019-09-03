Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A66C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 07:50:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BBC2053B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 07:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JO5Xr3bT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ny7CNQMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BBC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=otzt0YykxTnTn/4uSw8LF2b+x6ZerIpMJ8bBm/gIe1s=; b=JO5Xr3bTW+2HD4
	4VLSmdMiI3iJq6kkKKJAc4l8lkqQbz81dEVAfg83yPulNPVdpAj/RtyPX2ldf9/WvCZZ7exGh9XCo
	NFRpT1D3AYwmioB4H5/qYlVb3ZHr+abV+b6Uuuh2l9wt4rJXEZ8ot4NsqB/Wg/YN9zEwxXvui4fG7
	OGCax2ra4W/4NW3oTWiCJvmdQNnX75guHXNWj9YN40n2PHPdEmQSBfDLxB3A3IExaaDNtB8hCg8Ie
	+L7amP5mZjEDrMmSkQdIN97lzMcrXuqTAT6hsqH/dywCEX1B7JQK8igH304PSMMe5d8UnYNddTVBi
	Rpkbh8/Rmw/Vw2Edrfzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i53Zv-0007g7-3C; Tue, 03 Sep 2019 07:50:15 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i53Zq-0007fm-SD
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 07:50:12 +0000
Received: by mail-wm1-x341.google.com with SMTP id k1so16930599wmi.1
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4vZE09HDIWBO/CJ+tf4zc13wKX7qtMMzcbXhdHBRo6c=;
 b=Ny7CNQMVzOyDTJtZ+D35rLWCPxO0fTYNx0rv1hA/Eg0KuBYjOI+lAFnHjDW51DHCBb
 SMD26IppkD5fyB5kjX4dEvKFHY/nxcAS5VDavg8GUNf1SG+rbVmzmv+80zaeQpAVNajj
 uaITNRtqol3uu9/CCFhxMsbhGJzZwvD7WlFzYoA1IFLbiaBMqZXw1ULZ034V+Tuypoj3
 Dj+d82z67OlhdmVnDHrZsAtgmOLxZ5E3OnQnCKkNyRJv3i5UsqOJyZyD+rqexg5j297T
 7ge1qlIt5mIdommqaziBKa9is2hi88PmMvDw9V1Smm5kKgskDFhuYPqsSfBWDA1xbcOG
 rDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4vZE09HDIWBO/CJ+tf4zc13wKX7qtMMzcbXhdHBRo6c=;
 b=sPASV7ZjNRxaKiwoojjZXIBAOYhAIJJfE6fyOA03OhXIFtutAxPOJQhpWDIlfvY4Kr
 mk3cgQmGpmWqpXME71jiO3uuy93/fGutYgUcXaKP5z6zuxLCiar7N/7Rjl8PsGhUcolI
 IA4q0Ocb0FiW8iDlxzNvC4wf1kGFndApnGAtmvF/8tVy8OxEwQ/BU750IaLxrkDg9shj
 mbmDd1XZd88D4M8mJp1bO7f6yMdc79MNJdnrU4i1cZf9QQeBwL+P21Te8Y14WWZWU1S2
 41yYIFbpAWvyLY/qr/eLQlwoysNmj2TtBlI/C17WIGgxro8QveeKr1OroJ3z2anAaOPa
 3apQ==
X-Gm-Message-State: APjAAAXcow46rjLGMCFBds+38kRdPFqqKeHrvLNrYyIT9qhVeb+oq8JQ
 4UCAaAthOSGYTVHfMeEWTbFMbw==
X-Google-Smtp-Source: APXvYqzRpoTgdkP7LcbqlbvLQ/tqnEzKck2C5hl4YK2+VU7L/BHigKc/yps5U+IJM6T2nuW0hBbQsg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr42215230wmh.34.1567497008463; 
 Tue, 03 Sep 2019 00:50:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ca2:9689:fa5d:1fea?
 ([2a01:e34:ed2f:f020:ca2:9689:fa5d:1fea])
 by smtp.googlemail.com with ESMTPSA id t13sm16071283wra.70.2019.09.03.00.50.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 00:50:07 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Ming Lei <ming.lei@redhat.com>
References: <20190827225827.GA5263@ming.t460p>
 <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de>
 <20190828110633.GC15524@ming.t460p>
 <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
 <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
Date: Tue, 3 Sep 2019 09:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903072848.GA22170@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_005010_920269_ADBE41F6 
X-CRM114-Status: GOOD (  16.85  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDMvMDkvMjAxOSAwOToyOCwgTWluZyBMZWkgd3JvdGU6Cj4gT24gVHVlLCBTZXAgMDMsIDIw
MTkgYXQgMDg6NDA6MzVBTSArMDIwMCwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+IE9uIDAzLzA5
LzIwMTkgMDg6MzEsIE1pbmcgTGVpIHdyb3RlOgo+Pj4gSGkgRGFuaWVsLAo+Pj4KPj4+IE9uIFR1
ZSwgU2VwIDAzLCAyMDE5IGF0IDA3OjU5OjM5QU0gKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3Rl
Ogo+Pj4+Cj4+Pj4gSGkgTWluZyBMZWksCj4+Pj4KPj4+PiBPbiAwMy8wOS8yMDE5IDA1OjMwLCBN
aW5nIExlaSB3cm90ZToKPj4+Pgo+Pj4+IFsgLi4uIF0KPj4+Pgo+Pj4+Cj4+Pj4+Pj4gMikgaXJx
L3RpbWluZyBkb2Vzbid0IGNvdmVyIHNvZnRpcnEKPj4+Pj4+Cj4+Pj4+PiBUaGF0J3Mgc29sdmFi
bGUsIHJpZ2h0Pwo+Pj4+Pgo+Pj4+PiBZZWFoLCB3ZSBjYW4gZXh0ZW5kIGlycS90aW1pbmcsIGJ1
dCB1Z2x5IGZvciBpcnEvdGltaW5nLCBzaW5jZSBpcnEvdGltaW5nCj4+Pj4+IGZvY3VzZXMgb24g
aGFyZGlycSBwcmVkaWNhdGlvbiwgYW5kIHNvZnRpcnEgaXNuJ3QgaW52b2x2ZWQgaW4gdGhhdAo+
Pj4+PiBwdXJwb3NlLgo+Pj4+Pgo+Pj4+Pj4gIAo+Pj4+Pj4+IERhbmllbCwgY291bGQgeW91IHRh
a2UgYSBsb29rIGFuZCBzZWUgaWYgaXJxIGZsb29kIGRldGVjdGlvbiBjYW4gYmUKPj4+Pj4+PiBp
bXBsZW1lbnRlZCBlYXNpbHkgYnkgaXJxL3RpbWluZy5jPwo+Pj4+Pj4KPj4+Pj4+IEkgYXNzdW1l
IHlvdSBjYW4gdGFrZSBhIGxvb2sgYXMgd2VsbCwgcmlnaHQ/Cj4+Pj4+Cj4+Pj4+IFllYWgsIEkg
aGF2ZSBsb29rZWQgYXQgdGhlIGNvZGUgZm9yIGEgd2hpbGUsIGJ1dCBJIHRoaW5rIHRoYXQgaXJx
L3RpbWluZwo+Pj4+PiBjb3VsZCBiZWNvbWUgY29tcGxpY2F0ZWQgdW5uZWNlc3NhcmlseSBmb3Ig
Y292ZXJpbmcgaXJxIGZsb29kIGRldGVjdGlvbiwKPj4+Pj4gbWVhbnRpbWUgaXQgaXMgbXVjaCBs
ZXNzIGVmZmljaWVudCBmb3IgZGV0ZWN0aW5nIElSUSBmbG9vZC4KPj4+Pgo+Pj4+IEluIHRoZSBz
ZXJpZXMsIHRoZXJlIGlzIG5vdGhpbmcgZGVzY3JpYmluZyByaWdvcm91c2x5IHRoZSBwcm9ibGVt
IChJIGNhbgo+Pj4+IG9ubHkgZ3Vlc3MpIGFuZCB3aHkgdGhlIHByb3Bvc2VkIHNvbHV0aW9uIHNv
bHZlcyBpdC4KPj4+Pgo+Pj4+IFdoYXQgaXMgeW91ciBkZWZpbml0aW9uIG9mIGFuICdpcnEgZmxv
b2QnPyBBIGhpZ2ggaXJxIGxvYWQ/IEFuIGlycQo+Pj4+IGFycml2aW5nIHdoaWxlIHdlIGFyZSBw
cm9jZXNzaW5nIHRoZSBwcmV2aW91cyBvbmUgaW4gdGhlIGJvdHRvbSBoYWx2ZXM/Cj4+Pgo+Pj4g
U28gZmFyLCBpdCBtZWFucyB0aGF0IGhhbmRsaW5nIGludGVycnVwdCAmIHNvZnRpcnEgdGFrZXMg
YWxsIHV0aWxpemF0aW9uCj4+PiBvZiBvbmUgQ1BVLCB0aGVuIHByb2Nlc3NlcyBjYW4ndCBiZSBy
dW4gb24gdGhpcyBDUFUgYmFzaWNhbGx5LCB1c3VhbGx5Cj4+PiBzb3J0IG9mIENQVSBsb2NrdXAg
d2FybmluZyB3aWxsIGJlIHRyaWdnZXJlZC4KPj4KPj4gSXQgaXMgYSBzY2hlZHVsZXIgcHJvYmxl
bSB0aGVuID8KPiAKPiBTY2hlZHVsZXIgY2FuIGRvIG5vdGhpbmcgaWYgdGhlIENQVSBpcyB0YWtl
biBjb21wbGV0ZWx5IGJ5IGhhbmRsaW5nCj4gaW50ZXJydXB0ICYgc29mdGlycSwgc28gc2VlbXMg
bm90IGEgc2NoZWR1bGVyIHByb2JsZW0sIElNTy4KCldoeT8gSWYgdGhlcmUgaXMgYSBpcnEgcHJl
c3N1cmUgb24gb25lIENQVSByZWR1Y2luZyBpdHMgY2FwYWNpdHksIHRoZQpzY2hlZHVsZXIgd2ls
bCBiYWxhbmNlIHRoZSB0YXNrcyBvbiBhbm90aGVyIENQVSwgbm8/CgoKCi0tIAogPGh0dHA6Ly93
d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9M
aW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0
ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
