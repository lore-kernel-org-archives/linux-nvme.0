Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 15:24:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8057820897
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXiEYzwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8057820897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vkawxxRdAjZu12UZVrlJKz9HZfPwFHjr4mw8x5UVRrA=; b=SXiEYzwODTFJAqjRorBqD7g77
	e67otho1XkfX3/SxxizIOaoik2sxjkCAjE3H2MffPu0F+VF45/FfZGzykHf3UTHI4Tnsd/UM454uC
	lzb+I05iwZ9gN5ZBMvBqg56gidsNsEY32si/dHFtBsV/4Y27Mu4xWd7LoianlcvXdr7jYiLI06Y6z
	DpVF2AE6npc3k5KbTcLBHM3IopEB2RPKvgXXimSLT/CsHG2O2j4ijlTB2zvx8dZv3zGwl1kEyFXVI
	Sw/a03zdIcnWVnDoiFrzk1gubMB2sGYjEUocNJ831cYsGkE73cpN1OAvP23vv1EiefSz0hkQBot/1
	DM1nwwm8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Pwd-0005XD-FX; Wed, 19 Aug 2020 15:24:07 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Pwa-0005WY-Dy
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 15:24:05 +0000
Received: by mail-pg1-f196.google.com with SMTP id h12so11546884pgm.7
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 08:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4F74RoCGZE//2kpfQM9VpW/0qCy8ZTbnYdL63hWaZPQ=;
 b=AsAI/ZlCt1Zl/fHC1ApKgjr6jmJtz5MByktxy2GsVxAhDmLUUsTVk/RVv/OakHb0aZ
 Te6s1ylhYAWcOaLDA0/czbeZ0UK8kv3EpPwgaYoQJCpv68JcXPvOQ8x4VB6QC2PA/pTv
 JmQX1WjGE+QLOiAh/EHRUSmaTUeCmqWRAzoHlDbwsG+iGn9RepqLksYbzl5IHh+1cnE5
 HChN8EAzJ09I/SkNw6uO+CCu/HaFuhsbs4opmVdgja5NMtYysLq0V2dwUJSkkPL5E0n4
 k7oZe86uXcE36joAU3c9BK4fJSXdDpLy007AbI2dhvcaLRbOYvoBgv2C5Jl0QWR6WhHt
 3LDQ==
X-Gm-Message-State: AOAM533cuhy3pWTDD3IXKMVXD//Ka4Eg0xLcTOGJNb2FqK7jnEFOZMZa
 D+Lnrh7f3Vkfjs5hu4POBQ0HExZ9uBaVcQ==
X-Google-Smtp-Source: ABdhPJyEsfdqcFs4EILz1t10E1G7NLfdCKuWf9J0jTPaPyKKxJRQ8hakzVNucx06zttJHCqmckrAhg==
X-Received: by 2002:aa7:8743:: with SMTP id g3mr19200632pfo.76.1597850642591; 
 Wed, 19 Aug 2020 08:24:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bcd0:fda9:d34d:a3ab?
 ([2601:647:4802:9070:bcd0:fda9:d34d:a3ab])
 by smtp.gmail.com with ESMTPSA id l9sm3921866pgg.29.2020.08.19.08.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 08:24:01 -0700 (PDT)
Subject: Re: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
To: "Engel, Amit" <Amit.Engel@Dell.com>, Christoph Hellwig <hch@lst.de>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
 <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
Date: Wed, 19 Aug 2020 08:24:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_112404_481675_AD79CFC3 
X-CRM114-Status: GOOD (  15.32  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gQWN0dWFsbHkgdGhlIHNwZWMgc2F5cyB0aGF0IE5WTUUvVENQIHJlcXVpcmVzIGtlZXAgYWxp
dmUgc28gaXQgc2hvdWxkbuKAmXQgYmUgMC4KCk5vdGhpbmcgaW4gdGhpcyBsYW5ndWFnZSByZXF1
aXJlcyBpdC4gVGhlIGtleXdvcmQgc2hvdWxkIG1lYW5zIGFkdmljZS4KCj4gTWF5YmUgd2UgZG8g
bmVlZCB0byBzZXQgYSBkZWZhdWx0IHZhbHVlIGluIGNhc2Ugb2YgemVybyBrYXRvIHZhbHVlID8K
Ck5vLCB0aGUgcGF0Y2ggaXMgZmluZS4KCj4gTlZNZS1vRiAxLjE6Cj4gNy40LjggS2VlcCBBbGl2
ZQo+IFRoZSBOVk1lL1RDUCBUcmFuc3BvcnQgcmVxdWlyZXMgdGhlIHVzZSBvZiB0aGUgS2VlcCBB
bGl2ZSBmZWF0dXJlIChyZWZlciB0byBzZWN0aW9uIDcuMTIgaW4gdGhlIE5WTWUgYmFzZSBzcGVj
aWZpY2F0aW9uKS4gVGhlIE5WTWUvVENQIFRyYW5zcG9ydCBkb2VzIG5vdCBpbXBvc2UgYW55IGxp
bWl0YXRpb25zIG9uIHRoZSBtaW5pbXVtIGFuZCBtYXhpbXVtIEtlZXAgQWxpdmUgVGltZW91dCB2
YWx1ZS4gVGhlIG1pbmltdW0gc2hvdWxkIGJlIHNldCBsYXJnZSBlbm91Z2ggdG8gYWNjb3VudCBm
b3IgYW55IHRyYW5zaWVudCBmYWJyaWMgaW50ZXJjb25uZWN0IGZhaWx1cmVzIGJldHdlZW4gdGhl
IGhvc3QgYW5kIGNvbnRyb2xsZXIuCj4gVENQIGxldmVsIEtlZXAgQWxpdmUgZnVuY3Rpb25hbGl0
eSBpcyBub3QgcHJvaGliaXRlZCBidXQgaXQgaXMgcmVjb21tZW5kZWQgdGhhdCBUQ1AgbGV2ZWwg
S2VlcCBBbGl2ZSB0aW1lb3V0IGlzIHNldCB0byBhIGhpZ2hlciB2YWx1ZSB0aGFuIHRoZSBOVk1l
IEtlZXAgQWxpdmUgVGltZW91dCB0byBhdm9pZCBjb25mbGljdGluZyBwb2xpY2llcy4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
