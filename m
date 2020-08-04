Return-Path: <SRS0=RvWm=BO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8852BC433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2020 15:36:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602CB207FC
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2020 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FiwqqxI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602CB207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X2Di/Q65BRvukV2d0l4mjyGHrklWZfTc+FGtMS7aNPY=; b=FiwqqxI1X8MM5M0FkqVtZe4O4
	C3un5jDvoOVrL7LYwfQpvN15xtWU1gTKhYRFCZl4M6siyrN2eHg4F9vU0tCOoW9IlfbHRL9pDVx8q
	S61QfGjqpRYHsby0LSi41gJ+VFblq2lgkuErWt+AOeD1INEow6zzteLSOwz7FbzjCM2F38iZxp1YT
	SPB7PuKDswmy7xINy0Pyb7zWjXaiepI93cMKguOvN1Bu8g/fE1cyoM3LqkI7x3/4kZBkGTuatGQxv
	2e5mEgv+ZSaiTH5KX3c3yYVxja9u4/7rA+fnN8sbOK0xeOppbr6oCeflviY0awHNPzLR9TucVRqGL
	vljn376iA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2yzR-0008FF-1k; Tue, 04 Aug 2020 15:36:33 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2yzM-0008EI-44
 for linux-nvme@lists.infradead.org; Tue, 04 Aug 2020 15:36:28 +0000
Received: by mail-pg1-f182.google.com with SMTP id j21so3652235pgi.9
 for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2020 08:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RJgiRu5wEPpbcrwbGsqRdgc2QTqhMmJ4IO2uFO9gYUk=;
 b=ju+1Qy9Nxv/+rwcbX7GYEAUwoNgUhQFEDK/Rb29l6udGZEbLQlAVhgcZ/VtlSKt09U
 qSIIsMZ6IM0saULsVubyr+3CBsXQmlRp49TzuU/S5S+cTu1dKjQE2PL31uGr6fIOxoyN
 qYovfK1P77Fj1K+A5c11UHRMZ468HM7M14ySxL7CH3JDS9H/xiiOUwBcSlWJy1fBFKo6
 St+v+I/NVee8q2U3owgmu9hGGwDaUa3W0Jq8TZYdRgHCTg/o6gYpz9gyRFM2bOhUM+y6
 g15kyD6/xwJA+2i3uex6YFrcIOqkuGMnQduTaVzPUVLN5jTrUdJ6rBoLOsvD/gDUP4wE
 tkJQ==
X-Gm-Message-State: AOAM532vUfqk2EbKiAAUoKndWHinvn8l1e8j19DRh460olm4nBeqhBiF
 ScFn1q0ZcR8kReD4qB09hvc=
X-Google-Smtp-Source: ABdhPJzhsKU0OlvmSj88xCrzOCLqve+Cr0XoIvduTMRAh3uBKhbSQO3cOzYo865ILPKeBTGDNyWK+A==
X-Received: by 2002:a05:6a00:150a:: with SMTP id
 q10mr21931386pfu.91.1596555385223; 
 Tue, 04 Aug 2020 08:36:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:812c:bdc4:c26c:df75?
 ([2601:647:4802:9070:812c:bdc4:c26c:df75])
 by smtp.gmail.com with ESMTPSA id y4sm23202488pff.44.2020.08.04.08.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 08:36:24 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
Date: Tue, 4 Aug 2020 08:36:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200804_113628_182862_A467E47F 
X-CRM114-Status: GOOD (  20.23  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gK3N0YXRpYyB2b2lkIG52bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQoc3RydWN0IHJl
cXVlc3QgKnJxKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX3JlcXVlc3Qg
KnJlcSA9IGJsa19tcV9ycV90b19wZHUocnEpOwo+Pj4+ICvCoMKgwqAgc3RydWN0IG52bWVfcmRt
YV9xdWV1ZSAqcXVldWUgPSByZXEtPnF1ZXVlOwo+Pj4+ICvCoMKgwqAgc3RydWN0IG52bWVfcmRt
YV9jdHJsICpjdHJsID0gcXVldWUtPmN0cmw7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgLyogZmVuY2Ug
b3RoZXIgY29udGV4dHMgdGhhdCBtYXkgY29tcGxldGUgdGhlIGNvbW1hbmQgKi8KPj4+PiArwqDC
oMKgIGZsdXNoX3dvcmsoJmN0cmwtPmVycl93b3JrKTsKPj4+PiArwqDCoMKgIG52bWVfcmRtYV9z
dG9wX3F1ZXVlKHF1ZXVlKTsKPj4+IFRoZXJlIG1heWJlIGNvbmN1cnJlbnQgd2l0aCBlcnJvciBy
ZWNvdmVyeSwgbWF5IGNhdXNlIGFibm9ybWFsIGJlY2F1c2UKPj4+IG52bWVfcmRtYV9zdG9wX3F1
ZXVlIHdpbGwgcmV0dXJuIGJ1dCB0aGUgcXVldWUgaXMgbm90IHN0b3BlZCwKPj4+IG1heWJlIGlz
IHN0b3BwaW5nIGJ5IHRoZSBlcnJvciByZWNvdmVyeS4KPj4KPj4gZXJyX3dvcmsgZmx1c2ggdXNl
ZCB0byBmZW5jZSwgb25jZSB3ZSBkaWQgcXVldWUgc3RvcCwgaXQgc2hvdWxkIGJlIHNhZmUKPj4g
dG8gY29tcGxldGUgdGhlIGNvbW1hbmQgZnJvbSB0aGUgdGltZW91dCBoYW5kbGVyLgo+IAo+IEZs
dXNoIHdvcmsganVzdCBjYW4gYXZvaWQgdHJpZ2dlciBlcnJvciByZWNvdmVyeSBieSBudm1lX3Jk
bWFfdGltZW91dCBvcgo+IHJlZHVjZSBjb25jdXJyZW50IHByb2JhbGliaXR5IHRyaWdnZXIgZXJy
b3IgcmVjb3ZlcnkgYnkgb3RoZXIgcHJvZ3Jlc3MsCj4gYnV0IGNhbiBub3QgYXZvaWQuCgpUaGUg
cG9pbnQgaXMgdGhhdCB3ZSBjYW4gY29tcGxldGUgdGhlIGNvbW1hbmQgYmVjYXVzZSBlcnJfd29y
awp3YXMgZmx1c2hlZCBhbmQgdGhlIHF1ZXVlIHdhcyBzdG9wcGVkLCB3aGljaCBtZWFucyB3ZSBz
aG91bGRuJ3QgaGF2ZQphbnkgY29udGV4dCBjb21wbGV0aW5nIHRoZSByZXF1ZXN0LgoKPiBpZiBu
dm1lX3JkbWFfY21faGFuZGxlciBvciBvdGhlciBwcm9ncmVzcyBjYWxsCj4gbnZtZV9yZG1hX2Vy
cm9yX3JlY292ZXJ5LCBiZXR3ZWVuIGNoYW5nZSBzdGF0ZSB0byBxdWV1ZV93b3JrIG1heQo+IGlu
dGVycnVwdCBieSBoYXJkIGludGVycnVwdCwgYW5kIHRoZW4gdGltZW91dCBoYXBwZW4sIHRodXMg
Zmx1c2ggd29yawo+IGNhbiBub3QgYXZvaWQgY29uY3VycmVudC4KPiBMaWtlIHRoaXM6Cj4gCj4g
c3RhdGljIHZvaWQgbnZtZV9yZG1hX2Vycm9yX3JlY292ZXJ5KHN0cnVjdCBudm1lX3JkbWFfY3Ry
bCAqY3RybCkKPiB7Cj4gIMKgwqDCoMKgaWYgKCFudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJs
LT5jdHJsLCBOVk1FX0NUUkxfUkVTRVRUSU5HKSkKPiAgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpJZiB3ZSBhcmUgaW4gUkVTRVRUSU5H
L0NPTk5FQ1RJTkcgc3RhdGUgYWxyZWFkeSwgdGhpcyB3b24ndCBkbyBhbnl0aGluZy4KCj4gbWF5
IGludGVycnVwdCBieSBoYXJkIGludGVycnVwdCwgYW5kIHRoZW4gdGltZW91dCBwcm9ncmVzcyBm
bHVzaCB3b3JrCj4gYXQgdGhpcyB0aW1lLiBUaHVzIGVycm9yIHJlY292ZXJ5IGFuZCBudm1lX3Jk
bWFfY29tcGxldGVfdGltZWRfb3V0IG1heQo+IGNvbmN1cnJlbnQgdG8gc3RvcCBxdWV1ZS4gd2ls
bCBjYXVzZTogZXJyb3IgcmVjb3ZlcnkgbWF5IGNhbmNlbCByZXF1ZXN0Cj4gb3IgbnZtZV9yZG1h
X2NvbXBsZXRlX3RpbWVkX291dCBtYXkgY29tcGxldGUgcmVxdWVzdCwgYnV0IHRoZSBxdWV1ZSBt
YXkKPiBub3QgYmUgc3RvcGVkLiBUaHVzIHdpbGwgY2F1c2UgYWJub3JtYWwuCgpXZSBzaG91bGQg
YmUgZmluZSBhbmQgc2FmZSB0byBjb21wbGV0ZSB0aGUgSS9PLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
